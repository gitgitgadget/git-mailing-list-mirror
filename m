From: Jeff King <peff@peff.net>
Subject: Re: bearer token authorization with HTTPS transport
Date: Tue, 30 Dec 2014 20:42:10 -0500
Message-ID: <20141231014209.GA8789@peff.net>
References: <CACejzECGUnH6B2Leq+H6u0Joo1SQmMCZ5UoHja_fK99+6a_iEA@mail.gmail.com>
 <20141230235610.GC10649@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: David Renshaw <david@sandstorm.io>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 02:44:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y68Kn-0001Zn-Uo
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 02:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaLaBmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 20:42:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:58081 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750743AbaLaBmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 20:42:11 -0500
Received: (qmail 16778 invoked by uid 102); 31 Dec 2014 01:42:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Dec 2014 19:42:11 -0600
Received: (qmail 9428 invoked by uid 107); 31 Dec 2014 01:42:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Dec 2014 20:42:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Dec 2014 20:42:10 -0500
Content-Disposition: inline
In-Reply-To: <20141230235610.GC10649@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261965>

On Tue, Dec 30, 2014 at 11:56:11PM +0000, brian m. carlson wrote:

> On Tue, Dec 30, 2014 at 11:24:09AM -0800, David Renshaw wrote:
> > Hi,
> > I would like to be able to serve a git repository over HTTPS from a
> > web server that requires OAuth2-style bearer tokens for authorization.
> > For more context, see this thread:
> > https://groups.google.com/forum/#!topic/sandstorm-dev/4oigfb4-9E4
> > 
> > Does anyone here have any advice about how to convince a git client to
> > add an "Authorization: Bearer <token>" header?
> > 
> > I can think of a few approaches:
> > 
> > (1) I could modify the curl remote helper to insert the header if it
> > sees a "bearertoken" config option. I have in fact written a
> > proof-of-concept patch that does this (see
> > https://github.com/dwrensha/git/commit/4da7b64b85b3b6652abe7), but I
> > don't know how much of chance something like this has of getting
> > merged into the mainline git client.
> 
> An idea that might be interesting is to add a framework to select a set
> of authentication types (defaulting, of course, to "any").  As part of
> that, you could add a type, "bearer", that uses the password we've
> collected via the credential helper as the bearer token.

If you mean something like:

  [http]
  authType = bearer

in the config, which would cause us to treat the password we collect
(whether from a credential helper or prompted on the terminal), I think
that would work OK (and you could customize it per-host with the '[http
"http://...]' style of config, and use existing credential helpers).

I think the "username" in this instance is probably irrelevant, though.
We would want to make sure not to prompt for it, which means extra
communication between the http and credential code. It would also be
nice if the prompt could be customized (it should say "token" or
something, not "password"). I'd guess in most cases, though, that the
token would come from a credential helper.

Another option would be to just teach the credential code to accept a
"bearer" field from a credential helper. We would need to:

  1. Teach the credential code that getting a "bearer" token is
     sufficient (it does not need to prompt for username/password).

  2. Teach the http code to pull the bearer field out and stick it in an
     "Authorization" header.

Both should be pretty trivial. This approach seems conceptually cleaner
to me, though it does mean you could not specify a bearer via the
terminal prompt for a password (e.g., by cutting and pasting from
elsewhere). I don't know if that is a problem or not. You could override
it with:

  [credential]
  helper = '!f() {
    test "$1" = "get" || return
    echo >/dev/tty "No, really, give me a bearer token: "
    read token </dev/tty
    echo "bearer=$token"
  }; f'

or similar.

I'm not really clear on where the bearer data would be coming from, and
whether people would want to pull it from a credential helper, or if
most would cut and paste it, or would use an existing helper (like
osxkeychain) to store the token.

GitHub does OAuth-ish tokens, but accepts them just as "Basic"
authorization headers, with the token in place of the password. So I'd
imagine people are using existing helpers to store them (I know I do).

-Peff
