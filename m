Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D39C49EAB
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 02:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F6461C51
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 02:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhF0Ct6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 22:49:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60776 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhF0Ctz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 22:49:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BB7101F9F4;
        Sun, 27 Jun 2021 02:47:19 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 5/5] oidtree: a crit-bit tree for odb_loose_cache
Date:   Sun, 27 Jun 2021 02:47:18 +0000
Message-Id: <20210627024718.25383-6-e@80x24.org>
In-Reply-To: <20210627024718.25383-1-e@80x24.org>
References: <20210627024718.25383-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This saves 8K per `struct object_directory', meaning it saves
around 800MB in my case involving 100K alternates (half or more
of those alternates are unlikely to hold loose objects).

This is implemented in two parts: a generic, allocation-free
`cbtree' and the `oidtree' wrapper on top of it.  The latter
provides allocation using alloc_state as a memory pool to
improve locality and reduce free(3) overhead.

Unlike oid-array, the crit-bit tree does not require sorting.
Performance is bound by the key length, for oidtree that is
fixed at sizeof(struct object_id).  There's no need to have
256 oidtrees to mitigate the O(n log n) overhead like we did
with oid-array.

Being a prefix trie, it is natively suited for expanding short
object IDs via prefix-limited iteration in
`find_short_object_filename'.

On my busy workstation, p4205 performance seems to be roughly
unchanged (+/-8%).  Startup with 100K total alternates with no
loose objects seems around 10-20% faster on a hot cache.
(800MB in memory savings means more memory for the kernel FS
cache).

The generic cbtree implementation does impose some extra
overhead for oidtree in that it uses memcmp(3) on
"struct object_id" so it wastes cycles comparing 12 extra bytes
on SHA-1 repositories.  I've not yet explored reducing this
overhead, but I expect there are many places in our code base
where we'd want to investigate this.

More information on crit-bit trees: https://cr.yp.to/critbit.html

Signed-off-by: Eric Wong <e@80x24.org>
---
 Makefile                |   3 +
 alloc.c                 |   6 ++
 alloc.h                 |   1 +
 cbtree.c                | 167 ++++++++++++++++++++++++++++++++++++++++
 cbtree.h                |  56 ++++++++++++++
 object-file.c           |  17 ++--
 object-name.c           |  28 +++----
 object-store.h          |   5 +-
 oidtree.c               |  94 ++++++++++++++++++++++
 oidtree.h               |  29 +++++++
 t/helper/test-oidtree.c |  45 +++++++++++
 t/helper/test-tool.c    |   1 +
 t/helper/test-tool.h    |   1 +
 t/t0069-oidtree.sh      |  52 +++++++++++++
 14 files changed, 476 insertions(+), 29 deletions(-)
 create mode 100644 cbtree.c
 create mode 100644 cbtree.h
 create mode 100644 oidtree.c
 create mode 100644 oidtree.h
 create mode 100644 t/helper/test-oidtree.c
 create mode 100755 t/t0069-oidtree.sh

diff --git a/Makefile b/Makefile
index c3565fc0f8..a1525978fb 100644
--- a/Makefile
+++ b/Makefile
@@ -722,6 +722,7 @@ TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-oidmap.o
+TEST_BUILTINS_OBJS += test-oidtree.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
@@ -845,6 +846,7 @@ LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
+LIB_OBJS += cbtree.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
 LIB_OBJS += chunk-format.o
@@ -940,6 +942,7 @@ LIB_OBJS += object.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
+LIB_OBJS += oidtree.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
diff --git a/alloc.c b/alloc.c
index 957a0af362..ca1e178c5a 100644
--- a/alloc.c
+++ b/alloc.c
@@ -14,6 +14,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "oidtree.h"
 #include "alloc.h"
 
 #define BLOCKING 1024
@@ -123,6 +124,11 @@ void *alloc_commit_node(struct repository *r)
 	return c;
 }
 
+void *alloc_from_state(struct alloc_state *alloc_state, size_t n)
+{
+	return alloc_node(alloc_state, n);
+}
+
 static void report(const char *name, unsigned int count, size_t size)
 {
 	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
diff --git a/alloc.h b/alloc.h
index 371d388b55..4032375aa1 100644
--- a/alloc.h
+++ b/alloc.h
@@ -13,6 +13,7 @@ void init_commit_node(struct commit *c);
 void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
+void *alloc_from_state(struct alloc_state *, size_t n);
 void alloc_report(struct repository *r);
 
 struct alloc_state *allocate_alloc_state(void);
diff --git a/cbtree.c b/cbtree.c
new file mode 100644
index 0000000000..b0c65d810f
--- /dev/null
+++ b/cbtree.c
@@ -0,0 +1,167 @@
+/*
+ * crit-bit tree implementation, does no allocations internally
+ * For more information on crit-bit trees: https://cr.yp.to/critbit.html
+ * Based on Adam Langley's adaptation of Dan Bernstein's public domain code
+ * git clone https://github.com/agl/critbit.git
+ */
+#include "cbtree.h"
+
+static struct cb_node *cb_node_of(const void *p)
+{
+	return (struct cb_node *)((uintptr_t)p - 1);
+}
+
+/* locate the best match, does not do a final comparision */
+static struct cb_node *cb_internal_best_match(struct cb_node *p,
+					const uint8_t *k, size_t klen)
+{
+	while (1 & (uintptr_t)p) {
+		struct cb_node *q = cb_node_of(p);
+		uint8_t c = q->byte < klen ? k[q->byte] : 0;
+		size_t direction = (1 + (q->otherbits | c)) >> 8;
+
+		p = q->child[direction];
+	}
+	return p;
+}
+
+/* returns NULL if successful, existing cb_node if duplicate */
+struct cb_node *cb_insert(struct cb_tree *t, struct cb_node *node, size_t klen)
+{
+	size_t newbyte, newotherbits;
+	uint8_t c;
+	int newdirection;
+	struct cb_node **wherep, *p;
+
+	assert(!((uintptr_t)node & 1)); /* allocations must be aligned */
+
+	if (!t->root) {		/* insert into empty tree */
+		t->root = node;
+		return NULL;	/* success */
+	}
+
+	/* see if a node already exists */
+	p = cb_internal_best_match(t->root, node->k, klen);
+
+	/* find first differing byte */
+	for (newbyte = 0; newbyte < klen; newbyte++) {
+		if (p->k[newbyte] != node->k[newbyte])
+			goto different_byte_found;
+	}
+	return p;	/* element exists, let user deal with it */
+
+different_byte_found:
+	newotherbits = p->k[newbyte] ^ node->k[newbyte];
+	newotherbits |= newotherbits >> 1;
+	newotherbits |= newotherbits >> 2;
+	newotherbits |= newotherbits >> 4;
+	newotherbits = (newotherbits & ~(newotherbits >> 1)) ^ 255;
+	c = p->k[newbyte];
+	newdirection = (1 + (newotherbits | c)) >> 8;
+
+	node->byte = newbyte;
+	node->otherbits = newotherbits;
+	node->child[1 - newdirection] = node;
+
+	/* find a place to insert it */
+	wherep = &t->root;
+	for (;;) {
+		struct cb_node *q;
+		size_t direction;
+
+		p = *wherep;
+		if (!(1 & (uintptr_t)p))
+			break;
+		q = cb_node_of(p);
+		if (q->byte > newbyte)
+			break;
+		if (q->byte == newbyte && q->otherbits > newotherbits)
+			break;
+		c = q->byte < klen ? node->k[q->byte] : 0;
+		direction = (1 + (q->otherbits | c)) >> 8;
+		wherep = q->child + direction;
+	}
+
+	node->child[newdirection] = *wherep;
+	*wherep = (struct cb_node *)(1 + (uintptr_t)node);
+
+	return NULL; /* success */
+}
+
+struct cb_node *cb_lookup(struct cb_tree *t, const uint8_t *k, size_t klen)
+{
+	struct cb_node *p = cb_internal_best_match(t->root, k, klen);
+
+	return p && !memcmp(p->k, k, klen) ? p : NULL;
+}
+
+struct cb_node *cb_unlink(struct cb_tree *t, const uint8_t *k, size_t klen)
+{
+	struct cb_node **wherep = &t->root;
+	struct cb_node **whereq = NULL;
+	struct cb_node *q = NULL;
+	size_t direction = 0;
+	uint8_t c;
+	struct cb_node *p = t->root;
+
+	if (!p) return NULL;	/* empty tree, nothing to delete */
+
+	/* traverse to find best match, keeping link to parent */
+	while (1 & (uintptr_t)p) {
+		whereq = wherep;
+		q = cb_node_of(p);
+		c = q->byte < klen ? k[q->byte] : 0;
+		direction = (1 + (q->otherbits | c)) >> 8;
+		wherep = q->child + direction;
+		p = *wherep;
+	}
+
+	if (memcmp(p->k, k, klen))
+		return NULL;		/* no match, nothing unlinked */
+
+	/* found an exact match */
+	if (whereq)	/* update parent */
+		*whereq = q->child[1 - direction];
+	else
+		t->root = NULL;
+	return p;
+}
+
+static enum cb_next cb_descend(struct cb_node *p, cb_iter fn, void *arg)
+{
+	if (1 & (uintptr_t)p) {
+		struct cb_node *q = cb_node_of(p);
+		enum cb_next n = cb_descend(q->child[0], fn, arg);
+
+		return n == CB_BREAK ? n : cb_descend(q->child[1], fn, arg);
+	} else {
+		return fn(p, arg);
+	}
+}
+
+void cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
+			cb_iter fn, void *arg)
+{
+	struct cb_node *p = t->root;
+	struct cb_node *top = p;
+	size_t i = 0;
+
+	if (!p) return; /* empty tree */
+
+	/* Walk tree, maintaining top pointer */
+	while (1 & (uintptr_t)p) {
+		struct cb_node *q = cb_node_of(p);
+		uint8_t c = q->byte < klen ? kpfx[q->byte] : 0;
+		size_t direction = (1 + (q->otherbits | c)) >> 8;
+
+		p = q->child[direction];
+		if (q->byte < klen)
+			top = p;
+	}
+
+	for (i = 0; i < klen; i++) {
+		if (p->k[i] != kpfx[i])
+			return; /* "best" match failed */
+	}
+	cb_descend(top, fn, arg);
+}
diff --git a/cbtree.h b/cbtree.h
new file mode 100644
index 0000000000..fe4587087e
--- /dev/null
+++ b/cbtree.h
@@ -0,0 +1,56 @@
+/*
+ * crit-bit tree implementation, does no allocations internally
+ * For more information on crit-bit trees: https://cr.yp.to/critbit.html
+ * Based on Adam Langley's adaptation of Dan Bernstein's public domain code
+ * git clone https://github.com/agl/critbit.git
+ *
+ * This is adapted to store arbitrary data (not just NUL-terminated C strings
+ * and allocates no memory internally.  The user needs to allocate
+ * "struct cb_node" and fill cb_node.k[] with arbitrary match data
+ * for memcmp.
+ * If "klen" is variable, then it should be embedded into "c_node.k[]"
+ * Recursion is bound by the maximum value of "klen" used.
+ */
+#ifndef CBTREE_H
+#define CBTREE_H
+
+#include "git-compat-util.h"
+
+struct cb_node;
+struct cb_node {
+	struct cb_node *child[2];
+	/*
+	 * n.b. uint32_t for `byte' is excessive for OIDs,
+	 * we may consider shorter variants if nothing else gets stored.
+	 */
+	uint32_t byte;
+	uint8_t otherbits;
+	uint8_t k[FLEX_ARRAY]; /* arbitrary data */
+};
+
+struct cb_tree {
+	struct cb_node *root;
+};
+
+enum cb_next {
+	CB_CONTINUE = 0,
+	CB_BREAK = 1
+};
+
+#define CBTREE_INIT { .root = NULL }
+
+static inline void cb_init(struct cb_tree *t)
+{
+	t->root = NULL;
+}
+
+struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
+struct cb_node *cb_insert(struct cb_tree *, struct cb_node *, size_t klen);
+struct cb_node *cb_unlink(struct cb_tree *t, const uint8_t *k, size_t klen);
+
+typedef enum cb_next (*cb_iter)(struct cb_node *, void *arg);
+
+void cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
+		cb_iter, void *arg);
+
+#endif /* CBTREE_H */
diff --git a/object-file.c b/object-file.c
index 2c8b9c05f9..d33b84c4a4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1175,7 +1175,7 @@ static int quick_has_loose(struct repository *r,
 
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		if (oid_array_lookup(odb_loose_cache(odb, oid), oid) >= 0)
+		if (oidtree_contains(odb_loose_cache(odb, oid), oid))
 			return 1;
 	}
 	return 0;
