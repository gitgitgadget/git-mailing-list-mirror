Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554141F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 23:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfJFXaz (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:30:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39124 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfJFXay (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:30:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6F31D1F4C1;
        Sun,  6 Oct 2019 23:30:44 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 04/20] hashmap_entry_init takes "struct hashmap_entry *"
Date:   Sun,  6 Oct 2019 23:30:27 +0000
Message-Id: <20191006233043.3516-5-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

C compilers do type checking to make life easier for us.  So
rely on that and update all hashmap_entry_init callers to take
"struct hashmap_entry *" to avoid future bugs while improving
safety and readability.

Signed-off-by: Eric Wong <e@80x24.org>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
---
 attr.c                  |  4 ++--
 blame.c                 |  2 +-
 builtin/describe.c      |  2 +-
 builtin/difftool.c      |  6 +++---
 builtin/fast-export.c   |  2 +-
 builtin/fetch.c         |  2 +-
 config.c                |  4 ++--
 diffcore-rename.c       |  2 +-
 hashmap.c               |  4 ++--
 hashmap.h               | 12 ++++++------
 merge-recursive.c       | 13 +++++++------
 name-hash.c             | 10 +++++-----
 packfile.c              |  2 +-
 patch-ids.c             |  2 +-
 range-diff.c            |  4 ++--
 ref-filter.c            |  3 ++-
 refs.c                  |  2 +-
 remote.c                |  2 +-
 revision.c              |  4 ++--
 sequencer.c             |  5 +++--
 sub-process.c           |  4 ++--
 submodule-config.c      | 10 +++++-----
 t/helper/test-hashmap.c |  6 +++---
 23 files changed, 55 insertions(+), 52 deletions(-)

diff --git a/attr.c b/attr.c
index 93dc16b59c..a8be7a7b4f 100644
--- a/attr.c
+++ b/attr.c
@@ -98,7 +98,7 @@ static void *attr_hashmap_get(struct attr_hashmap *map,
 	if (!map->map.tablesize)
 		attr_hashmap_init(map);
 
-	hashmap_entry_init(&k, memhash(key, keylen));
+	hashmap_entry_init(&k.ent, memhash(key, keylen));
 	k.key = key;
 	k.keylen = keylen;
 	e = hashmap_get(&map->map, &k, NULL);
@@ -117,7 +117,7 @@ static void attr_hashmap_add(struct attr_hashmap *map,
 		attr_hashmap_init(map);
 
 	e = xmalloc(sizeof(struct attr_hash_entry));
-	hashmap_entry_init(e, memhash(key, keylen));
+	hashmap_entry_init(&e->ent, memhash(key, keylen));
 	e->key = key;
 	e->keylen = keylen;
 	e->value = value;
diff --git a/blame.c b/blame.c
index 36a2e7ef11..46059410cd 100644
--- a/blame.c
+++ b/blame.c
@@ -417,7 +417,7 @@ static void get_fingerprint(struct fingerprint *result,
 		/* Ignore whitespace pairs */
 		if (hash == 0)
 			continue;
-		hashmap_entry_init(entry, hash);
+		hashmap_entry_init(&entry->entry, hash);
 
 		found_entry = hashmap_get(&result->map, entry, NULL);
 		if (found_entry) {
diff --git a/builtin/describe.c b/builtin/describe.c
index 200154297d..596ddf89a5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -123,7 +123,7 @@ static void add_to_known_names(const char *path,
 		if (!e) {
 			e = xmalloc(sizeof(struct commit_name));
 			oidcpy(&e->peeled, peeled);
-			hashmap_entry_init(e, oidhash(peeled));
+			hashmap_entry_init(&e->entry, oidhash(peeled));
 			hashmap_add(&names, e);
 			e->path = NULL;
 		}
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 16eb8b70ea..98ffc04c61 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -161,7 +161,7 @@ static void add_left_or_right(struct hashmap *map, const char *path,
 	struct pair_entry *e, *existing;
 
 	FLEX_ALLOC_STR(e, path, path);
-	hashmap_entry_init(e, strhash(path));
+	hashmap_entry_init(&e->entry, strhash(path));
 	existing = hashmap_get(map, e, NULL);
 	if (existing) {
 		free(e);
@@ -234,7 +234,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	while (!strbuf_getline_nul(&buf, fp)) {
 		struct path_entry *entry;
 		FLEX_ALLOC_STR(entry, path, buf.buf);
-		hashmap_entry_init(entry, strhash(buf.buf));
+		hashmap_entry_init(&entry->entry, strhash(buf.buf));
 		hashmap_add(result, entry);
 	}
 	fclose(fp);
@@ -461,7 +461,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 
 			/* Avoid duplicate working_tree entries */
 			FLEX_ALLOC_STR(entry, path, dst_path);
-			hashmap_entry_init(entry, strhash(dst_path));
+			hashmap_entry_init(&entry->entry, strhash(dst_path));
 			if (hashmap_get(&working_tree_dups, entry, NULL)) {
 				free(entry);
 				continue;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f541f55d33..287dbd24a3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -148,7 +148,7 @@ static const void *anonymize_mem(struct hashmap *map,
 	if (!map->cmpfn)
 		hashmap_init(map, anonymized_entry_cmp, NULL, 0);
 
-	hashmap_entry_init(&key, memhash(orig, *len));
+	hashmap_entry_init(&key.hash, memhash(orig, *len));
 	key.orig = orig;
 	key.orig_len = *len;
 	ret = hashmap_get(map, &key, NULL);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 717dd14e89..b7d70eee70 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -276,7 +276,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 	size_t len = strlen(refname);
 
 	FLEX_ALLOC_MEM(ent, refname, refname, len);
-	hashmap_entry_init(ent, strhash(refname));
+	hashmap_entry_init(&ent->ent, strhash(refname));
 	oidcpy(&ent->oid, oid);
 	hashmap_add(map, ent);
 	return ent;
diff --git a/config.c b/config.c
index 3900e4947b..08d866e7de 100644
--- a/config.c
+++ b/config.c
@@ -1861,7 +1861,7 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	if (git_config_parse_key(key, &normalized_key, NULL))
 		return NULL;
 
-	hashmap_entry_init(&k, strhash(normalized_key));
+	hashmap_entry_init(&k.ent, strhash(normalized_key));
 	k.key = normalized_key;
 	found_entry = hashmap_get(&cs->config_hash, &k, NULL);
 	free(normalized_key);
@@ -1882,7 +1882,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	 */
 	if (!e) {
 		e = xmalloc(sizeof(*e));
-		hashmap_entry_init(e, strhash(key));
+		hashmap_entry_init(&e->ent, strhash(key));
 		e->key = xstrdup(key);
 		string_list_init(&e->value_list, 1);
 		hashmap_add(&cs->config_hash, e);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9624864858..44a3ab1e31 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -329,7 +329,7 @@ static void insert_file_table(struct repository *r,
 	entry->index = index;
 	entry->filespec = filespec;
 
-	hashmap_entry_init(entry, hash_filespec(r, filespec));
+	hashmap_entry_init(&entry->entry, hash_filespec(r, filespec));
 	hashmap_add(table, entry);
 }
 
diff --git a/hashmap.c b/hashmap.c
index d42f01ff5a..6818c65174 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -293,13 +293,13 @@ const void *memintern(const void *data, size_t len)
 		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, NULL, 0);
 
 	/* lookup interned string in pool */
-	hashmap_entry_init(&key, memhash(data, len));
+	hashmap_entry_init(&key.ent, memhash(data, len));
 	key.len = len;
 	e = hashmap_get(&map, &key, data);
 	if (!e) {
 		/* not found: create it */
 		FLEX_ALLOC_MEM(e, data, data, len);
-		hashmap_entry_init(e, key.ent.hash);
+		hashmap_entry_init(&e->ent, key.ent.hash);
 		e->len = len;
 		hashmap_add(&map, e);
 	}
diff --git a/hashmap.h b/hashmap.h
index 8424911566..54b0b8c698 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -48,14 +48,14 @@
  *         if (!strcmp("add", action)) {
  *             struct long2string *e;
  *             FLEX_ALLOC_STR(e, value, value);
- *             hashmap_entry_init(e, memhash(&key, sizeof(long)));
+ *             hashmap_entry_init(&e->ent, memhash(&key, sizeof(long)));
  *             e->key = key;
  *             hashmap_add(&map, e);
  *         }
  *
  *         if (!strcmp("print_all_by_key", action)) {
  *             struct long2string k, *e;
- *             hashmap_entry_init(&k, memhash(&key, sizeof(long)));
+ *             hashmap_entry_init(&k->ent, memhash(&key, sizeof(long)));
  *             k.key = key;
  *
  *             flags &= ~COMPARE_VALUE;
@@ -70,7 +70,7 @@
  *         if (!strcmp("has_exact_match", action)) {
  *             struct long2string *e;
  *             FLEX_ALLOC_STR(e, value, value);
- *             hashmap_entry_init(e, memhash(&key, sizeof(long)));
+ *             hashmap_entry_init(&e->ent, memhash(&key, sizeof(long)));
  *             e->key = key;
  *
  *             flags |= COMPARE_VALUE;
@@ -80,7 +80,7 @@
  *
  *         if (!strcmp("has_exact_match_no_heap_alloc", action)) {
  *             struct long2string k;
- *             hashmap_entry_init(&k, memhash(&key, sizeof(long)));
+ *             hashmap_entry_init(&k->ent, memhash(&key, sizeof(long)));
  *             k.key = key;
  *
  *             flags |= COMPARE_VALUE;
@@ -244,9 +244,9 @@ void hashmap_free(struct hashmap *map, int free_entries);
  * your structure was allocated with xmalloc(), you can just free(3) it,
  * and if it is on stack, you can just let it go out of scope).
  */
-static inline void hashmap_entry_init(void *entry, unsigned int hash)
+static inline void hashmap_entry_init(struct hashmap_entry *e,
+					unsigned int hash)
 {
-	struct hashmap_entry *e = entry;
 	e->hash = hash;
 	e->next = NULL;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 6b812d67e3..6bc4f14ff4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -61,7 +61,7 @@ static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
 
 	if (dir == NULL)
 		return NULL;
-	hashmap_entry_init(&key, strhash(dir));
+	hashmap_entry_init(&key.ent, strhash(dir));
 	key.dir = dir;
 	return hashmap_get(hashmap, &key, NULL);
 }
@@ -85,7 +85,7 @@ static void dir_rename_init(struct hashmap *map)
 static void dir_rename_entry_init(struct dir_rename_entry *entry,
 				  char *directory)
 {
-	hashmap_entry_init(entry, strhash(directory));
+	hashmap_entry_init(&entry->ent, strhash(directory));
 	entry->dir = directory;
 	entry->non_unique_new_dir = 0;
 	strbuf_init(&entry->new_dir, 0);
@@ -97,7 +97,7 @@ static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
 {
 	struct collision_entry key;
 
-	hashmap_entry_init(&key, strhash(target_file));
+	hashmap_entry_init(&key.ent, strhash(target_file));
 	key.target_file = target_file;
 	return hashmap_get(hashmap, &key, NULL);
 }
@@ -454,7 +454,7 @@ static int save_files_dirs(const struct object_id *oid,
 	strbuf_addstr(base, path);
 
 	FLEX_ALLOC_MEM(entry, path, base->buf, base->len);
-	hashmap_entry_init(entry, path_hash(entry->path));
+	hashmap_entry_init(&entry->e, path_hash(entry->path));
 	hashmap_add(&opt->current_file_dir_set, entry);
 
 	strbuf_setlen(base, baselen);
@@ -731,7 +731,7 @@ static char *unique_path(struct merge_options *opt, const char *path, const char
 	}
 
 	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
-	hashmap_entry_init(entry, path_hash(entry->path));
+	hashmap_entry_init(&entry->e, path_hash(entry->path));
 	hashmap_add(&opt->current_file_dir_set, entry);
 	return strbuf_detach(&newpath, NULL);
 }
@@ -2358,7 +2358,8 @@ static void compute_collisions(struct hashmap *collisions,
 		if (!collision_ent) {
 			collision_ent = xcalloc(1,
 						sizeof(struct collision_entry));
-			hashmap_entry_init(collision_ent, strhash(new_path));
+			hashmap_entry_init(&collision_ent->ent,
+						strhash(new_path));
 			hashmap_put(collisions, collision_ent);
 			collision_ent->target_file = new_path;
 		} else {
diff --git a/name-hash.c b/name-hash.c
index 695908609f..1ce1417f7e 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -33,7 +33,7 @@ static struct dir_entry *find_dir_entry__hash(struct index_state *istate,
 		const char *name, unsigned int namelen, unsigned int hash)
 {
 	struct dir_entry key;
-	hashmap_entry_init(&key, hash);
+	hashmap_entry_init(&key.ent, hash);
 	key.namelen = namelen;
 	return hashmap_get(&istate->dir_hash, &key, name);
 }
@@ -68,7 +68,7 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	if (!dir) {
 		/* not found, create it and add to hash table */
 		FLEX_ALLOC_MEM(dir, name, ce->name, namelen);
-		hashmap_entry_init(dir, memihash(ce->name, namelen));
+		hashmap_entry_init(&dir->ent, memihash(ce->name, namelen));
 		dir->namelen = namelen;
 		hashmap_add(&istate->dir_hash, dir);
 
@@ -106,7 +106,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	hashmap_entry_init(ce, memihash(ce->name, ce_namelen(ce)));
+	hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
 	hashmap_add(&istate->name_hash, ce);
 
 	if (ignore_case)
@@ -280,7 +280,7 @@ static struct dir_entry *hash_dir_entry_with_parent_and_prefix(
 	dir = find_dir_entry__hash(istate, prefix->buf, prefix->len, hash);
 	if (!dir) {
 		FLEX_ALLOC_MEM(dir, name, prefix->buf, prefix->len);
-		hashmap_entry_init(dir, hash);
+		hashmap_entry_init(&dir->ent, hash);
 		dir->namelen = prefix->len;
 		dir->parent = parent;
 		hashmap_add(&istate->dir_hash, dir);
@@ -472,7 +472,7 @@ static void *lazy_name_thread_proc(void *_data)
 	for (k = 0; k < d->istate->cache_nr; k++) {
 		struct cache_entry *ce_k = d->istate->cache[k];
 		ce_k->ce_flags |= CE_HASHED;
-		hashmap_entry_init(ce_k, d->lazy_entries[k].hash_name);
+		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
 		hashmap_add(&d->istate->name_hash, ce_k);
 	}
 
diff --git a/packfile.c b/packfile.c
index 37fe0b73a6..96535eb86b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1487,7 +1487,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 
 	if (!delta_base_cache.cmpfn)
 		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, NULL, 0);
-	hashmap_entry_init(ent, pack_entry_hash(p, base_offset));
+	hashmap_entry_init(&ent->ent, pack_entry_hash(p, base_offset));
 	hashmap_add(&delta_base_cache, ent);
 }
 
diff --git a/patch-ids.c b/patch-ids.c
index e8c150d0c9..a2da711678 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -83,7 +83,7 @@ static int init_patch_id_entry(struct patch_id *patch,
 	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1, 0))
 		return -1;
 
-	hashmap_entry_init(patch, oidhash(&header_only_patch_id));
+	hashmap_entry_init(&patch->ent, oidhash(&header_only_patch_id));
 	return 0;
 }
 
diff --git a/range-diff.c b/range-diff.c
index ba1e9a4265..32b29f9594 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -217,7 +217,7 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 		util->i = i;
 		util->patch = a->items[i].string;
 		util->diff = util->patch + util->diff_offset;
-		hashmap_entry_init(util, strhash(util->diff));
+		hashmap_entry_init(&util->e, strhash(util->diff));
 		hashmap_add(&map, util);
 	}
 
@@ -228,7 +228,7 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 		util->i = i;
 		util->patch = b->items[i].string;
 		util->diff = util->patch + util->diff_offset;
-		hashmap_entry_init(util, strhash(util->diff));
+		hashmap_entry_init(&util->e, strhash(util->diff));
 		other = hashmap_remove(&map, util, NULL);
 		if (other) {
 			if (other->matching >= 0)
diff --git a/ref-filter.c b/ref-filter.c
index f27cfc8c3e..206014c93d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1565,7 +1565,8 @@ static void populate_worktree_map(struct hashmap *map, struct worktree **worktre
 			struct ref_to_worktree_entry *entry;
 			entry = xmalloc(sizeof(*entry));
 			entry->wt = worktrees[i];
-			hashmap_entry_init(entry, strhash(worktrees[i]->head_ref));
+			hashmap_entry_init(&entry->ent,
+					strhash(worktrees[i]->head_ref));
 
 			hashmap_add(map, entry);
 		}
diff --git a/refs.c b/refs.c
index cd297ee4bd..c43ec59c6e 100644
--- a/refs.c
+++ b/refs.c
@@ -1796,7 +1796,7 @@ static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
 	struct ref_store_hash_entry *entry;
 
 	FLEX_ALLOC_STR(entry, name, name);
-	hashmap_entry_init(entry, strhash(name));
+	hashmap_entry_init(&entry->ent, strhash(name));
 	entry->refs = refs;
 	return entry;
 }
diff --git a/remote.c b/remote.c
index e50f7602ed..bd81cb71bc 100644
--- a/remote.c
+++ b/remote.c
@@ -158,7 +158,7 @@ static struct remote *make_remote(const char *name, int len)
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
 
-	hashmap_entry_init(ret, lookup_entry.hash);
+	hashmap_entry_init(&ret->ent, lookup_entry.hash);
 	replaced = hashmap_put(&remotes_hash, ret);
 	assert(replaced == NULL);  /* no previous entry overwritten */
 	return ret;
diff --git a/revision.c b/revision.c
index 07412297f0..3461c78883 100644
--- a/revision.c
+++ b/revision.c
@@ -141,7 +141,7 @@ static void paths_and_oids_insert(struct hashmap *map,
 	struct path_and_oids_entry key;
 	struct path_and_oids_entry *entry;
 
-	hashmap_entry_init(&key, hash);
+	hashmap_entry_init(&key.ent, hash);
 
 	/* use a shallow copy for the lookup */
 	key.path = (char *)path;
@@ -149,7 +149,7 @@ static void paths_and_oids_insert(struct hashmap *map,
 
 	if (!(entry = (struct path_and_oids_entry *)hashmap_get(map, &key, NULL))) {
 		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
-		hashmap_entry_init(entry, hash);
+		hashmap_entry_init(&entry->ent, hash);
 		entry->path = xstrdup(key.path);
 		oidset_init(&entry->trees, 16);
 		hashmap_put(map, entry);
diff --git a/sequencer.c b/sequencer.c
index 34ebf8ed94..1140cdf526 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4538,7 +4538,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 	}
 
 	FLEX_ALLOC_STR(labels_entry, label, label);
-	hashmap_entry_init(labels_entry, strihash(label));
+	hashmap_entry_init(&labels_entry->entry, strihash(label));
 	hashmap_add(&state->labels, labels_entry);
 
 	FLEX_ALLOC_STR(string_entry, string, label);
@@ -5252,7 +5252,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 						strhash(subject), subject)) {
 			FLEX_ALLOC_MEM(entry, subject, subject, subject_len);
 			entry->i = i;
-			hashmap_entry_init(entry, strhash(entry->subject));
+			hashmap_entry_init(&entry->entry,
+					strhash(entry->subject));
 			hashmap_put(&subject2item, entry);
 		}
 	}
diff --git a/sub-process.c b/sub-process.c
index 3f4af93555..9847dad6fc 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -20,7 +20,7 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 {
 	struct subprocess_entry key;
 
-	hashmap_entry_init(&key, strhash(cmd));
+	hashmap_entry_init(&key.ent, strhash(cmd));
 	key.cmd = cmd;
 	return hashmap_get(hashmap, &key, NULL);
 }
@@ -96,7 +96,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 		return err;
 	}
 
-	hashmap_entry_init(entry, strhash(cmd));
+	hashmap_entry_init(&entry->ent, strhash(cmd));
 
 	err = startfn(entry);
 	if (err) {
diff --git a/submodule-config.c b/submodule-config.c
index 4264ee216f..4aa02e280e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -123,7 +123,7 @@ static void cache_put_path(struct submodule_cache *cache,
 	unsigned int hash = hash_oid_string(&submodule->gitmodules_oid,
 					    submodule->path);
 	struct submodule_entry *e = xmalloc(sizeof(*e));
-	hashmap_entry_init(e, hash);
+	hashmap_entry_init(&e->ent, hash);
 	e->config = submodule;
 	hashmap_put(&cache->for_path, e);
 }
@@ -135,7 +135,7 @@ static void cache_remove_path(struct submodule_cache *cache,
 					    submodule->path);
 	struct submodule_entry e;
 	struct submodule_entry *removed;
-	hashmap_entry_init(&e, hash);
+	hashmap_entry_init(&e.ent, hash);
 	e.config = submodule;
 	removed = hashmap_remove(&cache->for_path, &e, NULL);
 	free(removed);
@@ -147,7 +147,7 @@ static void cache_add(struct submodule_cache *cache,
 	unsigned int hash = hash_oid_string(&submodule->gitmodules_oid,
 					    submodule->name);
 	struct submodule_entry *e = xmalloc(sizeof(*e));
-	hashmap_entry_init(e, hash);
+	hashmap_entry_init(&e->ent, hash);
 	e->config = submodule;
 	hashmap_add(&cache->for_name, e);
 }
@@ -163,7 +163,7 @@ static const struct submodule *cache_lookup_path(struct submodule_cache *cache,
 	oidcpy(&key_config.gitmodules_oid, gitmodules_oid);
 	key_config.path = path;
 
-	hashmap_entry_init(&key, hash);
+	hashmap_entry_init(&key.ent, hash);
 	key.config = &key_config;
 
 	entry = hashmap_get(&cache->for_path, &key, NULL);
@@ -183,7 +183,7 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
 	oidcpy(&key_config.gitmodules_oid, gitmodules_oid);
 	key_config.name = name;
 
-	hashmap_entry_init(&key, hash);
+	hashmap_entry_init(&key.ent, hash);
 	key.config = &key_config;
 
 	entry = hashmap_get(&cache->for_name, &key, NULL);
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index aaf17b0ddf..0c9fd7c996 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -37,7 +37,7 @@ static struct test_entry *alloc_test_entry(unsigned int hash,
 	size_t klen = strlen(key);
 	size_t vlen = strlen(value);
 	struct test_entry *entry = xmalloc(st_add4(sizeof(*entry), klen, vlen, 2));
-	hashmap_entry_init(entry, hash);
+	hashmap_entry_init(&entry->ent, hash);
 	memcpy(entry->key, key, klen + 1);
 	memcpy(entry->key + klen + 1, value, vlen + 1);
 	return entry;
@@ -103,7 +103,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 
 			/* add entries */
 			for (i = 0; i < TEST_SIZE; i++) {
-				hashmap_entry_init(entries[i], hashes[i]);
+				hashmap_entry_init(&entries[i]->ent, hashes[i]);
 				hashmap_add(&map, entries[i]);
 			}
 
@@ -116,7 +116,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 		/* fill the map (sparsely if specified) */
 		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
 		for (i = 0; i < j; i++) {
-			hashmap_entry_init(entries[i], hashes[i]);
+			hashmap_entry_init(&entries[i]->ent, hashes[i]);
 			hashmap_add(&map, entries[i]);
 		}
 
