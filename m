Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B526A1F4BE
	for <e@80x24.org>; Sun,  6 Oct 2019 23:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfJFXbZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:31:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39468 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfJFXbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:31:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B9B7F1F4CC;
        Sun,  6 Oct 2019 23:30:46 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 14/20] hashmap_cmp_fn takes hashmap_entry params
Date:   Sun,  6 Oct 2019 23:30:37 +0000
Message-Id: <20191006233043.3516-15-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another step in eliminating the requirement of hashmap_entry
being the first member of a struct.

Signed-off-by: Eric Wong <e@80x24.org>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
---
 attr.c                  | 10 ++++++----
 builtin/describe.c      | 10 ++++++----
 builtin/difftool.c      | 31 +++++++++++++++++++------------
 builtin/fast-export.c   |  9 +++++++--
 builtin/fetch.c         |  9 +++++----
 config.c                | 10 ++++++----
 diff.c                  | 12 +++++++-----
 hashmap.c               | 17 +++++++++++------
 hashmap.h               | 13 +++++++++----
 merge-recursive.c       | 33 +++++++++++++++++++++------------
 name-hash.c             | 21 +++++++++++++--------
 oidmap.c                | 14 +++++++++-----
 packfile.c              |  9 +++++++--
 patch-ids.c             | 10 ++++++----
 ref-filter.c            | 11 +++++++----
 refs.c                  | 11 ++++++++---
 remote.c                | 10 ++++++----
 revision.c              | 11 ++++++++---
 sequencer.c             | 24 +++++++++++++++++-------
 sub-process.c           | 10 ++++++----
 sub-process.h           |  4 ++--
 submodule-config.c      | 20 ++++++++++++--------
 t/helper/test-hashmap.c | 10 ++++++----
 23 files changed, 204 insertions(+), 115 deletions(-)

