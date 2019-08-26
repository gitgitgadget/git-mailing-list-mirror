Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6351F461
	for <e@80x24.org>; Mon, 26 Aug 2019 02:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfHZCnz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 22:43:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36404 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbfHZCny (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 22:43:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C039B1F4BE;
        Mon, 26 Aug 2019 02:43:33 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 07/11] hashmap_get takes "const struct hashmap_entry *"
Date:   Mon, 26 Aug 2019 02:43:28 +0000
Message-Id: <20190826024332.3403-8-e@80x24.org>
In-Reply-To: <20190826024332.3403-1-e@80x24.org>
References: <20190826024332.3403-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is less error-prone than "const void *" as the compiler
now detects invalid types being passed.

Signed-off-by: Eric Wong <e@80x24.org>
---
 attr.c                | 2 +-
 blame.c               | 6 +++---
 builtin/difftool.c    | 5 +++--
 builtin/fast-export.c | 2 +-
 config.c              | 2 +-
 diff.c                | 4 ++--
 hashmap.c             | 5 +++--
 hashmap.h             | 8 +++++---
 merge-recursive.c     | 4 ++--
 name-hash.c           | 2 +-
 patch-ids.c           | 2 +-
 revision.c            | 3 ++-
 sub-process.c         | 2 +-
 submodule-config.c    | 4 ++--
 14 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/attr.c b/attr.c
index fa26a3e3cb..9bdef61cc3 100644
--- a/attr.c
+++ b/attr.c
@@ -101,7 +101,7 @@ static void *attr_hashmap_get(struct attr_hashmap *map,
 	hashmap_entry_init(&k.ent, memhash(key, keylen));
 	k.key = key;
 	k.keylen = keylen;
-	e = hashmap_get(&map->map, &k, NULL);
+	e = hashmap_get(&map->map, &k.ent, NULL);
 
 	return e ? e->value : NULL;
 }
