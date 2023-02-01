Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9A5C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 09:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBAJZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 04:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBAJZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 04:25:57 -0500
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 01:25:55 PST
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C3539AF
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 01:25:55 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6D6E91F642;
        Wed,  1 Feb 2023 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1675243227;
        bh=gescvP7yb9uQlqjRNMauoN8P0ya0OGCxaSO4PtZWPXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y+xmVivcpY29I25q5B94xV+Xy8ht6AvEK/fJB47w9obHf+0DESPRQsVli7P5WFhXD
         XIBQIYK/5t18K+PsLWRLqE5QthajVfm5aUtt2P5Pw4O9DgLxGCt/EwDE2M01vHjnYG
         4ACLrmPnJ99r8qJv/uk+HTo/S2UZaQ3F77kjxd84=
Date:   Wed, 1 Feb 2023 09:20:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: pack-objects memory use observations [was: [PATCH] delta-islands:
 free island-related data after use]
Message-ID: <20230201092027.M96461@dcvr>
References: <20221116105013.1777440-1-e@80x24.org>
 <Y3UvhsRC9uCXJJ8P@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3UvhsRC9uCXJJ8P@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Nov 16, 2022 at 10:50:13AM +0000, Eric Wong wrote:
> >   Will try to hunt down more memory savings in the nearish future.
> 
> Yes, you've probably noticed that pack-objects does not distinguish much
> between what is necessary for the various phases. A few obvious things
> to look at:
> 
>   1. After the write phase, you can probably ditch the island bitmaps,
>      too. In many repacks we're basically done then, but if you're
>      generating bitmaps, that happens afterwards in the same process.

Also, island_marks oid_map gets pretty big itself (300M?), and
realloc gets painful when resizing a big khash especially on
non-GNU/Linux systems without MREMAP_MAYMOVE realloc.  Currently
experimenting with tweaks to make oidtree handle kh_oid_map
functionality to avoid resizes...[1]

>   2. The object traversal for pack-objects is done in-process these
>      days. But after it finishes, I suspect that we do not generally
>      need those object structs anymore, because all of the book-keeping
>      is done in the bit object_entry array in packing_data.

pdata->objects is 1.4G for me atm after many hours (still going).
I think packing_data could be split to avoid reallocs, but that
might need to touch a lot of code...

I need to get better data on my next attempts.  I suspect gcc
-O2 is throwing off mwrap-perl[2]+addr2line and I need to
rebuild w/ -O0.

[1] WIP oidtree map, but I feel like I forgot C, again :<

diff --git a/delta-islands.c b/delta-islands.c
index 90c0d6958f..9e824d7a0d 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -18,11 +18,13 @@
 #include "pack-objects.h"
 #include "delta-islands.h"
 #include "oid-array.h"
+#include "oidtree.h"
 #include "config.h"
 
 KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
 
-static kh_oid_map_t *island_marks;
+struct oidtree island_marks_storage;
+static struct oidtree *island_marks;
 static unsigned island_counter;
 static unsigned island_counter_core;
 
