Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE83C1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 02:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfHZCno (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 22:43:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36326 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbfHZCno (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 22:43:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 314441F4BB;
        Mon, 26 Aug 2019 02:43:33 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 04/11] hashmap_entry: detect improper initialization
Date:   Mon, 26 Aug 2019 02:43:25 +0000
Message-Id: <20190826024332.3403-5-e@80x24.org>
In-Reply-To: <20190826024332.3403-1-e@80x24.org>
References: <20190826024332.3403-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By renaming the "hash" field to "_hash", it's easy to spot
improper initialization of hashmap_entry structs which
can leave "hashmap_entry.next" uninitialized.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/fast-export.c               | 5 +++--
 hashmap.c                           | 9 +++++----
 hashmap.h                           | 4 ++--
 name-hash.c                         | 9 +++++----
 remote.c                            | 6 ++++--
 t/helper/test-lazy-init-name-hash.c | 4 ++--
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 287dbd24a3..f30a92a4d3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -144,18 +144,19 @@ static const void *anonymize_mem(struct hashmap *map,
 				 const void *orig, size_t *len)
 {
 	struct anonymized_entry key, *ret;
+	unsigned int hash = memhash(orig, *len);
 
 	if (!map->cmpfn)
 		hashmap_init(map, anonymized_entry_cmp, NULL, 0);
 
-	hashmap_entry_init(&key.hash, memhash(orig, *len));
+	hashmap_entry_init(&key.hash, hash);
 	key.orig = orig;
 	key.orig_len = *len;
 	ret = hashmap_get(map, &key, NULL);
 
 	if (!ret) {
 		ret = xmalloc(sizeof(*ret));
-		hashmap_entry_init(&ret->hash, key.hash.hash);
+		hashmap_entry_init(&ret->hash, hash);
 		ret->orig = xstrdup(orig);
 		ret->orig_len = *len;
 		ret->anon = generate(orig, len);
diff --git a/hashmap.c b/hashmap.c
index 6818c65174..777beda347 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -96,14 +96,14 @@ static inline int entry_equals(const struct hashmap *map,
 		const void *keydata)
 {
 	return (e1 == e2) ||
-	       (e1->hash == e2->hash &&
+	       (e1->_hash == e2->_hash &&
 		!map->cmpfn(map->cmpfn_data, e1, e2, keydata));
 }
 
 static inline unsigned int bucket(const struct hashmap *map,
 		const struct hashmap_entry *key)
 {
-	return key->hash & (map->tablesize - 1);
+	return key->_hash & (map->tablesize - 1);
 }
 
 int hashmap_bucket(const struct hashmap *map, unsigned int hash)
@@ -287,19 +287,20 @@ const void *memintern(const void *data, size_t len)
 {
 	static struct hashmap map;
 	struct pool_entry key, *e;
+	unsigned int hash = memhash(data, len);
 
 	/* initialize string pool hashmap */
 	if (!map.tablesize)
 		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, NULL, 0);
 
 	/* lookup interned string in pool */
-	hashmap_entry_init(&key.ent, memhash(data, len));
+	hashmap_entry_init(&key.ent, hash);
 	key.len = len;
 	e = hashmap_get(&map, &key, data);
 	if (!e) {
 		/* not found: create it */
 		FLEX_ALLOC_MEM(e, data, data, len);
-		hashmap_entry_init(&e->ent, key.ent.hash);
+		hashmap_entry_init(&e->ent, hash);
 		e->len = len;
 		hashmap_add(&map, e);
 	}
diff --git a/hashmap.h b/hashmap.h
index 3d7939c291..d635e0815a 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -145,7 +145,7 @@ struct hashmap_entry {
 	struct hashmap_entry *next;
 
 	/* entry's hash code */
-	unsigned int hash;
+	unsigned int _hash;
 };
 
 /*
@@ -247,7 +247,7 @@ void hashmap_free(struct hashmap *map, int free_entries);
 static inline void
 hashmap_entry_init(struct hashmap_entry *e, unsigned int hash)
 {
-	e->hash = hash;
+	e->_hash = hash;
 	e->next = NULL;
 }
 
diff --git a/name-hash.c b/name-hash.c
index 1ce1417f7e..8b33c5cb59 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -268,7 +268,7 @@ static struct dir_entry *hash_dir_entry_with_parent_and_prefix(
 	assert((parent != NULL) ^ (strchr(prefix->buf, '/') == NULL));
 
 	if (parent)
-		hash = memihash_cont(parent->ent.hash,
+		hash = memihash_cont(parent->ent._hash,
 			prefix->buf + parent->namelen,
 			prefix->len - parent->namelen);
 	else
@@ -289,7 +289,8 @@ static struct dir_entry *hash_dir_entry_with_parent_and_prefix(
 			unlock_dir_mutex(lock_nr);
 
 			/* All I really need here is an InterlockedIncrement(&(parent->nr)) */
-			lock_nr = compute_dir_lock_nr(&istate->dir_hash, parent->ent.hash);
+			lock_nr = compute_dir_lock_nr(&istate->dir_hash,
+							parent->ent._hash);
 			lock_dir_mutex(lock_nr);
 			parent->nr++;
 		}
@@ -427,10 +428,10 @@ static int handle_range_1(
 		lazy_entries[k].dir = parent;
 		if (parent) {
 			lazy_entries[k].hash_name = memihash_cont(
-				parent->ent.hash,
+				parent->ent._hash,
 				ce_k->name + parent->namelen,
 				ce_namelen(ce_k) - parent->namelen);
-			lazy_entries[k].hash_dir = parent->ent.hash;
+			lazy_entries[k].hash_dir = parent->ent._hash;
 		} else {
 			lazy_entries[k].hash_name = memihash(ce_k->name, ce_namelen(ce_k));
 		}
diff --git a/remote.c b/remote.c
index bd81cb71bc..dc09172e9d 100644
--- a/remote.c
+++ b/remote.c
@@ -136,6 +136,7 @@ static struct remote *make_remote(const char *name, int len)
 	struct remote *ret, *replaced;
 	struct remotes_hash_key lookup;
 	struct hashmap_entry lookup_entry;
+	unsigned int hash;
 
 	if (!len)
 		len = strlen(name);
@@ -143,7 +144,8 @@ static struct remote *make_remote(const char *name, int len)
 	init_remotes_hash();
 	lookup.str = name;
 	lookup.len = len;
-	hashmap_entry_init(&lookup_entry, memhash(name, len));
+	hash = memhash(name, len);
+	hashmap_entry_init(&lookup_entry, hash);
 
 	if ((ret = hashmap_get(&remotes_hash, &lookup_entry, &lookup)) != NULL)
 		return ret;
@@ -158,7 +160,7 @@ static struct remote *make_remote(const char *name, int len)
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
 
-	hashmap_entry_init(&ret->ent, lookup_entry.hash);
+	hashmap_entry_init(&ret->ent, hash);
 	replaced = hashmap_put(&remotes_hash, ret);
 	assert(replaced == NULL);  /* no previous entry overwritten */
 	return ret;
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index b99a37080d..d01ea0e526 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -43,13 +43,13 @@ static void dump_run(void)
 
 	dir = hashmap_iter_first(&the_index.dir_hash, &iter_dir);
 	while (dir) {
-		printf("dir %08x %7d %s\n", dir->ent.hash, dir->nr, dir->name);
+		printf("dir %08x %7d %s\n", dir->ent._hash, dir->nr, dir->name);
 		dir = hashmap_iter_next(&iter_dir);
 	}
 
 	ce = hashmap_iter_first(&the_index.name_hash, &iter_cache);
 	while (ce) {
-		printf("name %08x %s\n", ce->ent.hash, ce->name);
+		printf("name %08x %s\n", ce->ent._hash, ce->name);
 		ce = hashmap_iter_next(&iter_cache);
 	}
 
-- 
EW

