Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB6FC388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C09F20B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKMFHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 00:07:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:56920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKMFHS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 00:07:18 -0500
Received: (qmail 23773 invoked by uid 109); 13 Nov 2020 05:07:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 05:07:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6211 invoked by uid 111); 13 Nov 2020 05:07:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 00:07:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 00:07:17 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] block-sha1: take a size_t length parameter
Message-ID: <20201113050717.GD744691@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113050631.GA744608@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The block-sha1 implementation takes an "unsigned long" for the length of
a buffer to hash, but our hash algorithm wrappers take a size_t, as do
other implementations we support like openssl or sha1dc. On many
systems, including Linux, these two are equivalent, but they are not on
Windows (where only a "long long" is 64 bits). As a result, passing
large chunks to a single the_hash_algo->update_fn() would produce wrong
answers there.

Note that we don't need to update any other sizes outside of the
function interface. We store the cumulative size in a "long long" (which
we must do since we hash things bigger than 4GB, like packfiles, even on
32-bit platforms). And internally, we break that size_t len down into
64-byte blocks to feed into the guts of the algorithm.

Signed-off-by: Jeff King <peff@peff.net>
---
 block-sha1/sha1.c | 2 +-
 block-sha1/sha1.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 22b125cf8c..8681031402 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -203,7 +203,7 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx)
 	ctx->H[4] = 0xc3d2e1f0;
 }
 
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, size_t len)
 {
 	unsigned int lenW = ctx->size & 63;
 
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index 4df6747752..9fb0441b98 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -13,7 +13,7 @@ typedef struct {
 } blk_SHA_CTX;
 
 void blk_SHA1_Init(blk_SHA_CTX *ctx);
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, unsigned long len);
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, size_t len);
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
 
 #define platform_SHA_CTX	blk_SHA_CTX
-- 
2.29.2.705.g306f91dc4e

