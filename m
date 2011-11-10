From: Jeff King <peff@peff.net>
Subject: [PATCH 03/14] http: refactor http_request function
Date: Thu, 10 Nov 2011 02:48:31 -0500
Message-ID: <20111110074831.GC27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:48:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPNH-0002Yb-2V
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422Ab1KJHse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:48:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38911
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684Ab1KJHse (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:48:34 -0500
Received: (qmail 22203 invoked by uid 107); 10 Nov 2011 07:48:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:48:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:48:31 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185200>

This function takes a flag to indicate where the output
should go (either to a file or to a strbuf). This flag is
mostly used to set the callback function we hand to curl.

This isn't very flexible for adding new output types.
Instead, let's just let callers pass in the callback
function directly. This results in shorter, more readable,
and more flexible code.

The only other thing the flag was used for was to set a
"Range" header when we already have a partial file (by using
the results of ftell). This patch also adds an "offset"
parameter, which can be used by callers to specify this
feature separately (which is also more flexible, as non-FILE
callers can now resume partial transfers).

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c |   37 ++++++++++++++-----------------------
 1 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/http.c b/http.c
index 4f9e004..9ffd894 100644
--- a/http.c
+++ b/http.c
@@ -797,11 +797,8 @@ void append_remote_object_url(struct strbuf *buf, const char *url,
 	return strbuf_detach(&buf, NULL);
 }
 
-/* http_request() targets */
-#define HTTP_REQUEST_STRBUF	0
-#define HTTP_REQUEST_FILE	1
-
-static int http_request(const char *url, void *result, int target, int options)
+static int http_request(const char *url, curl_write_callback cb, void *result,
+			long offset, int options)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -818,19 +815,13 @@ static int http_request(const char *url, void *result, int target, int options)
 	} else {
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);
+		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, cb);
+	}
 
-		if (target == HTTP_REQUEST_FILE) {
-			long posn = ftell(result);
-			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-					 fwrite);
-			if (posn > 0) {
-				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
-				headers = curl_slist_append(headers, buf.buf);
-				strbuf_reset(&buf);
-			}
-		} else
-			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-					 fwrite_buffer);
+	if (offset > 0) {
+		strbuf_addf(&buf, "Range: bytes=%lu-", offset);
+		headers = curl_slist_append(headers, buf.buf);
+		strbuf_reset(&buf);
 	}
 
 	strbuf_addstr(&buf, "Pragma:");
@@ -881,18 +872,18 @@ static int http_request(const char *url, void *result, int target, int options)
 	return ret;
 }
 
-static int http_request_reauth(const char *url, void *result, int target,
-			       int options)
+static int http_request_reauth(const char *url, curl_write_callback cb,
+			       void *result, unsigned long offset, int options)
 {
-	int ret = http_request(url, result, target, options);
+	int ret = http_request(url, cb, result, offset, options);
 	if (ret != HTTP_REAUTH)
 		return ret;
-	return http_request(url, result, target, options);
+	return http_request(url, cb, result, offset, options);
 }
 
 int http_get_strbuf(const char *url, struct strbuf *result, int options)
 {
-	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
+	return http_request_reauth(url, fwrite_buffer, result, 0, options);
 }
 
 /*
@@ -915,7 +906,7 @@ static int http_get_file(const char *url, const char *filename, int options)
 		goto cleanup;
 	}
 
-	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
+	ret = http_request_reauth(url, NULL, result, ftell(result), options);
 	fclose(result);
 
 	if ((ret == HTTP_OK) && move_temp_to_file(tmpfile.buf, filename))
-- 
1.7.7.2.7.g9f96f
