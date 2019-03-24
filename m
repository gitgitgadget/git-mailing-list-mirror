Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33335202BB
	for <e@80x24.org>; Sun, 24 Mar 2019 12:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCXMNS (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:13:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:34234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726160AbfCXMNS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:13:18 -0400
Received: (qmail 4682 invoked by uid 109); 24 Mar 2019 12:13:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Mar 2019 12:13:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1585 invoked by uid 111); 24 Mar 2019 12:13:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Mar 2019 08:13:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2019 08:13:16 -0400
Date:   Sun, 24 Mar 2019 08:13:16 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Wolfgang Denk <wd@denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: [PATCH 3/3] http: use normalize_curl_result() instead of manual
 conversion
Message-ID: <20190324121316.GC312@sigill.intra.peff.net>
References: <20190324120757.GA18684@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190324120757.GA18684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we switched off CURLOPT_FAILONERROR in 17966c0a63 (http: avoid
disconnecting on 404s for loose objects, 2016-07-11), the fetch_object()
function started manually handling 404's. Since we now have
normalize_curl_result() for use elsewhere, we can use it here as well,
shortening the code.

Note that we lose the check for http/https in the URL here. None of the
other result-normalizing code paths bother with this. Looking at
missing_target(), which checks specifically for an FTP-specific CURLcode
and "http" code 550, it seems likely that git-over-ftp has been subtly
broken since 17966c0a63. This patch does nothing to fix that, but nor
should it make anything worse (in fact, it may be slightly better
because we'll actually recognize an error as such, rather than assuming
CURLE_OK means we actually got some data).

Signed-off-by: Jeff King <peff@peff.net>
---
I can't bring myself to care too much about whether git-over-ftp works
with alternates, but if somebody wants to dig into it, be my guest. I
suspect other bits may be broken, too, as we check http_code in several
places and assume it has some sensible http-based number in it (notably,
for 401 triggering authentication).

It may not even work at all. I didn't try (and I'd be kind of surprised
if somebody is actually using it in practice). I'm content to let it
bit-rot unless somebody using it shows up to report a bug.

(I'd also be fine with officially deprecating it. But then I kind of
feel the same way about the dumb-http code).

 http-walker.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 745436921d..48b1b3a193 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -526,17 +526,8 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		req->localfile = -1;
 	}
 
-	/*
-	 * we turned off CURLOPT_FAILONERROR to avoid losing a
-	 * persistent connection and got CURLE_OK.
-	 */
-	if (req->http_code >= 300 && req->curl_result == CURLE_OK &&
-			(starts_with(req->url, "http://") ||
-			 starts_with(req->url, "https://"))) {
-		req->curl_result = CURLE_HTTP_RETURNED_ERROR;
-		xsnprintf(req->errorstr, sizeof(req->errorstr),
-			  "HTTP request failed");
-	}
+	normalize_curl_result(&req->curl_result, req->http_code,
+			      req->errorstr, sizeof(req->errorstr));
 
 	if (obj_req->state == ABORTED) {
 		ret = error("Request for %s aborted", hex);
-- 
2.21.0.705.g64cb90f133
