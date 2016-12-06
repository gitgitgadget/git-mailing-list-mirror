Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371C420259
	for <e@80x24.org>; Tue,  6 Dec 2016 18:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbcLFSZq (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:25:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:52618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbcLFSZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:25:41 -0500
Received: (qmail 4753 invoked by uid 109); 6 Dec 2016 18:25:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 18:25:40 +0000
Received: (qmail 15828 invoked by uid 111); 6 Dec 2016 18:26:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:26:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 13:25:39 -0500
Date:   Tue, 6 Dec 2016 13:25:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v2 6/6] http-walker: complain about non-404 loose object
 errors
Message-ID: <20161206182539.tiyvf2c3j2acoxqt@sigill.intra.peff.net>
References: <20161206182414.466uotqfufcimpqb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161206182414.466uotqfufcimpqb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 17966c0a6 (http: avoid disconnecting on 404s
for loose objects, 2016-07-11), we turn off curl's
FAILONERROR option and instead manually deal with failing
HTTP codes.

However, the logic to do so only recognizes HTTP 404 as a
failure. This is probably the most common result, but if we
were to get another code, the curl result remains CURLE_OK,
and we treat it as success. We still end up detecting the
failure when we try to zlib-inflate the object (which will
fail), but instead of reporting the HTTP error, we just
claim that the object is corrupt.

Instead, let's catch anything in the 300's or above as an
error (300's are redirects which are not an error at the
HTTP level, but are an indication that we've explicitly
disabled redirects, so we should treat them as such; we
certainly don't have the resulting object content).

Note that we also fill in req->errorstr, which we didn't do
before. Without FAILONERROR, curl will not have filled this
in, and it will remain a blank string. This never mattered
for the 404 case, because in the logic below we hit the
"missing_target()" branch and print nothing. But for other
errors, we'd want to say _something_, if only to fill in the
blank slot in the error message.

Signed-off-by: Jeff King <peff@peff.net>
---
The second hunk here is new in v2; earlier it appeared in patch 3. But
arguably it goes better here anyway; I didn't even need to modify the
commit message to explain it.

 http-walker.c | 7 +++++--
 http.c        | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 25a8b1ad4..c2f81cd6a 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -482,10 +482,13 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 	 * we turned off CURLOPT_FAILONERROR to avoid losing a
 	 * persistent connection and got CURLE_OK.
 	 */
-	if (req->http_code == 404 && req->curl_result == CURLE_OK &&
+	if (req->http_code >= 300 && req->curl_result == CURLE_OK &&
 			(starts_with(req->url, "http://") ||
-			 starts_with(req->url, "https://")))
+			 starts_with(req->url, "https://"))) {
 		req->curl_result = CURLE_HTTP_RETURNED_ERROR;
+		xsnprintf(req->errorstr, sizeof(req->errorstr),
+			  "HTTP request failed");
+	}
 
 	if (obj_req->state == ABORTED) {
 		ret = error("Request for %s aborted", hex);
diff --git a/http.c b/http.c
index ff4d88231..c25d1d540 100644
--- a/http.c
+++ b/http.c
@@ -2021,7 +2021,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		if (c != CURLE_OK)
 			die("BUG: curl_easy_getinfo for HTTP code failed: %s",
 				curl_easy_strerror(c));
-		if (slot->http_code >= 400)
+		if (slot->http_code >= 300)
 			return size;
 	}
 
-- 
2.11.0.191.gdb26c57
