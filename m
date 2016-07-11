Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4ED61F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbcGKUvm (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:51:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33732 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932221AbcGKUvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:51:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8CAA20191;
	Mon, 11 Jul 2016 20:51:35 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Eric Wong <e@80x24.org>
Subject: [PATCH 2/3] http: avoid disconnecting on 404s for loose objects
Date:	Mon, 11 Jul 2016 20:51:30 +0000
Message-Id: <20160711205131.1291-3-e@80x24.org>
In-Reply-To: <20160711205131.1291-1-e@80x24.org>
References: <20160711205131.1291-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

404s are common when fetching loose objects on static HTTP
servers, and reestablishing a connection for every single
404 adds additional latency.

Signed-off-by: Eric Wong <e@80x24.org>
---
 http-walker.c |  9 +++++++++
 http.c        | 16 ++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 9f28523..48f2df4 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -488,6 +488,15 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		req->localfile = -1;
 	}
 
+	/*
+	 * we turned off CURLOPT_FAILONERROR to avoid losing a
+	 * persistent connection and got CURLE_OK.
+	 */
+	if (req->http_code == 404 && req->curl_result == CURLE_OK &&
+			(starts_with(req->url, "http://") ||
+			 starts_with(req->url, "https://")))
+		req->curl_result = CURLE_HTTP_RETURNED_ERROR;
+
 	if (obj_req->state == ABORTED) {
 		ret = error("Request for %s aborted", hex);
 	} else if (req->curl_result != CURLE_OK &&
diff --git a/http.c b/http.c
index d8b2bec..e81dd13 100644
--- a/http.c
+++ b/http.c
@@ -1975,8 +1975,19 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 	unsigned char expn[4096];
 	size_t size = eltsize * nmemb;
 	int posn = 0;
-	struct http_object_request *freq =
-		(struct http_object_request *)data;
+	struct http_object_request *freq = data;
+	struct active_request_slot *slot = freq->slot;
+
+	if (slot) {
+		CURLcode c = curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE,
+						&slot->http_code);
+		if (c != CURLE_OK)
+			die("BUG: curl_easy_getinfo for HTTP code failed: %s",
+				curl_easy_strerror(c));
+		if (slot->http_code >= 400)
+			return size;
+	}
+
 	do {
 		ssize_t retval = xwrite(freq->localfile,
 					(char *) ptr + posn, size - posn);
@@ -2097,6 +2108,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	freq->slot = get_active_slot();
 
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
-- 
EW

