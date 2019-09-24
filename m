Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63DC41F463
	for <e@80x24.org>; Tue, 24 Sep 2019 01:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503769AbfIXBEH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:04:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59488 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391798AbfIXBEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:04:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E9E401FA01;
        Tue, 24 Sep 2019 01:03:27 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 15/19] hashmap: use *_entry APIs for iteration
Date:   Tue, 24 Sep 2019 01:03:20 +0000
Message-Id: <20190924010324.22619-16-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inspired by list_for_each_entry in the Linux kernel.
Once again, these are somewhat compromised usability-wise
by compilers lacking __typeof__ support.

Signed-off-by: Eric Wong <e@80x24.org>
---
 attr.c                              |  5 +++--
 blame.c                             | 10 ++++++----
 builtin/describe.c                  |  4 ++--
 builtin/difftool.c                  |  8 ++++----
 config.c                            |  5 +++--
 hashmap.c                           |  2 +-
 hashmap.h                           | 15 +++++++++++++--
 merge-recursive.c                   | 25 +++++++++++++++----------
 oidmap.h                            |  6 ++++--
 revision.c                          | 10 ++++++----
 submodule-config.c                  |  8 +++++---
 t/helper/test-hashmap.c             |  7 ++++---
 t/helper/test-lazy-init-name-hash.c | 12 ++++--------
 13 files changed, 70 insertions(+), 47 deletions(-)

