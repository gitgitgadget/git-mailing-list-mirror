Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156302023D
	for <e@80x24.org>; Thu, 29 Jun 2017 01:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbdF2BNm (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 21:13:42 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35621 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdF2BNj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 21:13:39 -0400
Received: by mail-pg0-f51.google.com with SMTP id j186so39678123pge.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 18:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ykVin0AYDpVklKJo6B3l+CJt3PubXuPnL/DoRpS9Qp8=;
        b=X4tLMz9wCpYoCIfwQDOVo5id8IqOtmvr2gpHO6eG/noaWGbM78ON/4p4VUoX/OKGGn
         NjkkT8TGWBwuc+JTWnLZkt6eqea4IeMAkzReewUSjrjg/5VajA1XssgSHuPjthqgwkmd
         TUHETjla9l01a0PE06P9Y1aMvFZJD1QjCv7RviAZHuV3F91SXx2VwmDL00MEcrZSL04h
         8jVG+9agvjC16ubp4cC4yVEG5vaob3gDKF/UIQyilVlriOGxTWCW7sIQVLjffMqOfXT9
         fVTQQVCQehENGBqDyK1H7CRhkvRjFBQP2vR/oZxFpuq0MdniC7XprTS2Ffujfph2Q6+e
         Zr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ykVin0AYDpVklKJo6B3l+CJt3PubXuPnL/DoRpS9Qp8=;
        b=LDhEY+aUr/fW0+gwPNQORs1cFIVHle3NELdL9e1mYKuclj9lzMFsmx//dIAKAVX0w/
         s2zlyqTbgzKJYwwMrWChr3T0ErB7jYowguty9RIPtT3JF9I21kwtE0D0iOfo/0RiRagO
         pOgP7LERLIEB386lmJIKm1h059v/nM3qr7x45p8cRk/noRYxk5kxvp4vwZyU2sD9imEB
         4aKkWuwQc06scx56zPChVtnqphmkhRJct+ffbv1VYrBIWw5kkxxgAE1YB3nGDN2AQPyH
         6I0iUA5Ipn6MdsA6cnaFlSeAk6XAZLMZYf0gHKjQA8IPWo87cgEXWN8sdym5zIm7wtYR
         2HZw==
X-Gm-Message-State: AKS2vOx+/sNZapixBioH696thSbheHZyTghveRylWPJ4sx9ufZUYD1wN
        0hj0iEXODaQmeN5VyO4ong==
X-Received: by 10.84.172.131 with SMTP id n3mr15000533plb.14.1498698818273;
        Wed, 28 Jun 2017 18:13:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:18c6:2a3:5614:1523])
        by smtp.gmail.com with ESMTPSA id f85sm6707607pfj.6.2017.06.28.18.13.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 18:13:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] hashmap.h: compare function has access to a data field
Date:   Wed, 28 Jun 2017 18:13:33 -0700
Message-Id: <20170629011334.11173-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170629011334.11173-1-sbeller@google.com>
References: <20170629011334.11173-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the hashmap a common need is to have access to arbitrary data
in the compare function. A couple of times we abuse the keydata field
to pass in the data needed. This happens for example in patch-ids.c.

This patch changes the function signature of the compare function
to have one more void pointer available. The pointer given for each
invocation of the compare function must be defined in the init function
of the hashmap and is just passed through.

Documentation of this new feature is deferred to a later patch.

While at it improve the naming of the fields of all compare functions used
by hashmaps by ensuring unused parameters are prefixed with 'unused_' and
naming the parameters what they are (instead of 'unused' make it
'unused_keydata').

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c                  |  4 ++--
 builtin/describe.c      |  6 ++++--
 builtin/difftool.c      | 20 ++++++++++++--------
 builtin/fast-export.c   |  5 +++--
 config.c                |  7 +++++--
 convert.c               |  3 ++-
 diffcore-rename.c       |  2 +-
 hashmap.c               | 17 ++++++++++++-----
 hashmap.h               |  9 ++++++---
 name-hash.c             | 12 ++++++++----
 oidset.c                |  5 +++--
 patch-ids.c             |  6 ++++--
 refs.c                  |  4 ++--
 remote.c                |  7 +++++--
 sha1_file.c             |  5 +++--
 sub-process.c           |  5 +++--
 sub-process.h           |  6 ++++--
 submodule-config.c      | 10 ++++++----
 t/helper/test-hashmap.c | 15 ++++++++++-----
 19 files changed, 95 insertions(+), 53 deletions(-)

