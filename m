Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4BB1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 01:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503785AbfIXBET (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:04:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59582 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503775AbfIXBET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:04:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E827C1FAD8;
        Tue, 24 Sep 2019 01:03:28 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 19/19] hashmap: remove type arg from hashmap_{get,put,remove}_entry
Date:   Tue, 24 Sep 2019 01:03:24 +0000
Message-Id: <20190924010324.22619-20-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since these macros already take a `keyvar' pointer of a known type,
we can rely on OFFSETOF_VAR to get the correct offset without
relying on non-portable `__typeof__' and `offsetof'.

Argument order is also rearranged, so `keyvar' and `member' are
sequential as they are used as: `keyvar->member'

Signed-off-by: Eric Wong <e@80x24.org>
---
 attr.c                  |  2 +-
 blame.c                 | 10 ++++-----
 builtin/difftool.c      |  2 +-
 builtin/fast-export.c   |  2 +-
 config.c                |  3 +--
 diff.c                  |  6 ++----
 hashmap.c               |  2 +-
 hashmap.h               | 45 ++++++++++++++++++++++++++++++-----------
 merge-recursive.c       |  6 ++----
 name-hash.c             |  3 +--
 patch-ids.c             |  3 +--
 range-diff.c            |  4 +---
 remote.c                |  3 +--
 revision.c              |  3 +--
 sub-process.c           |  3 +--
 submodule-config.c      | 10 +++------
 t/helper/test-hashmap.c |  4 +---
 17 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/attr.c b/attr.c
index 9849106627..15f0efdf60 100644
--- a/attr.c
+++ b/attr.c
@@ -103,7 +103,7 @@ static void *attr_hashmap_get(struct attr_hashmap *map,
 	hashmap_entry_init(&k.ent, memhash(key, keylen));
 	k.key = key;
 	k.keylen = keylen;
-	e = hashmap_get_entry(&map->map, &k, NULL, struct attr_hash_entry, ent);
+	e = hashmap_get_entry(&map->map, &k, ent, NULL);
 
 	return e ? e->value : NULL;
 }
diff --git a/blame.c b/blame.c
index 90b247abf9..6384f48133 100644
--- a/blame.c
+++ b/blame.c
@@ -419,8 +419,8 @@ static void get_fingerprint(struct fingerprint *result,
 			continue;
 		hashmap_entry_init(&entry->entry, hash);
 
-		found_entry = hashmap_get_entry(&result->map, entry, NULL,
-					struct fingerprint_entry, entry);
+		found_entry = hashmap_get_entry(&result->map, entry,
+						/* member name */ entry, NULL);
 		if (found_entry) {
 			found_entry->count += 1;
 		} else {
@@ -452,8 +452,7 @@ static int fingerprint_similarity(struct fingerprint *a, struct fingerprint *b)
 
 	hashmap_for_each_entry(&b->map, &iter, entry_b,
 				entry /* member name */) {
-		entry_a = hashmap_get_entry(&a->map, entry_b, NULL,
-					struct fingerprint_entry, entry);
+		entry_a = hashmap_get_entry(&a->map, entry_b, entry, NULL);
 		if (entry_a) {
 			intersection += entry_a->count < entry_b->count ?
 					entry_a->count : entry_b->count;
@@ -474,8 +473,7 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 
 	hashmap_for_each_entry(&b->map, &iter, entry_b,
 				entry /* member name */) {
-		entry_a = hashmap_get_entry(&a->map, entry_b, NULL,
-					struct fingerprint_entry, entry);
+		entry_a = hashmap_get_entry(&a->map, entry_b, entry, NULL);
 		if (entry_a) {
 			if (entry_a->count <= entry_b->count)
 				hashmap_remove(&a->map, &entry_b->entry, NULL);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index f2d4d1e0f8..c280e682b2 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -167,7 +167,7 @@ static void add_left_or_right(struct hashmap *map, const char *path,
 
 	FLEX_ALLOC_STR(e, path, path);
 	hashmap_entry_init(&e->entry, strhash(path));
-	existing = hashmap_get_entry(map, e, NULL, struct pair_entry, entry);
+	existing = hashmap_get_entry(map, e, entry, NULL);
 	if (existing) {
 		free(e);
 		e = existing;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ef0578bf90..e3de403efd 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -156,7 +156,7 @@ static const void *anonymize_mem(struct hashmap *map,
 	hashmap_entry_init(&key.hash, memhash(orig, *len));
 	key.orig = orig;
 	key.orig_len = *len;
-	ret = hashmap_get_entry(map, &key, NULL, struct anonymized_entry, hash);
+	ret = hashmap_get_entry(map, &key, hash, NULL);
 
 	if (!ret) {
 		ret = xmalloc(sizeof(*ret));
diff --git a/config.c b/config.c
index 77ed00bfbf..a4fa464ed2 100644
--- a/config.c
+++ b/config.c
@@ -1863,8 +1863,7 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 
 	hashmap_entry_init(&k.ent, strhash(normalized_key));
 	k.key = normalized_key;
-	found_entry = hashmap_get_entry(&cs->config_hash, &k, NULL,
-				struct config_set_element, ent);
+	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
 	free(normalized_key);
 	return found_entry;
 }
diff --git a/diff.c b/diff.c
index 051de9832d..a9ecb93af3 100644
--- a/diff.c
+++ b/diff.c
@@ -1146,15 +1146,13 @@ static void mark_color_as_moved(struct diff_options *o,
 		case DIFF_SYMBOL_PLUS:
 			hm = del_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get_entry(hm, key, NULL,
-						struct moved_entry, ent);
+			match = hashmap_get_entry(hm, key, ent, NULL);
 			free(key);
 			break;
 		case DIFF_SYMBOL_MINUS:
 			hm = add_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get_entry(hm, key, NULL,
-						struct moved_entry, ent);
+			match = hashmap_get_entry(hm, key, ent, NULL);
 			free(key);
 			break;
 		default:
diff --git a/hashmap.c b/hashmap.c
index 1efd5e431b..83358226c0 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -311,7 +311,7 @@ const void *memintern(const void *data, size_t len)
 	/* lookup interned string in pool */
 	hashmap_entry_init(&key.ent, memhash(data, len));
 	key.len = len;
-	e = hashmap_get_entry(&map, &key, data, struct pool_entry, ent);
+	e = hashmap_get_entry(&map, &key, ent, data);
 	if (!e) {
 		/* not found: create it */
 		FLEX_ALLOC_MEM(e, data, data, len);
diff --git a/hashmap.h b/hashmap.h
index 519213a812..407bc10913 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -63,7 +63,7 @@
  *             k.key = key;
  *
  *             flags &= ~COMPARE_VALUE;
- *             e = hashmap_get_entry(&map, &k, NULL, struct long2string, ent);
+ *             e = hashmap_get_entry(&map, &k, ent, NULL);
  *             if (e) {
  *                 printf("first: %ld %s\n", e->key, e->value);
  *                 while ((e = hashmap_get_next_entry(&map, e,
@@ -359,8 +359,17 @@ void hashmap_add(struct hashmap *map, struct hashmap_entry *entry);
 struct hashmap_entry *
 hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
 
-#define hashmap_put_entry(map, keyvar, type, member) \
-	container_of_or_null(hashmap_put(map, &(keyvar)->member), type, member)
+/*
+ * Adds or replaces a hashmap entry contained within @keyvar,
+ * where @keyvar is a pointer to a struct containing a
+ * "struct hashmap_entry" @member.
+ *
+ * Returns the replaced pointer which is of the same type as @keyvar,
+ * or NULL if not found.
+ */
+#define hashmap_put_entry(map, keyvar, member) \
+	container_of_or_null_offset(hashmap_put(map, &(keyvar)->member), \
+				OFFSETOF_VAR(keyvar, member))
 
 /*
  * Removes a hashmap entry matching the specified key. If the hashmap contains
@@ -373,9 +382,20 @@ struct hashmap_entry *
 hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
 		const void *keydata);
 
-#define hashmap_remove_entry(map, keyvar, keydata, type, member) \
-	container_of_or_null(hashmap_remove(map, &(keyvar)->member, keydata), \
-				type, member)
+/*
+ * Removes a hashmap entry contained within @keyvar,
+ * where @keyvar is a pointer to a struct containing a
+ * "struct hashmap_entry" @member.
+ *
+ * See `hashmap_get` for an explanation of @keydata
+ *
+ * Returns the replaced pointer which is of the same type as @keyvar,
+ * or NULL if not found.
+ */
+#define hashmap_remove_entry(map, keyvar, member, keydata) \
+	container_of_or_null_offset( \
+			hashmap_remove(map, &(keyvar)->member, keydata), \
+			OFFSETOF_VAR(keyvar, member))
 
 /*
  * Returns the `bucket` an entry is stored in.
@@ -436,13 +456,14 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
 						OFFSETOF_VAR(var, member)))
 
 /*
- * returns a @pointer of @type matching @keyvar, or NULL if nothing found.
- * @keyvar is a pointer of @type
- * @member is the name of the "struct hashmap_entry" field in @type
+ * returns a pointer of type matching @keyvar, or NULL if nothing found.
+ * @keyvar is a pointer to a struct containing a
+ * "struct hashmap_entry" @member.
  */
-#define hashmap_get_entry(map, keyvar, keydata, type, member) \
-	container_of_or_null(hashmap_get(map, &(keyvar)->member, keydata), \
-				type, member)
+#define hashmap_get_entry(map, keyvar, member, keydata) \
+	container_of_or_null_offset( \
+				hashmap_get(map, &(keyvar)->member, keydata), \
+				OFFSETOF_VAR(keyvar, member))
 
 #define hashmap_get_entry_from_hash(map, hash, keydata, type, member) \
 	container_of_or_null(hashmap_get_from_hash(map, hash, keydata), \
diff --git a/merge-recursive.c b/merge-recursive.c
index 3abba3a618..8787a40b0c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -65,8 +65,7 @@ static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
 		return NULL;
 	hashmap_entry_init(&key.ent, strhash(dir));
 	key.dir = dir;
-	return hashmap_get_entry(hashmap, &key, NULL,
-				struct dir_rename_entry, ent);
+	return hashmap_get_entry(hashmap, &key, ent, NULL);
 }
 
 static int dir_rename_cmp(const void *unused_cmp_data,
@@ -104,8 +103,7 @@ static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
 
 	hashmap_entry_init(&key.ent, strhash(target_file));
 	key.target_file = target_file;
-	return hashmap_get_entry(hashmap, &key, NULL,
-				struct collision_entry, ent);
+	return hashmap_get_entry(hashmap, &key, ent, NULL);
 }
 
 static int collision_cmp(const void *unused_cmp_data,
diff --git a/name-hash.c b/name-hash.c
index 3cda22b657..ceb1d7bd6f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -37,8 +37,7 @@ static struct dir_entry *find_dir_entry__hash(struct index_state *istate,
 	struct dir_entry key;
 	hashmap_entry_init(&key.ent, hash);
 	key.namelen = namelen;
-	return hashmap_get_entry(&istate->dir_hash, &key, name,
-					struct dir_entry, ent);
+	return hashmap_get_entry(&istate->dir_hash, &key, ent, name);
 }
 
 static struct dir_entry *find_dir_entry(struct index_state *istate,
diff --git a/patch-ids.c b/patch-ids.c
index af17828e33..12aa6d494b 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -101,8 +101,7 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 	if (init_patch_id_entry(&patch, commit, ids))
 		return NULL;
 
-	return hashmap_get_entry(&ids->patches, &patch, NULL,
-					struct patch_id, ent);
+	return hashmap_get_entry(&ids->patches, &patch, ent, NULL);
 }
 
 struct patch_id *add_commit_patch_id(struct commit *commit,
diff --git a/range-diff.c b/range-diff.c
index 9df53569bb..22ad959cee 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -229,9 +229,7 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 		util->patch = b->items[i].string;
 		util->diff = util->patch + util->diff_offset;
 		hashmap_entry_init(&util->e, strhash(util->diff));
-		other = hashmap_remove_entry(&map, util, NULL,
-					struct patch_util,
-					e /* member name */);
+		other = hashmap_remove_entry(&map, util, e, NULL);
 		if (other) {
 			if (other->matching >= 0)
 				BUG("already assigned!");
diff --git a/remote.c b/remote.c
index 5fcddcd88d..5c4666b53a 100644
--- a/remote.c
+++ b/remote.c
@@ -162,8 +162,7 @@ static struct remote *make_remote(const char *name, int len)
 	remotes[remotes_nr++] = ret;
 
 	hashmap_entry_init(&ret->ent, lookup_entry.hash);
-	replaced = hashmap_put_entry(&remotes_hash, ret, struct remote,
-					ent /* member name */);
+	replaced = hashmap_put_entry(&remotes_hash, ret, ent);
 	assert(replaced == NULL);  /* no previous entry overwritten */
 	return ret;
 }
diff --git a/revision.c b/revision.c
index 5abd4a1fe7..6688f89d0d 100644
--- a/revision.c
+++ b/revision.c
@@ -151,8 +151,7 @@ static void paths_and_oids_insert(struct hashmap *map,
 	key.path = (char *)path;
 	oidset_init(&key.trees, 0);
 
-	entry = hashmap_get_entry(map, &key, NULL,
-				struct path_and_oids_entry, ent);
+	entry = hashmap_get_entry(map, &key, ent, NULL);
 	if (!entry) {
 		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
 		hashmap_entry_init(&entry->ent, hash);
diff --git a/sub-process.c b/sub-process.c
index ad94f72665..1b1af9dcbd 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -24,8 +24,7 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 
 	hashmap_entry_init(&key.ent, strhash(cmd));
 	key.cmd = cmd;
-	return hashmap_get_entry(hashmap, &key, NULL,
-				struct subprocess_entry, ent);
+	return hashmap_get_entry(hashmap, &key, ent, NULL);
 }
 
 int subprocess_read_status(int fd, struct strbuf *status)
diff --git a/submodule-config.c b/submodule-config.c
index c22855cd38..401a9b2382 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -141,9 +141,7 @@ static void cache_remove_path(struct submodule_cache *cache,
 	struct submodule_entry *removed;
 	hashmap_entry_init(&e.ent, hash);
 	e.config = submodule;
-	removed = hashmap_remove_entry(&cache->for_path, &e, NULL,
-					struct submodule_entry,
-					ent /* member name */);
+	removed = hashmap_remove_entry(&cache->for_path, &e, ent, NULL);
 	free(removed);
 }
 
@@ -172,8 +170,7 @@ static const struct submodule *cache_lookup_path(struct submodule_cache *cache,
 	hashmap_entry_init(&key.ent, hash);
 	key.config = &key_config;
 
-	entry = hashmap_get_entry(&cache->for_path, &key, NULL,
-				struct submodule_entry, ent);
+	entry = hashmap_get_entry(&cache->for_path, &key, ent, NULL);
 	if (entry)
 		return entry->config;
 	return NULL;
@@ -193,8 +190,7 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
 	hashmap_entry_init(&key.ent, hash);
 	key.config = &key_config;
 
-	entry = hashmap_get_entry(&cache->for_name, &key, NULL,
-				struct submodule_entry, ent);
+	entry = hashmap_get_entry(&cache->for_name, &key, ent, NULL);
 	if (entry)
 		return entry->config;
 	return NULL;
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index f89d1194ef..cc577c8956 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -189,9 +189,7 @@ int cmd__hashmap(int argc, const char **argv)
 			entry = alloc_test_entry(hash, p1, p2);
 
 			/* add / replace entry */
-			entry = hashmap_put_entry(&map, entry,
-						struct test_entry,
-						ent /* member name */);
+			entry = hashmap_put_entry(&map, entry, ent);
 
 			/* print and free replaced entry, if any */
 			puts(entry ? get_value(entry) : "NULL");