diff --git a/attr.c b/attr.c
index 4230bee63d..6053481610 100644
--- a/attr.c
+++ b/attr.c
@@ -70,12 +70,14 @@ struct attr_hash_entry {
 
 /* attr_hashmap comparison function */
 static int attr_hash_entry_cmp(const void *unused_cmp_data,
-			       const void *entry,
-			       const void *entry_or_key,
+			       const struct hashmap_entry *eptr,
+			       const struct hashmap_entry *entry_or_key,
 			       const void *unused_keydata)
 {
-	const struct attr_hash_entry *a = entry;
-	const struct attr_hash_entry *b = entry_or_key;
+	const struct attr_hash_entry *a, *b;
+
+	a = container_of(eptr, const struct attr_hash_entry, ent);
+	b = container_of(entry_or_key, const struct attr_hash_entry, ent);
 	return (a->keylen != b->keylen) || strncmp(a->key, b->key, a->keylen);
 }
 
diff --git a/builtin/describe.c b/builtin/describe.c
index c6d2386b64..e9267b5c9c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -64,12 +64,14 @@ static const char *prio_names[] = {
 };
 
 static int commit_name_neq(const void *unused_cmp_data,
-			   const void *entry,
-			   const void *entry_or_key,
+			   const struct hashmap_entry *eptr,
+			   const struct hashmap_entry *entry_or_key,
 			   const void *peeled)
 {
-	const struct commit_name *cn1 = entry;
-	const struct commit_name *cn2 = entry_or_key;
+	const struct commit_name *cn1, *cn2;
+
+	cn1 = container_of(eptr, const struct commit_name, entry);
+	cn2 = container_of(entry_or_key, const struct commit_name, entry);
 
 	return !oideq(&cn1->peeled, peeled ? peeled : &cn2->peeled);
 }
diff --git a/builtin/difftool.c b/builtin/difftool.c
index fa9c862e3a..4a37b3edee 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -125,12 +125,15 @@ struct working_tree_entry {
 };
 
 static int working_tree_entry_cmp(const void *unused_cmp_data,
-				  const void *entry,
-				  const void *entry_or_key,
+				  const struct hashmap_entry *eptr,
+				  const struct hashmap_entry *entry_or_key,
 				  const void *unused_keydata)
 {
-	const struct working_tree_entry *a = entry;
-	const struct working_tree_entry *b = entry_or_key;
+	const struct working_tree_entry *a, *b;
+
+	a = container_of(eptr, const struct working_tree_entry, entry);
+	b = container_of(entry_or_key, const struct working_tree_entry, entry);
+
 	return strcmp(a->path, b->path);
 }
 
@@ -145,12 +148,14 @@ struct pair_entry {
 };
 
 static int pair_cmp(const void *unused_cmp_data,
-		    const void *entry,
-		    const void *entry_or_key,
+		    const struct hashmap_entry *eptr,
+		    const struct hashmap_entry *entry_or_key,
 		    const void *unused_keydata)
 {
-	const struct pair_entry *a = entry;
-	const struct pair_entry *b = entry_or_key;
+	const struct pair_entry *a, *b;
+
+	a = container_of(eptr, const struct pair_entry, entry);
+	b = container_of(entry_or_key, const struct pair_entry, entry);
 
 	return strcmp(a->path, b->path);
 }
@@ -179,12 +184,14 @@ struct path_entry {
 };
 
 static int path_entry_cmp(const void *unused_cmp_data,
-			  const void *entry,
-			  const void *entry_or_key,
+			  const struct hashmap_entry *eptr,
+			  const struct hashmap_entry *entry_or_key,
 			  const void *key)
 {
-	const struct path_entry *a = entry;
-	const struct path_entry *b = entry_or_key;
+	const struct path_entry *a, *b;
+
+	a = container_of(eptr, const struct path_entry, entry);
+	b = container_of(entry_or_key, const struct path_entry, entry);
 
 	return strcmp(a->path, key ? key : b->path);
 }
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 25195badd4..ef0578bf90 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -126,10 +126,15 @@ struct anonymized_entry {
 };
 
 static int anonymized_entry_cmp(const void *unused_cmp_data,
-				const void *va, const void *vb,
+				const struct hashmap_entry *eptr,
+				const struct hashmap_entry *entry_or_key,
 				const void *unused_keydata)
 {
-	const struct anonymized_entry *a = va, *b = vb;
+	const struct anonymized_entry *a, *b;
+
+	a = container_of(eptr, const struct anonymized_entry, hash);
+	b = container_of(entry_or_key, const struct anonymized_entry, hash);
+
 	return a->orig_len != b->orig_len ||
 		memcmp(a->orig, b->orig, a->orig_len);
 }
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d06f2b98aa..476c2416e3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -258,13 +258,14 @@ struct refname_hash_entry {
 };
 
 static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data,
-				  const void *e1_,
-				  const void *e2_,
+				  const struct hashmap_entry *eptr,
+				  const struct hashmap_entry *entry_or_key,
 				  const void *keydata)
 {
-	const struct refname_hash_entry *e1 = e1_;
-	const struct refname_hash_entry *e2 = e2_;
+	const struct refname_hash_entry *e1, *e2;
 
+	e1 = container_of(eptr, const struct refname_hash_entry, ent);
+	e2 = container_of(entry_or_key, const struct refname_hash_entry, ent);
 	return strcmp(e1->refname, keydata ? keydata : e2->refname);
 }
 
diff --git a/config.c b/config.c
index 4952d1cc9e..33043ee73c 100644
--- a/config.c
+++ b/config.c
@@ -1914,12 +1914,14 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 }
 
 static int config_set_element_cmp(const void *unused_cmp_data,
-				  const void *entry,
-				  const void *entry_or_key,
+				  const struct hashmap_entry *eptr,
+				  const struct hashmap_entry *entry_or_key,
 				  const void *unused_keydata)
 {
-	const struct config_set_element *e1 = entry;
-	const struct config_set_element *e2 = entry_or_key;
+	const struct config_set_element *e1, *e2;
+
+	e1 = container_of(eptr, const struct config_set_element, ent);
+	e2 = container_of(entry_or_key, const struct config_set_element, ent);
 
 	return strcmp(e1->key, e2->key);
 }