diff --git a/attr.c b/attr.c
index 37454999d2..2f51417675 100644
--- a/attr.c
+++ b/attr.c
@@ -78,7 +78,7 @@ struct attr_hash_entry {
 /* attr_hashmap comparison function */
 static int attr_hash_entry_cmp(const struct attr_hash_entry *a,
 			       const struct attr_hash_entry *b,
-			       void *unused)
+			       void *unused_keydata, void *unused_data)
 {
 	return (a->keylen != b->keylen) || strncmp(a->key, b->key, a->keylen);
 }
@@ -86,7 +86,7 @@ static int attr_hash_entry_cmp(const struct attr_hash_entry *a,
 /* Initialize an 'attr_hashmap' object */
 static void attr_hashmap_init(struct attr_hashmap *map)
 {
-	hashmap_init(&map->map, (hashmap_cmp_fn) attr_hash_entry_cmp, 0);
+	hashmap_init(&map->map, (hashmap_cmp_fn) attr_hash_entry_cmp, NULL, 0);
 }
 
 /*
diff --git a/builtin/describe.c b/builtin/describe.c
index 70eb144608..a6c5a969a0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -55,7 +55,9 @@ static const char *prio_names[] = {
 };
 
 static int commit_name_cmp(const struct commit_name *cn1,
-		const struct commit_name *cn2, const void *peeled)
+			   const struct commit_name *cn2,
+			   const void *peeled,
+			   const void *unused_data)
 {
 	return oidcmp(&cn1->peeled, peeled ? peeled : &cn2->peeled);
 }
@@ -501,7 +503,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		return cmd_name_rev(args.argc, args.argv, prefix);
 	}
 
-	hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, 0);
+	hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, NULL, 0);
 	for_each_rawref(get_name, NULL);
 	if (!names.size && !always)
 		die(_("No names found, cannot describe anything."));
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 9199227f6e..80786a95ab 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -131,7 +131,9 @@ struct working_tree_entry {
 };
 
 static int working_tree_entry_cmp(struct working_tree_entry *a,
-				  struct working_tree_entry *b, void *keydata)
+				  struct working_tree_entry *b,
+				  void *unused_keydata,
+				  void *unused_data)
 {
 	return strcmp(a->path, b->path);
 }
@@ -146,7 +148,8 @@ struct pair_entry {
 	const char path[FLEX_ARRAY];
 };
 
-static int pair_cmp(struct pair_entry *a, struct pair_entry *b, void *keydata)
+static int pair_cmp(struct pair_entry *a, struct pair_entry *b,
+		    void *unused_keydata, void *unused_data)
 {
 	return strcmp(a->path, b->path);
 }
@@ -174,7 +177,8 @@ struct path_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int path_entry_cmp(struct path_entry *a, struct path_entry *b, void *key)
+static int path_entry_cmp(struct path_entry *a, struct path_entry *b,
+			  void *key, void *unused_data)
 {
 	return strcmp(a->path, key ? key : b->path);
 }
@@ -367,9 +371,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	wtdir_len = wtdir.len;
 
 	hashmap_init(&working_tree_dups,
-		     (hashmap_cmp_fn)working_tree_entry_cmp, 0);
-	hashmap_init(&submodules, (hashmap_cmp_fn)pair_cmp, 0);
-	hashmap_init(&symlinks2, (hashmap_cmp_fn)pair_cmp, 0);
+		     (hashmap_cmp_fn)working_tree_entry_cmp, NULL, 0);
+	hashmap_init(&submodules, (hashmap_cmp_fn)pair_cmp, NULL, 0);
+	hashmap_init(&symlinks2, (hashmap_cmp_fn)pair_cmp, NULL, 0);
 
 	child.no_stdin = 1;
 	child.git_cmd = 1;
@@ -580,9 +584,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * files through the symlink.
 	 */
 	hashmap_init(&wt_modified, (hashmap_cmp_fn)path_entry_cmp,
-		     wtindex.cache_nr);
+		     NULL, wtindex.cache_nr);
 	hashmap_init(&tmp_modified, (hashmap_cmp_fn)path_entry_cmp,
-		     wtindex.cache_nr);
+		     NULL, wtindex.cache_nr);
 
 	for (i = 0; i < wtindex.cache_nr; i++) {
 		struct hashmap_entry dummy;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 12d501bfde..fa389fe252 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -94,7 +94,8 @@ struct anonymized_entry {
 };
 
 static int anonymized_entry_cmp(const void *va, const void *vb,
-				const void *data)
+				const void *unused_keydata,
+				const void *unused_data)
 {
 	const struct anonymized_entry *a = va, *b = vb;
 	return a->orig_len != b->orig_len ||
@@ -113,7 +114,7 @@ static const void *anonymize_mem(struct hashmap *map,
 	struct anonymized_entry key, *ret;
 
 	if (!map->cmpfn)
-		hashmap_init(map, anonymized_entry_cmp, 0);
+		hashmap_init(map, anonymized_entry_cmp, NULL, 0);
 
 	hashmap_entry_init(&key, memhash(orig, *len));
 	key.orig = orig;
diff --git a/config.c b/config.c
index 1cd40a5fe6..aa0198a5fd 100644
--- a/config.c
+++ b/config.c
@@ -1754,14 +1754,17 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 }
 
 static int config_set_element_cmp(const struct config_set_element *e1,
-				 const struct config_set_element *e2, const void *unused)
+				 const struct config_set_element *e2,
+				 const void *unused_keydata,
+				 const void *unused_data)
 {
 	return strcmp(e1->key, e2->key);
 }
 
 void git_configset_init(struct config_set *cs)
 {
-	hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_set_element_cmp, 0);
+	hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_set_element_cmp,
+		     NULL, 0);
 	cs->hash_initialized = 1;
 	cs->list.nr = 0;
 	cs->list.alloc = 0;