@@ -2454,11 +2454,11 @@ int for_each_loose_object(each_loose_object_fn cb, void *data,
 static int append_loose_object(const struct object_id *oid, const char *path,
 			       void *data)
 {
-	oid_array_append(data, oid);
+	oidtree_insert(data, oid);
 	return 0;
 }
 
-struct oid_array *odb_loose_cache(struct object_directory *odb,
+struct oidtree *odb_loose_cache(struct object_directory *odb,
 				  const struct object_id *oid)
 {
 	int subdir_nr = oid->hash[0];
@@ -2473,24 +2473,21 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 
 	bitmap = &odb->loose_objects_subdir_seen[subdir_nr / BM_SIZE];
 	if (*bitmap & bit)
-		return &odb->loose_objects_cache[subdir_nr];
+		return &odb->loose_objects_cache;
 
 	strbuf_addstr(&buf, odb->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    append_loose_object,
 				    NULL, NULL,
-				    &odb->loose_objects_cache[subdir_nr]);
+				    &odb->loose_objects_cache);
 	*bitmap |= bit;
 	strbuf_release(&buf);
-	return &odb->loose_objects_cache[subdir_nr];
+	return &odb->loose_objects_cache;
 }
 
 void odb_clear_loose_cache(struct object_directory *odb)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(odb->loose_objects_cache); i++)
