From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fix http auth with multiple curl handles
Date: Thu, 12 Apr 2012 03:09:10 -0400
Message-ID: <20120412070910.GA31122@sigill.intra.peff.net>
References: <20120402083115.GA2235@sigill.intra.peff.net>
 <1334051620-18044-1-git-send-email-drizzd@aon.at>
 <1334051620-18044-3-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Apr 12 09:09:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIE9w-0007Ee-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 09:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762071Ab2DLHJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 03:09:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58352
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757468Ab2DLHJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 03:09:12 -0400
Received: (qmail 24041 invoked by uid 107); 12 Apr 2012 07:09:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 03:09:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 03:09:10 -0400
Content-Disposition: inline
In-Reply-To: <1334051620-18044-3-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195305>

On Tue, Apr 10, 2012 at 11:53:40AM +0200, Clemens Buchacher wrote:

> HTTP authentication is currently handled by get_refs and fetch_ref, but
> not by fetch_object, fetch_pack or fetch_alternates. In the
> single-threaded case, this is not an issue, since get_refs is always
> called first. It recognigzes the 401 and prompts the user for
> credentials, which will then be used subsequently.
> 
> If the curl multi interface is used, however, only the multi handle used
> by get_refs will have credentials configured. Requests made by other
> handles fail with an authentication error.
> 
> Fix this by setting CURLOPT_USERPWD whenever a slot is requested.

The reason I didn't like my initial patch was that by calling
curl_easy_setopt() for every request, we end up leaking the password
buffer once per request.

Unfortunately, I don't think there's a way to ask curl whether it has
anything in CURLOPT_USERPWD. So we have to overwrite. Recent versions of
curl will actually copy the string we give it anyway, so the existing
code is already leaking a little bit (but once per process, not once per
request). I wish we could get away with just handing curl the data and
assuming it would copy, but that code came about in curl 7.17.0, in
2007. According to our #if statements, we handle much older versions of
curl, so that is a non-option.

I think the best we can do is to put the auth data in a static buffer
and feed that to curl. We end up rewriting the auth data into our buffer
over and over, but at least we don't re-malloc it. Like this:

diff --git a/http.c b/http.c
index f3f83d7..374c3bb 100644
--- a/http.c
+++ b/http.c
@@ -211,12 +211,12 @@ static int http_options(const char *var, const char *value, void *cb)
 static void init_curl_http_auth(CURL *result)
 {
 	if (http_auth.username) {
-		struct strbuf up = STRBUF_INIT;
+		static struct strbuf up = STRBUF_INIT;
 		credential_fill(&http_auth);
+		strbuf_reset(&up);
 		strbuf_addf(&up, "%s:%s",
 			    http_auth.username, http_auth.password);
-		curl_easy_setopt(result, CURLOPT_USERPWD,
-				 strbuf_detach(&up, NULL));
+		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
 	}
 }
 

By the way, this touches on an area that I noticed while refactoring the
http auth code a while ago, but decided not to tackle at the time. We
fill in the auth information early, and then never bother to revisit it
as URLs change. So for example, if I got a redirect from host A to host
B, we would continue to use the credential for host A and host B. Which
is maybe convenient, and maybe a security issue.

It has been that way since the beginning of git, and nobody has seemed
to care. So maybe it is not worth dealing with. But if we did want to,
the right way would be to keep several credentials on hand, and match
each URL to them as we were about to request it. That would also provide
a fix to the problem we are fixing here. I don't know if it is worth
doing or not.

-Peff