diff --git a/convert.c b/convert.c
index 7d2a519daf..deaf0ba7b3 100644
--- a/convert.c
+++ b/convert.c
@@ -583,7 +583,8 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 
 	if (!subprocess_map_initialized) {
 		subprocess_map_initialized = 1;
-		hashmap_init(&subprocess_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn) cmd2process_cmp,
+			     NULL, 0);
 		entry = NULL;
 	} else {
 		entry = (struct cmd2process *)subprocess_find_entry(&subprocess_map, cmd);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1e4678b7d7..786f389498 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -341,7 +341,7 @@ static int find_exact_renames(struct diff_options *options)
 	/* Add all sources to the hash table in reverse order, because
 	 * later on they will be retrieved in LIFO order.
 	 */
-	hashmap_init(&file_table, NULL, rename_src_nr);
+	hashmap_init(&file_table, NULL, NULL, rename_src_nr);
 	for (i = rename_src_nr-1; i >= 0; i--)
 		insert_file_table(&file_table, i, rename_src[i].p->one);
 
diff --git a/hashmap.c b/hashmap.c
index 7d1044eb5d..82d70b329b 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -95,7 +95,9 @@ static inline int entry_equals(const struct hashmap *map,
 		const struct hashmap_entry *e1, const struct hashmap_entry *e2,
 		const void *keydata)
 {
-	return (e1 == e2) || (e1->hash == e2->hash && !map->cmpfn(e1, e2, keydata));
+	return (e1 == e2) ||
+	       (e1->hash == e2->hash &&
+		!map->cmpfn(e1, e2, keydata, map->data));
 }
 
 static inline unsigned int bucket(const struct hashmap *map,
@@ -140,19 +142,23 @@ static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
 	return e;
 }
 
-static int always_equal(const void *unused1, const void *unused2, const void *unused3)
+static int always_equal(const void *unused1,
+			const void *unused2,
+			const void *unused_keydata,
+			const void *unused_data)
 {
 	return 0;
 }
 
 void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
-		size_t initial_size)
+		const void *data, size_t initial_size)
 {
 	unsigned int size = HASHMAP_INITIAL_SIZE;
 
 	memset(map, 0, sizeof(*map));
 
 	map->cmpfn = equals_function ? equals_function : always_equal;
+	map->data = data;
 
 	/* calculate initial table size and allocate the table */
 	initial_size = (unsigned int) ((uint64_t) initial_size * 100
@@ -262,7 +268,8 @@ struct pool_entry {
 
 static int pool_entry_cmp(const struct pool_entry *e1,
 			  const struct pool_entry *e2,
-			  const unsigned char *keydata)
+			  const unsigned char *keydata,
+			  const void *unused_data)
 {
 	return e1->data != keydata &&
 	       (e1->len != e2->len || memcmp(e1->data, keydata, e1->len));
@@ -275,7 +282,7 @@ const void *memintern(const void *data, size_t len)
 
 	/* initialize string pool hashmap */
 	if (!map.tablesize)
-		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, 0);
+		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, NULL, 0);
 
 	/* lookup interned string in pool */
 	hashmap_entry_init(&key, memhash(data, len));
diff --git a/hashmap.h b/hashmap.h
index de6022a3a9..1c26bbad5b 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -33,11 +33,12 @@ struct hashmap_entry {
 };
 
 typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
-		const void *keydata);
+		const void *keydata, const void *cbdata);
 
 struct hashmap {
 	struct hashmap_entry **table;
 	hashmap_cmp_fn cmpfn;
+	const void *data;
 	unsigned int size, tablesize, grow_at, shrink_at;
 	unsigned disallow_rehash : 1;
 };