-		oid_array_clear(&odb->loose_objects_cache[i]);
+	oidtree_destroy(&odb->loose_objects_cache);
 	memset(&odb->loose_objects_subdir_seen, 0,
 	       sizeof(odb->loose_objects_subdir_seen));
 }
diff --git a/object-name.c b/object-name.c
index 64202de60b..3263c19457 100644
--- a/object-name.c
+++ b/object-name.c
@@ -87,27 +87,21 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 
 static int match_hash(unsigned, const unsigned char *, const unsigned char *);
 
+static enum cb_next match_prefix(const struct object_id *oid, void *arg)
+{
+	struct disambiguate_state *ds = arg;
+	/* no need to call match_hash, oidtree_each did prefix match */
+	update_candidates(ds, oid);
+	return ds->ambiguous ? CB_BREAK : CB_CONTINUE;
+}
+
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct object_directory *odb;
 
-	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next) {
-		int pos;
-		struct oid_array *loose_objects;
-
-		loose_objects = odb_loose_cache(odb, &ds->bin_pfx);
-		pos = oid_array_lookup(loose_objects, &ds->bin_pfx);
-		if (pos < 0)
-			pos = -1 - pos;
-		while (!ds->ambiguous && pos < loose_objects->nr) {
-			const struct object_id *oid;
-			oid = loose_objects->oid + pos;
-			if (!match_hash(ds->len, ds->bin_pfx.hash, oid->hash))
-				break;
-			update_candidates(ds, oid);
-			pos++;
-		}
-	}
+	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next)
+		oidtree_each(odb_loose_cache(odb, &ds->bin_pfx),
+				&ds->bin_pfx, ds->len, match_prefix, ds);
 }
 
 static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
