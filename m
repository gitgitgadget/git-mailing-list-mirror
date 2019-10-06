Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC301F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 23:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfJFXbT (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:31:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39414 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfJFXbT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:31:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 44EE11F4CB;
        Sun,  6 Oct 2019 23:30:46 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 12/20] hashmap: use *_entry APIs to wrap container_of
Date:   Sun,  6 Oct 2019 23:30:35 +0000
Message-Id: <20191006233043.3516-13-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using `container_of' can be verbose and choosing names for
intermediate "struct hashmap_entry" pointers is a hard problem.
So introduce "*_entry" APIs inspired by similar linked-list
APIs in the Linux kernel.

Unfortunately, `__typeof__' is not portable C, so we need an
extra parameter to specify the type.

Signed-off-by: Eric Wong <e@80x24.org>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
---
 diff.c                  | 21 +++++++++------------
 diffcore-rename.c       | 14 +++++---------
 git-compat-util.h       | 15 +++++++++++++++
 hashmap.h               | 40 ++++++++++++++++++++++++++++++++++------
 name-hash.c             | 11 +++++------
 t/helper/test-hashmap.c | 12 +++++-------
 6 files changed, 73 insertions(+), 40 deletions(-)

diff --git a/diff.c b/diff.c
index 0978814086..66cdf4e9ca 100644
--- a/diff.c
+++ b/diff.c
@@ -1035,10 +1035,8 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 {
 	int i;
 	char *got_match = xcalloc(1, pmb_nr);
-	struct hashmap_entry *ent;
 
-	for (ent = &match->ent; ent; ent = hashmap_get_next(hm, ent)) {
-		match = container_of(ent, struct moved_entry, ent);
+	hashmap_for_each_entry_from(hm, match, struct moved_entry, ent) {
 		for (i = 0; i < pmb_nr; i++) {
 			struct moved_entry *prev = pmb[i].match;
 			struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1137,9 +1135,8 @@ static void mark_color_as_moved(struct diff_options *o,
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
 		struct hashmap *hm = NULL;
-		struct hashmap_entry *ent = NULL;
 		struct moved_entry *key;
-		struct moved_entry *match;
+		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
 		enum diff_symbol last_symbol = 0;
 
@@ -1147,20 +1144,22 @@ static void mark_color_as_moved(struct diff_options *o,
 		case DIFF_SYMBOL_PLUS:
 			hm = del_lines;
 			key = prepare_entry(o, n);
-			ent = hashmap_get(hm, &key->ent, NULL);
+			match = hashmap_get_entry(hm, key, NULL,
+						struct moved_entry, ent);
 			free(key);
 			break;
 		case DIFF_SYMBOL_MINUS:
 			hm = add_lines;
 			key = prepare_entry(o, n);
-			ent = hashmap_get(hm, &key->ent, NULL);
+			match = hashmap_get_entry(hm, key, NULL,
+						struct moved_entry, ent);
 			free(key);
 			break;
 		default:
 			flipped_block = 0;
 		}
 
-		if (!ent) {
+		if (!match) {
 			int i;
 
 			adjust_last_block(o, n, block_length);
@@ -1172,7 +1171,6 @@ static void mark_color_as_moved(struct diff_options *o,
 			last_symbol = l->s;
 			continue;
 		}
-		match = container_of(ent, struct moved_entry, ent);
 
 		if (o->color_moved == COLOR_MOVED_PLAIN) {
 			last_symbol = l->s;
@@ -1193,9 +1191,8 @@ static void mark_color_as_moved(struct diff_options *o,
 			 * The current line is the start of a new block.
 			 * Setup the set of potential blocks.
 			 */
-			for (; ent; ent = hashmap_get_next(hm, ent)) {
-				match = container_of(ent, struct moved_entry,
-							ent);
+			hashmap_for_each_entry_from(hm, match,
+						struct moved_entry, ent) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 71aa240a68..611b08f463 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -274,23 +274,19 @@ static int find_identical_files(struct hashmap *srcs,
 				struct diff_options *options)
 {
 	int renames = 0;
-	struct hashmap_entry *ent;
 	struct diff_filespec *target = rename_dst[dst_index].two;
 	struct file_similarity *p, *best = NULL;
 	int i = 100, best_score = -1;
+	unsigned int hash = hash_filespec(options->repo, target);
 
 	/*
 	 * Find the best source match for specified destination.
 	 */
-	ent = hashmap_get_from_hash(srcs,
-				  hash_filespec(options->repo, target),
-				  NULL);
-	for (; ent; ent = hashmap_get_next(srcs, ent)) {
+	p = hashmap_get_entry_from_hash(srcs, hash, NULL,
+					struct file_similarity, entry);
+	hashmap_for_each_entry_from(srcs, p, struct file_similarity, entry) {
 		int score;
-		struct diff_filespec *source;
-
-		p = container_of(ent, struct file_similarity, entry);
-		source = p->filespec;
+		struct diff_filespec *source = p->filespec;
 
 		/* False hash collision? */
 		if (!oideq(&source->oid, &target->oid))
diff --git a/git-compat-util.h b/git-compat-util.h
index 4cc2c8283a..4a23b9090b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1322,4 +1322,19 @@ void unleak_memory(const void *ptr, size_t len);
 #define container_of(ptr, type, member) \
 	((type *) ((char *)(ptr) - offsetof(type, member)))
 
+/*
+ * helper function for `container_of_or_null' to avoid multiple
+ * evaluation of @ptr
+ */
+static inline void *container_of_or_null_offset(void *ptr, size_t offset)
+{
+	return ptr ? (char *)ptr - offset : NULL;
+}
+
+/*
+ * like `container_of', but allows returned value to be NULL
+ */
+#define container_of_or_null(ptr, type, member) \
+	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
+
 #endif
diff --git a/hashmap.h b/hashmap.h
index 21bc8aff2b..cd42dcc15c 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -55,17 +55,15 @@
  *
  *         if (!strcmp("print_all_by_key", action)) {
  *             struct long2string k, *e;
- *             struct hashmap_entry *ent;
  *             hashmap_entry_init(&k->ent, memhash(&key, sizeof(long)));
  *             k.key = key;
  *
  *             flags &= ~COMPARE_VALUE;
- *             ent = hashmap_get(&map, &k, NULL);
- *             if (ent) {
- *                 e = container_of(ent, struct long2string, ent);
+ *             e = hashmap_get_entry(&map, &k, NULL, struct long2string, ent);
+ *             if (e) {
  *                 printf("first: %ld %s\n", e->key, e->value);
- *                 while ((ent = hashmap_get_next(&map, ent))) {
- *                     e = container_of(ent, struct long2string, ent);
+ *                 while ((e = hashmap_get_next_entry(&map, e,
+ *                                              struct long2string, ent))) {
  *                     printf("found more: %ld %s\n", e->key, e->value);
  *                 }
  *             }
@@ -387,6 +385,36 @@ static inline void *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }
 
+/*
+ * returns a @pointer of @type matching @keyvar, or NULL if nothing found.
+ * @keyvar is a pointer of @type
+ * @member is the name of the "struct hashmap_entry" field in @type
+ */
+#define hashmap_get_entry(map, keyvar, keydata, type, member) \
+	container_of_or_null(hashmap_get(map, &(keyvar)->member, keydata), \
+				type, member)
+
+#define hashmap_get_entry_from_hash(map, hash, keydata, type, member) \
+	container_of_or_null(hashmap_get_from_hash(map, hash, keydata), \
+				type, member)
+/*
+ * returns the next equal @type pointer to @var, or NULL if not found.
+ * @var is a pointer of @type
+ * @member is the name of the "struct hashmap_entry" field in @type
+ */
+#define hashmap_get_next_entry(map, var, type, member) \
+	container_of_or_null(hashmap_get_next(map, &(var)->member), \
+				type, member)
+
+/*
+ * iterate @map starting from @var, where @var is a pointer of @type
+ * and @member is the name of the "struct hashmap_entry" field in @type
+ */
+#define hashmap_for_each_entry_from(map, var, type, member) \
+	for (; \
+		var; \
+		var = hashmap_get_next_entry(map, var, type, member))
+
 /*
  * Disable item counting and automatic rehashing when adding/removing items.
  *
diff --git a/name-hash.c b/name-hash.c
index dbacb34f50..73b83adf3d 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -702,17 +702,16 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	struct cache_entry *ce;
-	struct hashmap_entry *ent;
+	unsigned int hash = memihash(name, namelen);
 
 	lazy_init_name_hash(istate);
 
-	ent = hashmap_get_from_hash(&istate->name_hash,
-				   memihash(name, namelen), NULL);
-	while (ent) {
-		ce = container_of(ent, struct cache_entry, ent);
+	ce = hashmap_get_entry_from_hash(&istate->name_hash, hash, NULL,
+					 struct cache_entry, ent);
+	hashmap_for_each_entry_from(&istate->name_hash, ce,
+					struct cache_entry, ent) {
 		if (same_name(ce, name, namelen, icase))
 			return ce;
-		ent = hashmap_get_next(&istate->name_hash, ent);
 	}
 	return NULL;
 }
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index d85b8dc58e..e82cbfdee2 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -194,18 +194,16 @@ int cmd__hashmap(int argc, const char **argv)
 			free(entry);
 
 		} else if (!strcmp("get", cmd) && p1) {
-			struct hashmap_entry *e;
-
 			/* lookup entry in hashmap */
-			e = hashmap_get_from_hash(&map, hash, p1);
+			entry = hashmap_get_entry_from_hash(&map, hash, p1,
+							struct test_entry, ent);
 
 			/* print result */
-			if (!e)
+			if (!entry)
 				puts("NULL");
-			while (e) {
-				entry = container_of(e, struct test_entry, ent);
+			hashmap_for_each_entry_from(&map, entry,
+						struct test_entry, ent) {
 				puts(get_value(entry));
-				e = hashmap_get_next(&map, e);
 			}
 
 		} else if (!strcmp("remove", cmd) && p1) {