@@ -50,8 +51,10 @@ struct hashmap_iter {
 
 /* hashmap functions */
 
-extern void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
-		size_t initial_size);
+extern void hashmap_init(struct hashmap *map,
+			 hashmap_cmp_fn equals_function,
+			 const void *data,
+			 size_t initial_size);
 extern void hashmap_free(struct hashmap *map, int free_entries);
 
 /* hashmap_entry functions */
diff --git a/name-hash.c b/name-hash.c
index 39309efb7f..4e9eac925a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -17,7 +17,9 @@ struct dir_entry {
 };
 
 static int dir_entry_cmp(const struct dir_entry *e1,
-		const struct dir_entry *e2, const char *name)
+			 const struct dir_entry *e2,
+			 const char *name,
+			 const void *unused_data)
 {
 	return e1->namelen != e2->namelen || strncasecmp(e1->name,
 			name ? name : e2->name, e1->namelen);
@@ -108,7 +110,9 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 }
 
 static int cache_entry_cmp(const struct cache_entry *ce1,
-		const struct cache_entry *ce2, const void *remove)
+			   const struct cache_entry *ce2,
+			   const void *remove,
+			   const void *unused_data)
 {
 	/*
 	 * For remove_name_hash, find the exact entry (pointer equality); for
@@ -571,9 +575,9 @@ static void lazy_init_name_hash(struct index_state *istate)
 	if (istate->name_hash_initialized)
 		return;
 	hashmap_init(&istate->name_hash, (hashmap_cmp_fn) cache_entry_cmp,
-			istate->cache_nr);
+			NULL, istate->cache_nr);
 	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp,
-			istate->cache_nr);
+			NULL, istate->cache_nr);
 
 	if (lookup_lazy_params(istate)) {
 		hashmap_disallow_rehash(&istate->dir_hash, 1);
diff --git a/oidset.c b/oidset.c
index ac169f05d3..f20e6e4df3 100644
--- a/oidset.c
+++ b/oidset.c
@@ -7,7 +7,8 @@ struct oidset_entry {
 };
 
 static int oidset_hashcmp(const void *va, const void *vb,
-			  const void *vkey)
+			  const void *vkey,
+			  const void *unused_data)
 {
 	const struct oidset_entry *a = va, *b = vb;
 	const struct object_id *key = vkey;
@@ -30,7 +31,7 @@ int oidset_insert(struct oidset *set, const struct object_id *oid)
 	struct oidset_entry *entry;
 
 	if (!set->map.cmpfn)
-		hashmap_init(&set->map, oidset_hashcmp, 0);
+		hashmap_init(&set->map, oidset_hashcmp, NULL, 0);
 
 	if (oidset_contains(set, oid))
 		return 1;
diff --git a/patch-ids.c b/patch-ids.c
index 9c0ab9e67a..b9b2ebbad0 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -37,6 +37,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
  */
 static int patch_id_cmp(struct patch_id *a,
 			struct patch_id *b,
+			const void *unused_keydata,
 			struct diff_options *opt)
 {
 	if (is_null_oid(&a->patch_id) &&
@@ -57,7 +58,8 @@ int init_patch_ids(struct patch_ids *ids)
 	ids->diffopts.detect_rename = 0;
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
-	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp, 256);
+	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp,
+		     &ids->diffopts, 256);
 	return 0;
 }
 
