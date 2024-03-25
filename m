Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C89823C3
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408061; cv=none; b=aEuyht5F26+jEg3syiPrfR5Zwtq3hQprPXN/5YKq6dm46b5hSdzTEYvwSpIMBka7VWMUuoFaEkR09Kc4lsvwCwOPvL+iKCpsi09Z17TkFwDqF6hR8XkYSJZyjm2kke2DYv8l31fEyJuFidLcVqfHAXvlI1W2nMwzof64GYMioOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408061; c=relaxed/simple;
	bh=zJIDDa+H/BojMc7Ax+IL6D2ISeedNRi1wQ2JjL6RXRg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rklxrqi+87NhJc3uBNKZhehWL17kaTvbN1wT5oILXCP07XIXhQjI9tKnKGHZWG4FuYjG8UHaaQtFzPhxvYWdVb7l5ynkbMElR6zVYkrWd9V8Q9AJzV+pbHigIIBRLjsO6iZhOFJqbYNKwKyuGVkOYTyRAK52g30E85G1TK6AUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=rB4byvCg; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="rB4byvCg"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D95A1F543
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711408025;
	bh=zJIDDa+H/BojMc7Ax+IL6D2ISeedNRi1wQ2JjL6RXRg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rB4byvCgR5iCs191bwvU91gnmwMe6CkKTnKKpEQ4XzazdgnnHheAirMG+t+vTNdTa
	 pVGQHd0Pvg0cQm49H3fz95JUIwqv8n2ESnvm3Ki/J0uWHvMvyDXANxqmCDdsfkssYx
	 rnJTi7/FH9MQz4WIEw1w7J7ltK6EWs0i/BuIGKsg=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [REJECT 4/3] switch to khashl ensemble
Date: Mon, 25 Mar 2024 23:07:04 +0000
Message-ID: <20240325230704.262272-5-e@80x24.org>
In-Reply-To: <20240325230704.262272-1-e@80x24.org>
References: <20240325230704.262272-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using an ensemble of hash tables to implement a larger one can
reduce the temporary space required to resize a hash table.
However, I haven't been able to measure an improvement using
glibc memusage(1), yet.

