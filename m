From: Jeff King <peff@peff.net>
Subject: [PATCH 1/9] http: add HTTP_KEEP_ERROR option
Date: Fri, 5 Apr 2013 18:14:06 -0400
Message-ID: <20130405221406.GA22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:22:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWPz-0001b9-UR
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162925Ab3DEWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:14:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58233 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162922Ab3DEWOP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:14:15 -0400
Received: (qmail 18253 invoked by uid 107); 5 Apr 2013 22:16:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:16:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:14:06 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220207>

We currently set curl's FAILONERROR option, which means that
any http failures are reported as curl errors, and the
http body content from the server is thrown away.

This patch introduces a new option to http_get_strbuf which
specifies that the body content from a failed http response
should be placed in the destination strbuf, where it can be
accessed by the caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 37 +++++++++++++++++++++++++++++++++++++
 http.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/http.c b/http.c
index 8803c70..45cc7c7 100644
--- a/http.c
+++ b/http.c
@@ -761,6 +761,25 @@ int handle_curl_result(struct slot_results *results)
 
 int handle_curl_result(struct slot_results *results)
 {
+	/*
+	 * If we see a failing http code with CURLE_OK, we have turned off
+	 * FAILONERROR (to keep the server's custom error response), and should
+	 * translate the code into failure here.
+	 */
+	if (results->curl_result == CURLE_OK &&
+	    results->http_code >= 400) {
+		results->curl_result = CURLE_HTTP_RETURNED_ERROR;
+		/*
+		 * Normally curl will already have put the "reason phrase"
+		 * from the server into curl_errorstr; unfortunately without
+		 * FAILONERROR it is lost, so we can give only the numeric
+		 * status code.
+		 */
+		snprintf(curl_errorstr, sizeof(curl_errorstr),
+			 "The requested URL returned error: %ld",
+			 results->http_code);
+	}
+
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
 		return HTTP_OK;
@@ -825,6 +844,8 @@ static int http_request(const char *url, struct strbuf *type,
 	strbuf_addstr(&buf, "Pragma:");
 	if (options & HTTP_NO_CACHE)
 		strbuf_addstr(&buf, " no-cache");
+	if (options & HTTP_KEEP_ERROR)
+		curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
 	headers = curl_slist_append(headers, buf.buf);
 
@@ -862,6 +883,22 @@ static int http_request_reauth(const char *url,
 	int ret = http_request(url, type, result, target, options);
 	if (ret != HTTP_REAUTH)
 		return ret;
+
+	/*
+	 * If we are using KEEP_ERROR, the previous request may have
+	 * put cruft into our output stream; we should clear it out before
+	 * making our next request. We only know how to do this for
+	 * the strbuf case, but that is enough to satisfy current callers.
+	 */
+	if (options & HTTP_KEEP_ERROR) {
+		switch (target) {
+		case HTTP_REQUEST_STRBUF:
+			strbuf_reset(result);
+			break;
+		default:
+			die("BUG: HTTP_KEEP_ERROR is only supported with strbufs");
+		}
+	}
 	return http_request(url, type, result, target, options);
 }
 
diff --git a/http.h b/http.h
index 25d1931..0fe54f4 100644
--- a/http.h
+++ b/http.h
@@ -118,6 +118,7 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 
 /* Options for http_request_*() */
 #define HTTP_NO_CACHE		1
+#define HTTP_KEEP_ERROR		2
 
 /* Return values for http_request_*() */
 #define HTTP_OK			0
-- 
1.8.2.rc0.33.gd915649
