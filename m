Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462A71F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfBSAFv (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732132AbfBSAFq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:46 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1EB2F6108D;
        Tue, 19 Feb 2019 00:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534744;
        bh=chanO02PTBNQacZjxYq8ujf5A20Iexl2FZfuX/BiuM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ez+OgtiFqISRuteOnT4IftYypOW5h/K8qXPiS0y8xHaRfR5CJOfCn7eCKr7hypBcZ
         AaTL5U5jEya7BDmO+G8CyrmSUz9vISsV7QMaKSoC47bB8dKLx1ZRh+s0KFiLleP1wn
         bXfnR06MH1BFk2/1+xFBx2x2hMHECwNXEdubZQiVLgIqAT/YeUL/KnkyseAi0PTODC
         aZi51azhgiAvWwD8tN+rck1GRpEbyYqjot22mmj0SGXZsCxAjeSLLkbbQfalDWP+Oo
         hj1/6lRj/oGscIObP+9m/1YENHsCUybuaTYqUK4uhs/Peo0d6wwMGpaHyaSTsauoE/
         +gfc18LLwtQ4a8iTCx3JPguLKXs9ev98Qs+6NOe/kGpis3vljnJexRF5aY4CNmT/n5
         H55QZTJNrpxzgomzeqQHkYCTELA+5udHeuKTxae3BSbLiBw2CDcOJUz6KtIYxdDSPu
         XlgPCDbReZSzFDe2x+yLJNpVuVFFdnQeQMOB94+PJ/Yoz9FZqdR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 07/35] pack-bitmap: switch hash tables to use struct object_id
