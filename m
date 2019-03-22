Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305C120248
	for <e@80x24.org>; Fri, 22 Mar 2019 07:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfCVHMg (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 03:12:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:60434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727882AbfCVHMe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 03:12:34 -0400
Received: (qmail 6416 invoked by uid 109); 22 Mar 2019 07:12:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Mar 2019 07:12:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17307 invoked by uid 111); 22 Mar 2019 07:12:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Mar 2019 03:12:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2019 03:12:31 -0400
Date:   Fri, 22 Mar 2019 03:12:31 -0400
From:   Jeff King <peff@peff.net>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Wolfgang Denk <wd@denx.de>
Subject: Re: [BUG] Cloning with git HEAD fails for some repositories
Message-ID: <20190322071231.GA26114@sigill.intra.peff.net>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
 <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 07:02:41AM +0100, Heinrich Schuchardt wrote:

> Initial cloning via
> 
>     git clone http://git.denx.de/u-boot-efi.git
> 
> fails with git version 2.21.0.196.g041f5ea1cf
> 
> git version 2.1.4 works fine.
> 
> Bisection points to this first bad commit:
> 17966c0a63d25b1cc2dd1e98d30873e643bd581f
> http: avoid disconnecting on 404s for loose objects
> 
> Please, fix the regression.

I think 17966c0a63d needed to massage the CURLcode in more places, since
missing_target() cares about it. The patch below gets me past the error
you saw, but later dies with:

  error: Request for 283d73eda8011371f12daa2cd9fc3107705637dc aborted
  error: Unable to find 283d73eda8011371f12daa2cd9fc3107705637dc under https://git.denx.de/u-boot-efi.git
  Cannot obtain needed object 283d73eda8011371f12daa2cd9fc3107705637dc
  while processing commit d9af3c87df93e1a8126b1a52adf8db978e9a0d40.
  error: fetch failed.

However, so does the parent of 17966c0a63d. So I don't know if the
u-boot-efi repo is just broken, or if there's some other different bug
at play.

-Peff

diff --git a/http-walker.c b/http-walker.c
index 48f2df4d31..83e23e787c 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -93,6 +93,9 @@ static void process_object_response(void *callback_data)
 	process_http_object_request(obj_req->req);
 	obj_req->state = COMPLETE;
 
+	normalize_curl_result(&obj_req->req->curl_result,
+			      obj_req->req->http_code);
+
 	/* Use alternates if necessary */
 	if (missing_target(obj_req->req)) {
 		fetch_alternates(walker, alt->base);
@@ -189,6 +192,8 @@ static void process_alternates_response(void *callback_data)
 	char *data;
 	int i = 0;
 
+	normalize_curl_result(&slot->curl_result, slot->http_code);
+
 	if (alt_req->http_specific) {
 		if (slot->curl_result != CURLE_OK ||
 		    !alt_req->buffer->len) {
@@ -488,14 +493,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		req->localfile = -1;
 	}
 
-	/*
-	 * we turned off CURLOPT_FAILONERROR to avoid losing a
-	 * persistent connection and got CURLE_OK.
-	 */
-	if (req->http_code == 404 && req->curl_result == CURLE_OK &&
-			(starts_with(req->url, "http://") ||
-			 starts_with(req->url, "https://")))
-		req->curl_result = CURLE_HTTP_RETURNED_ERROR;
+	normalize_curl_result(&req->curl_result, req->http_code);
 
 	if (obj_req->state == ABORTED) {
 		ret = error("Request for %s aborted", hex);
diff --git a/http.c b/http.c
index 6f12661a14..1d60a0064a 100644
--- a/http.c
+++ b/http.c
@@ -1116,16 +1116,15 @@ char *get_remote_object_url(const char *url, const char *hex,
 	return strbuf_detach(&buf, NULL);
 }
 
-static int handle_curl_result(struct slot_results *results)
+void normalize_curl_result(CURLcode *result, long http_code)
 {
 	/*
 	 * If we see a failing http code with CURLE_OK, we have turned off
 	 * FAILONERROR (to keep the server's custom error response), and should
 	 * translate the code into failure here.
 	 */
-	if (results->curl_result == CURLE_OK &&
-	    results->http_code >= 400) {
-		results->curl_result = CURLE_HTTP_RETURNED_ERROR;
+	if (*result == CURLE_OK && http_code >= 400) {
+		*result = CURLE_HTTP_RETURNED_ERROR;
 		/*
 		 * Normally curl will already have put the "reason phrase"
 		 * from the server into curl_errorstr; unfortunately without
@@ -1134,8 +1133,13 @@ static int handle_curl_result(struct slot_results *results)
 		 */
 		snprintf(curl_errorstr, sizeof(curl_errorstr),
 			 "The requested URL returned error: %ld",
-			 results->http_code);
+			 http_code);
 	}
+}
+
+static int handle_curl_result(struct slot_results *results)
+{
+	normalize_curl_result(&results->curl_result, results->http_code);
 
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
diff --git a/http.h b/http.h
index 36f558bfb3..1c75e99570 100644
--- a/http.h
+++ b/http.h
@@ -129,6 +129,12 @@ static inline int missing__target(int code, int result)
 
 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
 
+/*
+ * Yuck, we cannot just pass the struct containing these because we store the
+ * results in various structs.
+ */
+void normalize_curl_result(CURLcode *result, long http_code);
+
 /* Helpers for modifying and creating URLs */
 extern void append_remote_object_url(struct strbuf *buf, const char *url,
 				     const char *hex,
