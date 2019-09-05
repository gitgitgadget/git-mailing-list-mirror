Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F6B1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfIEWwv (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:52:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:41436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726837AbfIEWwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:52:50 -0400
Received: (qmail 10357 invoked by uid 109); 5 Sep 2019 22:52:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 22:52:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32509 invoked by uid 111); 5 Sep 2019 22:54:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 18:54:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 18:52:49 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH 3/6] bulk-checkin: zero-initialize hashfile_checkpoint
Message-ID: <20190905225249.GC25657@sigill.intra.peff.net>
References: <20190905224859.GA28660@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905224859.GA28660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We declare a "struct hashfile_checkpoint" but only sometimes actually
call hashfile_checkpoint() on it. That makes it not immediately obvious
that it's valid when we later access its members.

In fact, the code is fine: we fill it in unconditionally in the while(1)
loop as long as "idx" is non-NULL. And then if "idx" is NULL, we exit
early from the function (because we're just computing the hash, not
actually writing), before we look at the struct.

However, this does seem to confuse gcc 9.2.1's -Wmaybe-uninitialized
when compiled with "-flto -O2" (probably because with LTO it can now
realize that our call to hashfile_truncate() does not set the members
either). Let's zero-initialize the struct to tell the compiler, as well
as any readers of the code, that all is well.

Reported-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Jeff King <peff@peff.net>
---
We could also have a HASHFILE_CHECKPOINT_INIT, but it seemed like
overkill. I dunno.

 bulk-checkin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 39ee7d6107..583aacb9e3 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -197,7 +197,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
-	struct hashfile_checkpoint checkpoint;
+	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
 
 	seekback = lseek(fd, 0, SEEK_CUR);
-- 
2.23.0.463.g883b23b1c5