Date:   Tue, 19 Feb 2019 00:04:58 +0000
Message-Id: <20190219000526.476553-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of storing unsigned char pointers in the hash tables, switch to
storing instances of struct object_id. Update several internal functions
and one external function to take pointers to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c |  6 ++---
 pack-bitmap.c          | 58 +++++++++++++++++++++---------------------
 pack-bitmap.h          |  2 +-
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a9fac7c128..6989136740 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1486,6 +1486,7 @@ static int can_reuse_delta(const unsigned char *base_sha1,
 			   struct object_entry **base_out)
 {
 	struct object_entry *base;
+	struct object_id base_oid;
 
 	if (!base_sha1)
 		return 0;
@@ -1507,10 +1508,9 @@ static int can_reuse_delta(const unsigned char *base_sha1,
 	 * even if it was buried too deep in history to make it into the
 	 * packing list.
 	 */
-	if (thin && bitmap_has_sha1_in_uninteresting(bitmap_git, base_sha1)) {
+	oidread(&base_oid, base_sha1);
+	if (thin && bitmap_has_oid_in_uninteresting(bitmap_git, &base_oid)) {
 		if (use_delta_islands) {
-			struct object_id base_oid;
-			hashcpy(base_oid.hash, base_sha1);
 			if (!in_same_island(&delta->idx.oid, &base_oid))
 				return 0;
 		}
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 603492c237..70d51f4f50 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -60,8 +60,8 @@ struct bitmap_index {
 	struct ewah_bitmap *blobs;
 	struct ewah_bitmap *tags;
 
-	/* Map from SHA1 -> `stored_bitmap` for all the bitmapped commits */
-	khash_sha1 *bitmaps;
+	/* Map from object ID -> `stored_bitmap` for all the bitmapped commits */
+	kh_oid_map_t *bitmaps;
 
 	/* Number of bitmapped commits */
 	uint32_t entry_count;
@@ -80,7 +80,7 @@ struct bitmap_index {
 		struct object **objects;
 		uint32_t *hashes;
 		uint32_t count, alloc;
-		khash_sha1_pos *positions;
+		kh_oid_pos_t *positions;
 	} ext_index;
 
 	/* Bitmap result of the last performed walk */
@@ -183,7 +183,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	stored->flags = flags;
 	oidread(&stored->oid, hash);
 
-	hash_pos = kh_put_sha1(index->bitmaps, stored->oid.hash, &ret);
+	hash_pos = kh_put_oid_map(index->bitmaps, stored->oid, &ret);
 
 	/* a 0 return code means the insertion succeeded with no changes,
 	 * because the SHA1 already existed on the map. this is bad, there
@@ -306,8 +306,8 @@ static int load_pack_bitmap(struct bitmap_index *bitmap_git)
 {
 	assert(bitmap_git->map);
 
-	bitmap_git->bitmaps = kh_init_sha1();
-	bitmap_git->ext_index.positions = kh_init_sha1_pos();
+	bitmap_git->bitmaps = kh_init_oid_map();
+	bitmap_git->ext_index.positions = kh_init_oid_pos();
 	load_pack_revindex(bitmap_git->pack);
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
@@ -362,10 +362,10 @@ struct include_data {
 };
 
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
-					   const unsigned char *sha1)
+					   const struct object_id *oid)
 {
-	khash_sha1_pos *positions = bitmap_git->ext_index.positions;
-	khiter_t pos = kh_get_sha1_pos(positions, sha1);
+	khash_oid_pos *positions = bitmap_git->ext_index.positions;
+	khiter_t pos = kh_get_oid_pos(positions, *oid);
 
 	if (pos < kh_end(positions)) {
 		int bitmap_pos = kh_value(positions, pos);
@@ -376,9 +376,9 @@ static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 }
 
 static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
-					   const unsigned char *sha1)
+					   const struct object_id *oid)
 {
-	off_t offset = find_pack_entry_one(sha1, bitmap_git->pack);
+	off_t offset = find_pack_entry_one(oid->hash, bitmap_git->pack);
 	if (!offset)
 		return -1;
 
@@ -386,10 +386,10 @@ static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
 }
 
 static int bitmap_position(struct bitmap_index *bitmap_git,
-			   const unsigned char *sha1)
+			   const struct object_id *oid)
 {
-	int pos = bitmap_position_packfile(bitmap_git, sha1);
-	return (pos >= 0) ? pos : bitmap_position_extended(bitmap_git, sha1);
+	int pos = bitmap_position_packfile(bitmap_git, oid);
+	return (pos >= 0) ? pos : bitmap_position_extended(bitmap_git, oid);
 }
 
 static int ext_index_add_object(struct bitmap_index *bitmap_git,
@@ -401,7 +401,7 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 	int hash_ret;
 	int bitmap_pos;
 
-	hash_pos = kh_put_sha1_pos(eindex->positions, object->oid.hash, &hash_ret);
+	hash_pos = kh_put_oid_pos(eindex->positions, object->oid, &hash_ret);
 	if (hash_ret > 0) {
 		if (eindex->count >= eindex->alloc) {
 			eindex->alloc = (eindex->alloc + 16) * 3 / 2;
@@ -431,7 +431,7 @@ static void show_object(struct object *object, const char *name, void *data_)
 	struct bitmap_show_data *data = data_;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(data->bitmap_git, object->oid.hash);
+	bitmap_pos = bitmap_position(data->bitmap_git, &object->oid);
 
 	if (bitmap_pos < 0)
 		bitmap_pos = ext_index_add_object(data->bitmap_git, object,
@@ -446,7 +446,7 @@ static void show_commit(struct commit *commit, void *data)
 
 static int add_to_include_set(struct bitmap_index *bitmap_git,
 			      struct include_data *data,
-			      const unsigned char *sha1,
+			      const struct object_id *oid,
 			      int bitmap_pos)
 {
 	khiter_t hash_pos;
@@ -457,7 +457,7 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
 	if (bitmap_get(data->base, bitmap_pos))
 		return 0;
 
-	hash_pos = kh_get_sha1(bitmap_git->bitmaps, sha1);
+	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, *oid);
 	if (hash_pos < kh_end(bitmap_git->bitmaps)) {
 		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, hash_pos);
 		bitmap_or_ewah(data->base, lookup_stored_bitmap(st));
@@ -473,13 +473,13 @@ static int should_include(struct commit *commit, void *_data)
 	struct include_data *data = _data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(data->bitmap_git, commit->object.oid.hash);
+	bitmap_pos = bitmap_position(data->bitmap_git, &commit->object.oid);
 	if (bitmap_pos < 0)
 		bitmap_pos = ext_index_add_object(data->bitmap_git,
 						  (struct object *)commit,
 						  NULL);
 
-	if (!add_to_include_set(data->bitmap_git, data, commit->object.oid.hash,
+	if (!add_to_include_set(data->bitmap_git, data, &commit->object.oid,
 				bitmap_pos)) {
 		struct commit_list *parent = commit->parents;
 
@@ -517,7 +517,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		roots = roots->next;
 
 		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_sha1(bitmap_git->bitmaps, object->oid.hash);
+			khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, object->oid);
 
 			if (pos < kh_end(bitmap_git->bitmaps)) {
 				struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
@@ -559,7 +559,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		int pos;
 
 		roots = roots->next;
-		pos = bitmap_position(bitmap_git, object->oid.hash);
+		pos = bitmap_position(bitmap_git, &object->oid);
 
 		if (pos < 0 || base == NULL || !bitmap_get(base, pos)) {
 			object->flags &= ~UNINTERESTING;
@@ -925,7 +925,7 @@ static void test_show_object(struct object *object, const char *name,
 	struct bitmap_test_data *tdata = data;
 	int bitmap_pos;
 
-	bitmap_pos = bitmap_position(tdata->bitmap_git, object->oid.hash);
+	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
 
@@ -939,7 +939,7 @@ static void test_show_commit(struct commit *commit, void *data)
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git,
-				     commit->object.oid.hash);
+				     &commit->object.oid);
 	if (bitmap_pos < 0)
 		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
 
@@ -966,7 +966,7 @@ void test_bitmap_walk(struct rev_info *revs)
 		bitmap_git->version, bitmap_git->entry_count);
 
 	root = revs->pending.objects[0].item;
-	pos = kh_get_sha1(bitmap_git->bitmaps, root->oid.hash);
+	pos = kh_get_oid_map(bitmap_git->bitmaps, root->oid);
 
 	if (pos < kh_end(bitmap_git->bitmaps)) {
 		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
@@ -1108,7 +1108,7 @@ void free_bitmap_index(struct bitmap_index *b)
 	ewah_pool_free(b->trees);
 	ewah_pool_free(b->blobs);
 	ewah_pool_free(b->tags);
-	kh_destroy_sha1(b->bitmaps);
+	kh_destroy_oid_map(b->bitmaps);
 	free(b->ext_index.objects);
 	free(b->ext_index.hashes);
 	bitmap_free(b->result);
@@ -1116,8 +1116,8 @@ void free_bitmap_index(struct bitmap_index *b)
 	free(b);
 }
 
-int bitmap_has_sha1_in_uninteresting(struct bitmap_index *bitmap_git,
-				     const unsigned char *sha1)
+int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
+				    const struct object_id *oid)
 {
 	int pos;
 
@@ -1126,7 +1126,7 @@ int bitmap_has_sha1_in_uninteresting(struct bitmap_index *bitmap_git,
 	if (!bitmap_git->haves)
 		return 0; /* walk had no "haves" */
 
-	pos = bitmap_position_packfile(bitmap_git, sha1);
+	pos = bitmap_position_packfile(bitmap_git, oid);
 	if (pos < 0)
 		return 0;
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 344ba23af9..ee9792264c 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -59,7 +59,7 @@ void free_bitmap_index(struct bitmap_index *);
  * queried to see if a particular object was reachable from any of the
  * objects flagged as UNINTERESTING.
  */
-int bitmap_has_sha1_in_uninteresting(struct bitmap_index *, const unsigned char *sha1);
+int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_id *oid);
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