@@ -93,7 +95,7 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 	if (init_patch_id_entry(&patch, commit, ids))
 		return NULL;
 
-	return hashmap_get(&ids->patches, &patch, &ids->diffopts);
+	return hashmap_get(&ids->patches, &patch, NULL);
 }
 
 struct patch_id *add_commit_patch_id(struct commit *commit,
diff --git a/refs.c b/refs.c
index 88658ba769..71e0170feb 100644
--- a/refs.c
+++ b/refs.c
@@ -1526,7 +1526,7 @@ struct ref_store_hash_entry
 };
 
 static int ref_store_hash_cmp(const void *entry, const void *entry_or_key,
-			      const void *keydata)
+			      const void *keydata, const void *unused_data)
 {
 	const struct ref_store_hash_entry *e1 = entry, *e2 = entry_or_key;
 	const char *name = keydata ? keydata : e2->name;
@@ -1608,7 +1608,7 @@ static void register_ref_store_map(struct hashmap *map,
 				   const char *name)
 {
 	if (!map->tablesize)
-		hashmap_init(map, ref_store_hash_cmp, 0);
+		hashmap_init(map, ref_store_hash_cmp, NULL, 0);
 
 	if (hashmap_put(map, alloc_ref_store_hash_entry(name, refs)))
 		die("BUG: %s ref_store '%s' initialized twice", type, name);
diff --git a/remote.c b/remote.c
index d87482573d..b5e05890ee 100644
--- a/remote.c
+++ b/remote.c
@@ -133,7 +133,10 @@ struct remotes_hash_key {
 	int len;
 };
 
-static int remotes_hash_cmp(const struct remote *a, const struct remote *b, const struct remotes_hash_key *key)
+static int remotes_hash_cmp(const struct remote *a,
+			    const struct remote *b,
+			    const struct remotes_hash_key *key,
+			    const void *unused_data)
 {
 	if (key)
 		return strncmp(a->name, key->str, key->len) || a->name[key->len];
@@ -144,7 +147,7 @@ static int remotes_hash_cmp(const struct remote *a, const struct remote *b, cons
 static inline void init_remotes_hash(void)
 {
 	if (!remotes_hash.cmpfn)
-		hashmap_init(&remotes_hash, (hashmap_cmp_fn)remotes_hash_cmp, 0);
+		hashmap_init(&remotes_hash, (hashmap_cmp_fn)remotes_hash_cmp, NULL, 0);
 }
 
 static struct remote *make_remote(const char *name, int len)
diff --git a/sha1_file.c b/sha1_file.c
index fb1fd809dc..b748db31ed 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2390,7 +2390,8 @@ static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
 }
 
 static int delta_base_cache_hash_cmp(const void *va, const void *vb,
-				     const void *vkey)
+				     const void *vkey,
+				     const void *unused_data)
 {
 	const struct delta_base_cache_entry *a = va, *b = vb;
 	const struct delta_base_cache_key *key = vkey;
@@ -2472,7 +2473,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	list_add_tail(&ent->lru, &delta_base_cache_lru);
 
 	if (!delta_base_cache.cmpfn)
-		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, 0);
+		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, NULL, 0);
 	hashmap_entry_init(ent, pack_entry_hash(p, base_offset));
 	hashmap_add(&delta_base_cache, ent);
 }