diff --git a/blame.c b/blame.c
index 4d20aee435..73ffb59403 100644
--- a/blame.c
+++ b/blame.c
@@ -419,7 +419,7 @@ static void get_fingerprint(struct fingerprint *result,
 			continue;
 		hashmap_entry_init(&entry->entry, hash);
 
-		found_entry = hashmap_get(&result->map, entry, NULL);
+		found_entry = hashmap_get(&result->map, &entry->entry, NULL);
 		if (found_entry) {
 			found_entry->count += 1;
 		} else {
@@ -452,7 +452,7 @@ static int fingerprint_similarity(struct fingerprint *a, struct fingerprint *b)
 	hashmap_iter_init(&b->map, &iter);
 
 	while ((entry_b = hashmap_iter_next(&iter))) {
-		if ((entry_a = hashmap_get(&a->map, entry_b, NULL))) {
+		if ((entry_a = hashmap_get(&a->map, &entry_b->entry, NULL))) {
 			intersection += entry_a->count < entry_b->count ?
 					entry_a->count : entry_b->count;
 		}
@@ -471,7 +471,7 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 	hashmap_iter_init(&b->map, &iter);
 
 	while ((entry_b = hashmap_iter_next(&iter))) {
-		if ((entry_a = hashmap_get(&a->map, entry_b, NULL))) {
+		if ((entry_a = hashmap_get(&a->map, &entry_b->entry, NULL))) {
 			if (entry_a->count <= entry_b->count)
 				hashmap_remove(&a->map, entry_b, NULL);
 			else
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 82c146718d..f41298d199 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -162,7 +162,7 @@ static void add_left_or_right(struct hashmap *map, const char *path,
 
 	FLEX_ALLOC_STR(e, path, path);
 	hashmap_entry_init(&e->entry, strhash(path));
-	existing = hashmap_get(map, e, NULL);
+	existing = hashmap_get(map, &e->entry, NULL);
 	if (existing) {
 		free(e);
 		e = existing;
@@ -462,7 +462,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			/* Avoid duplicate working_tree entries */
 			FLEX_ALLOC_STR(entry, path, dst_path);
 			hashmap_entry_init(&entry->entry, strhash(dst_path));
-			if (hashmap_get(&working_tree_dups, entry, NULL)) {
+			if (hashmap_get(&working_tree_dups, &entry->entry,
+					NULL)) {
 				free(entry);
 				continue;
 			}
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f30a92a4d3..081cdd70c9 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -152,7 +152,7 @@ static const void *anonymize_mem(struct hashmap *map,
 	hashmap_entry_init(&key.hash, hash);
 	key.orig = orig;
 	key.orig_len = *len;
-	ret = hashmap_get(map, &key, NULL);
+	ret = hashmap_get(map, &key.hash, NULL);
 
 	if (!ret) {
 		ret = xmalloc(sizeof(*ret));
diff --git a/config.c b/config.c
index 2243d7c3d6..1a1b6675fd 100644
--- a/config.c
+++ b/config.c
@@ -1863,7 +1863,7 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 
 	hashmap_entry_init(&k.ent, strhash(normalized_key));
 	k.key = normalized_key;
-	found_entry = hashmap_get(&cs->config_hash, &k, NULL);
+	found_entry = hashmap_get(&cs->config_hash, &k.ent, NULL);
 	free(normalized_key);
 	return found_entry;
 }
diff --git a/diff.c b/diff.c
index cc7f06d10d..72d3c6aa19 100644
--- a/diff.c
+++ b/diff.c
@@ -1144,13 +1144,13 @@ static void mark_color_as_moved(struct diff_options *o,
 		case DIFF_SYMBOL_PLUS:
 			hm = del_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, key, NULL);
+			match = hashmap_get(hm, &key->ent, NULL);
 			free(key);
 			break;
 		case DIFF_SYMBOL_MINUS:
 			hm = add_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, key, NULL);
+			match = hashmap_get(hm, &key->ent, NULL);
 			free(key);
 			break;
 		default:
diff --git a/hashmap.c b/hashmap.c
index 1aa1324c3e..f02ac41758 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -186,7 +186,8 @@ void hashmap_free(struct hashmap *map, int free_entries)
 	memset(map, 0, sizeof(*map));
 }
 
-void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)
+void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
+		const void *keydata)
 {
 	return *find_entry_ptr(map, key, keydata);
 }
@@ -297,7 +298,7 @@ const void *memintern(const void *data, size_t len)
 	/* lookup interned string in pool */
 	hashmap_entry_init(&key.ent, hash);
 	key.len = len;
-	e = hashmap_get(&map, &key, data);
+	e = hashmap_get(&map, &key.ent, data);
 	if (!e) {
 		/* not found: create it */
 		FLEX_ALLOC_MEM(e, data, data, len);
diff --git a/hashmap.h b/hashmap.h
index 6a2fdf451b..dea369868d 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -74,7 +74,8 @@
  *             e->key = key;
  *
  *             flags |= COMPARE_VALUE;
- *             printf("%sfound\n", hashmap_get(&map, e, NULL) ? "" : "not ");
+ *             printf("%sfound\n",
+ *                    hashmap_get(&map, &e->ent, NULL) ? "" : "not ");
  *             free(e);
  *         }
  *
@@ -84,7 +85,8 @@
  *             k.key = key;
  *
  *             flags |= COMPARE_VALUE;
- *             printf("%sfound\n", hashmap_get(&map, &k, value) ? "" : "not ");
+ *             printf("%sfound\n",
+ *                    hashmap_get(&map, &k->ent, value) ? "" : "not ");
  *         }
  *
  *         if (!strcmp("end", action)) {
@@ -286,7 +288,7 @@ static inline unsigned int hashmap_get_size(struct hashmap *map)
  * If an entry with matching hash code is found, `key` and `keydata` are passed
  * to `hashmap_cmp_fn` to decide whether the entry matches the key.
  */
-void *hashmap_get(const struct hashmap *map, const void *key,
+void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
 			 const void *keydata);
 
 /*
diff --git a/merge-recursive.c b/merge-recursive.c
index db9b247ece..2d31a3e279 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -63,7 +63,7 @@ static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
 		return NULL;
 	hashmap_entry_init(&key.ent, strhash(dir));
 	key.dir = dir;
-	return hashmap_get(hashmap, &key, NULL);
+	return hashmap_get(hashmap, &key.ent, NULL);
 }
 
 static int dir_rename_cmp(const void *unused_cmp_data,
@@ -99,7 +99,7 @@ static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
 
 	hashmap_entry_init(&key.ent, strhash(target_file));
 	key.target_file = target_file;
-	return hashmap_get(hashmap, &key, NULL);
+	return hashmap_get(hashmap, &key.ent, NULL);
 }
 
 static int collision_cmp(void *unused_cmp_data,
diff --git a/name-hash.c b/name-hash.c
index def3576a8b..7368913613 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -35,7 +35,7 @@ static struct dir_entry *find_dir_entry__hash(struct index_state *istate,
 	struct dir_entry key;
 	hashmap_entry_init(&key.ent, hash);
 	key.namelen = namelen;
-	return hashmap_get(&istate->dir_hash, &key, name);
+	return hashmap_get(&istate->dir_hash, &key.ent, name);
 }
 
 static struct dir_entry *find_dir_entry(struct index_state *istate,
diff --git a/patch-ids.c b/patch-ids.c
index f87b62bf58..437f29e42c 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -99,7 +99,7 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 	if (init_patch_id_entry(&patch, commit, ids))
 		return NULL;
 
-	return hashmap_get(&ids->patches, &patch, NULL);
+	return hashmap_get(&ids->patches, &patch.ent, NULL);
 }
 
 struct patch_id *add_commit_patch_id(struct commit *commit,
diff --git a/revision.c b/revision.c
index 3461c78883..4336281286 100644
--- a/revision.c
+++ b/revision.c
@@ -147,7 +147,8 @@ static void paths_and_oids_insert(struct hashmap *map,
 	key.path = (char *)path;
 	oidset_init(&key.trees, 0);
 
-	if (!(entry = (struct path_and_oids_entry *)hashmap_get(map, &key, NULL))) {
+	entry = hashmap_get(map, &key.ent, NULL);
+	if (!entry) {
 		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
 		hashmap_entry_init(&entry->ent, hash);
 		entry->path = xstrdup(key.path);
diff --git a/sub-process.c b/sub-process.c
index d58e069855..debd86bb68 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -22,7 +22,7 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 
 	hashmap_entry_init(&key.ent, strhash(cmd));
 	key.cmd = cmd;
-	return hashmap_get(hashmap, &key, NULL);
+	return hashmap_get(hashmap, &key.ent, NULL);
 }
 
 int subprocess_read_status(int fd, struct strbuf *status)
diff --git a/submodule-config.c b/submodule-config.c
index a3bbd9fd6f..58d585cd7d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -166,7 +166,7 @@ static const struct submodule *cache_lookup_path(struct submodule_cache *cache,
 	hashmap_entry_init(&key.ent, hash);
 	key.config = &key_config;
 
-	entry = hashmap_get(&cache->for_path, &key, NULL);
+	entry = hashmap_get(&cache->for_path, &key.ent, NULL);
 	if (entry)
 		return entry->config;
 	return NULL;
@@ -186,7 +186,7 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
 	hashmap_entry_init(&key.ent, hash);
 	key.config = &key_config;
 
-	entry = hashmap_get(&cache->for_name, &key, NULL);
+	entry = hashmap_get(&cache->for_name, &key.ent, NULL);
 	if (entry)
 		return entry->config;
 	return NULL;
-- 
EW

