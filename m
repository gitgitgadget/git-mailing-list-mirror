From: Jeff King <peff@peff.net>
Subject: Re: git https transport and wrong password
Date: Tue, 2 Apr 2013 15:28:45 -0400
Message-ID: <20130402192845.GC17784@sigill.intra.peff.net>
References: <20130402155440.GT30514@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:29:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6tS-0006lc-Vt
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762142Ab3DBT2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:28:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52545 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760406Ab3DBT2t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:28:49 -0400
Received: (qmail 13417 invoked by uid 107); 2 Apr 2013 19:30:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 15:30:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 15:28:45 -0400
Content-Disposition: inline
In-Reply-To: <20130402155440.GT30514@lakka.kapsi.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219858>

On Tue, Apr 02, 2013 at 06:54:40PM +0300, Mikko Rapeli wrote:

> I have a problem with git (1.7.9 and 1.8.2.357.gcc3e4eb) and https transport
> to gerrit server (2.5.1-3-g719dfc7). I'm producing the problem on Cygwin but my
> colleagues have same issue on Linux as well.
> 
> Gerrit server is matching corporate policies with single sign on, so after
> three failed login attempts the account gets locked until a password reset.
> 
> Git amplifies this problem by asking for users password only once, and if
> user made a typo git is still re-using the wrong password enough times to
> get an account immediately locked.

Hmm. The sequence should be:

  - request, get 401
  - prompt user for password
  - retry request with password
  - if 401, die

IOW, we should make only a single request with the credential, and
immediately die afterwards. We do hit once to get the initial 401, but
we do not even provide a username, so unless the corporate policy is
locking out based on IP, it should not matter (and if it is, that shows
a fundamental misunderstanding about how a 401 is supposed to work).

But from your log, I see:

> ---------------------------------------------------------------
> 
> $ GIT_CURL_VERBOSE=1 git fetch
> ...
> > GET /gerrit/.../info/refs?service=git-upload-pack HTTP/1.1
> ...
> < HTTP/1.1 401 Authorization Required
> ...

Here's our first 401. OK.

> ---------- I guess git prompts for password here. --------------

Maybe...see below.

> * Server auth using Basic with user '...'
> > GET /gerrit/.../info/refs?service=git-upload-pack HTTP/1.1
> Authorization: Basic ...
> ...
> < HTTP/1.1 401 Authorization Required
> < Date: ...
> * Authentication problem. Ignoring this.
> ...
> * The requested URL returned error: 401

We get another 401. Now git should die. But it doesn't:

> * STATE: PROTOCONNECT => DO handle...
> * Server auth using Basic with user '...'
> > GET /gerrit/.../info/refs?service=git-upload-pack HTTP/1.1
> Authorization: Basic ...

It makes another request instead.

Weirdly, this does not result in a 401:

> * STATE: DO => DO_DONE handle...
> * STATE: DO_DONE => WAITPERFORM handle...
> * STATE: WAITPERFORM => PERFORM handle...
> ...
> < HTTP/1.1 302 Found
> ...
> < Location: ...funnylongurl
> ...
> * Ignoring the response-body
> * Connection #1 to host ... left intact
> * Issue another request to this URL: '...funnylongurl'
> ...
> * Server auth using Basic with user '...'
> > GET ...funnylongurl
> Authorization: Basic ...
> ...
> * The requested URL returned error: 500 Internal Server Error
> * Closing connection 1

We get redirected somewhere where we provide the (presumably wrong)
credential again. I do not think that is git's fault; the server asked
us to make the extra request. Is that part of the lockout procedure? If
it is not, it seems odd that the server would issue a redirect for a
bogus auth (shouldn't it just keep giving us 401?).

I do not know what is going on with the redirection there, but I have a
hunch on the extra auth round-trip.  What does your remote URL look
like? Does it have your username (e.g., https://user@host/project.git)?

I have noticed that if curl sees such a URL, it attempts to do a
password-less authentication itself, before even handing control back to
git. So my above sequence would become:

  1. git feeds URL to curl, who makes request
  2. we get a 401
  3. curl says "Oh, I have a username; let me try that" and re-requests
  4. we get another 401, because we need a password
  5. curl says "that didn't work" and hands control back to git
  6. git requests a password from the user and gives it to curl
  7. curl retries with the password, but it's wrong, so that results in
     a 401, too

At the end of it, we've now made _two_ failed requests for user X,
rather than one. I don't know if there's a way to tell curl not to try
the extra user-only round-trip. But you can strip the username out of
your URL to avoid it.

-Peff
