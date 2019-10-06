Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA2C1F4BE
	for <e@80x24.org>; Sun,  6 Oct 2019 23:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfJFXbX (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:31:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39442 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfJFXbW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:31:22 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8182B1F4CF;
        Sun,  6 Oct 2019 23:30:46 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 13/20] hashmap_get{,_from_hash} return "struct hashmap_entry *"
Date:   Sun,  6 Oct 2019 23:30:36 +0000
Message-Id: <20191006233043.3516-14-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update callers to use hashmap_get_entry, hashmap_get_entry_from_hash
or container_of as appropriate.

This is another step towards eliminating the requirement of
hashmap_entry being the first field in a struct.

Signed-off-by: Eric Wong <e@80x24.org>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
---
 attr.c                |  2 +-
 blame.c               | 11 ++++++++---
 builtin/describe.c    |  3 ++-
 builtin/difftool.c    |  2 +-
 builtin/fast-export.c |  2 +-
 builtin/fetch.c       | 11 +++++++----
 config.c              |  3 ++-
 hashmap.c             |  7 ++++---
 hashmap.h             | 12 +++++++-----
 merge-recursive.c     |  6 ++++--
 name-hash.c           |  3 ++-
 packfile.c            |  5 +++--
 patch-ids.c           |  3 ++-
 ref-filter.c          | 12 +++++++-----
 refs.c                |  5 ++++-
 remote.c              |  7 ++++---
 revision.c            |  3 ++-
 sequencer.c           |  7 +++++--
 sub-process.c         |  3 ++-
 submodule-config.c    |  6 ++++--
 20 files changed, 72 insertions(+), 41 deletions(-)

diff --git a/attr.c b/attr.c
index 9bdef61cc3..4230bee63d 100644
--- a/attr.c
+++ b/attr.c
@@ -101,7 +101,7 @@ static void *attr_hashmap_get(struct attr_hashmap *map,
 	hashmap_entry_init(&k.ent, memhash(key, keylen));
 	k.key = key;
 	k.keylen = keylen;
-	e = hashmap_get(&map->map, &k.ent, NULL);
+	e = hashmap_get_entry(&map->map, &k, NULL, struct attr_hash_entry, ent);
 
 	return e ? e->value : NULL;
 }
