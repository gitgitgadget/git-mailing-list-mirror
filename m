From: Jeff King <peff@peff.net>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Wed, 10 Apr 2013 21:56:13 -0400
Message-ID: <20130411015613.GA8455@sigill.intra.peff.net>
References: <20130409054553.GA1537@mteis.lan>
 <20130409171247.GD21972@sigill.intra.peff.net>
 <5165DA13.8010100@gmail.com>
 <20130410214722.GA6215@sigill.intra.peff.net>
 <20130410231919.GA1315@mteis.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Magnus Therning <magnus@therning.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 03:56:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ6kT-0002mH-1m
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 03:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935496Ab3DKB4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 21:56:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39541 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933295Ab3DKB4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 21:56:20 -0400
Received: (qmail 10415 invoked by uid 107); 11 Apr 2013 01:58:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 21:58:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 21:56:13 -0400
Content-Disposition: inline
In-Reply-To: <20130410231919.GA1315@mteis.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220800>

On Thu, Apr 11, 2013 at 01:19:19AM +0200, Magnus Therning wrote:

> Nope.  I'm pretty sure this had *nothing* to do with my config.  This
> is the original config, which doesn't work:
> 
> $HTTP["url"] =~ "^/git" {
>     cgi.assign = ( "" => "" )
>     setenv.add-environment = (
>         "GIT_PROJECT_ROOT" => "/srv/git",
>         "GIT_HTTP_EXPORT_ALL" => ""
>     )
>     $HTTP["url"] =~ "^/git/.*/git-receive-pack$" {
>         include "trac-git-auth.conf"
>     }
> }

Ah, I think I see what it is.

Did you turn on http.receivepack in the git config to enable pushing?
From "git help http-backend":

  By default, only the upload-pack service is enabled, which serves git
  fetch-pack and git ls-remote clients, which are invoked from git
  fetch, git pull, and git clone. If the client is authenticated, the
  receive-pack service is enabled, which serves git send-pack clients,
  which is invoked from git push.

  [...]

  http.receivepack
      This serves git send-pack clients, allowing push. It is disabled
      by default for anonymous users, and enabled by default for users
      authenticated by the web server. It can be disabled by setting
      this item to false, or enabled for all users, including anonymous
      users, by setting it to true.

If there is no authentication happening for the initial service-request,
then the default http.receivepack kicks in, which is to turn pushing
off (because there is no authenticated user).

When you do this;

> $HTTP["querystring"] =~ "service=git-receive-pack" {
>     $HTTP["url"] =~ "^/git" {
>         cgi.assign = ( "" => "" )
>         setenv.add-environment = (
>             "GIT_PROJECT_ROOT" => "/srv/git",
>             "GIT_HTTP_EXPORT_ALL" => ""
>         )
>         include "trac-git-auth.conf"
>     }

Then you are asking for authentication earlier (on the first request),
and the default behavior is to allow the push.

The documentation should probably make the use of http.receivepack more
clear in this situation.

> > However, even before the fix, it never got a 403 on the GET of
> > info/refs. It got a 401 on the later POST, but didn't prompt for
> > credentials.
> 
> I know nothing about CGI, but surely the script signals the need for a
> valid user to the server somehow, couldn't the web server then decide
> to return 403 rather than 401 *if there's no configuration for
> authentication*?

I think that series is a red herring. It did not affect the server-side
at all, but was a fix for the _client_ to handle the 401 it should
receive in that situation. But your server was generating a 403, for
different reasons.

So _if_ you fixed it by setting http.receivepack (which I think is the
simplest thing under Apache, since matching the query string there is
hard), then you would need a version of git with that fix on the
client side to actually have git prompt for the password correctly.

But your fix under lighttpd is much better, as it asks for the
credentials up front (which means the client does not go to any work
creating a packfile just to find out that it does not have access).

-Peff
