From: Jeff King <peff@peff.net>
Subject: [PATCH 05/14] http: retry authentication failures for all http
 requests
Date: Mon, 18 Jul 2011 03:50:14 -0400
Message-ID: <20110718075014.GE12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:50:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiiav-0004H2-Ue
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab1GRHuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:50:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50621
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048Ab1GRHuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:50:16 -0400
Received: (qmail 19801 invoked by uid 107); 18 Jul 2011 07:50:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:50:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:50:14 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177348>

Commit 42653c0 (Prompt for a username when an HTTP request
401s, 2010-04-01) changed http_get_strbuf to prompt for
credentials when we receive a 401, but didn't touch
http_get_file. The latter is called only for dumb http;
while it's usually the case that people don't use
authentication on top of dumb http, there is no reason not
to allow both types of requests to use this feature.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index c93716c..89e3cf4 100644
--- a/http.c
+++ b/http.c
@@ -846,13 +846,18 @@ static int http_request(const char *url, void *result, int target, int options)
 	return ret;
 }
 
+static int http_request_reauth(const char *url, void *result, int target,
+			       int options)
+{
+	int ret = http_request(url, result, target, options);
+	if (ret != HTTP_REAUTH)
+		return ret;
+	return http_request(url, result, target, options);
+}
+
 int http_get_strbuf(const char *url, struct strbuf *result, int options)
 {
-	int http_ret = http_request(url, result, HTTP_REQUEST_STRBUF, options);
-	if (http_ret == HTTP_REAUTH) {
-		http_ret = http_request(url, result, HTTP_REQUEST_STRBUF, options);
-	}
-	return http_ret;
+	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
 }
 
 /*
@@ -875,7 +880,7 @@ static int http_get_file(const char *url, const char *filename, int options)
 		goto cleanup;
 	}
 
-	ret = http_request(url, result, HTTP_REQUEST_FILE, options);
+	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
 	if ((ret == HTTP_OK) && move_temp_to_file(tmpfile.buf, filename))
-- 
1.7.6.rc1.12.g65e2