diff --git a/sub-process.c b/sub-process.c
index 92f8aea70a..68b53cf48a 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -6,8 +6,9 @@
 #include "pkt-line.h"
 
 int cmd2process_cmp(const struct subprocess_entry *e1,
-			   const struct subprocess_entry *e2,
-			   const void *unused)
+		    const struct subprocess_entry *e2,
+		    const void *unused_keydata,
+		    const void *unused_data)
 {
 	return strcmp(e1->cmd, e2->cmd);
 }
diff --git a/sub-process.h b/sub-process.h
index d9a45cd359..a19b4d9936 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -20,8 +20,10 @@ struct subprocess_entry {
 
 /* subprocess functions */
 
-int cmd2process_cmp(const struct subprocess_entry *e1,
-	const struct subprocess_entry *e2, const void *unused);
+extern int cmd2process_cmp(const struct subprocess_entry *e1,
+			   const struct subprocess_entry *e2,
+			   const void *unused_keydata,
+			   const void *unused_data);
 
 typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
 int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
diff --git a/submodule-config.c b/submodule-config.c
index d8f8d5ea32..5c2fc489b8 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -36,7 +36,8 @@ static int is_cache_init;
 
 static int config_path_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
-			   const void *unused)
+			   const void *unused_keydata,
+			   const void *unused_data)
 {
 	return strcmp(a->config->path, b->config->path) ||
 	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
@@ -44,7 +45,8 @@ static int config_path_cmp(const struct submodule_entry *a,
 
 static int config_name_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
-			   const void *unused)
+			   const void *unused_keydata,
+			   const void *unused_data)
 {
 	return strcmp(a->config->name, b->config->name) ||
 	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
@@ -52,8 +54,8 @@ static int config_name_cmp(const struct submodule_entry *a,
 
 static void cache_init(struct submodule_cache *cache)
 {
-	hashmap_init(&cache->for_path, (hashmap_cmp_fn) config_path_cmp, 0);
-	hashmap_init(&cache->for_name, (hashmap_cmp_fn) config_name_cmp, 0);
+	hashmap_init(&cache->for_path, (hashmap_cmp_fn) config_path_cmp, NULL, 0);
+	hashmap_init(&cache->for_name, (hashmap_cmp_fn) config_name_cmp, NULL, 0);
 }
 
 static void free_one_config(struct submodule_entry *entry)
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 7aa9440e27..72cdc4a6b1 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -14,13 +14,17 @@ static const char *get_value(const struct test_entry *e)
 }
 
 static int test_entry_cmp(const struct test_entry *e1,
-		const struct test_entry *e2, const char* key)
+			  const struct test_entry *e2,
+			  const char* key,
+			  const void *unused_data)
 {
 	return strcmp(e1->key, key ? key : e2->key);
 }
 
 static int test_entry_cmp_icase(const struct test_entry *e1,
-		const struct test_entry *e2, const char* key)
+				const struct test_entry *e2,
+				const char* key,
+				const void *unused_data)
 {
 	return strcasecmp(e1->key, key ? key : e2->key);
 }
@@ -92,7 +96,8 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 	if (method & TEST_ADD) {
 		/* test adding to the map */
 		for (j = 0; j < rounds; j++) {
-			hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, 0);
+			hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp,
+				     NULL, 0);
 
 			/* add entries */
 			for (i = 0; i < TEST_SIZE; i++) {
@@ -104,7 +109,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 		}
 	} else {
 		/* test map lookups */
-		hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, 0);
+		hashmap_init(&map, (hashmap_cmp_fn) test_entry_cmp, NULL, 0);
 
 		/* fill the map (sparsely if specified) */
 		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
@@ -147,7 +152,7 @@ int cmd_main(int argc, const char **argv)
 	/* init hash map */
 	icase = argc > 1 && !strcmp("ignorecase", argv[1]);
 	hashmap_init(&map, (hashmap_cmp_fn) (icase ? test_entry_cmp_icase
-			: test_entry_cmp), 0);
+			: test_entry_cmp), NULL, 0);
 
 	/* process commands from stdin */
 	while (fgets(line, sizeof(line), stdin)) {
-- 
2.13.0.31.g9b732c453e

