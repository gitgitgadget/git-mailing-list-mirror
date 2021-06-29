Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA3C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E837613BE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhF2Uzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:55:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34782 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235607AbhF2Uzj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 16:55:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BA0701F8C9;
        Tue, 29 Jun 2021 20:53:05 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 3/5] make object_directory.loose_objects_subdir_seen a bitmap
Date:   Tue, 29 Jun 2021 20:53:03 +0000
Message-Id: <20210629205305.7100-4-e@80x24.org>
In-Reply-To: <20210627024718.25383-1-e@80x24.org>
References: <20210627024718.25383-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in using 8 bits per-directory when 1 bit
will do.  This saves us 224 bytes per object directory, which
ends up being 22MB when dealing with 100K alternates.

v2: use bitsizeof() macro and better variable names

Signed-off-by: Eric Wong <e@80x24.org>
---
 object-file.c  | 11 ++++++++---
 object-store.h |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6be43c2b60..91183d1297 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2463,12 +2463,17 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
+	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
+	size_t word_index = subdir_nr / word_bits;
+	size_t mask = 1 << (subdir_nr % word_bits);
+	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen))
+	    subdir_nr >= bitsizeof(odb->loose_objects_subdir_seen))
 		BUG("subdir_nr out of range");
 
-	if (odb->loose_objects_subdir_seen[subdir_nr])
+	bitmap = &odb->loose_objects_subdir_seen[word_index];
+	if (*bitmap & mask)
 		return &odb->loose_objects_cache[subdir_nr];
 
 	strbuf_addstr(&buf, odb->path);
@@ -2476,7 +2481,7 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 				    append_loose_object,
 				    NULL, NULL,
 				    &odb->loose_objects_cache[subdir_nr]);
-	odb->loose_objects_subdir_seen[subdir_nr] = 1;
+	*bitmap |= mask;
 	strbuf_release(&buf);
 	return &odb->loose_objects_cache[subdir_nr];
 }
diff --git a/object-store.h b/object-store.h
index 20c1cedb75..8fcddf3e65 100644
--- a/object-store.h
+++ b/object-store.h
@@ -22,7 +22,7 @@ struct object_directory {
 	 *
 	 * Be sure to call odb_load_loose_cache() before using.
 	 */
-	char loose_objects_subdir_seen[256];
+	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oid_array loose_objects_cache[256];
 
 	/*