I could be tuning it wrong (too few or too many sub hash
tables), and it may not be useful with glibc malloc since large
realloc(3) are optimized with mremap(2) to provide in-place
growth.
---
 builtin/fast-import.c | 10 ++++----
 builtin/replay.c      | 10 ++++----
 delta-islands.c       | 54 +++++++++++++++++++-------------------
 fsck.c                | 10 ++++----
 khashl.h              | 60 ++++++++++++++++++++++++++++++++-----------
 pack-bitmap-write.c   |  4 +--
 pack-bitmap.c         | 32 +++++++++++------------
 7 files changed, 105 insertions(+), 75 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 29e50fd675..190e136e2e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2198,7 +2198,7 @@ static uintmax_t change_note_fanout(struct tree_entry *root,
 static int parse_mapped_oid_hex(const char *hex, struct object_id *oid, const char **end)
 {
 	int algo;
-	khiter_t it;
+	kh_ensitr_t it;
 
 	/* Make SHA-1 object IDs have all-zero padding. */
 	memset(oid->hash, 0, sizeof(oid->hash));
@@ -2209,13 +2209,13 @@ static int parse_mapped_oid_hex(const char *hex, struct object_id *oid, const ch
 
 	it = kh_get_oid_map(sub_oid_map, *oid);
 	/* No such object? */
-	if (it == kh_end(sub_oid_map)) {
+	if (kh_ens_is_end(it)) {
 		/* If we're using the same algorithm, pass it through. */
 		if (hash_algos[algo].format_id == the_hash_algo->format_id)
 			return 0;
 		return -1;
 	}
-	oidcpy(oid, kh_value(sub_oid_map, it));
+	oidcpy(oid, kh_ens_val(sub_oid_map, it));
 	return 0;
 }
 
@@ -3083,13 +3083,13 @@ static void insert_mapped_mark(uintmax_t mark, void *object, void *cbp)
 	struct object_id *fromoid = object;
 	struct object_id *tooid = find_mark(cbp, mark);
 	int ret;
-	khiter_t it;
+	kh_ensitr_t it;
 
 	it = kh_put_oid_map(sub_oid_map, *fromoid, &ret);
 	/* We've already seen this object. */
 	if (ret == 0)
 		return;
-	kh_value(sub_oid_map, it) = tooid;
+	kh_ens_val(sub_oid_map, it) = tooid;
 }
 
 static void build_mark_map_one(struct mark_set *from, struct mark_set *to)
diff --git a/builtin/replay.c b/builtin/replay.c
index 6bc4b47f09..e084da8a94 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -227,10 +227,10 @@ static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
 				    struct commit *commit,
 				    struct commit *fallback)
 {
-	khint_t pos = kh_get_oid_map(replayed_commits, commit->object.oid);
-	if (pos == kh_end(replayed_commits))
+	kh_ensitr_t pos = kh_get_oid_map(replayed_commits, commit->object.oid);
+	if (kh_ens_is_end(pos))
 		return fallback;
-	return kh_value(replayed_commits, pos);
+	return kh_ens_val(replayed_commits, pos);
 }
 
 static struct commit *pick_regular_commit(struct commit *pickme,
@@ -381,7 +381,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	replayed_commits = kh_init_oid_map();
 	while ((commit = get_revision(&revs))) {
 		const struct name_decoration *decoration;
-		khint_t pos;
+		kh_ensitr_t pos;
 		int hr;
 
 		if (!commit->parents)
@@ -399,7 +399,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (hr == 0)
 			BUG("Duplicate rewritten commit: %s\n",
 			    oid_to_hex(&commit->object.oid));
-		kh_value(replayed_commits, pos) = last_commit;
+		kh_ens_val(replayed_commits, pos) = last_commit;
 
 		/* Update any necessary branches */
 		if (advance_name)
diff --git a/delta-islands.c b/delta-islands.c
index aa35839f15..de159e98a8 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -90,7 +90,7 @@ static int island_bitmap_get(struct island_bitmap *self, uint32_t i)
 
 int in_same_island(const struct object_id *trg_oid, const struct object_id *src_oid)
 {
-	khiter_t trg_pos, src_pos;
+	kh_ensitr_t trg_pos, src_pos;
 
 	/* If we aren't using islands, assume everything goes together. */
 	if (!island_marks)
@@ -101,7 +101,7 @@ int in_same_island(const struct object_id *trg_oid, const struct object_id *src_
 	 * against anything -- it's not an important object
 	 */
 	trg_pos = kh_get_oid_map(island_marks, *trg_oid);
-	if (trg_pos >= kh_end(island_marks))
+	if (kh_ens_is_end(trg_pos))
 		return 1;
 
 	/*
@@ -109,28 +109,28 @@ int in_same_island(const struct object_id *trg_oid, const struct object_id *src_
 	 * we don't want to base any deltas on it!
 	 */
 	src_pos = kh_get_oid_map(island_marks, *src_oid);
-	if (src_pos >= kh_end(island_marks))
+	if (kh_ens_is_end(src_pos))
 		return 0;
 
-	return island_bitmap_is_subset(kh_value(island_marks, trg_pos),
-				kh_value(island_marks, src_pos));
+	return island_bitmap_is_subset(kh_ens_val(island_marks, trg_pos),
+				kh_ens_val(island_marks, src_pos));
 }
 
 int island_delta_cmp(const struct object_id *a, const struct object_id *b)
 {
-	khiter_t a_pos, b_pos;
+	kh_ensitr_t a_pos, b_pos;
 	struct island_bitmap *a_bitmap = NULL, *b_bitmap = NULL;
 
 	if (!island_marks)
 		return 0;
 
 	a_pos = kh_get_oid_map(island_marks, *a);
-	if (a_pos < kh_end(island_marks))
-		a_bitmap = kh_value(island_marks, a_pos);
+	if (!kh_ens_is_end(a_pos))
+		a_bitmap = kh_ens_val(island_marks, a_pos);
 
 	b_pos = kh_get_oid_map(island_marks, *b);
-	if (b_pos < kh_end(island_marks))
-		b_bitmap = kh_value(island_marks, b_pos);
+	if (!kh_ens_is_end(b_pos))
+		b_bitmap = kh_ens_val(island_marks, b_pos);
 
 	if (a_bitmap) {
 		if (!b_bitmap || !island_bitmap_is_subset(a_bitmap, b_bitmap))
@@ -146,20 +146,20 @@ int island_delta_cmp(const struct object_id *a, const struct object_id *b)
 
 static struct island_bitmap *create_or_get_island_marks(struct object *obj)
 {
-	khiter_t pos;
+	kh_ensitr_t pos;
 	int hash_ret;
 
 	pos = kh_put_oid_map(island_marks, obj->oid, &hash_ret);
 	if (hash_ret)
-		kh_value(island_marks, pos) = island_bitmap_new(NULL);
+		kh_ens_val(island_marks, pos) = island_bitmap_new(NULL);
 
-	return kh_value(island_marks, pos);
+	return kh_ens_val(island_marks, pos);
 }
 
 static void set_island_marks(struct object *obj, struct island_bitmap *marks)
 {
 	struct island_bitmap *b;
-	khiter_t pos;
+	kh_ensitr_t pos;
 	int hash_ret;
 
 	pos = kh_put_oid_map(island_marks, obj->oid, &hash_ret);
@@ -169,7 +169,7 @@ static void set_island_marks(struct object *obj, struct island_bitmap *marks)
 		 * parent.
 		 */
 		marks->refcount++;
-		kh_value(island_marks, pos) = marks;
+		kh_ens_val(island_marks, pos) = marks;
 		return;
 	}
 
@@ -177,10 +177,10 @@ static void set_island_marks(struct object *obj, struct island_bitmap *marks)
 	 * We do have it. Make sure we split any copy-on-write before
 	 * updating.
 	 */
-	b = kh_value(island_marks, pos);
+	b = kh_ens_val(island_marks, pos);
 	if (b->refcount > 1) {
 		b->refcount--;
-		b = kh_value(island_marks, pos) = island_bitmap_new(b);
+		b = kh_ens_val(island_marks, pos) = island_bitmap_new(b);
 	}
 	island_bitmap_or(b, marks);
 }
@@ -272,13 +272,13 @@ void resolve_tree_islands(struct repository *r,
 		struct tree *tree;
 		struct tree_desc desc;
 		struct name_entry entry;
-		khiter_t pos;
+		kh_ensitr_t pos;
 
 		pos = kh_get_oid_map(island_marks, ent->idx.oid);
-		if (pos >= kh_end(island_marks))
+		if (kh_ens_is_end(pos))
 			continue;
 
-		root_marks = kh_value(island_marks, pos);
+		root_marks = kh_ens_val(island_marks, pos);
 
 		tree = lookup_tree(r, &ent->idx.oid);
 		if (!tree || parse_tree(tree) < 0)
@@ -499,11 +499,11 @@ void load_delta_islands(struct repository *r, int progress)
 
 void propagate_island_marks(struct commit *commit)
 {
-	khiter_t pos = kh_get_oid_map(island_marks, commit->object.oid);
+	kh_ensitr_t pos = kh_get_oid_map(island_marks, commit->object.oid);
 
-	if (pos < kh_end(island_marks)) {
+	if (!kh_ens_is_end(pos)) {
 		struct commit_list *p;
-		struct island_bitmap *root_marks = kh_value(island_marks, pos);
+		struct island_bitmap *root_marks = kh_ens_val(island_marks, pos);
 
 		repo_parse_commit(the_repository, commit);
 		set_island_marks(&repo_get_commit_tree(the_repository, commit)->object,
@@ -518,7 +518,7 @@ void free_island_marks(void)
 	struct island_bitmap *bitmap;
 
 	if (island_marks) {
-		kh_foreach_value(island_marks, bitmap, {
+		kh_ens_foreach_value(island_marks, bitmap, {
 			if (!--bitmap->refcount)
 				free(bitmap);
 		});
@@ -538,12 +538,12 @@ int compute_pack_layers(struct packing_data *to_pack)
 
 	for (i = 0; i < to_pack->nr_objects; ++i) {
 		struct object_entry *entry = &to_pack->objects[i];
-		khiter_t pos = kh_get_oid_map(island_marks, entry->idx.oid);
+		kh_ensitr_t pos = kh_get_oid_map(island_marks, entry->idx.oid);
 
 		oe_set_layer(to_pack, entry, 1);
 
-		if (pos < kh_end(island_marks)) {
-			struct island_bitmap *bitmap = kh_value(island_marks, pos);
+		if (!kh_ens_is_end(pos)) {
+			struct island_bitmap *bitmap = kh_ens_val(island_marks, pos);
 
 			if (island_bitmap_get(bitmap, island_counter_core))
 				oe_set_layer(to_pack, entry, 0);
diff --git a/fsck.c b/fsck.c
index 8ded0a473a..4c67e1e64c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -266,13 +266,13 @@ void fsck_enable_object_names(struct fsck_options *options)
 const char *fsck_get_object_name(struct fsck_options *options,
 				 const struct object_id *oid)
 {
-	khiter_t pos;
+	kh_ensitr_t pos;
 	if (!options->object_names)
 		return NULL;
 	pos = kh_get_oid_map(options->object_names, *oid);
-	if (pos >= kh_end(options->object_names))
+	if (kh_ens_is_end(pos))
 		return NULL;
-	return kh_value(options->object_names, pos);
+	return kh_ens_val(options->object_names, pos);
 }
 
 void fsck_put_object_name(struct fsck_options *options,
@@ -281,7 +281,7 @@ void fsck_put_object_name(struct fsck_options *options,
 {
 	va_list ap;
 	struct strbuf buf = STRBUF_INIT;
-	khiter_t pos;
+	kh_ensitr_t pos;
 	int hashret;
 
 	if (!options->object_names)
@@ -292,7 +292,7 @@ void fsck_put_object_name(struct fsck_options *options,
 		return;
 	va_start(ap, fmt);
 	strbuf_vaddf(&buf, fmt, ap);
-	kh_value(options->object_names, pos) = strbuf_detach(&buf, NULL);
+	kh_ens_val(options->object_names, pos) = strbuf_detach(&buf, NULL);
 	va_end(ap);
 }
 
diff --git a/khashl.h b/khashl.h
index 8ffe80fbb2..e950593d61 100644
--- a/khashl.h
+++ b/khashl.h
@@ -203,22 +203,22 @@ static kh_inline khint_t __kh_h2b(khint_t hash, khint_t bits) { return hash * 26
 	__KHASHL_PROTOTYPES(HType, prefix, khkey_t)
 
 /* compatibility wrappers to make khash -> khashl migration easier */
-#define __KHASH_COMPAT(SCOPE, HType, prefix, khkey_t) \
+#define __KHASH_COMPAT(SCOPE, kh_idx, HType, prefix, khkey_t) \
 	typedef HType HType##_t; \
 	SCOPE HType *kh_init_##prefix(void) { return prefix##_init(); } \
 	SCOPE void kh_release_##prefix(HType *h) { prefix##_release(h); } \
 	SCOPE void kh_destroy_##prefix(HType *h) { prefix##_destroy(h); } \
 	SCOPE void kh_clear_##prefix(HType *h) { prefix##_clear(h); } \
-	SCOPE khint_t kh_get_##prefix(const HType *h, khkey_t key) { \
+	SCOPE kh_idx kh_get_##prefix(const HType *h, khkey_t key) { \
 		return prefix##_get(h, key); \
 	} \
 	SCOPE void kh_resize_##prefix(HType *h, khint_t new_n_buckets) { \
 		prefix##_resize(h, new_n_buckets); \
 	} \
-	SCOPE khint_t kh_put_##prefix(HType *h, khkey_t key, int *absent) { \
+	SCOPE kh_idx kh_put_##prefix(HType *h, khkey_t key, int *absent) { \
 		return prefix##_put(h, key, absent); \
 	} \
-	SCOPE int kh_del_##prefix(HType *h, khint_t i) { \
+	SCOPE int kh_del_##prefix(HType *h, kh_idx i) { \
 		return prefix##_del(h, i); \
 	}
 
@@ -244,18 +244,32 @@ typedef struct {
 		khint64_t count:54, bits:8; \
 		HType##_sub *sub; \
 	} HType; \
-	SCOPE HType *prefix##_init(int bits) { \
-		HType *g; \
-		g = (HType*)kcalloc(1, sizeof(*g)); \
+	SCOPE HType *prefix##_init_bits(HType *g, size_t bits) { \
 		g->bits = bits; \
 		g->sub = (HType##_sub*)kcalloc(1U<<bits, sizeof(*g->sub)); \
 		return g; \
 	} \
+	SCOPE HType *prefix##_init(void) { \
+		HType *g; \
+		g = (HType*)kcalloc(1, sizeof(*g)); \
+		return prefix##_init_bits(g, 6); /* unsure about default */ \
+	} \
+	SCOPE void prefix##_release(HType *g) { \
+		int t; \
+		for (t = 0; t < 1<<g->bits; ++t) \
+			prefix##_sub_release(&g->sub[t]); \
+		kfree(g->sub); \
+	} \
 	SCOPE void prefix##_destroy(HType *g) { \
+		if (!g) return; \
+		prefix##_release(g); \
+		kfree(g); \
+	} \
+	SCOPE void prefix##_clear(HType *g) { \
 		int t; \
 		if (!g) return; \
-		for (t = 0; t < 1<<g->bits; ++t) { kfree((void*)g->sub[t].keys); kfree(g->sub[t].used); } \
-		kfree(g->sub); kfree(g); \
+		for (t = 0; t < 1<<g->bits; ++t) \
+			prefix##_sub_clear(&g->sub[t]); \
 	} \
 	SCOPE kh_ensitr_t prefix##_getp(const HType *g, const khkey_t *key) { \
 		khint_t hash, low, ret; \
@@ -312,7 +326,7 @@ typedef struct {
 	SCOPE khint_t prefix##_get(const HType *h, khkey_t key) { HType##_s_bucket_t t; t.key = key; return prefix##_s_getp(h, &t); } \
 	SCOPE int prefix##_del(HType *h, khint_t k) { return prefix##_s_del(h, k); } \
 	SCOPE khint_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_s_bucket_t t; t.key = key; return prefix##_s_putp(h, &t, absent); } \
-	__KHASH_COMPAT(SCOPE, HType, prefix, khkey_t)
+	__KHASH_COMPAT(SCOPE, khint_t, HType, prefix, khkey_t)
 
 #define KHASHL_MAP_INIT(SCOPE, HType, prefix, khkey_t, kh_val_t, __hash_fn, __hash_eq) \
 	typedef struct { khkey_t key; kh_val_t val; } __kh_packed HType##_m_bucket_t; \
@@ -327,7 +341,7 @@ typedef struct {
 	SCOPE khint_t prefix##_get(const HType *h, khkey_t key) { HType##_m_bucket_t t; t.key = key; return prefix##_m_getp(h, &t); } \
 	SCOPE int prefix##_del(HType *h, khint_t k) { return prefix##_m_del(h, k); } \
 	SCOPE khint_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_m_bucket_t t; t.key = key; return prefix##_m_putp(h, &t, absent); } \
-	__KHASH_COMPAT(SCOPE, HType, prefix, khkey_t)
+	__KHASH_COMPAT(SCOPE, khint_t, HType, prefix, khkey_t)
 
 #define KHASHL_CSET_INIT(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
 	typedef struct { khkey_t key; khint_t hash; } __kh_packed HType##_cs_bucket_t; \
@@ -354,11 +368,15 @@ typedef struct {
 	static kh_inline khint_t prefix##_m_hash(HType##_m_bucket_t x) { return __hash_fn(x.key); } \
 	static kh_inline int prefix##_m_eq(HType##_m_bucket_t x, HType##_m_bucket_t y) { return __hash_eq(x.key, y.key); } \
 	KHASHE_INIT(KH_LOCAL, HType, prefix##_m, HType##_m_bucket_t, prefix##_m_hash, prefix##_m_eq) \
-	SCOPE HType *prefix##_init(int bits) { return prefix##_m_init(bits); } \
+	SCOPE HType *prefix##_init(void) { return prefix##_m_init(); } \
+	SCOPE void prefix##_release(HType *h) { prefix##_m_release(h); } \
 	SCOPE void prefix##_destroy(HType *h) { prefix##_m_destroy(h); } \
+	SCOPE void prefix##_clear(HType *h) { prefix##_m_clear(h); } \
+	SCOPE void prefix##_resize(HType *h, khint_t ignore) { /* noop */ } \
 	SCOPE kh_ensitr_t prefix##_get(const HType *h, khkey_t key) { HType##_m_bucket_t t; t.key = key; return prefix##_m_getp(h, &t); } \
 	SCOPE int prefix##_del(HType *h, kh_ensitr_t k) { return prefix##_m_del(h, k); } \
-	SCOPE kh_ensitr_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_m_bucket_t t; t.key = key; return prefix##_m_putp(h, &t, absent); }
+	SCOPE kh_ensitr_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_m_bucket_t t; t.key = key; return prefix##_m_putp(h, &t, absent); } \
+	__KHASH_COMPAT(SCOPE, kh_ensitr_t, HType, prefix, khkey_t)
 
 /**************************
  * Public macro functions *
@@ -487,6 +505,18 @@ static kh_inline khint_t kh_hash_bytes(int len, const unsigned char *s) {
 		code;						\
 	} }
 
+#define kh_ens_foreach(g, kvar, vvar, code) do { \
+	size_t t; \
+	for (t = 0; t < 1<<g->bits; ++t) \
+		kh_foreach(&g->sub[t], kvar, vvar, code); \
+} while (0)
+
+#define kh_ens_foreach_value(g, vvar, code) do { \
+	size_t t; \
+	for (t = 0; t < 1<<g->bits; ++t) \
+		kh_foreach_value(&g->sub[t], vvar, code); \
+} while (0)
+
 /*! @function
   @abstract     Iterate over the values in the hash table
   @param  h     Pointer to the hash table
@@ -513,10 +543,10 @@ static inline int oideq_by_value(struct object_id a, struct object_id b)
 KHASHL_SET_INIT(KH_LOCAL, kh_oid_set, oid_set, struct object_id,
 		oidhash_by_value, oideq_by_value)
 
-KHASHL_MAP_INIT(KH_LOCAL, kh_oid_map, oid_map, struct object_id, void *,
+KHASHE_MAP_INIT(KH_LOCAL, kh_oid_map, oid_map, struct object_id, void *,
 		oidhash_by_value, oideq_by_value)
 
-KHASHL_MAP_INIT(KH_LOCAL, kh_oid_pos, oid_pos, struct object_id, int,
+KHASHE_MAP_INIT(KH_LOCAL, kh_oid_pos, oid_pos, struct object_id, int,
 		oidhash_by_value, oideq_by_value)
 
 #endif /* __AC_KHASHL_H */
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 990a9498d7..bbf2090c46 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -465,7 +465,7 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 static void store_selected(struct bb_commit *ent, struct commit *commit)
 {
 	struct bitmapped_commit *stored = &writer.selected[ent->idx];
-	khiter_t hash_pos;
+	kh_ensitr_t hash_pos;
 	int hash_ret;
 
 	stored->bitmap = bitmap_to_ewah(ent->bitmap);
@@ -474,7 +474,7 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 	if (hash_ret == 0)
 		die("Duplicate entry when writing index: %s",
 		    oid_to_hex(&commit->object.oid));
-	kh_value(writer.bitmaps, hash_pos) = stored;
+	kh_ens_val(writer.bitmaps, hash_pos) = stored;
 }
 
 int bitmap_writer_build(struct packing_data *to_pack)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2baeabacee..68cd893dee 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -214,7 +214,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 					  int flags)
 {
 	struct stored_bitmap *stored;
-	khiter_t hash_pos;
+	kh_ensitr_t hash_pos;
 	int ret;
 
 	stored = xmalloc(sizeof(struct stored_bitmap));
@@ -235,7 +235,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 		return NULL;
 	}
 
-	kh_value(index->bitmaps, hash_pos) = stored;
+	kh_ens_val(index->bitmaps, hash_pos) = stored;
 	return stored;
 }
 
@@ -721,7 +721,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	static size_t xor_items_nr = 0, xor_items_alloc = 0;
 	static int is_corrupt = 0;
 	int xor_flags;
-	khiter_t hash_pos;
+	kh_ensitr_t hash_pos;
 	struct bitmap_lookup_table_xor_item *xor_item;
 
 	if (is_corrupt)
@@ -766,8 +766,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 		 * has already been stored. So, assign this stored bitmap
 		 * to the xor_bitmap.
 		 */
-		if (hash_pos < kh_end(bitmap_git->bitmaps) &&
-			(xor_bitmap = kh_value(bitmap_git->bitmaps, hash_pos)))
+		if (!kh_ens_is_end(hash_pos) &&
+			(xor_bitmap = kh_ens_val(bitmap_git->bitmaps, hash_pos)))
 			break;
 		xor_items_nr++;
 		xor_row = triplet.xor_row;
@@ -841,9 +841,9 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit)
 {
-	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
+	kh_ensitr_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
 					   commit->object.oid);
-	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
+	if (kh_ens_is_end(hash_pos)) {
 		struct stored_bitmap *bitmap = NULL;
 		if (!bitmap_git->table_lookup)
 			return NULL;
@@ -855,17 +855,17 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 			return NULL;
 		return lookup_stored_bitmap(bitmap);
 	}
-	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
+	return lookup_stored_bitmap(kh_ens_val(bitmap_git->bitmaps, hash_pos));
 }
 
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
 	kh_oid_pos_t *positions = bitmap_git->ext_index.positions;
-	khiter_t pos = kh_get_oid_pos(positions, *oid);
+	kh_ensitr_t pos = kh_get_oid_pos(positions, *oid);
 
-	if (pos < kh_end(positions)) {
-		int bitmap_pos = kh_value(positions, pos);
+	if (!kh_ens_is_end(pos)) {
+		int bitmap_pos = kh_ens_val(positions, pos);
 		return bitmap_pos + bitmap_num_objects(bitmap_git);
 	}
 
@@ -913,7 +913,7 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 
-	khiter_t hash_pos;
+	kh_ensitr_t hash_pos;
 	int hash_ret;
 	int bitmap_pos;
 
@@ -928,10 +928,10 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 		bitmap_pos = eindex->count;
 		eindex->objects[eindex->count] = object;
 		eindex->hashes[eindex->count] = pack_name_hash(name);
-		kh_value(eindex->positions, hash_pos) = bitmap_pos;
+		kh_ens_val(eindex->positions, hash_pos) = bitmap_pos;
 		eindex->count++;
 	} else {
-		bitmap_pos = kh_value(eindex->positions, hash_pos);
+		bitmap_pos = kh_ens_val(eindex->positions, hash_pos);
 	}
 
 	return bitmap_pos + bitmap_num_objects(bitmap_git);
@@ -2361,7 +2361,7 @@ int test_bitmap_commits(struct repository *r)
 			die(_("failed to load bitmap indexes"));
 	}
 
-	kh_foreach(bitmap_git->bitmaps, oid, value, {
+	kh_ens_foreach(bitmap_git->bitmaps, oid, value, {
 		printf_ln("%s", oid_to_hex(&oid));
 	});
 
@@ -2479,7 +2479,7 @@ void free_bitmap_index(struct bitmap_index *b)
 	ewah_pool_free(b->tags);
 	if (b->bitmaps) {
 		struct stored_bitmap *sb;
-		kh_foreach_value(b->bitmaps, sb, {
+		kh_ens_foreach_value(b->bitmaps, sb, {
 			ewah_pool_free(sb->root);
 			free(sb);
 		});
