From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: git https transport and wrong password
Date: Wed, 3 Apr 2013 19:15:36 +0300
Message-ID: <20130403161536.GZ30514@lakka.kapsi.fi>
References: <20130402155440.GT30514@lakka.kapsi.fi>
 <20130402192845.GC17784@sigill.intra.peff.net>
 <20130402194751.GV30514@lakka.kapsi.fi>
 <20130402200551.GA535@sigill.intra.peff.net>
 <20130402202054.GX30514@lakka.kapsi.fi>
 <20130403094302.GY30514@lakka.kapsi.fi>
 <20130403141212.GA10494@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 03 18:16:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNQMC-00049T-FH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 18:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761015Ab3DCQPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 12:15:43 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:54302 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761722Ab3DCQPl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 12:15:41 -0400
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UNQLY-0008M0-VP; Wed, 03 Apr 2013 19:15:36 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UNQLY-0007nU-Sg; Wed, 03 Apr 2013 19:15:36 +0300
Content-Disposition: inline
In-Reply-To: <20130403141212.GA10494@sigill.intra.peff.net>
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mikko.rapeli@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219953>

On Wed, Apr 03, 2013 at 10:12:12AM -0400, Jeff King wrote:
> I would expect without the username in the URL for it to make only two
> requests: one to get the first 401, then git collects the credentials,
> then a follow-up with the credentials. But instead we get:
> 
>   $ GIT_CURL_VERBOSE=1 git ls-remote https://github.com/requires/auth \
>       2>&1 >/dev/null | egrep '^>|^< HTTP|^Authorization|requested URL'
>   > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
>   * The requested URL returned error: 401 Authorization Required
>   Username for 'https://github.com': foo
>   Password for 'https://foo@github.com': 
>   > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
>   < HTTP/1.1 401 Authorization Required
>   > GET /requires/auth/info/refs?service=git-upload-pack HTTP/1.1
>   Authorization: Basic Zm9vOmJhcg==
>   < HTTP/1.1 401 Authorization Required
>   * The requested URL returned error: 401
> 
> So we get a 401, as expected, git prompts for the credentials and feeds
> them directly to curl, but then we still get _two_ requests: we trigger
> another 401, and only then does curl provide the authorization header to
> the server.
> 
> I'm not sure if that extra auth is intended or not.

git uses CURLAUTH_ANY which means: first try without authentication
(CURLAUTH_NONE), if that fails it will try (I guess) CURLAUTH_BASIC|DIGEST|
GSS|NTML and so on, and only then it will fail with the 401.

It seems that skipping CURLAUTH_NONE try is not possible even if it's
not a good idea when a username and possibly password is available.
Changing CURLAUTH_ANY to skip CURLAUTH_NONE could also break other
users.

Since netrc support really needs this one try from git to curl before
password prompt I guess in our case using HTTPS with git is simply not
feasible. Changing the corporate single sign-on policies is also hard
so I will now try to get SSH transport running on the server.

Account locking will still be quite easy but hopefully only after
multiple false passwords to the SSH promp.

-Mikko
