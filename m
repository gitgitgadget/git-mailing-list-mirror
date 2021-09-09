Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F30C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09FB606A5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbhIIT6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:58:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:43298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhIIT6J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:58:09 -0400
Received: (qmail 737 invoked by uid 109); 9 Sep 2021 19:56:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Sep 2021 19:56:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16176 invoked by uid 111); 9 Sep 2021 19:57:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Sep 2021 15:57:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Sep 2021 15:56:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] pack-bitmap: drop repository argument from
 prepare_midx_bitmap_git()
Message-ID: <YTpnCsqXdzeFp8Uz@coredump.intra.peff.net>
References: <YTpms9UnVsx+uu/2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTpms9UnVsx+uu/2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We never look at the repository argument which is passed. This makes
sense, since the multi_pack_index struct already tells us everything we
need to access the files in its associated object directory.

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c        | 2 +-
 pack-bitmap.c | 3 +--
 pack-bitmap.h | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index ccdc3e5702..864034a6ad 100644
--- a/midx.c
+++ b/midx.c
@@ -1144,7 +1144,7 @@ static int write_midx_internal(const char *object_dir,
 		int bitmap_exists;
 		int want_bitmap = flags & MIDX_WRITE_BITMAP;
 
-		bitmap_git = prepare_midx_bitmap_git(the_repository, ctx.m);
+		bitmap_git = prepare_midx_bitmap_git(ctx.m);
 		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
 		free_bitmap_index(bitmap_git);
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index fa69ed7a6d..f2a7994a9c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -517,8 +517,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 	return NULL;
 }
 
-struct bitmap_index *prepare_midx_bitmap_git(struct repository *r,
-					     struct multi_pack_index *midx)
+struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 81664f933f..469090bad2 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -44,8 +44,7 @@ typedef int (*show_reachable_fn)(
 struct bitmap_index;
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r);
-struct bitmap_index *prepare_midx_bitmap_git(struct repository *r,
-					     struct multi_pack_index *midx);
+struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx);
 void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
 			      uint32_t *trees, uint32_t *blobs, uint32_t *tags);
 void traverse_bitmap_commit_list(struct bitmap_index *,
-- 
2.33.0.621.ga797e945d8