diff --git a/object-store.h b/object-store.h
index 8fcddf3e65..b507108d18 100644
--- a/object-store.h
+++ b/object-store.h
@@ -9,6 +9,7 @@
 #include "thread-utils.h"
 #include "khash.h"
 #include "dir.h"
+#include "oidtree.h"
 
 struct object_directory {
 	struct object_directory *next;
@@ -23,7 +24,7 @@ struct object_directory {
 	 * Be sure to call odb_load_loose_cache() before using.
 	 */
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
-	struct oid_array loose_objects_cache[256];
+	struct oidtree loose_objects_cache;
 
 	/*
 	 * Path to the alternative object store. If this is a relative path,
@@ -69,7 +70,7 @@ void add_to_alternates_memory(const char *dir);
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
  */
-struct oid_array *odb_loose_cache(struct object_directory *odb,
+struct oidtree *odb_loose_cache(struct object_directory *odb,
 				  const struct object_id *oid);
 
 /* Empty the loose object cache for the specified object directory. */
diff --git a/oidtree.c b/oidtree.c
new file mode 100644
index 0000000000..c1188d8f48
--- /dev/null
+++ b/oidtree.c
@@ -0,0 +1,94 @@
+/*
+ * A wrapper around cbtree which stores oids
+ * May be used to replace oid-array for prefix (abbreviation) matches
+ */
+#include "oidtree.h"
+#include "alloc.h"
+#include "hash.h"
+
+struct oidtree_node {
+	/* n.k[] is used to store "struct object_id" */
+	struct cb_node n;
+};
+
+struct oidtree_iter_data {
+	oidtree_iter fn;
+	void *arg;
+	size_t *last_nibble_at;
+	int algo;
+	uint8_t last_byte;
+};
+
+void oidtree_destroy(struct oidtree *ot)
+{
+	if (ot->mempool) {
+		clear_alloc_state(ot->mempool);
+		FREE_AND_NULL(ot->mempool);
+	}
+	oidtree_init(ot);
+}
+
+void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
+{
+	struct oidtree_node *on;
+
+	if (!ot->mempool)
+		ot->mempool = allocate_alloc_state();
+	if (!oid->algo)
+		BUG("oidtree_insert requires oid->algo");
+
+	on = alloc_from_state(ot->mempool, sizeof(*on) + sizeof(*oid));
+	oidcpy_with_padding((struct object_id *)on->n.k, oid);
+
+	/*
+	 * n.b. we shouldn't get duplicates, here, but we'll have
+	 * a small leak that won't be freed until oidtree_destroy
+	 */
+	cb_insert(&ot->t, &on->n, sizeof(*oid));
+}
+
+int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
+{
+	struct object_id k = { 0 };
+	size_t klen = sizeof(k);
+	oidcpy_with_padding(&k, oid);
+
+	if (oid->algo == GIT_HASH_UNKNOWN) {
+		k.algo = hash_algo_by_ptr(the_hash_algo);
+		klen -= sizeof(oid->algo);
+	}
+
+	return cb_lookup(&ot->t, (const uint8_t *)&k, klen) ? 1 : 0;
+}
+
+static enum cb_next iter(struct cb_node *n, void *arg)
+{
+	struct oidtree_iter_data *x = arg;
+	const struct object_id *oid = (const struct object_id *)n->k;
+
+	if (x->algo != GIT_HASH_UNKNOWN && x->algo != oid->algo)
+		return CB_CONTINUE;
+
+	if (x->last_nibble_at) {
+		if ((oid->hash[*x->last_nibble_at] ^ x->last_byte) & 0xf0)
+			return CB_CONTINUE;
+	}
+
+	return x->fn(oid, x->arg);
+}
+
+void oidtree_each(struct oidtree *ot, const struct object_id *oid,
+			size_t oidhexlen, oidtree_iter fn, void *arg)
+{
+	size_t klen = oidhexlen / 2;
+	struct oidtree_iter_data x = { 0 };
+
+	x.fn = fn;
+	x.arg = arg;
+	x.algo = oid->algo;
+	if (oidhexlen & 1) {
+		x.last_byte = oid->hash[klen];
+		x.last_nibble_at = &klen;
+	}
+	cb_each(&ot->t, (const uint8_t *)oid, klen, iter, &x);
+}
diff --git a/oidtree.h b/oidtree.h
new file mode 100644
index 0000000000..73399bb978
--- /dev/null
+++ b/oidtree.h
@@ -0,0 +1,29 @@
+#ifndef OIDTREE_H
+#define OIDTREE_H
+
+#include "cbtree.h"
+#include "hash.h"
+
+struct alloc_state;
+struct oidtree {
+	struct cb_tree t;
+	struct alloc_state *mempool;
+};
+
+#define OIDTREE_INIT { .t = CBTREE_INIT, .mempool = NULL }
+
+static inline void oidtree_init(struct oidtree *ot)
+{
+	cb_init(&ot->t);
+	ot->mempool = NULL;
+}
+
+void oidtree_destroy(struct oidtree *);
+void oidtree_insert(struct oidtree *, const struct object_id *);
+int oidtree_contains(struct oidtree *, const struct object_id *);
+
+typedef enum cb_next (*oidtree_iter)(const struct object_id *, void *arg);
+void oidtree_each(struct oidtree *, const struct object_id *,
+			size_t oidhexlen, oidtree_iter, void *arg);
+
+#endif /* OIDTREE_H */
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
new file mode 100644
index 0000000000..44bb2e7c29
--- /dev/null
+++ b/t/helper/test-oidtree.c
@@ -0,0 +1,45 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "oidtree.h"
+
+static enum cb_next print_oid(const struct object_id *oid, void *data)
+{
+	puts(oid_to_hex(oid));
+	return CB_CONTINUE;
+}
+
+int cmd__oidtree(int argc, const char **argv)
+{
+	struct oidtree ot = OIDTREE_INIT;
+	struct strbuf line = STRBUF_INIT;
+	int nongit_ok;
+
+	setup_git_directory_gently(&nongit_ok);
+
+	while (strbuf_getline(&line, stdin) != EOF) {
+		const char *arg;
+		struct object_id oid;
+
+		if (skip_prefix(line.buf, "insert ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die("not a hexadecimal oid: %s", arg);
+			oidtree_insert(&ot, &oid);
+		} else if (skip_prefix(line.buf, "contains ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die("not a hexadecimal oid: %s", arg);
+			printf("%d\n", oidtree_contains(&ot, &oid));
+		} else if (skip_prefix(line.buf, "each ", &arg)) {
+			char buf[GIT_SHA1_HEXSZ  + 1] = { '0' };
+			memset(&oid, 0, sizeof(oid));
+			memcpy(buf, arg, strlen(arg));
+			buf[GIT_SHA1_HEXSZ] = 0;
+			get_oid_hex_any(buf, &oid);
+			oid.algo = GIT_HASH_SHA1;
+			oidtree_each(&ot, &oid, strlen(arg), print_oid, NULL);
+		} else if (!strcmp(line.buf, "destroy"))
+			oidtree_destroy(&ot);
+		else
+			die("unknown command: %s", line.buf);
+	}
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c5bd0c6d4c..9d37debf28 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -43,6 +43,7 @@ static struct test_cmd cmds[] = {
 	{ "mktemp", cmd__mktemp },
 	{ "oid-array", cmd__oid_array },
 	{ "oidmap", cmd__oidmap },
+	{ "oidtree", cmd__oidtree },
 	{ "online-cpus", cmd__online_cpus },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e8069a3b22..f683a2f59c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -32,6 +32,7 @@ int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
+int cmd__oidtree(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
new file mode 100755
index 0000000000..bb4229210c
--- /dev/null
+++ b/t/t0069-oidtree.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='basic tests for the oidtree implementation'
+. ./test-lib.sh
+
+echoid () {
+	prefix="${1:+$1 }"
+	shift
+	while test $# -gt 0
+	do
+		echo "$1"
+		shift
+	done | awk -v prefix="$prefix" '{
+		printf("%s%s", prefix, $0);
+		need = 40 - length($0);
+		for (i = 0; i < need; i++)
+			printf("0");
+		printf "\n";
+	}'
+}
+
+test_expect_success 'oidtree insert and contains' '
+	cat >expect <<EOF &&
+0
+0
+0
+1
+1
+0
+EOF
+	{
+		echoid insert 444 1 2 3 4 5 a b c d e &&
+		echoid contains 44 441 440 444 4440 4444
+		echo destroy
+	} | test-tool oidtree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'oidtree each' '
+	echoid "" 123 321 321 >expect &&
+	{
+		echoid insert f 9 8 123 321 a b c d e
+		echo each 12300
+		echo each 3211
+		echo each 3210
+		echo each 32100
+		echo destroy
+	} | test-tool oidtree >actual &&
+	test_cmp expect actual
+'
+
+test_done
