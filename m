Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DD4C49EAB
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 02:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97D861151
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 02:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhF0Ctv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 22:49:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60616 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhF0Ctt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 22:49:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6ADE61F8C9;
        Sun, 27 Jun 2021 02:47:19 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/5] make object_directory.loose_objects_subdir_seen a bitmap
Date:   Sun, 27 Jun 2021 02:47:16 +0000
Message-Id: <20210627024718.25383-4-e@80x24.org>
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

Signed-off-by: Eric Wong <e@80x24.org>
---
 object-file.c  | 10 +++++++---
 object-store.h |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6be43c2b60..2c8b9c05f9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2463,12 +2463,16 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
+	size_t BM_SIZE = sizeof(odb->loose_objects_subdir_seen[0]) * CHAR_BIT;
+	uint32_t *bitmap;
+	uint32_t bit = 1 << (subdir_nr % BM_SIZE);
 
 	if (subdir_nr < 0 ||
-	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen))
+	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen) * BM_SIZE)
 		BUG("subdir_nr out of range");
 
-	if (odb->loose_objects_subdir_seen[subdir_nr])
+	bitmap = &odb->loose_objects_subdir_seen[subdir_nr / BM_SIZE];
+	if (*bitmap & bit)
 		return &odb->loose_objects_cache[subdir_nr];
 
 	strbuf_addstr(&buf, odb->path);
@@ -2476,7 +2480,7 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 				    append_loose_object,
 				    NULL, NULL,
 				    &odb->loose_objects_cache[subdir_nr]);
-	odb->loose_objects_subdir_seen[subdir_nr] = 1;
+	*bitmap |= bit;
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