@@ -93,7 +95,7 @@ static int island_bitmap_get(struct island_bitmap *self, uint32_t i)
 
 int in_same_island(const struct object_id *trg_oid, const struct object_id *src_oid)
 {
-	khiter_t trg_pos, src_pos;
+	struct island_bitmap *trg, *src;
 
 	/* If we aren't using islands, assume everything goes together. */
 	if (!island_marks)
@@ -103,37 +105,30 @@ int in_same_island(const struct object_id *trg_oid, const struct object_id *src_
 	 * If we don't have a bitmap for the target, we can delta it
 	 * against anything -- it's not an important object
 	 */
-	trg_pos = kh_get_oid_map(island_marks, *trg_oid);
-	if (trg_pos >= kh_end(island_marks))
+	trg = oidtree_get(island_marks, trg_oid);
+	if (!trg)
 		return 1;
 
 	/*
 	 * if the source (our delta base) doesn't have a bitmap,
 	 * we don't want to base any deltas on it!
 	 */
-	src_pos = kh_get_oid_map(island_marks, *src_oid);
-	if (src_pos >= kh_end(island_marks))
+	src = oidtree_get(island_marks, src_oid);
+	if (!src)
 		return 0;
 
-	return island_bitmap_is_subset(kh_value(island_marks, trg_pos),
-				kh_value(island_marks, src_pos));
+	return island_bitmap_is_subset(trg, src);
 }
 
 int island_delta_cmp(const struct object_id *a, const struct object_id *b)
 {
-	khiter_t a_pos, b_pos;
-	struct island_bitmap *a_bitmap = NULL, *b_bitmap = NULL;
+	struct island_bitmap *a_bitmap, *b_bitmap;
 
 	if (!island_marks)
 		return 0;
 
-	a_pos = kh_get_oid_map(island_marks, *a);
-	if (a_pos < kh_end(island_marks))
-		a_bitmap = kh_value(island_marks, a_pos);
-
-	b_pos = kh_get_oid_map(island_marks, *b);
-	if (b_pos < kh_end(island_marks))
-		b_bitmap = kh_value(island_marks, b_pos);
+	a_bitmap = oidtree_get(island_marks, a);
+	b_bitmap = oidtree_get(island_marks, b);
 
 	if (a_bitmap) {
 		if (!b_bitmap || !island_bitmap_is_subset(a_bitmap, b_bitmap))
@@ -149,30 +144,28 @@ int island_delta_cmp(const struct object_id *a, const struct object_id *b)
 
 static struct island_bitmap *create_or_get_island_marks(struct object *obj)
 {
-	khiter_t pos;
-	int hash_ret;
+	void **val;
+	size_t n = sizeof(struct island_bitmap *);
 
-	pos = kh_put_oid_map(island_marks, obj->oid, &hash_ret);
-	if (hash_ret)
-		kh_value(island_marks, pos) = island_bitmap_new(NULL);
+	if (oidtree_put(island_marks, &obj->oid, &val, n))
+		*val = island_bitmap_new(NULL);
 
-	return kh_value(island_marks, pos);
+	return *val;
 }
 
 static void set_island_marks(struct object *obj, struct island_bitmap *marks)
 {
 	struct island_bitmap *b;
-	khiter_t pos;
-	int hash_ret;
+	void **val;
+	size_t n = sizeof(struct island_bitmap *);
 
-	pos = kh_put_oid_map(island_marks, obj->oid, &hash_ret);
-	if (hash_ret) {
+	if (oidtree_put(island_marks, &obj->oid, &val, n)) {
 		/*
 		 * We don't have one yet; make a copy-on-write of the
 		 * parent.
 		 */
 		marks->refcount++;
-		kh_value(island_marks, pos) = marks;
+		*val = marks;
 		return;
 	}
 
@@ -180,10 +173,10 @@ static void set_island_marks(struct object *obj, struct island_bitmap *marks)
 	 * We do have it. Make sure we split any copy-on-write before
 	 * updating.
 	 */
-	b = kh_value(island_marks, pos);
+	b = *val;
 	if (b->refcount > 1) {
 		b->refcount--;
-		b = kh_value(island_marks, pos) = island_bitmap_new(b);
+		*val = b = island_bitmap_new(b);
 	}
 	island_bitmap_or(b, marks);
 }
@@ -275,14 +268,11 @@ void resolve_tree_islands(struct repository *r,
 		struct tree *tree;
 		struct tree_desc desc;
 		struct name_entry entry;
-		khiter_t pos;
 
-		pos = kh_get_oid_map(island_marks, ent->idx.oid);
-		if (pos >= kh_end(island_marks))
+		root_marks = oidtree_get(island_marks, &ent->idx.oid);
+		if (!root_marks)
 			continue;
 
-		root_marks = kh_value(island_marks, pos);
-
 		tree = lookup_tree(r, &ent->idx.oid);
 		if (!tree || parse_tree(tree) < 0)
 			die(_("bad tree object %s"), oid_to_hex(&ent->idx.oid));
@@ -485,7 +475,8 @@ void load_delta_islands(struct repository *r, int progress)
 {
 	struct island_load_data ild = { 0 };
 
-	island_marks = kh_init_oid_map();
+	oidtree_init(&island_marks_storage);
+	island_marks = &island_marks_storage;
 
 	git_config(island_config_callback, &ild);
 	ild.remote_islands = kh_init_str();
@@ -500,11 +491,11 @@ void load_delta_islands(struct repository *r, int progress)
 
 void propagate_island_marks(struct commit *commit)
 {
-	khiter_t pos = kh_get_oid_map(island_marks, commit->object.oid);
+	struct island_bitmap *root_marks;
 
-	if (pos < kh_end(island_marks)) {
+	root_marks = oidtree_get(island_marks, &commit->object.oid);
+	if (root_marks) {
 		struct commit_list *p;
-		struct island_bitmap *root_marks = kh_value(island_marks, pos);
 
 		parse_commit(commit);
 		set_island_marks(&get_commit_tree(commit)->object, root_marks);
@@ -522,16 +513,13 @@ int compute_pack_layers(struct packing_data *to_pack)
 
 	for (i = 0; i < to_pack->nr_objects; ++i) {
 		struct object_entry *entry = &to_pack->objects[i];
-		khiter_t pos = kh_get_oid_map(island_marks, entry->idx.oid);
+		struct island_bitmap *bitmap;
 
 		oe_set_layer(to_pack, entry, 1);
 
-		if (pos < kh_end(island_marks)) {
-			struct island_bitmap *bitmap = kh_value(island_marks, pos);
-
-			if (island_bitmap_get(bitmap, island_counter_core))
-				oe_set_layer(to_pack, entry, 0);
-		}
+		bitmap = oidtree_get(island_marks, &entry->idx.oid);
+		if (bitmap && island_bitmap_get(bitmap, island_counter_core))
+			oe_set_layer(to_pack, entry, 0);
 	}
 
 	return 2;
diff --git a/oidtree.c b/oidtree.c
index 0d39389bee..eb7e76335e 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -28,15 +28,16 @@ void oidtree_clear(struct oidtree *ot)
 	}
 }
 
-void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
+static void **oidtree_insert3(struct oidtree *ot, const struct object_id *oid,
+				size_t extra)
 {
 	struct cb_node *on;
 	struct object_id k;
 
 	if (!oid->algo)
-		BUG("oidtree_insert requires oid->algo");
+		BUG("oidtree insertion requires oid->algo");
 
-	on = mem_pool_alloc(&ot->mem_pool, sizeof(*on) + sizeof(*oid));
+	on = mem_pool_alloc(&ot->mem_pool, sizeof(*on) + sizeof(*oid) + extra);
 
 	/*
 	 * Clear the padding and copy the result in separate steps to
@@ -45,19 +46,22 @@ void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 	oidcpy_with_padding(&k, oid);
 	memcpy(on->k, &k, sizeof(k));
 
-	/*
-	 * n.b. Current callers won't get us duplicates, here.  If a
-	 * future caller causes duplicates, there'll be a a small leak
-	 * that won't be freed until oidtree_clear.  Currently it's not
-	 * worth maintaining a free list
-	 */
-	cb_insert(&ot->tree, on, sizeof(*oid));
+	if (!cb_insert(&ot->tree, on, sizeof(*oid)))
+		return (void **)(on->k + sizeof(k)); /* success */
+
+	warning("oidtree leak (check contains/get before insert/put)");
+	return NULL;
 }
 
+void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
+{
+	(void)oidtree_insert3(ot, oid, 0);
+}
 
-int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
+static void **oidtree_find(struct oidtree *ot, const struct object_id *oid)
 {
 	struct object_id k;
+	struct cb_node *on;
 	size_t klen = sizeof(k);
 
 	oidcpy_with_padding(&k, oid);
@@ -69,7 +73,31 @@ int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
 	klen += BUILD_ASSERT_OR_ZERO(offsetof(struct object_id, hash) <
 				offsetof(struct object_id, algo));
 
-	return cb_lookup(&ot->tree, (const uint8_t *)&k, klen) ? 1 : 0;
+	on = cb_lookup(&ot->tree, (const uint8_t *)&k, klen);
+	return on ? (void **)(on->k + sizeof(k)) : NULL;
+}
+
+int oidtree_put(struct oidtree *ot, const struct object_id *oid,
+		void ***p, size_t n)
+{
+	*p = oidtree_find(ot, oid);
+	if (*p)
+		return 0;
+
+	*p = oidtree_insert3(ot, oid, n);
+	assert(*p);
+	return 1;
+}
+
+void *oidtree_get(struct oidtree *ot, const struct object_id *oid)
+{
+	void **p = oidtree_find(ot, oid);
+	return p ? *p : NULL;
+}
+
+int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
+{
+	return oidtree_find(ot, oid) ? 1 : 0;
 }
 
 static enum cb_next iter(struct cb_node *n, void *arg)
diff --git a/oidtree.h b/oidtree.h
index 77898f510a..2f6e6f1beb 100644
--- a/oidtree.h
+++ b/oidtree.h
@@ -12,6 +12,8 @@ struct oidtree {
 
 void oidtree_init(struct oidtree *);
 void oidtree_clear(struct oidtree *);
+
+/* oid_set-like API */
 void oidtree_insert(struct oidtree *, const struct object_id *);
 int oidtree_contains(struct oidtree *, const struct object_id *);
 
@@ -19,4 +21,17 @@ typedef enum cb_next (*oidtree_iter)(const struct object_id *, void *data);
 void oidtree_each(struct oidtree *, const struct object_id *,
 			size_t oidhexsz, oidtree_iter, void *data);
 
+/* oid_map-like API */
+
+/* returns a pointer to the data payload associated with object_id */
+void *oidtree_get(struct oidtree *, const struct object_id *);
+
+/*
+ * points @p to the destination of the value
+ * @n must be consistent for the entire oidtree
+ * returns true if a new oidtree node was created,
+ * returns false if reusing an existing oidtree node
+ */
+int oidtree_put(struct oidtree *, const struct object_id *,
+		void ***p, size_t n);
 #endif /* OIDTREE_H */


[2] https://80x24.org/mwrap-perl.git

    # after install, run gc under mwrap-perl with backtrace 10
    MWRAP=socket_dir:/tmp/mwrap,bt:10 mwrap-perl git gc

    # recommended: use GNU addr2line 2.39+ (Aug 2022) for +OFFSET decoding

    # start HTTP reverse proxy
    ADDR2LINE='/path/to/addr2line -p -f -i' \
	mwrap-rproxy --socket-dir=/tmp/mwrap

    # the per-PID each/2000 URLs can get really expensive for browsers
    # even w3m struggles:
    w3m http://0:5000/ # follow per-PID links