diff --git a/diff.c b/diff.c
index 66cdf4e9ca..5eaf689fcc 100644
--- a/diff.c
+++ b/diff.c
@@ -933,16 +933,18 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 }
 
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
-			   const void *entry,
-			   const void *entry_or_key,
+			   const struct hashmap_entry *eptr,
+			   const struct hashmap_entry *entry_or_key,
 			   const void *keydata)
 {
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
-	const struct moved_entry *a = entry;
-	const struct moved_entry *b = entry_or_key;
+	const struct moved_entry *a, *b;
 	unsigned flags = diffopt->color_moved_ws_handling
 			 & XDF_WHITESPACE_FLAGS;
 
+	a = container_of(eptr, const struct moved_entry, ent);
+	b = container_of(entry_or_key, const struct moved_entry, ent);
+
 	if (diffopt->color_moved_ws_handling &
 	    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
 		/*
@@ -1019,7 +1021,7 @@ static void pmb_advance_or_null(struct diff_options *o,
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
 				prev->next_line : NULL;
-		if (cur && !hm->cmpfn(o, cur, match, NULL)) {
+		if (cur && !hm->cmpfn(o, &cur->ent, &match->ent, NULL)) {
 			pmb[i].match = cur;
 		} else {
 			pmb[i].match = NULL;
diff --git a/hashmap.c b/hashmap.c
index 5662bee10a..64f6accfff 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -140,8 +140,8 @@ static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
 }
 
 static int always_equal(const void *unused_cmp_data,
-			const void *unused1,
-			const void *unused2,
+			const struct hashmap_entry *unused1,
+			const struct hashmap_entry *unused2,
 			const void *unused_keydata)
 {
 	return 0;
@@ -279,10 +279,15 @@ struct pool_entry {
 };
 
 static int pool_entry_cmp(const void *unused_cmp_data,
-			  const struct pool_entry *e1,
-			  const struct pool_entry *e2,
-			  const unsigned char *keydata)
+			  const struct hashmap_entry *eptr,
+			  const struct hashmap_entry *entry_or_key,
+			  const void *keydata)
 {
+	const struct pool_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct pool_entry, ent);
+	e2 = container_of(entry_or_key, const struct pool_entry, ent);
+
 	return e1->data != keydata &&
 	       (e1->len != e2->len || memcmp(e1->data, keydata, e1->len));
 }
@@ -294,7 +299,7 @@ const void *memintern(const void *data, size_t len)
 
 	/* initialize string pool hashmap */
 	if (!map.tablesize)
-		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, NULL, 0);
+		hashmap_init(&map, pool_entry_cmp, NULL, 0);
 
 	/* lookup interned string in pool */
 	hashmap_entry_init(&key.ent, memhash(data, len));
diff --git a/hashmap.h b/hashmap.h
index 82ddb0ef41..8f5c163d56 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -21,12 +21,16 @@
  * #define COMPARE_VALUE 1
  *
  * static int long2string_cmp(const void *hashmap_cmp_fn_data,
- *                            const struct long2string *e1,
- *                            const struct long2string *e2,
+ *                            const struct hashmap_entry *eptr,
+ *                            const struct hashmap_entry *entry_or_key,
  *                            const void *keydata)
  * {
  *     const char *string = keydata;
  *     unsigned flags = *(unsigned *)hashmap_cmp_fn_data;
+ *     const struct long2string *e1, *e2;
+ *
+ *     e1 = container_of(eptr, const struct long2string, ent);
+ *     e2 = container_of(entry_or_key, const struct long2string, ent);
  *
  *     if (flags & COMPARE_VALUE)
  *         return e1->key != e2->key ||
@@ -41,7 +45,7 @@
  *     char value[255], action[32];
  *     unsigned flags = 0;
  *
- *     hashmap_init(&map, (hashmap_cmp_fn) long2string_cmp, &flags, 0);
+ *     hashmap_init(&map, long2string_cmp, &flags, 0);
  *
  *     while (scanf("%s %ld %s", action, &key, value)) {
  *
@@ -172,7 +176,8 @@ struct hashmap_entry {
  * The `hashmap_cmp_fn_data` entry is the pointer given in the init function.
  */
 typedef int (*hashmap_cmp_fn)(const void *hashmap_cmp_fn_data,
-			      const void *entry, const void *entry_or_key,
+			      const struct hashmap_entry *entry,
+			      const struct hashmap_entry *entry_or_key,
 			      const void *keydata);
 
 /*
diff --git a/merge-recursive.c b/merge-recursive.c
index 8274828c4d..b06e9f7f0b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -35,14 +35,16 @@ struct path_hashmap_entry {
 };
 
 static int path_hashmap_cmp(const void *cmp_data,
-			    const void *entry,
-			    const void *entry_or_key,
+			    const struct hashmap_entry *eptr,
+			    const struct hashmap_entry *entry_or_key,
 			    const void *keydata)
 {
-	const struct path_hashmap_entry *a = entry;
-	const struct path_hashmap_entry *b = entry_or_key;
+	const struct path_hashmap_entry *a, *b;
 	const char *key = keydata;
 
+	a = container_of(eptr, const struct path_hashmap_entry, e);
+	b = container_of(entry_or_key, const struct path_hashmap_entry, e);
+
 	if (ignore_case)
 		return strcasecmp(a->path, key ? key : b->path);
 	else
@@ -68,12 +70,14 @@ static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
 }
 
 static int dir_rename_cmp(const void *unused_cmp_data,
-			  const void *entry,
-			  const void *entry_or_key,
+			  const struct hashmap_entry *eptr,
+			  const struct hashmap_entry *entry_or_key,
 			  const void *unused_keydata)
 {
-	const struct dir_rename_entry *e1 = entry;
-	const struct dir_rename_entry *e2 = entry_or_key;
+	const struct dir_rename_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct dir_rename_entry, ent);
+	e2 = container_of(entry_or_key, const struct dir_rename_entry, ent);
 
 	return strcmp(e1->dir, e2->dir);
 }
@@ -104,17 +108,22 @@ static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
 				struct collision_entry, ent);
 }
 
-static int collision_cmp(void *unused_cmp_data,
-			 const struct collision_entry *e1,
-			 const struct collision_entry *e2,
+static int collision_cmp(const void *unused_cmp_data,
+			 const struct hashmap_entry *eptr,
+			 const struct hashmap_entry *entry_or_key,
 			 const void *unused_keydata)
 {
+	const struct collision_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct collision_entry, ent);
+	e2 = container_of(entry_or_key, const struct collision_entry, ent);
+
 	return strcmp(e1->target_file, e2->target_file);
 }
 
 static void collision_init(struct hashmap *map)
 {
-	hashmap_init(map, (hashmap_cmp_fn) collision_cmp, NULL, 0);
+	hashmap_init(map, collision_cmp, NULL, 0);
 }
 
 static void flush_output(struct merge_options *opt)
diff --git a/name-hash.c b/name-hash.c
index aa8253ddd5..85a1ce982c 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -17,14 +17,16 @@ struct dir_entry {
 };
 
 static int dir_entry_cmp(const void *unused_cmp_data,
-			 const void *entry,
-			 const void *entry_or_key,
+			 const struct hashmap_entry *eptr,
+			 const struct hashmap_entry *entry_or_key,
 			 const void *keydata)
 {
-	const struct dir_entry *e1 = entry;
-	const struct dir_entry *e2 = entry_or_key;
+	const struct dir_entry *e1, *e2;
 	const char *name = keydata;
 
+	e1 = container_of(eptr, const struct dir_entry, ent);
+	e2 = container_of(entry_or_key, const struct dir_entry, ent);
+
 	return e1->namelen != e2->namelen || strncasecmp(e1->name,
 			name ? name : e2->name, e1->namelen);
 }
@@ -115,12 +117,15 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 }
 
 static int cache_entry_cmp(const void *unused_cmp_data,
-			   const void *entry,
-			   const void *entry_or_key,
+			   const struct hashmap_entry *eptr,
+			   const struct hashmap_entry *entry_or_key,
 			   const void *remove)
 {
-	const struct cache_entry *ce1 = entry;
-	const struct cache_entry *ce2 = entry_or_key;
+	const struct cache_entry *ce1, *ce2;
+
+	ce1 = container_of(eptr, const struct cache_entry, ent);
+	ce2 = container_of(entry_or_key, const struct cache_entry, ent);
+
 	/*
 	 * For remove_name_hash, find the exact entry (pointer equality); for
 	 * index_file_exists, find all entries with matching hash code and
diff --git a/oidmap.c b/oidmap.c
index cd22b3a8bf..4942599391 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -2,14 +2,18 @@
 #include "oidmap.h"
 
 static int oidmap_neq(const void *hashmap_cmp_fn_data,
-		      const void *entry, const void *entry_or_key,
+		      const struct hashmap_entry *e1,
+		      const struct hashmap_entry *e2,
 		      const void *keydata)
 {
-	const struct oidmap_entry *entry_ = entry;
+	const struct oidmap_entry *a, *b;
+
+	a = container_of(e1, const struct oidmap_entry, internal_entry);
+	b = container_of(e2, const struct oidmap_entry, internal_entry);
+
 	if (keydata)
-		return !oideq(&entry_->oid, (const struct object_id *) keydata);
-	return !oideq(&entry_->oid,
-		      &((const struct oidmap_entry *) entry_or_key)->oid);
+		return !oideq(&a->oid, (const struct object_id *) keydata);
+	return !oideq(&a->oid, &b->oid);
 }
 
 void oidmap_init(struct oidmap *map, size_t initial_size)
diff --git a/packfile.c b/packfile.c
index f2aa34bb49..675d5f2287 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1401,11 +1401,16 @@ static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
 }
 
 static int delta_base_cache_hash_cmp(const void *unused_cmp_data,
-				     const void *va, const void *vb,
+				     const struct hashmap_entry *va,
+				     const struct hashmap_entry *vb,
 				     const void *vkey)
 {
-	const struct delta_base_cache_entry *a = va, *b = vb;
+	const struct delta_base_cache_entry *a, *b;
 	const struct delta_base_cache_key *key = vkey;
+
+	a = container_of(va, const struct delta_base_cache_entry, ent);
+	b = container_of(vb, const struct delta_base_cache_entry, ent);
+
 	if (key)
 		return !delta_base_cache_key_eq(&a->key, key);
 	else
diff --git a/patch-ids.c b/patch-ids.c
index 176c47d967..75f8c9f1a1 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -36,14 +36,16 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
  * any significance; only that it is non-zero matters.
  */
 static int patch_id_neq(const void *cmpfn_data,
-			const void *entry,
-			const void *entry_or_key,
+			const struct hashmap_entry *eptr,
+			const struct hashmap_entry *entry_or_key,
 			const void *unused_keydata)
 {
 	/* NEEDSWORK: const correctness? */
 	struct diff_options *opt = (void *)cmpfn_data;
-	struct patch_id *a = (void *)entry;
-	struct patch_id *b = (void *)entry_or_key;
+	struct patch_id *a, *b;
+
+	a = container_of(eptr, struct patch_id, ent);
+	b = container_of(entry_or_key, struct patch_id, ent);
 
 	if (is_null_oid(&a->patch_id) &&
 	    commit_patch_id(a->commit, opt, &a->patch_id, 0, 0))
diff --git a/ref-filter.c b/ref-filter.c
index 9999426914..4613df8826 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -84,12 +84,15 @@ struct ref_to_worktree_entry {
 };
 
 static int ref_to_worktree_map_cmpfnc(const void *unused_lookupdata,
-				      const void *existing_hashmap_entry_to_test,
-				      const void *key,
+				      const struct hashmap_entry *eptr,
+				      const struct hashmap_entry *kptr,
 				      const void *keydata_aka_refname)
 {
-	const struct ref_to_worktree_entry *e = existing_hashmap_entry_to_test;
-	const struct ref_to_worktree_entry *k = key;
+	const struct ref_to_worktree_entry *e, *k;
+
+	e = container_of(eptr, const struct ref_to_worktree_entry, ent);
+	k = container_of(kptr, const struct ref_to_worktree_entry, ent);
+
 	return strcmp(e->wt->head_ref,
 		keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
 }
diff --git a/refs.c b/refs.c
index 43a95105f1..2d3eb40f39 100644
--- a/refs.c
+++ b/refs.c
@@ -1781,11 +1781,16 @@ struct ref_store_hash_entry
 };
 
 static int ref_store_hash_cmp(const void *unused_cmp_data,
-			      const void *entry, const void *entry_or_key,
+			      const struct hashmap_entry *eptr,
+			      const struct hashmap_entry *entry_or_key,
 			      const void *keydata)
 {
-	const struct ref_store_hash_entry *e1 = entry, *e2 = entry_or_key;
-	const char *name = keydata ? keydata : e2->name;
+	const struct ref_store_hash_entry *e1, *e2;
+	const char *name;
+
+	e1 = container_of(eptr, const struct ref_store_hash_entry, ent);
+	e2 = container_of(entry_or_key, const struct ref_store_hash_entry, ent);
+	name = keydata ? keydata : e2->name;
 
 	return strcmp(e1->name, name);
 }
diff --git a/remote.c b/remote.c
index ed95ae6ed6..fa9cadcfbd 100644
--- a/remote.c
+++ b/remote.c
@@ -111,14 +111,16 @@ struct remotes_hash_key {
 };
 
 static int remotes_hash_cmp(const void *unused_cmp_data,
-			    const void *entry,
-			    const void *entry_or_key,
+			    const struct hashmap_entry *eptr,
+			    const struct hashmap_entry *entry_or_key,
 			    const void *keydata)
 {
-	const struct remote *a = entry;
-	const struct remote *b = entry_or_key;
+	const struct remote *a, *b;
 	const struct remotes_hash_key *key = keydata;
 
+	a = container_of(eptr, const struct remote, ent);
+	b = container_of(entry_or_key, const struct remote, ent);
+
 	if (key)
 		return strncmp(a->name, key->str, key->len) || a->name[key->len];
 	else
diff --git a/revision.c b/revision.c
index d5f534209d..f32fbc5e2e 100644
--- a/revision.c
+++ b/revision.c
@@ -107,16 +107,21 @@ struct path_and_oids_entry {
 };
 
 static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
-			     const struct path_and_oids_entry *e1,
-			     const struct path_and_oids_entry *e2,
+			     const struct hashmap_entry *eptr,
+			     const struct hashmap_entry *entry_or_key,
 			     const void *keydata)
 {
+	const struct path_and_oids_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct path_and_oids_entry, ent);
+	e2 = container_of(entry_or_key, const struct path_and_oids_entry, ent);
+
 	return strcmp(e1->path, e2->path);
 }
 
 static void paths_and_oids_init(struct hashmap *map)
 {
-	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, NULL, 0);
+	hashmap_init(map, path_and_oids_cmp, NULL, 0);
 }
 
 static void paths_and_oids_clear(struct hashmap *map)
diff --git a/sequencer.c b/sequencer.c
index aea2cb12cc..b3e7319b55 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4440,9 +4440,14 @@ struct labels_entry {
 	char label[FLEX_ARRAY];
 };
 
-static int labels_cmp(const void *fndata, const struct labels_entry *a,
-		      const struct labels_entry *b, const void *key)
+static int labels_cmp(const void *fndata, const struct hashmap_entry *eptr,
+		      const struct hashmap_entry *entry_or_key, const void *key)
 {
+	const struct labels_entry *a, *b;
+
+	a = container_of(eptr, const struct labels_entry, entry);
+	b = container_of(entry_or_key, const struct labels_entry, entry);
+
 	return key ? strcmp(a->label, key) : strcmp(a->label, b->label);
 }
 
@@ -4573,7 +4578,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 	oidmap_init(&commit2todo, 0);
 	oidmap_init(&state.commit2label, 0);
-	hashmap_init(&state.labels, (hashmap_cmp_fn) labels_cmp, NULL, 0);
+	hashmap_init(&state.labels, labels_cmp, NULL, 0);
 	strbuf_init(&state.buf, 32);
 
 	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
@@ -5138,9 +5143,15 @@ struct subject2item_entry {
 };
 
 static int subject2item_cmp(const void *fndata,
-			    const struct subject2item_entry *a,
-			    const struct subject2item_entry *b, const void *key)
+			    const struct hashmap_entry *eptr,
+			    const struct hashmap_entry *entry_or_key,
+			    const void *key)
 {
+	const struct subject2item_entry *a, *b;
+
+	a = container_of(eptr, const struct subject2item_entry, entry);
+	b = container_of(entry_or_key, const struct subject2item_entry, entry);
+
 	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
 }
 
@@ -5173,8 +5184,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 	 * In that case, last[i] will indicate the index of the latest item to
 	 * be moved to appear after the i'th.
 	 */
-	hashmap_init(&subject2item, (hashmap_cmp_fn) subject2item_cmp,
-		     NULL, todo_list->nr);
+	hashmap_init(&subject2item, subject2item_cmp, NULL, todo_list->nr);
 	ALLOC_ARRAY(next, todo_list->nr);
 	ALLOC_ARRAY(tail, todo_list->nr);
 	ALLOC_ARRAY(subjects, todo_list->nr);
diff --git a/sub-process.c b/sub-process.c
index f2fcc16c3e..ad94f72665 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -6,12 +6,14 @@
 #include "pkt-line.h"
 
 int cmd2process_cmp(const void *unused_cmp_data,
-		    const void *entry,
-		    const void *entry_or_key,
+		    const struct hashmap_entry *eptr,
+		    const struct hashmap_entry *entry_or_key,
 		    const void *unused_keydata)
 {
-	const struct subprocess_entry *e1 = entry;
-	const struct subprocess_entry *e2 = entry_or_key;
+	const struct subprocess_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct subprocess_entry, ent);
+	e2 = container_of(entry_or_key, const struct subprocess_entry, ent);
 
 	return strcmp(e1->cmd, e2->cmd);
 }
diff --git a/sub-process.h b/sub-process.h
index 5c182fad98..0d12708b8c 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -43,8 +43,8 @@ struct subprocess_capability {
 
 /* Function to test two subprocess hashmap entries for equality. */
 int cmd2process_cmp(const void *unused_cmp_data,
-		    const void *e1,
-		    const void *e2,
+		    const struct hashmap_entry *e,
+		    const struct hashmap_entry *entry_or_key,
 		    const void *unused_keydata);
 
 /*
diff --git a/submodule-config.c b/submodule-config.c
index b031884789..5463729ab8 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -38,24 +38,28 @@ enum lookup_type {
 };
 
 static int config_path_cmp(const void *unused_cmp_data,
-			   const void *entry,
-			   const void *entry_or_key,
+			   const struct hashmap_entry *eptr,
+			   const struct hashmap_entry *entry_or_key,
 			   const void *unused_keydata)
 {
-	const struct submodule_entry *a = entry;
-	const struct submodule_entry *b = entry_or_key;
+	const struct submodule_entry *a, *b;
+
+	a = container_of(eptr, const struct submodule_entry, ent);
+	b = container_of(entry_or_key, const struct submodule_entry, ent);
 
 	return strcmp(a->config->path, b->config->path) ||
 	       !oideq(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
 }
 
 static int config_name_cmp(const void *unused_cmp_data,
-			   const void *entry,
-			   const void *entry_or_key,
+			   const struct hashmap_entry *eptr,
+			   const struct hashmap_entry *entry_or_key,
 			   const void *unused_keydata)
 {
-	const struct submodule_entry *a = entry;
-	const struct submodule_entry *b = entry_or_key;
+	const struct submodule_entry *a, *b;
+
+	a = container_of(eptr, const struct submodule_entry, ent);
+	b = container_of(entry_or_key, const struct submodule_entry, ent);
 
 	return strcmp(a->config->name, b->config->name) ||
 	       !oideq(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index e82cbfdee2..56846da64c 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -16,15 +16,17 @@ static const char *get_value(const struct test_entry *e)
 }
 
 static int test_entry_cmp(const void *cmp_data,
-			  const void *entry,
-			  const void *entry_or_key,
+			  const struct hashmap_entry *eptr,
+			  const struct hashmap_entry *entry_or_key,
 			  const void *keydata)
 {
 	const int ignore_case = cmp_data ? *((int *)cmp_data) : 0;
-	const struct test_entry *e1 = entry;
-	const struct test_entry *e2 = entry_or_key;
+	const struct test_entry *e1, *e2;
 	const char *key = keydata;
 
+	e1 = container_of(eptr, const struct test_entry, ent);
+	e2 = container_of(entry_or_key, const struct test_entry, ent);
+
 	if (ignore_case)
 		return strcasecmp(e1->key, key ? key : e2->key);
 	else