diff --git a/blame.c b/blame.c
index 00f8f3fb0a..aa46c7ec52 100644
--- a/blame.c
+++ b/blame.c
@@ -419,7 +419,8 @@ static void get_fingerprint(struct fingerprint *result,
 			continue;
 		hashmap_entry_init(&entry->entry, hash);
 
-		found_entry = hashmap_get(&result->map, &entry->entry, NULL);
+		found_entry = hashmap_get_entry(&result->map, entry, NULL,
+					struct fingerprint_entry, entry);
 		if (found_entry) {
 			found_entry->count += 1;
 		} else {
@@ -452,7 +453,9 @@ static int fingerprint_similarity(struct fingerprint *a, struct fingerprint *b)
 	hashmap_iter_init(&b->map, &iter);
 
 	while ((entry_b = hashmap_iter_next(&iter))) {
-		if ((entry_a = hashmap_get(&a->map, &entry_b->entry, NULL))) {
+		entry_a = hashmap_get_entry(&a->map, entry_b, NULL,
+					struct fingerprint_entry, entry);
+		if (entry_a) {
 			intersection += entry_a->count < entry_b->count ?
 					entry_a->count : entry_b->count;
 		}
@@ -471,7 +474,9 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 	hashmap_iter_init(&b->map, &iter);
 
 	while ((entry_b = hashmap_iter_next(&iter))) {
-		if ((entry_a = hashmap_get(&a->map, &entry_b->entry, NULL))) {
+		entry_a = hashmap_get_entry(&a->map, entry_b, NULL,
+					struct fingerprint_entry, entry);
+		if (entry_a) {
 			if (entry_a->count <= entry_b->count)
 				hashmap_remove(&a->map, &entry_b->entry, NULL);
 			else
diff --git a/builtin/describe.c b/builtin/describe.c
index f5e0a7e033..c6d2386b64 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -76,7 +76,8 @@ static int commit_name_neq(const void *unused_cmp_data,
 
 static inline struct commit_name *find_commit_name(const struct object_id *peeled)
 {
-	return hashmap_get_from_hash(&names, oidhash(peeled), peeled);
+	return hashmap_get_entry_from_hash(&names, oidhash(peeled), peeled,
+						struct commit_name, entry);
 }
 
 static int replace_name(struct commit_name *e,
diff --git a/builtin/difftool.c b/builtin/difftool.c
index f41298d199..fa9c862e3a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -162,7 +162,7 @@ static void add_left_or_right(struct hashmap *map, const char *path,
 
 	FLEX_ALLOC_STR(e, path, path);
 	hashmap_entry_init(&e->entry, strhash(path));
-	existing = hashmap_get(map, &e->entry, NULL);
+	existing = hashmap_get_entry(map, e, NULL, struct pair_entry, entry);
 	if (existing) {
 		free(e);
 		e = existing;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 192e21dae4..25195badd4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -151,7 +151,7 @@ static const void *anonymize_mem(struct hashmap *map,
 	hashmap_entry_init(&key.hash, memhash(orig, *len));
 	key.orig = orig;
 	key.orig_len = *len;
-	ret = hashmap_get(map, &key.hash, NULL);
+	ret = hashmap_get_entry(map, &key, NULL, struct anonymized_entry, hash);
 
 	if (!ret) {
 		ret = xmalloc(sizeof(*ret));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 909dbde909..d06f2b98aa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -383,8 +383,10 @@ static void find_non_local_tags(const struct ref *refs,
 	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
 		const char *refname = remote_ref_item->string;
 		struct ref *rm;
+		unsigned int hash = strhash(refname);
 
-		item = hashmap_get_from_hash(&remote_refs, strhash(refname), refname);
+		item = hashmap_get_entry_from_hash(&remote_refs, hash, refname,
+					struct refname_hash_entry, ent);
 		if (!item)
 			BUG("unseen remote ref?");
 
@@ -516,10 +518,11 @@ static struct ref *get_ref_map(struct remote *remote,
 		if (rm->peer_ref) {
 			const char *refname = rm->peer_ref->name;
 			struct refname_hash_entry *peer_item;
+			unsigned int hash = strhash(refname);
 
-			peer_item = hashmap_get_from_hash(&existing_refs,
-							  strhash(refname),
-							  refname);
+			peer_item = hashmap_get_entry_from_hash(&existing_refs,
+						hash, refname,
+						struct refname_hash_entry, ent);
 			if (peer_item) {
 				struct object_id *old_oid = &peer_item->oid;
 				oidcpy(&rm->peer_ref->old_oid, old_oid);
diff --git a/config.c b/config.c
index 1a1b6675fd..4952d1cc9e 100644
--- a/config.c
+++ b/config.c
@@ -1863,7 +1863,8 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 
 	hashmap_entry_init(&k.ent, strhash(normalized_key));
 	k.key = normalized_key;
-	found_entry = hashmap_get(&cs->config_hash, &k.ent, NULL);
+	found_entry = hashmap_get_entry(&cs->config_hash, &k, NULL,
+				struct config_set_element, ent);
 	free(normalized_key);
 	return found_entry;
 }
diff --git a/hashmap.c b/hashmap.c
index 22bc7c5b3b..5662bee10a 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -186,8 +186,9 @@ void hashmap_free(struct hashmap *map, int free_entries)
 	memset(map, 0, sizeof(*map));
 }
 
-void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
-		const void *keydata)
+struct hashmap_entry *hashmap_get(const struct hashmap *map,
+				const struct hashmap_entry *key,
+				const void *keydata)
 {
 	return *find_entry_ptr(map, key, keydata);
 }
@@ -298,7 +299,7 @@ const void *memintern(const void *data, size_t len)
 	/* lookup interned string in pool */
 	hashmap_entry_init(&key.ent, memhash(data, len));
 	key.len = len;
-	e = hashmap_get(&map, &key.ent, data);
+	e = hashmap_get_entry(&map, &key, data, struct pool_entry, ent);
 	if (!e) {
 		/* not found: create it */
 		FLEX_ALLOC_MEM(e, data, data, len);
diff --git a/hashmap.h b/hashmap.h
index cd42dcc15c..82ddb0ef41 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -290,8 +290,9 @@ static inline unsigned int hashmap_get_size(struct hashmap *map)
  * If an entry with matching hash code is found, `key` and `keydata` are passed
  * to `hashmap_cmp_fn` to decide whether the entry matches the key.
  */
-void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
-			 const void *keydata);
+struct hashmap_entry *hashmap_get(const struct hashmap *map,
+				const struct hashmap_entry *key,
+				const void *keydata);
 
 /*
  * Returns the hashmap entry for the specified hash code and key data,
@@ -305,9 +306,10 @@ void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
  * `entry_or_key` parameter of `hashmap_cmp_fn` points to a hashmap_entry
  * structure that should not be used in the comparison.
  */
-static inline void *hashmap_get_from_hash(const struct hashmap *map,
-					  unsigned int hash,
-					  const void *keydata)
+static inline struct hashmap_entry *hashmap_get_from_hash(
+					const struct hashmap *map,
+					unsigned int hash,
+					const void *keydata)
 {
 	struct hashmap_entry key;
 	hashmap_entry_init(&key, hash);
diff --git a/merge-recursive.c b/merge-recursive.c
index a685b4fb69..8274828c4d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -63,7 +63,8 @@ static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
 		return NULL;
 	hashmap_entry_init(&key.ent, strhash(dir));
 	key.dir = dir;
-	return hashmap_get(hashmap, &key.ent, NULL);
+	return hashmap_get_entry(hashmap, &key, NULL,
+				struct dir_rename_entry, ent);
 }
 
 static int dir_rename_cmp(const void *unused_cmp_data,
@@ -99,7 +100,8 @@ static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
 
 	hashmap_entry_init(&key.ent, strhash(target_file));
 	key.target_file = target_file;
-	return hashmap_get(hashmap, &key.ent, NULL);
+	return hashmap_get_entry(hashmap, &key, NULL,
+				struct collision_entry, ent);
 }
 
 static int collision_cmp(void *unused_cmp_data,
diff --git a/name-hash.c b/name-hash.c
index 73b83adf3d..aa8253ddd5 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -35,7 +35,8 @@ static struct dir_entry *find_dir_entry__hash(struct index_state *istate,
 	struct dir_entry key;
 	hashmap_entry_init(&key.ent, hash);
 	key.namelen = namelen;
-	return hashmap_get(&istate->dir_hash, &key.ent, name);
+	return hashmap_get_entry(&istate->dir_hash, &key, name,
+					struct dir_entry, ent);
 }
 
 static struct dir_entry *find_dir_entry(struct index_state *istate,
diff --git a/packfile.c b/packfile.c
index 3edd648de0..f2aa34bb49 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1381,7 +1381,7 @@ static unsigned int pack_entry_hash(struct packed_git *p, off_t base_offset)
 static struct delta_base_cache_entry *
 get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
 {
-	struct hashmap_entry entry;
+	struct hashmap_entry entry, *e;
 	struct delta_base_cache_key key;
 
 	if (!delta_base_cache.cmpfn)
@@ -1390,7 +1390,8 @@ get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
 	hashmap_entry_init(&entry, pack_entry_hash(p, base_offset));
 	key.p = p;
 	key.base_offset = base_offset;
-	return hashmap_get(&delta_base_cache, &entry, &key);
+	e = hashmap_get(&delta_base_cache, &entry, &key);
+	return e ? container_of(e, struct delta_base_cache_entry, ent) : NULL;
 }
 
 static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
diff --git a/patch-ids.c b/patch-ids.c
index 437f29e42c..176c47d967 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -99,7 +99,8 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 	if (init_patch_id_entry(&patch, commit, ids))
 		return NULL;
 
-	return hashmap_get(&ids->patches, &patch.ent, NULL);
+	return hashmap_get_entry(&ids->patches, &patch, NULL,
+					struct patch_id, ent);
 }
 
 struct patch_id *add_commit_patch_id(struct commit *commit,
diff --git a/ref-filter.c b/ref-filter.c
index d939ebc6bb..9999426914 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1585,18 +1585,20 @@ static void lazy_init_worktree_map(void)
 
 static char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
 {
-	struct hashmap_entry entry;
+	struct hashmap_entry entry, *e;
 	struct ref_to_worktree_entry *lookup_result;
 
 	lazy_init_worktree_map();
 
 	hashmap_entry_init(&entry, strhash(ref->refname));
-	lookup_result = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
+	e = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
 
-	if (lookup_result)
-		return xstrdup(lookup_result->wt->path);
-	else
+	if (!e)
 		return xstrdup("");
+
+	lookup_result = container_of(e, struct ref_to_worktree_entry, ent);
+
+	return xstrdup(lookup_result->wt->path);
 }
 
 /*
diff --git a/refs.c b/refs.c
index 3e55031256..43a95105f1 100644
--- a/refs.c
+++ b/refs.c
@@ -1815,12 +1815,15 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
 					      const char *name)
 {
 	struct ref_store_hash_entry *entry;
+	unsigned int hash;
 
 	if (!map->tablesize)
 		/* It's initialized on demand in register_ref_store(). */
 		return NULL;
 
-	entry = hashmap_get_from_hash(map, strhash(name), name);
+	hash = strhash(name);
+	entry = hashmap_get_entry_from_hash(map, hash, name,
+					struct ref_store_hash_entry, ent);
 	return entry ? entry->refs : NULL;
 }
 
diff --git a/remote.c b/remote.c
index 8ca23d95dc..ed95ae6ed6 100644
--- a/remote.c
+++ b/remote.c
@@ -135,7 +135,7 @@ static struct remote *make_remote(const char *name, int len)
 {
 	struct remote *ret, *replaced;
 	struct remotes_hash_key lookup;
-	struct hashmap_entry lookup_entry;
+	struct hashmap_entry lookup_entry, *e;
 
 	if (!len)
 		len = strlen(name);
@@ -145,8 +145,9 @@ static struct remote *make_remote(const char *name, int len)
 	lookup.len = len;
 	hashmap_entry_init(&lookup_entry, memhash(name, len));
 
-	if ((ret = hashmap_get(&remotes_hash, &lookup_entry, &lookup)) != NULL)
-		return ret;
+	e = hashmap_get(&remotes_hash, &lookup_entry, &lookup);
+	if (e)
+		return container_of(e, struct remote, ent);
 
 	ret = xcalloc(1, sizeof(struct remote));
 	ret->prune = -1;  /* unspecified */
diff --git a/revision.c b/revision.c
index a7e2339064..d5f534209d 100644
--- a/revision.c
+++ b/revision.c
@@ -147,7 +147,8 @@ static void paths_and_oids_insert(struct hashmap *map,
 	key.path = (char *)path;
 	oidset_init(&key.trees, 0);
 
-	entry = hashmap_get(map, &key.ent, NULL);
+	entry = hashmap_get_entry(map, &key, NULL,
+				struct path_and_oids_entry, ent);
 	if (!entry) {
 		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
 		hashmap_entry_init(&entry->ent, hash);
diff --git a/sequencer.c b/sequencer.c
index b4ef70e260..aea2cb12cc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5217,8 +5217,11 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 					break;
 			}
 
-			if ((entry = hashmap_get_from_hash(&subject2item,
-							   strhash(p), p)))
+			entry = hashmap_get_entry_from_hash(&subject2item,
+						strhash(p), p,
+						struct subject2item_entry,
+						entry);
+			if (entry)
 				/* found by title */
 				i2 = entry->i;
 			else if (!strchr(p, ' ') &&
diff --git a/sub-process.c b/sub-process.c
index 99fccef592..f2fcc16c3e 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -22,7 +22,8 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 
 	hashmap_entry_init(&key.ent, strhash(cmd));
 	key.cmd = cmd;
-	return hashmap_get(hashmap, &key.ent, NULL);
+	return hashmap_get_entry(hashmap, &key, NULL,
+				struct subprocess_entry, ent);
 }
 
 int subprocess_read_status(int fd, struct strbuf *status)
diff --git a/submodule-config.c b/submodule-config.c
index 9248c5ea5b..b031884789 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -166,7 +166,8 @@ static const struct submodule *cache_lookup_path(struct submodule_cache *cache,
 	hashmap_entry_init(&key.ent, hash);
 	key.config = &key_config;
 
-	entry = hashmap_get(&cache->for_path, &key.ent, NULL);
+	entry = hashmap_get_entry(&cache->for_path, &key, NULL,
+				struct submodule_entry, ent);
 	if (entry)
 		return entry->config;
 	return NULL;
@@ -186,7 +187,8 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
 	hashmap_entry_init(&key.ent, hash);
 	key.config = &key_config;
 
-	entry = hashmap_get(&cache->for_name, &key.ent, NULL);
+	entry = hashmap_get_entry(&cache->for_name, &key, NULL,
+				struct submodule_entry, ent);
 	if (entry)
 		return entry->config;
 	return NULL;
