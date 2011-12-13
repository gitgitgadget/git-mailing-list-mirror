From: Jeff King <peff@peff.net>
Subject: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 15:25:08 -0500
Message-ID: <20111213202508.GA12187@sigill.intra.peff.net>
References: <20111213201704.GA12072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:25:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYua-000269-1D
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab1LMUZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:25:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49768
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871Ab1LMUZK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:25:10 -0500
Received: (qmail 24087 invoked by uid 107); 13 Dec 2011 20:31:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 15:31:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 15:25:08 -0500
Content-Disposition: inline
In-Reply-To: <20111213201704.GA12072@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187059>

This reverts commit 986bbc0842334f0e07731fa37f2a55d2930a5b8c.

The rationale for that commit relied on the fact that asking
for the password up-front was merely an optimization,
because git will notice an HTTP 401 and prompt for the
password. However, that is only true for smart-http, and for
dumb fetching. Dumb push over DAV does not have this
feature; as a result, authenticated push-over-DAV does not
work at all, as it never prompts the user for a password.

Signed-off-by: Jeff King <peff@peff.net>
---
We need to deal with this regression for v1.7.8.1, I think.

There are basically three options for fixing it:

  1. Teach http-push the same retry-after-401 trick that the rest of the
     http code knows.

  2. Refactor the retry-after-401 logic from http.c into a common
     function that http-push can build on top of.

  3. Revert 986bbc08 and leave it alone; it only hurts .netrc users,
     there's a reasonable workaround (don't put the user in the URL) and
     hopefully those people will convert to using better storage via
     credential helper once it is available.

I looked at doing (1), but my first attempt[1] didn't quite work. So
it's not a huge amount of code, but it's annoyingly non-trivial. And as
a long-term solution, it's just making hack-y code hackier.

Doing (2) would be the best solution, but it's going to require some
pretty major surgery to http.c and http-push.c. I'll take a look, but if
it gets too complex, it may simply not be worth it (now that smart-http
is available, I would hope that push-over-DAV is slowly going away).

Doing (3) is obviously the easiest thing. And given the complexity of
the other two solutions, I think it makes sense to revert 986bbc08
(i.e., apply this patch), ship a working v1.7.8.1, and then look at
doing one of the other two solutions for v1.7.9.

[1] http://article.gmane.org/gmane.comp.version-control.msysgit/14153

 http.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 008ad72..a4bc770 100644
--- a/http.c
+++ b/http.c
@@ -279,6 +279,8 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif
 
+	init_curl_http_auth(result);
+
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
@@ -844,7 +846,7 @@ static int http_request(const char *url, void *result, int target, int options)
 		else if (missing_target(&results))
 			ret = HTTP_MISSING_TARGET;
 		else if (results.http_code == 401) {
-			if (user_name && user_pass) {
+			if (user_name) {
 				ret = HTTP_NOAUTH;
 			} else {
 				/*
@@ -853,8 +855,7 @@ static int http_request(const char *url, void *result, int target, int options)
 				 * but that is non-portable.  Using git_getpass() can at least be stubbed
 				 * on other platforms with a different implementation if/when necessary.
 				 */
-				if (!user_name)
-					user_name = xstrdup(git_getpass_with_description("Username", description));
+				user_name = xstrdup(git_getpass_with_description("Username", description));
 				init_curl_http_auth(slot->curl);
 				ret = HTTP_REAUTH;
 			}
-- 
1.7.8.17.gfd3524
