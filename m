From: Jeff King <peff@peff.net>
Subject: Re: git https transport and wrong password
Date: Wed, 3 Apr 2013 10:12:12 -0400
Message-ID: <20130403141212.GA10494@sigill.intra.peff.net>
References: <20130402155440.GT30514@lakka.kapsi.fi>
 <20130402192845.GC17784@sigill.intra.peff.net>
 <20130402194751.GV30514@lakka.kapsi.fi>
 <20130402200551.GA535@sigill.intra.peff.net>
 <20130402202054.GX30514@lakka.kapsi.fi>
 <20130403094302.GY30514@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 03 16:12:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNOQj-0001lM-1R
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 16:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068Ab3DCOMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 10:12:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53451 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab3DCOMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 10:12:17 -0400
Received: (qmail 24387 invoked by uid 107); 3 Apr 2013 14:14:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Apr 2013 10:14:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2013 10:12:12 -0400
Content-Disposition: inline
In-Reply-To: <20130403094302.GY30514@lakka.kapsi.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219935>

[+cc Daniel for curl questions below]

On Wed, Apr 03, 2013 at 12:43:02PM +0300, Mikko Rapeli wrote:

> Maybe my git installation was incomplete before when running from ~/bin since
> I was not able to set break points to http_request() and some debug code
> was not there until I ran git through bin-wrappers in the source tree.

Debugging git-over-http is somewhat difficult because the interesting
bits happen in sub-processes. You can get much closer to the http calls
by running the transport helper directly, like:

  gdb --args git-remote-https https://yourhost/

which will start by reading commands from stdin (try "list" to get it to
fetch the remote refs).

> I added some debug prints to http.c functions http_request() and
> handle_curl_result(), and now I see this chain of events:
> 
>  http_request_reauth()
>  http_request()
>  GET ...info/refs?service=git-upload-pack
>  HTTP/1.1 401 Authorization Required
> * Ignoring the response-body
> * Issue another request to this URL: '...'
>  GET ...info/refs?service=git-upload-pack
>  HTTP/1.1 401 Authorization Required
>  handle_curl_result: res = 22, http_code = 401, user = ..., pass = (null)
> Password for '...': (enter valid password)
>  GET ...info/refs?service=git-upload-pack
>  HTTP/1.1 200 OK
> 
> So, for some reason the first GET request is issued twice and first 401
> is ignored. I'll try to debug run_active_slot() next...

Right, I think that's curl trying to make use of the username in the
URL. Try this (I'm using github here as a convenient http servers, but
you should be able to replicate with your internal server):

  $ GIT_CURL_VERBOSE=1 git ls-remote https://foo@github.com/requires/auth \
      2>&1 >/dev/null | egrep '^>|^< HTTP|^Authorization|requested URL'
  > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
  < HTTP/1.1 401 Authorization Required
  > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
  Authorization: Basic Zm9vOg==
  < HTTP/1.1 401 Authorization Required
  * The requested URL returned error: 401
  Password for 'https://foo@github.com': 
  > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
  Authorization: Basic Zm9vOmJhcg==
  < HTTP/1.1 401 Authorization Required
  * The requested URL returned error: 401

So you can see that curl makes _two_ requests internally before it
returns the 401. One unadorned, and one with just the username
("Zm9vOg==", which decodes to "foo:") for the auth. Then git prompts for
the password, and we retry (and of course I am feeding it a bogus
username/password combo, so we get another 401).

I would expect without the username in the URL for it to make only two
requests: one to get the first 401, then git collects the credentials,
then a follow-up with the credentials. But instead we get:

  $ GIT_CURL_VERBOSE=1 git ls-remote https://github.com/requires/auth \
      2>&1 >/dev/null | egrep '^>|^< HTTP|^Authorization|requested URL'
  > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
  * The requested URL returned error: 401 Authorization Required
  Username for 'https://github.com': foo
  Password for 'https://foo@github.com': 
  > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
  < HTTP/1.1 401 Authorization Required
  > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
  Authorization: Basic Zm9vOmJhcg==
  < HTTP/1.1 401 Authorization Required
  * The requested URL returned error: 401

So we get a 401, as expected, git prompts for the credentials and feeds
them directly to curl, but then we still get _two_ requests: we trigger
another 401, and only then does curl provide the authorization header to
the server.

I'm not sure if that extra auth is intended or not.

It's also possible that git is screwing up in providing the credentials
to curl, but I don't think so. We feed them to the curl handle as soon
as we get them, and there should be only one handle in use here.

-Peff
