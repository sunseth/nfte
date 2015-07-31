express = require 'express'
engine = require 'ejs-locals'
passport = require 'passport'
cookieParser = require 'cookie-parser'

config = require '../config'
auth = require '../middleware/auth'
paths = require '../paths'
data = require '../data'
dependencies = {config, auth, paths, data}

module.exports = (app) ->

  app.engine 'ejs', engine
  app.set 'views', "#{__dirname}/../views"
  app.set 'view engine', 'ejs'

  app.use '/', express.static("#{__dirname}/../public")

  app.use passport.initialize()
  app.use passport.session()

  app.use cookieParser()

  require('./authRoutes')(app, dependencies)

  require('./public/home')(app, dependencies)
  require('./public/events')(app, dependencies)
  require('./public/families')(app, dependencies)
  require('./public/committees')(app, dependencies)
  require('./public/cabinet')(app, dependencies)
  require('./public/blog')(app, dependencies)