Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA5220601
	for <e@80x24.org>; Sun, 24 Mar 2019 12:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfCXMIk (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:08:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:34194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726160AbfCXMIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:08:40 -0400
Received: (qmail 4490 invoked by uid 109); 24 Mar 2019 12:08:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Mar 2019 12:08:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1518 invoked by uid 111); 24 Mar 2019 12:09:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Mar 2019 08:09:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2019 08:08:38 -0400
Date:   Sun, 24 Mar 2019 08:08:38 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Wolfgang Denk <wd@denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: [PATCH 1/3] http: factor out curl result code normalization
Message-ID: <20190324120838.GA312@sigill.intra.peff.net>
References: <20190324120757.GA18684@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190324120757.GA18684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We make some requests with CURLOPT_FAILONERROR and some without, and
then handle_curl_result() normalizes any failures to a uniform CURLcode.

There are some other code paths in the dumb-http walker which don't use
handle_curl_result(); let's pull the normalization into its own function
so it can be reused.

Arguably those code paths would benefit from the rest of
handle_curl_result(), notably the auth handling. But retro-fitting it
now would be a lot of work, and in practice it doesn't matter too much
(whatever authentication we needed to make the initial contact with the
server is generally sufficient for the rest of the dumb-http requests).

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 18 ++++++++++++------
 http.h |  9 +++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index a32ad36ddf..89fcd36a80 100644
--- a/http.c
+++ b/http.c
@@ -1544,7 +1544,8 @@ char *get_remote_object_url(const char *url, const char *hex,
 	return strbuf_detach(&buf, NULL);
 }
 
-static int handle_curl_result(struct slot_results *results)
+void normalize_curl_result(CURLcode *result, long http_code,
+			   char *errorstr, size_t errorlen)
 {
 	/*
 	 * If we see a failing http code with CURLE_OK, we have turned off
@@ -1554,19 +1555,24 @@ static int handle_curl_result(struct slot_results *results)
 	 * Likewise, if we see a redirect (30x code), that means we turned off
 	 * redirect-following, and we should treat the result as an error.
 	 */
-	if (results->curl_result == CURLE_OK &&
-	    results->http_code >= 300) {
-		results->curl_result = CURLE_HTTP_RETURNED_ERROR;
+	if (*result == CURLE_OK && http_code >= 300) {
+		*result = CURLE_HTTP_RETURNED_ERROR;
 		/*
 		 * Normally curl will already have put the "reason phrase"
 		 * from the server into curl_errorstr; unfortunately without
 		 * FAILONERROR it is lost, so we can give only the numeric
 		 * status code.
 		 */
-		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
+		xsnprintf(errorstr, errorlen,
 			  "The requested URL returned error: %ld",
-			  results->http_code);
+			  http_code);
 	}
+}
+
+static int handle_curl_result(struct slot_results *results)
+{
+	normalize_curl_result(&results->curl_result, results->http_code,
+			      curl_errorstr, sizeof(curl_errorstr));
 
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
diff --git a/http.h b/http.h
index 4eb4e808e5..f0d271bb7b 100644
--- a/http.h
+++ b/http.h
@@ -136,6 +136,15 @@ static inline int missing__target(int code, int result)
 
 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
 
+/*
+ * Normalize curl results to handle CURL_FAILONERROR (or lack thereof). Failing
+ * http codes have their "result" converted to CURLE_HTTP_RETURNED_ERROR, and
+ * an appropriate string placed in the errorstr buffer (pass curl_errorstr if
+ * you don't have a custom buffer).
+ */
+void normalize_curl_result(CURLcode *result, long http_code, char *errorstr,
+			   size_t errorlen);
+
 /* Helpers for modifying and creating URLs */
 extern void append_remote_object_url(struct strbuf *buf, const char *url,
 				     const char *hex,
-- 
2.21.0.705.g64cb90f133

