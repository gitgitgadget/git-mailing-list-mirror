From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] http: factor out http error code handling
Date: Mon, 27 Aug 2012 09:26:04 -0400
Message-ID: <20120827132604.GG17375@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zKZ-00022q-8Y
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab2H0N0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:26:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39709 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab2H0N0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:26:06 -0400
Received: (qmail 12940 invoked by uid 107); 27 Aug 2012 13:26:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:26:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:26:04 -0400
Content-Disposition: inline
In-Reply-To: <20120827132145.GA17265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204340>

Most of our http requests go through the http_request()
interface, which does some nice post-processing on the
results. In particular, it handles prompting for missing
credentials as well as approving and rejecting valid or
invalid credentials. Unfortunately, it only handles GET
requests. Making it handle POSTs would be quite complex, so
let's pull result handling code into its own function so
that it can be reused from the POST code paths.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 51 ++++++++++++++++++++++++++++-----------------------
 http.h |  1 +
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/http.c b/http.c
index b61ac85..6793137 100644
--- a/http.c
+++ b/http.c
@@ -745,6 +745,33 @@ char *get_remote_object_url(const char *url, const char *hex,
 	return strbuf_detach(&buf, NULL);
 }
 
+int handle_curl_result(struct active_request_slot *slot)
+{
+	struct slot_results *results = slot->results;
+
+	if (results->curl_result == CURLE_OK) {
+		credential_approve(&http_auth);
+		return HTTP_OK;
+	} else if (missing_target(results))
+		return HTTP_MISSING_TARGET;
+	else if (results->http_code == 401) {
+		if (http_auth.username && http_auth.password) {
+			credential_reject(&http_auth);
+			return HTTP_NOAUTH;
+		} else {
+			credential_fill(&http_auth);
+			init_curl_http_auth(slot->curl);
+			return HTTP_REAUTH;
+		}
+	} else {
+		if (!curl_errorstr[0])
+			strlcpy(curl_errorstr,
+				curl_easy_strerror(results->curl_result),
+				sizeof(curl_errorstr));
+		return HTTP_ERROR;
+	}
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -792,26 +819,7 @@ static int http_request(const char *url, void *result, int target, int options)
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (results.curl_result == CURLE_OK)
-			ret = HTTP_OK;
-		else if (missing_target(&results))
-			ret = HTTP_MISSING_TARGET;
-		else if (results.http_code == 401) {
-			if (http_auth.username && http_auth.password) {
-				credential_reject(&http_auth);
-				ret = HTTP_NOAUTH;
-			} else {
-				credential_fill(&http_auth);
-				init_curl_http_auth(slot->curl);
-				ret = HTTP_REAUTH;
-			}
-		} else {
-			if (!curl_errorstr[0])
-				strlcpy(curl_errorstr,
-					curl_easy_strerror(results.curl_result),
-					sizeof(curl_errorstr));
-			ret = HTTP_ERROR;
-		}
+		ret = handle_curl_result(slot);
 	} else {
 		error("Unable to start HTTP request for %s", url);
 		ret = HTTP_START_FAILED;
@@ -820,9 +828,6 @@ static int http_request(const char *url, void *result, int target, int options)
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 
-	if (ret == HTTP_OK)
-		credential_approve(&http_auth);
-
 	return ret;
 }
 
diff --git a/http.h b/http.h
index 915c286..12de255 100644
--- a/http.h
+++ b/http.h
@@ -78,6 +78,7 @@ extern int start_active_slot(struct active_request_slot *slot);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
+extern int handle_curl_result(struct active_request_slot *slot);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
-- 
1.7.11.5.10.g3c8125b
