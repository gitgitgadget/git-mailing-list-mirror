Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C054A1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbdCXRdN (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:33:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:51125 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750721AbdCXRdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:33:11 -0400
Received: (qmail 17644 invoked by uid 109); 24 Mar 2017 17:26:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 17:26:27 +0000
Received: (qmail 483 invoked by uid 111); 24 Mar 2017 17:26:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 13:26:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 13:26:24 -0400
Date:   Fri, 24 Mar 2017 13:26:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] fast-import: use xsnprintf for formatting headers
Message-ID: <20170324172624.ddqquklvam2emn24@sigill.intra.peff.net>
References: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The stream_blob() function checks the return value of
snprintf and dies. This is more simply done with
xsnprintf (and matches the similar call in store_object).

The message the user would get is less specific, but since
the point is that this _shouldn't_ ever happen, that's OK.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4e0f3f5dd..4a057e81f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1237,9 +1237,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	sha1file_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
-	hdrlen = snprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
-	if (out_sz <= hdrlen)
-		die("impossibly large object header");
+	hdrlen = xsnprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
 
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, out_buf, hdrlen);
-- 
2.12.1.843.g1937c56c2

