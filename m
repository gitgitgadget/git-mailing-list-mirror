Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4AEC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71630610A3
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbhIIT6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:58:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:43300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhIIT6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:58:32 -0400
Received: (qmail 744 invoked by uid 109); 9 Sep 2021 19:57:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Sep 2021 19:57:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16196 invoked by uid 111); 9 Sep 2021 19:57:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Sep 2021 15:57:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Sep 2021 15:57:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] pack-bitmap: drop bitmap_index argument from
 try_partial_reuse()
Message-ID: <YTpnIQSiYfSYlexy@coredump.intra.peff.net>
References: <YTpms9UnVsx+uu/2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTpms9UnVsx+uu/2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting in commit 0f533c7284 (pack-bitmap: read multi-pack bitmaps,
2021-08-31), we no longer look at the "struct bitmap_index" passed to
try_partial_reuse(). This is because we only handle verbatim reuse from
a single pack: either the pack whose bitmap we're looking at, or the
"preferred" pack of a midx bitmap. And thus the primary item we look at
is the "pack" parameter added by that same commit, and not the
bitmap_git->pack parameter (which would be NULL for a midx bitmap). It's
our caller, reuse_partial_packfile_from_bitmap(), which decides which
pack to use and passes it in to us.

Drop the unused parameter to prevent confusion.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f2a7994a9c..8504110a4d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1328,8 +1328,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
  * -1 means "stop trying further objects"; 0 means we may or may not have
  * reused, but you can keep feeding bits.
  */
-static int try_partial_reuse(struct bitmap_index *bitmap_git,
-			     struct packed_git *pack,
+static int try_partial_reuse(struct packed_git *pack,
 			     size_t pos,
 			     struct bitmap *reuse,
 			     struct pack_window **w_curs)
@@ -1476,7 +1475,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			if (try_partial_reuse(bitmap_git, pack, pos + offset,
+			if (try_partial_reuse(pack, pos + offset,
 					      reuse, &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
-- 
2.33.0.621.ga797e945d8
