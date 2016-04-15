From: Jeff King <peff@peff.net>
Subject: Re: Default authentication over https?
Date: Fri, 15 Apr 2016 18:43:35 -0400
Message-ID: <20160415224334.GA32160@sigill.intra.peff.net>
References: <CAPf1peAW11hZpN6_ztA62tcu6mgCfV3VwwjjtXT5yySUPD9Qpw@mail.gmail.com>
 <20160413223613.GB10011@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604141142190.23813@tvnag.unkk.fr>
 <CAPf1peDf_YbDsaz1ykvzKLkdUWtSqrHT7yrgfUgjE4R1eS4r6g@mail.gmail.com>
 <20160415222120.GA24777@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Daniel Stenberg <daniel@haxx.se>, git <git@vger.kernel.org>
To: Isaac Levy <isaac.r.levy@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:43:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCSk-0004mJ-G8
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbcDOWni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:43:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:50520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751406AbcDOWni (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:43:38 -0400
Received: (qmail 15071 invoked by uid 102); 15 Apr 2016 22:43:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 18:43:37 -0400
Received: (qmail 16327 invoked by uid 107); 15 Apr 2016 22:43:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 18:43:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2016 18:43:35 -0400
Content-Disposition: inline
In-Reply-To: <20160415222120.GA24777@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291685>

On Fri, Apr 15, 2016 at 06:21:20PM -0400, Jeff King wrote:

> I think we can take that down to _two_ requests pretty easily. We know
> in the very first request that the server told us something like:
> 
>   < WWW-Authenticate: Basic realm="GitHub"
> 
> but curl doesn't remember that. However, we should be able to pull it
> out of the old request and feed it into the new one. That would save the
> second request, which is just a probe.

Hmm. Looks like we already pull this out of the curl result for other
reasons, but we never feed it back in to the next request. So if I do
this:

diff --git a/http.c b/http.c
index 9bedad7..add9bf2 100644
--- a/http.c
+++ b/http.c
@@ -1132,6 +1132,8 @@ static int handle_curl_result(struct slot_results *results)
 			return HTTP_NOAUTH;
 		} else {
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+			if (results->auth_avail)
+				http_auth_methods = results->auth_avail;
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
 #endif
 			return HTTP_REAUTH;

that drops my test case down to two requests: once to find out that we
need auth via the 401, and then we feed curl sufficient information to
do the followup in a single request (the GSSNEGOTIATE thing there is a
hack from 4dbe664, which we can ignore for now).

Interestingly, curl _does_ reuse the connection this time. I'm still not
sure why it didn't in the original case. But this means the whole thing
is happening over a single TCP session, which is good (and I didn't have
to change my config at all).

-Peff
