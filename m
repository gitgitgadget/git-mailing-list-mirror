Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A7F1FC96
	for <e@80x24.org>; Thu,  1 Dec 2016 09:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759193AbcLAJKR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 04:10:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:49672 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758381AbcLAJEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 04:04:42 -0500
Received: (qmail 5007 invoked by uid 109); 1 Dec 2016 09:04:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 09:04:38 +0000
Received: (qmail 30701 invoked by uid 111); 1 Dec 2016 09:05:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:05:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 04:04:37 -0500
Date:   Thu, 1 Dec 2016 04:04:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>
Subject: [PATCH 6/6] http-walker: complain about non-404 loose object errors
Message-ID: <20161201090436.cwh2pxio7afowtfs@sigill.intra.peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
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
 http-walker.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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
-- 
2.11.0.319.g1f4e1e0
