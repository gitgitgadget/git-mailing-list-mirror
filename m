Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A791F463
	for <e@80x24.org>; Tue, 24 Sep 2019 01:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503781AbfIXBEQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:04:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59554 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503775AbfIXBEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:04:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B08631FAD6;
        Tue, 24 Sep 2019 01:03:28 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 18/19] OFFSETOF_VAR macro to simplify hashmap iterators
Date:   Tue, 24 Sep 2019 01:03:23 +0000
Message-Id: <20190924010324.22619-19-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While we cannot rely on a `__typeof__' operator being portable
to use with `offsetof'; we can calculate the pointer offset
using an existing pointer and the address of a member using
pointer arithmetic.

This allows us to simplify usage of hashmap iterator macros
by not having to specify a type when a pointer of that type
is already given.

In the future, list iterator macros (e.g. list_for_each_entry)
may also be implemented using OFFSETOF_VAR to save hackers the
trouble of using container_of/list_entry macros and without
relying on non-portable `__typeof__'.

Signed-off-by: Eric Wong <e@80x24.org>
---
 attr.c                              |  1 -
 blame.c                             |  2 --
 builtin/describe.c                  |  2 +-
 builtin/difftool.c                  |  4 +--
 config.c                            |  1 -
 diff.c                              |  5 ++--
 diffcore-rename.c                   |  2 +-
 git-compat-util.h                   |  7 +++++
 hashmap.h                           | 44 ++++++++++++++++++++---------
 merge-recursive.c                   |  5 ----
 name-hash.c                         |  3 +-
 revision.c                          |  8 ++----
 submodule-config.c                  |  2 +-
 t/helper/test-hashmap.c             |  5 +---
 t/helper/test-lazy-init-name-hash.c |  4 +--
 15 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/attr.c b/attr.c
index ca8be46e8e..9849106627 100644
--- a/attr.c
+++ b/attr.c
@@ -168,7 +168,6 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 		check->all_attrs_nr = size;
 
 		hashmap_for_each_entry(&map->map, &iter, e,
-					struct attr_hash_entry,
 					ent /* member name */) {
 			const struct git_attr *a = e->value;
 			check->all_attrs[a->attr_nr].attr = a;
diff --git a/blame.c b/blame.c
index f33af0da9f..90b247abf9 100644
--- a/blame.c
+++ b/blame.c
@@ -451,7 +451,6 @@ static int fingerprint_similarity(struct fingerprint *a, struct fingerprint *b)
 	const struct fingerprint_entry *entry_a, *entry_b;
 
 	hashmap_for_each_entry(&b->map, &iter, entry_b,
-				const struct fingerprint_entry,
 				entry /* member name */) {
 		entry_a = hashmap_get_entry(&a->map, entry_b, NULL,
 					struct fingerprint_entry, entry);
@@ -474,7 +473,6 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 	hashmap_iter_init(&b->map, &iter);
 
 	hashmap_for_each_entry(&b->map, &iter, entry_b,
-				const struct fingerprint_entry,
 				entry /* member name */) {
 		entry_a = hashmap_get_entry(&a->map, entry_b, NULL,
 					struct fingerprint_entry, entry);
diff --git a/builtin/describe.c b/builtin/describe.c
index 8cf2cd992d..1caf98f716 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -333,7 +333,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		struct commit_name *n;
 
 		init_commit_names(&commit_names);
-		hashmap_for_each_entry(&names, &iter, n, struct commit_name,
+		hashmap_for_each_entry(&names, &iter, n,
 					entry /* member name */) {
 			c = lookup_commit_reference_gently(the_repository,
 							   &n->peeled, 1);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index dd94179b68..f2d4d1e0f8 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -539,7 +539,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * change in the recorded SHA1 for the submodule.
 	 */
 	hashmap_for_each_entry(&submodules, &iter, entry,
-				struct pair_entry, entry /* member name */) {
+				entry /* member name */) {
 		if (*entry->left) {
 			add_path(&ldir, ldir_len, entry->path);
 			ensure_leading_directories(ldir.buf);
@@ -558,7 +558,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * This loop replicates that behavior.
 	 */
 	hashmap_for_each_entry(&symlinks2, &iter, entry,
-				struct pair_entry, entry /* member name */) {
+				entry /* member name */) {
 		if (*entry->left) {
 			add_path(&ldir, ldir_len, entry->path);
 			ensure_leading_directories(ldir.buf);
diff --git a/config.c b/config.c
index 4d05dbc15a..77ed00bfbf 100644
--- a/config.c
+++ b/config.c
@@ -1943,7 +1943,6 @@ void git_configset_clear(struct config_set *cs)
 		return;
 
 	hashmap_for_each_entry(&cs->config_hash, &iter, entry,
-				struct config_set_element,
 				ent /* member name */) {
 		free(entry->key);
 		string_list_clear(&entry->value_list, 1);
diff --git a/diff.c b/diff.c
index f94d9f96af..051de9832d 100644
--- a/diff.c
+++ b/diff.c
@@ -1038,7 +1038,7 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 	int i;
 	char *got_match = xcalloc(1, pmb_nr);
 
-	hashmap_for_each_entry_from(hm, match, struct moved_entry, ent) {
+	hashmap_for_each_entry_from(hm, match, ent) {
 		for (i = 0; i < pmb_nr; i++) {
 			struct moved_entry *prev = pmb[i].match;
 			struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1193,8 +1193,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			 * The current line is the start of a new block.
 			 * Setup the set of potential blocks.
 			 */
-			hashmap_for_each_entry_from(hm, match,
-						struct moved_entry, ent) {
+			hashmap_for_each_entry_from(hm, match, ent) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 994609ed58..9ad4dc395a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -284,7 +284,7 @@ static int find_identical_files(struct hashmap *srcs,
 	 */
 	p = hashmap_get_entry_from_hash(srcs, hash, NULL,
 					struct file_similarity, entry);
-	hashmap_for_each_entry_from(srcs, p, struct file_similarity, entry) {
+	hashmap_for_each_entry_from(srcs, p, entry) {
 		int score;
 		struct diff_filespec *source = p->filespec;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index e24510452a..b3dbb5a3c9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1338,4 +1338,11 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 #define container_of_or_null(ptr, type, member) \
 	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
 
+/*
+ * like offsetof(), but takes a pointer to type instead of the type
+ * @ptr is subject to multiple evaluation since we can't rely on TYPEOF()
+ */
+#define OFFSETOF_VAR(ptr, member) \
+	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
+
 #endif
diff --git a/hashmap.h b/hashmap.h
index 7c7a54d15e..519213a812 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -408,16 +408,32 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }
 
-#define hashmap_iter_next_entry(iter, type, member) \
-	container_of_or_null(hashmap_iter_next(iter), type, member)
-
+/*
+ * returns the first entry in @map using @iter, where the entry is of
+ * @type (e.g. "struct foo") and @member is the name of the
+ * "struct hashmap_entry" in @type
+ */
 #define hashmap_iter_first_entry(map, iter, type, member) \
 	container_of_or_null(hashmap_iter_first(map, iter), type, member)
 
-#define hashmap_for_each_entry(map, iter, var, type, member) \
-	for (var = hashmap_iter_first_entry(map, iter, type, member); \
+/* internal macro for hashmap_for_each_entry */
+#define hashmap_iter_next_entry_offset(iter, offset) \
+	container_of_or_null_offset(hashmap_iter_next(iter), offset)
+
+/* internal macro for hashmap_for_each_entry */
+#define hashmap_iter_first_entry_offset(map, iter, offset) \
+	container_of_or_null_offset(hashmap_iter_first(map, iter), offset)
+
+/*
+ * iterate through @map using @iter, @var is a pointer to a type
+ * containing a @member which is a "struct hashmap_entry"
+ */
+#define hashmap_for_each_entry(map, iter, var, member) \
+	for (var = hashmap_iter_first_entry_offset(map, iter, \
+						OFFSETOF_VAR(var, member)); \
 		var; \
-		var = hashmap_iter_next_entry(iter, type, member))
+		var = hashmap_iter_next_entry_offset(iter, \
+						OFFSETOF_VAR(var, member)))
 
 /*
  * returns a @pointer of @type matching @keyvar, or NULL if nothing found.
@@ -432,22 +448,22 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
 	container_of_or_null(hashmap_get_from_hash(map, hash, keydata), \
 				type, member)
 /*
- * returns the next equal @type pointer to @var, or NULL if not found.
- * @var is a pointer of @type
- * @member is the name of the "struct hashmap_entry" field in @type
+ * returns the next equal pointer to @var, or NULL if not found.
+ * @var is a pointer of any type containing "struct hashmap_entry"
+ * @member is the name of the "struct hashmap_entry" field
  */
-#define hashmap_get_next_entry(map, var, type, member) \
-	container_of_or_null(hashmap_get_next(map, &(var)->member), \
-				type, member)
+#define hashmap_get_next_entry(map, var, member) \
+	container_of_or_null_offset(hashmap_get_next(map, &(var)->member), \
+				OFFSETOF_VAR(var, member))
 
 /*
  * iterate @map starting from @var, where @var is a pointer of @type
  * and @member is the name of the "struct hashmap_entry" field in @type
  */
-#define hashmap_for_each_entry_from(map, var, type, member) \
+#define hashmap_for_each_entry_from(map, var, member) \
 	for (; \
 		var; \
-		var = hashmap_get_next_entry(map, var, type, member))
+		var = hashmap_get_next_entry(map, var, member))
 
 /*
  * Disable item counting and automatic rehashing when adding/removing items.
diff --git a/merge-recursive.c b/merge-recursive.c
index 34b3d54154..3abba3a618 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2136,7 +2136,6 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 	struct string_list remove_from_merge = STRING_LIST_INIT_NODUP;
 
 	hashmap_for_each_entry(dir_re_head, &iter, head_ent,
-				struct dir_rename_entry,
 				ent /* member name */) {
 		merge_ent = dir_rename_find_entry(dir_re_merge, head_ent->dir);
 		if (merge_ent &&
@@ -2162,7 +2161,6 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
 
 	hashmap_for_each_entry(dir_re_merge, &iter, merge_ent,
-				struct dir_rename_entry,
 				ent /* member name */) {
 		head_ent = dir_rename_find_entry(dir_re_head, merge_ent->dir);
 		if (tree_has_path(opt->repo, merge, merge_ent->dir)) {
@@ -2268,7 +2266,6 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs)
 	 * that there is no winner), we no longer need possible_new_dirs.
 	 */
 	hashmap_for_each_entry(dir_renames, &iter, entry,
-				struct dir_rename_entry,
 				ent /* member name */) {
 		int max = 0;
 		int bad_max = 0;
@@ -2628,7 +2625,6 @@ static struct string_list *get_renames(struct merge_options *opt,
 	}
 
 	hashmap_for_each_entry(&collisions, &iter, e,
-				struct collision_entry,
 				ent /* member name */) {
 		free(e->target_file);
 		string_list_clear(&e->source_files, 0);
@@ -2847,7 +2843,6 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 	struct dir_rename_entry *e;
 
 	hashmap_for_each_entry(dir_renames, &iter, e,
-				struct dir_rename_entry,
 				ent /* member name */) {
 		free(e->dir);
 		strbuf_release(&e->new_dir);
diff --git a/name-hash.c b/name-hash.c
index c86fe0f1df..3cda22b657 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -714,8 +714,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 
 	ce = hashmap_get_entry_from_hash(&istate->name_hash, hash, NULL,
 					 struct cache_entry, ent);
-	hashmap_for_each_entry_from(&istate->name_hash, ce,
-					struct cache_entry, ent) {
+	hashmap_for_each_entry_from(&istate->name_hash, ce, ent) {
 		if (same_name(ce, name, namelen, icase))
 			return ce;
 	}
diff --git a/revision.c b/revision.c
index 8a5f866ae6..5abd4a1fe7 100644
--- a/revision.c
+++ b/revision.c
@@ -129,9 +129,7 @@ static void paths_and_oids_clear(struct hashmap *map)
 	struct hashmap_iter iter;
 	struct path_and_oids_entry *entry;
 
-	hashmap_for_each_entry(map, &iter, entry,
-				struct path_and_oids_entry,
-				ent /* member name */) {
+	hashmap_for_each_entry(map, &iter, entry, ent /* member name */) {
 		oidset_clear(&entry->trees);
 		free(entry->path);
 	}
@@ -243,9 +241,7 @@ void mark_trees_uninteresting_sparse(struct repository *r,
 		add_children_by_path(r, tree, &map);
 	}
 
-	hashmap_for_each_entry(&map, &map_iter, entry,
-				struct path_and_oids_entry,
-				ent /* member name */)
+	hashmap_for_each_entry(&map, &map_iter, entry, ent /* member name */)
 		mark_trees_uninteresting_sparse(r, &entry->trees);
 
 	paths_and_oids_clear(&map);
diff --git a/submodule-config.c b/submodule-config.c
index 5462acc8ec..c22855cd38 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -100,7 +100,7 @@ static void submodule_cache_clear(struct submodule_cache *cache)
 	 * their .gitmodules blob sha1 and submodule name.
 	 */
 	hashmap_for_each_entry(&cache->for_name, &iter, entry,
-				struct submodule_entry, ent /* member name */)
+				ent /* member name */)
 		free_one_config(entry);
 
 	hashmap_free_entries(&cache->for_path, struct submodule_entry, ent);
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 6f2530dcc8..f89d1194ef 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -205,10 +205,8 @@ int cmd__hashmap(int argc, const char **argv)
 			/* print result */
 			if (!entry)
 				puts("NULL");
-			hashmap_for_each_entry_from(&map, entry,
-						struct test_entry, ent) {
+			hashmap_for_each_entry_from(&map, entry, ent)
 				puts(get_value(entry));
-			}
 
 		} else if (!strcmp("remove", cmd) && p1) {
 
@@ -230,7 +228,6 @@ int cmd__hashmap(int argc, const char **argv)
 			struct hashmap_iter iter;
 
 			hashmap_for_each_entry(&map, &iter, entry,
-						struct test_entry,
 						ent /* member name */)
 				printf("%s %s\n", entry->key, get_value(entry));
 
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 9d4664d6a4..cd1b4c9736 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -42,11 +42,11 @@ static void dump_run(void)
 	}
 
 	hashmap_for_each_entry(&the_index.dir_hash, &iter_dir, dir,
-				struct dir_entry, ent /* member name */)
+				ent /* member name */)
 		printf("dir %08x %7d %s\n", dir->ent.hash, dir->nr, dir->name);
 
 	hashmap_for_each_entry(&the_index.name_hash, &iter_cache, ce,
-				struct cache_entry, ent /* member name */)
+				ent /* member name */)
 		printf("name %08x %s\n", ce->ent.hash, ce->name);
 
 	discard_cache();