diff --git a/attr.c b/attr.c
index 6053481610..ca8be46e8e 100644
--- a/attr.c
+++ b/attr.c
@@ -163,12 +163,13 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	if (size != check->all_attrs_nr) {
 		struct attr_hash_entry *e;
 		struct hashmap_iter iter;
-		hashmap_iter_init(&map->map, &iter);
 
 		REALLOC_ARRAY(check->all_attrs, size);
 		check->all_attrs_nr = size;
 
-		while ((e = hashmap_iter_next(&iter))) {
+		hashmap_for_each_entry(&map->map, &iter, e,
+					struct attr_hash_entry,
+					ent /* member name */) {
 			const struct git_attr *a = e->value;
 			check->all_attrs[a->attr_nr].attr = a;
 		}
diff --git a/blame.c b/blame.c
index aa46c7ec52..3d8accf902 100644
--- a/blame.c
+++ b/blame.c
@@ -450,9 +450,9 @@ static int fingerprint_similarity(struct fingerprint *a, struct fingerprint *b)
 	struct hashmap_iter iter;
 	const struct fingerprint_entry *entry_a, *entry_b;
 
-	hashmap_iter_init(&b->map, &iter);
-
-	while ((entry_b = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(&b->map, &iter, entry_b,
+				const struct fingerprint_entry,
+				entry /* member name */) {
 		entry_a = hashmap_get_entry(&a->map, entry_b, NULL,
 					struct fingerprint_entry, entry);
 		if (entry_a) {
@@ -473,7 +473,9 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 
 	hashmap_iter_init(&b->map, &iter);
 
-	while ((entry_b = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(&b->map, &iter, entry_b,
+				const struct fingerprint_entry,
+				entry /* member name */) {
 		entry_a = hashmap_get_entry(&a->map, entry_b, NULL,
 					struct fingerprint_entry, entry);
 		if (entry_a) {
diff --git a/builtin/describe.c b/builtin/describe.c
index e9267b5c9c..8cf2cd992d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -333,8 +333,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		struct commit_name *n;
 
 		init_commit_names(&commit_names);
-		n = hashmap_iter_first(&names, &iter);
-		for (; n; n = hashmap_iter_next(&iter)) {
+		hashmap_for_each_entry(&names, &iter, n, struct commit_name,
+					entry /* member name */) {
 			c = lookup_commit_reference_gently(the_repository,
 							   &n->peeled, 1);
 			if (c)
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4a37b3edee..dd94179b68 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -538,8 +538,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * temporary file to both the left and right directories to show the
 	 * change in the recorded SHA1 for the submodule.
 	 */
-	hashmap_iter_init(&submodules, &iter);
-	while ((entry = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(&submodules, &iter, entry,
+				struct pair_entry, entry /* member name */) {
 		if (*entry->left) {
 			add_path(&ldir, ldir_len, entry->path);
 			ensure_leading_directories(ldir.buf);
@@ -557,8 +557,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * shows only the link itself, not the contents of the link target.
 	 * This loop replicates that behavior.
 	 */
-	hashmap_iter_init(&symlinks2, &iter);
-	while ((entry = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(&symlinks2, &iter, entry,
+				struct pair_entry, entry /* member name */) {
 		if (*entry->left) {
 			add_path(&ldir, ldir_len, entry->path);
 			ensure_leading_directories(ldir.buf);
diff --git a/config.c b/config.c
index 33043ee73c..8433f74371 100644
--- a/config.c
+++ b/config.c
@@ -1942,8 +1942,9 @@ void git_configset_clear(struct config_set *cs)
 	if (!cs->hash_initialized)
 		return;
 
-	hashmap_iter_init(&cs->config_hash, &iter);
-	while ((entry = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(&cs->config_hash, &iter, entry,
+				struct config_set_element,
+				ent /* member name */) {
 		free(entry->key);
 		string_list_clear(&entry->value_list, 1);
 	}
diff --git a/hashmap.c b/hashmap.c
index 47934161aa..fd81a389dd 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -256,7 +256,7 @@ void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter)
 	iter->next = NULL;
 }
 
-void *hashmap_iter_next(struct hashmap_iter *iter)
+struct hashmap_entry *hashmap_iter_next(struct hashmap_iter *iter)
 {
 	struct hashmap_entry *current = iter->next;
 	for (;;) {
diff --git a/hashmap.h b/hashmap.h
index a657ab0050..46837ba436 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -382,16 +382,27 @@ struct hashmap_iter {
 void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
 
 /* Returns the next hashmap_entry, or NULL if there are no more entries. */
-void *hashmap_iter_next(struct hashmap_iter *iter);
+struct hashmap_entry *hashmap_iter_next(struct hashmap_iter *iter);
 
 /* Initializes the iterator and returns the first entry, if any. */
-static inline void *hashmap_iter_first(struct hashmap *map,
+static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
 		struct hashmap_iter *iter)
 {
 	hashmap_iter_init(map, iter);
 	return hashmap_iter_next(iter);
 }
 
+#define hashmap_iter_next_entry(iter, type, member) \
+	container_of_or_null(hashmap_iter_next(iter), type, member)
+
+#define hashmap_iter_first_entry(map, iter, type, member) \
+	container_of_or_null(hashmap_iter_first(map, iter), type, member)
+
+#define hashmap_for_each_entry(map, iter, var, type, member) \
+	for (var = hashmap_iter_first_entry(map, iter, type, member); \
+		var; \
+		var = hashmap_iter_next_entry(iter, type, member))
+
 /*
  * returns a @pointer of @type matching @keyvar, or NULL if nothing found.
  * @keyvar is a pointer of @type
diff --git a/merge-recursive.c b/merge-recursive.c
index b06e9f7f0b..73c7750448 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2135,8 +2135,9 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 	struct string_list remove_from_head = STRING_LIST_INIT_NODUP;
 	struct string_list remove_from_merge = STRING_LIST_INIT_NODUP;
 
-	hashmap_iter_init(dir_re_head, &iter);
-	while ((head_ent = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(dir_re_head, &iter, head_ent,
+				struct dir_rename_entry,
+				ent /* member name */) {
 		merge_ent = dir_rename_find_entry(dir_re_merge, head_ent->dir);
 		if (merge_ent &&
 		    !head_ent->non_unique_new_dir &&
@@ -2160,8 +2161,9 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 	remove_hashmap_entries(dir_re_head, &remove_from_head);
 	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
 
-	hashmap_iter_init(dir_re_merge, &iter);
-	while ((merge_ent = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(dir_re_merge, &iter, merge_ent,
+				struct dir_rename_entry,
+				ent /* member name */) {
 		head_ent = dir_rename_find_entry(dir_re_head, merge_ent->dir);
 		if (tree_has_path(opt->repo, merge, merge_ent->dir)) {
 			/* 2. This wasn't a directory rename after all */
@@ -2265,8 +2267,9 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs)
 	 * we set non_unique_new_dir.  Once we've determined the winner (or
 	 * that there is no winner), we no longer need possible_new_dirs.
 	 */
-	hashmap_iter_init(dir_renames, &iter);
-	while ((entry = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(dir_renames, &iter, entry,
+				struct dir_rename_entry,
+				ent /* member name */) {
 		int max = 0;
 		int bad_max = 0;
 		char *best = NULL;
@@ -2624,8 +2627,9 @@ static struct string_list *get_renames(struct merge_options *opt,
 							     entries);
 	}
 
-	hashmap_iter_init(&collisions, &iter);
-	while ((e = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(&collisions, &iter, e,
+				struct collision_entry,
+				ent /* member name */) {
 		free(e->target_file);
 		string_list_clear(&e->source_files, 0);
 	}
@@ -2842,8 +2846,9 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 	struct hashmap_iter iter;
 	struct dir_rename_entry *e;
 
-	hashmap_iter_init(dir_renames, &iter);
-	while ((e = hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(dir_renames, &iter, e,
+				struct dir_rename_entry,
+				ent /* member name */) {
 		free(e->dir);
 		strbuf_release(&e->new_dir);
 		/* possible_new_dirs already cleared in get_directory_renames */
diff --git a/oidmap.h b/oidmap.h
index 7a939461ff..c66a83ab1d 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -78,14 +78,16 @@ static inline void oidmap_iter_init(struct oidmap *map, struct oidmap_iter *iter
 
 static inline void *oidmap_iter_next(struct oidmap_iter *iter)
 {
-	return hashmap_iter_next(&iter->h_iter);
+	/* TODO: this API could be reworked to do compile-time type checks */
+	return (void *)hashmap_iter_next(&iter->h_iter);
 }
 
 static inline void *oidmap_iter_first(struct oidmap *map,
 				      struct oidmap_iter *iter)
 {
 	oidmap_iter_init(map, iter);
-	return oidmap_iter_next(iter);
+	/* TODO: this API could be reworked to do compile-time type checks */
+	return (void *)oidmap_iter_next(iter);
 }
 
 #endif
diff --git a/revision.c b/revision.c
index f32fbc5e2e..f28cbe5de8 100644
--- a/revision.c
+++ b/revision.c
@@ -128,9 +128,10 @@ static void paths_and_oids_clear(struct hashmap *map)
 {
 	struct hashmap_iter iter;
 	struct path_and_oids_entry *entry;
-	hashmap_iter_init(map, &iter);
 
-	while ((entry = (struct path_and_oids_entry *)hashmap_iter_next(&iter))) {
+	hashmap_for_each_entry(map, &iter, entry,
+				struct path_and_oids_entry,
+				ent /* member name */) {
 		oidset_clear(&entry->trees);
 		free(entry->path);
 	}
@@ -242,8 +243,9 @@ void mark_trees_uninteresting_sparse(struct repository *r,
 		add_children_by_path(r, tree, &map);
 	}
 
-	hashmap_iter_init(&map, &map_iter);
-	while ((entry = hashmap_iter_next(&map_iter)))
+	hashmap_for_each_entry(&map, &map_iter, entry,
+				struct path_and_oids_entry,
+				ent /* member name */)
 		mark_trees_uninteresting_sparse(r, &entry->trees);
 
 	paths_and_oids_clear(&map);
diff --git a/submodule-config.c b/submodule-config.c
index 5463729ab8..5319933e1d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -99,8 +99,8 @@ static void submodule_cache_clear(struct submodule_cache *cache)
 	 * allocation of struct submodule entries. Each is allocated by
 	 * their .gitmodules blob sha1 and submodule name.
 	 */
-	hashmap_iter_init(&cache->for_name, &iter);
-	while ((entry = hashmap_iter_next(&iter)))
+	hashmap_for_each_entry(&cache->for_name, &iter, entry,
+				struct submodule_entry, ent /* member name */)
 		free_one_config(entry);
 
 	hashmap_free(&cache->for_path, 1);
@@ -556,7 +556,9 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		struct hashmap_iter iter;
 		struct submodule_entry *entry;
 
-		entry = hashmap_iter_first(&cache->for_name, &iter);
+		entry = hashmap_iter_first_entry(&cache->for_name, &iter,
+						struct submodule_entry,
+						ent /* member name */);
 		if (!entry)
 			return NULL;
 		return entry->config;
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 56846da64c..4ec5e11556 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -222,10 +222,11 @@ int cmd__hashmap(int argc, const char **argv)
 			free(entry);
 
 		} else if (!strcmp("iterate", cmd)) {
-
 			struct hashmap_iter iter;
-			hashmap_iter_init(&map, &iter);
-			while ((entry = hashmap_iter_next(&iter)))
+
+			hashmap_for_each_entry(&map, &iter, entry,
+						struct test_entry,
+						ent /* member name */)
 				printf("%s %s\n", entry->key, get_value(entry));
 
 		} else if (!strcmp("size", cmd)) {
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index b99a37080d..9d4664d6a4 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -41,17 +41,13 @@ static void dump_run(void)
 			die("non-threaded code path used");
 	}
 
-	dir = hashmap_iter_first(&the_index.dir_hash, &iter_dir);
-	while (dir) {
+	hashmap_for_each_entry(&the_index.dir_hash, &iter_dir, dir,
+				struct dir_entry, ent /* member name */)
 		printf("dir %08x %7d %s\n", dir->ent.hash, dir->nr, dir->name);
-		dir = hashmap_iter_next(&iter_dir);
-	}
 
-	ce = hashmap_iter_first(&the_index.name_hash, &iter_cache);
-	while (ce) {
+	hashmap_for_each_entry(&the_index.name_hash, &iter_cache, ce,
+				struct cache_entry, ent /* member name */)
 		printf("name %08x %s\n", ce->ent.hash, ce->name);
-		ce = hashmap_iter_next(&iter_cache);
-	}
 
 	discard_cache();
 }
