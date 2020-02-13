Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB56C47409
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5160320873
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgBMCQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:16:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:42052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729469AbgBMCQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:16:16 -0500
Received: (qmail 9793 invoked by uid 109); 13 Feb 2020 02:15:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:15:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8537 invoked by uid 111); 13 Feb 2020 02:25:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:25:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:16:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/13] pack-bitmap: factor out type iterator initialization
Message-ID: <20200213021615.GA1126038@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When count_object_type() wants to iterate over the bitmap of all objects
of a certain type, we have to pair up OBJ_COMMIT with bitmap->commits,
and so forth. Since we're about to add more code to iterate over these
bitmaps, let's pull the initialization into its own function.

We can also use this to simplify traverse_bitmap_commit_list(). It
accomplishes the same thing by manually passing the object type and the
bitmap to show_objects_for_type(), but using our helper we just need the
object type.

Note there's one small code change here: previously we'd simply return
zero when counting an unknown object type, and now we'll BUG(). This
shouldn't matter in practice, as all of the callers pass in only usual
commit/tree/blob/tag types.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 63 +++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e07c798879..9ca356ee29 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -616,9 +616,35 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	}
 }
 
+static void init_type_iterator(struct ewah_iterator *it,
+			       struct bitmap_index *bitmap_git,
+			       enum object_type type)
+{
+	switch (type) {
+	case OBJ_COMMIT:
+		ewah_iterator_init(it, bitmap_git->commits);
+		break;
+
+	case OBJ_TREE:
+		ewah_iterator_init(it, bitmap_git->trees);
+		break;
+
+	case OBJ_BLOB:
+		ewah_iterator_init(it, bitmap_git->blobs);
+		break;
+
+	case OBJ_TAG:
+		ewah_iterator_init(it, bitmap_git->tags);
+		break;
+
+	default:
+		BUG("object type %d not stored by bitmap type index", type);
+		break;
+	}
+}
+
 static void show_objects_for_type(
 	struct bitmap_index *bitmap_git,
-	struct ewah_bitmap *type_filter,
 	enum object_type object_type,
 	show_reachable_fn show_reach)
 {
@@ -633,7 +659,7 @@ static void show_objects_for_type(
 	if (bitmap_git->reuse_objects == bitmap_git->pack->num_objects)
 		return;
 
-	ewah_iterator_init(&it, type_filter);
+	init_type_iterator(&it, bitmap_git, object_type);
 
 	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
 		eword_t word = objects->words[i] & filter;
@@ -835,14 +861,10 @@ void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
 {
 	assert(bitmap_git->result);
 
-	show_objects_for_type(bitmap_git, bitmap_git->commits,
-		OBJ_COMMIT, show_reachable);
-	show_objects_for_type(bitmap_git, bitmap_git->trees,
-		OBJ_TREE, show_reachable);
-	show_objects_for_type(bitmap_git, bitmap_git->blobs,
-		OBJ_BLOB, show_reachable);
-	show_objects_for_type(bitmap_git, bitmap_git->tags,
-		OBJ_TAG, show_reachable);
+	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable);
+	show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable);
+	show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable);
+	show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable);
 
 	show_extended_objects(bitmap_git, show_reachable);
 }
@@ -857,26 +879,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 	struct ewah_iterator it;
 	eword_t filter;
 
-	switch (type) {
-	case OBJ_COMMIT:
-		ewah_iterator_init(&it, bitmap_git->commits);
-		break;
-
-	case OBJ_TREE:
-		ewah_iterator_init(&it, bitmap_git->trees);
-		break;
-
-	case OBJ_BLOB:
-		ewah_iterator_init(&it, bitmap_git->blobs);
-		break;
-
-	case OBJ_TAG:
-		ewah_iterator_init(&it, bitmap_git->tags);
-		break;
-
-	default:
-		return 0;
-	}
+	init_type_iterator(&it, bitmap_git, type);
 
 	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
 		eword_t word = objects->words[i++] & filter;
-- 
2.25.0.785.g49bcbe7794

