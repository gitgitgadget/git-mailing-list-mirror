Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2181A201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 19:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbdF3TOS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 15:14:18 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36135 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdF3TOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 15:14:16 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so71411465pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GwBD1rlPwRYs1c+RYF349LTe4u1j1tbo7Zjxv8koFGE=;
        b=NtxG1uqNZCnIq/qQBB+SyPHWDz5QddPXCInms3tl4D3Ipp3g7Ve4gGkkSZW2nqLzdN
         ccqlWrzzF8IVEJcJxLeEw0DSGTSIxlu20eiuuHZEXiVC9WLC+QRc+LT8gjXHT7/ooGR9
         GBEbh9Lh8tUPR+gU2rLm1T7K9DLdsSxCweH6R7eZAZWGEC5qj13WmLJBGvThTkzxePlm
         OdPWzCCzpBUO3fN368nVV3QKTHhVxsYtOToC29JAVJ93xCvrP1w4D6yrAOYwpvqzVaeq
         Az7vjWgI6sE3gHCrW5cZhk83HY4j/ira2R5HOGcS8eU/2DMOoC7ZkyAJHd/EG7UWq47l
         VYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GwBD1rlPwRYs1c+RYF349LTe4u1j1tbo7Zjxv8koFGE=;
        b=Scfetl12nQjkepH39FjcaIaqMwtbQZ7ZvHrIGgXPGqQNlKYpGif/FfAGdCNbcSME6i
         2ZC3YSrF/WMLvVAiGQH1xeja0x5Z4+NoXEp92ok/WsAkkL6tEctt6Lclpebcu3ioI409
         YfAnaxNrAf6oTuRYwd+GfKe1SEBUna9RgYxcsGXcGoU7CUNgPxukmBFkRgWr+dRUNeyx
         f9prSin4/+Alevqcyd1C8abCfvRscpSFK1g66pvrvw5XQkD8zy1982Mj+VwOfdTFTgv7
         6Ri8n+mAJ5GQ86GdGbDblbIkv1x3xTU0BnqGmsegM4kEz/WQGmiYMgXP0uCq1SzjKVfQ
         7Qtg==
X-Gm-Message-State: AKS2vOwiO8n8r8Rt5pW67zAz4Z1ZzWUC7qsvoTRc3kotcof2+PBRrSaR
        g1cYCUVbd/visCwD
X-Received: by 10.84.229.69 with SMTP id d5mr25656388pln.197.1498850054955;
        Fri, 30 Jun 2017 12:14:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id g15sm18914980pfe.70.2017.06.30.12.14.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 12:14:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com
Subject: [PATCHv3 1/3] hashmap.h: compare function has access to a data field
Date:   Fri, 30 Jun 2017 12:14:05 -0700
Message-Id: <20170630191407.5381-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630191407.5381-1-sbeller@google.com>
References: <20170629235336.28460-1-sbeller@google.com>
 <20170630191407.5381-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the hashmap a common need is to have access to caller provided
data in the compare function. A couple of times we abuse the keydata field
to pass in the data needed. This happens for example in patch-ids.c.

This patch changes the function signature of the compare function
to have one more void pointer available. The pointer given for each
invocation of the compare function must be defined in the init function
of the hashmap and is just passed through.

Documentation of this new feature is deferred to a later patch.
This is a rather mechanical conversion, just adding the new pass-through
parameter.  However while at it improve the naming of the fields of all
compare functions used by hashmaps by ensuring unused parameters are
prefixed with 'unused_' and naming the parameters what they are (instead
of 'unused' make it 'unused_keydata').

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c                  |  7 ++++---
 builtin/describe.c      |  8 +++++---
 builtin/difftool.c      | 24 +++++++++++++++---------
 builtin/fast-export.c   |  7 ++++---
 config.c                |  9 ++++++---
 convert.c               |  3 ++-
 diffcore-rename.c       |  2 +-
 hashmap.c               | 17 ++++++++++++-----
 hashmap.h               | 12 ++++++++----
 name-hash.c             | 16 ++++++++++------
 oidset.c                |  5 +++--
 patch-ids.c             |  6 ++++--
 refs.c                  |  5 +++--
 remote.c                |  7 +++++--
 sha1_file.c             |  5 +++--
 sub-process.c           |  7 ++++---
 sub-process.h           |  6 ++++--
 submodule-config.c      | 14 ++++++++------
 t/helper/test-hashmap.c | 19 ++++++++++++-------
 19 files changed, 113 insertions(+), 66 deletions(-)

diff --git a/attr.c b/attr.c
index 37454999d2..56961f0236 100644
--- a/attr.c
+++ b/attr.c
@@ -76,9 +76,10 @@ struct attr_hash_entry {
 };
 
 /* attr_hashmap comparison function */
-static int attr_hash_entry_cmp(const struct attr_hash_entry *a,
+static int attr_hash_entry_cmp(void *unused_cmp_data,
+			       const struct attr_hash_entry *a,
 			       const struct attr_hash_entry *b,
-			       void *unused)
+			       void *unused_keydata)
 {
 	return (a->keylen != b->keylen) || strncmp(a->key, b->key, a->keylen);
 }
@@ -86,7 +87,7 @@ static int attr_hash_entry_cmp(const struct attr_hash_entry *a,
 /* Initialize an 'attr_hashmap' object */
 static void attr_hashmap_init(struct attr_hashmap *map)
 {
-	hashmap_init(&map->map, (hashmap_cmp_fn) attr_hash_entry_cmp, 0);
+	hashmap_init(&map->map, (hashmap_cmp_fn) attr_hash_entry_cmp, NULL, 0);
 }
 
 /*
diff --git a/builtin/describe.c b/builtin/describe.c
index 70eb144608..8868f00ed0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -54,8 +54,10 @@ static const char *prio_names[] = {
 	N_("head"), N_("lightweight"), N_("annotated"),
 };
 
-static int commit_name_cmp(const struct commit_name *cn1,
-		const struct commit_name *cn2, const void *peeled)
+static int commit_name_cmp(const void *unused_cmp_data,
+			   const struct commit_name *cn1,
+			   const struct commit_name *cn2,
+			   const void *peeled)
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
index 9199227f6e..a1a26ba891 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -130,8 +130,10 @@ struct working_tree_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int working_tree_entry_cmp(struct working_tree_entry *a,
-				  struct working_tree_entry *b, void *keydata)
+static int working_tree_entry_cmp(const void *unused_cmp_data,
+				  struct working_tree_entry *a,
+				  struct working_tree_entry *b,
+				  void *unused_keydata)
 {
 	return strcmp(a->path, b->path);
 }
@@ -146,7 +148,9 @@ struct pair_entry {
 	const char path[FLEX_ARRAY];
 };
 
-static int pair_cmp(struct pair_entry *a, struct pair_entry *b, void *keydata)
+static int pair_cmp(const void *unused_cmp_data,
+		    struct pair_entry *a, struct pair_entry *b,
+		    void *unused_keydata)
 {
 	return strcmp(a->path, b->path);
 }
@@ -174,7 +178,9 @@ struct path_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int path_entry_cmp(struct path_entry *a, struct path_entry *b, void *key)
+static int path_entry_cmp(const void *unused_cmp_data,
+			  struct path_entry *a, struct path_entry *b,
+			  void *key)
 {
 	return strcmp(a->path, key ? key : b->path);
 }
@@ -367,9 +373,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
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
@@ -580,9 +586,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
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
index 12d501bfde..d412c0a8f3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -93,8 +93,9 @@ struct anonymized_entry {
 	size_t anon_len;
 };
 
-static int anonymized_entry_cmp(const void *va, const void *vb,
-				const void *data)
+static int anonymized_entry_cmp(const void *unused_cmp_data,
+				const void *va, const void *vb,
+				const void *unused_keydata)
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
index 1cd40a5fe6..4a31e31ac3 100644
--- a/config.c
+++ b/config.c
@@ -1753,15 +1753,18 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	return 0;
 }
 
-static int config_set_element_cmp(const struct config_set_element *e1,
-				 const struct config_set_element *e2, const void *unused)
+static int config_set_element_cmp(const void *unused_cmp_data,
+				  const struct config_set_element *e1,
+				  const struct config_set_element *e2,
+				  const void *unused_keydata)
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
index 7d1044eb5d..9b6a12859b 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -95,7 +95,9 @@ static inline int entry_equals(const struct hashmap *map,
 		const struct hashmap_entry *e1, const struct hashmap_entry *e2,
 		const void *keydata)
 {
-	return (e1 == e2) || (e1->hash == e2->hash && !map->cmpfn(e1, e2, keydata));
+	return (e1 == e2) ||
+	       (e1->hash == e2->hash &&
+		!map->cmpfn(map->cmpfn_data, e1, e2, keydata));
 }
 
 static inline unsigned int bucket(const struct hashmap *map,
@@ -140,19 +142,23 @@ static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
 	return e;
 }
 
-static int always_equal(const void *unused1, const void *unused2, const void *unused3)
+static int always_equal(const void *unused_cmp_data,
+			const void *unused1,
+			const void *unused2,
+			const void *unused_keydata)
 {
 	return 0;
 }
 
 void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
-		size_t initial_size)
+		const void *cmpfn_data, size_t initial_size)
 {
 	unsigned int size = HASHMAP_INITIAL_SIZE;
 
 	memset(map, 0, sizeof(*map));
 
 	map->cmpfn = equals_function ? equals_function : always_equal;
+	map->cmpfn_data = cmpfn_data;
 
 	/* calculate initial table size and allocate the table */
 	initial_size = (unsigned int) ((uint64_t) initial_size * 100
@@ -260,7 +266,8 @@ struct pool_entry {
 	unsigned char data[FLEX_ARRAY];
 };
 
-static int pool_entry_cmp(const struct pool_entry *e1,
+static int pool_entry_cmp(const void *unused_cmp_data,
+			  const struct pool_entry *e1,
 			  const struct pool_entry *e2,
 			  const unsigned char *keydata)
 {
@@ -275,7 +282,7 @@ const void *memintern(const void *data, size_t len)
 
 	/* initialize string pool hashmap */
 	if (!map.tablesize)
-		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, 0);
+		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, NULL, 0);
 
 	/* lookup interned string in pool */
 	hashmap_entry_init(&key, memhash(data, len));
diff --git a/hashmap.h b/hashmap.h
index de6022a3a9..aaf09e047e 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -32,12 +32,14 @@ struct hashmap_entry {
 	unsigned int hash;
 };
 
-typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
-		const void *keydata);
+typedef int (*hashmap_cmp_fn)(const void *hashmap_cmp_fn_data,
+			      const void *entry, const void *entry_or_key,
+			      const void *keydata);
 
 struct hashmap {
 	struct hashmap_entry **table;
 	hashmap_cmp_fn cmpfn;
+	const void *cmpfn_data;
 	unsigned int size, tablesize, grow_at, shrink_at;
 	unsigned disallow_rehash : 1;
 };
@@ -50,8 +52,10 @@ struct hashmap_iter {
 
 /* hashmap functions */
 
-extern void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
-		size_t initial_size);
+extern void hashmap_init(struct hashmap *map,
+			 hashmap_cmp_fn equals_function,
+			 const void *equals_function_data,
+			 size_t initial_size);
 extern void hashmap_free(struct hashmap *map, int free_entries);
 
 /* hashmap_entry functions */
diff --git a/name-hash.c b/name-hash.c
index 39309efb7f..0e10f3eab8 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -16,8 +16,10 @@ struct dir_entry {
 	char name[FLEX_ARRAY];
 };
 
-static int dir_entry_cmp(const struct dir_entry *e1,
-		const struct dir_entry *e2, const char *name)
+static int dir_entry_cmp(const void *unused_cmp_data,
+			 const struct dir_entry *e1,
+			 const struct dir_entry *e2,
+			 const char *name)
 {
 	return e1->namelen != e2->namelen || strncasecmp(e1->name,
 			name ? name : e2->name, e1->namelen);
@@ -107,8 +109,10 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		add_dir_entry(istate, ce);
 }
 
-static int cache_entry_cmp(const struct cache_entry *ce1,
-		const struct cache_entry *ce2, const void *remove)
+static int cache_entry_cmp(const void *unused_cmp_data,
+			   const struct cache_entry *ce1,
+			   const struct cache_entry *ce2,
+			   const void *remove)
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
index ac169f05d3..a6a08ba52a 100644
--- a/oidset.c
+++ b/oidset.c
@@ -6,7 +6,8 @@ struct oidset_entry {
 	struct object_id oid;
 };
 
-static int oidset_hashcmp(const void *va, const void *vb,
+static int oidset_hashcmp(const void *unused_cmp_data,
+			  const void *va, const void *vb,
 			  const void *vkey)
 {
 	const struct oidset_entry *a = va, *b = vb;
@@ -30,7 +31,7 @@ int oidset_insert(struct oidset *set, const struct object_id *oid)
 	struct oidset_entry *entry;
 
 	if (!set->map.cmpfn)
-		hashmap_init(&set->map, oidset_hashcmp, 0);
+		hashmap_init(&set->map, oidset_hashcmp, NULL, 0);
 
 	if (oidset_contains(set, oid))
 		return 1;
diff --git a/patch-ids.c b/patch-ids.c
index 9c0ab9e67a..815c115811 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -35,7 +35,8 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
  * the side of safety.  The actual value being negative does not have
  * any significance; only that it is non-zero matters.
  */
-static int patch_id_cmp(struct patch_id *a,
+static int patch_id_cmp(const void *unused_cmp_data,
+			struct patch_id *a,
 			struct patch_id *b,
 			struct diff_options *opt)
 {
@@ -57,7 +58,8 @@ int init_patch_ids(struct patch_ids *ids)
 	ids->diffopts.detect_rename = 0;
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
-	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp, 256);
+	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp,
+		     NULL, 256);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index 88658ba769..eef1a7b67d 100644
--- a/refs.c
+++ b/refs.c
@@ -1525,7 +1525,8 @@ struct ref_store_hash_entry
 	char name[FLEX_ARRAY];
 };
 
-static int ref_store_hash_cmp(const void *entry, const void *entry_or_key,
+static int ref_store_hash_cmp(const void *unused_cmp_data,
+			      const void *entry, const void *entry_or_key,
 			      const void *keydata)
 {
 	const struct ref_store_hash_entry *e1 = entry, *e2 = entry_or_key;
@@ -1608,7 +1609,7 @@ static void register_ref_store_map(struct hashmap *map,
 				   const char *name)
 {
 	if (!map->tablesize)
-		hashmap_init(map, ref_store_hash_cmp, 0);
+		hashmap_init(map, ref_store_hash_cmp, NULL, 0);
 
 	if (hashmap_put(map, alloc_ref_store_hash_entry(name, refs)))
 		die("BUG: %s ref_store '%s' initialized twice", type, name);
diff --git a/remote.c b/remote.c
index d87482573d..60d0043921 100644
--- a/remote.c
+++ b/remote.c
@@ -133,7 +133,10 @@ struct remotes_hash_key {
 	int len;
 };
 
-static int remotes_hash_cmp(const struct remote *a, const struct remote *b, const struct remotes_hash_key *key)
+static int remotes_hash_cmp(const void *unused_cmp_data,
+			    const struct remote *a,
+			    const struct remote *b,
+			    const struct remotes_hash_key *key)
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
index fb1fd809dc..8c523a5b74 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2389,7 +2389,8 @@ static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
 	return a->p == b->p && a->base_offset == b->base_offset;
 }
 
-static int delta_base_cache_hash_cmp(const void *va, const void *vb,
+static int delta_base_cache_hash_cmp(const void *unused_cmp_data,
+				     const void *va, const void *vb,
 				     const void *vkey)
 {
 	const struct delta_base_cache_entry *a = va, *b = vb;
@@ -2472,7 +2473,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	list_add_tail(&ent->lru, &delta_base_cache_lru);
 
 	if (!delta_base_cache.cmpfn)
-		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, 0);
+		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, NULL, 0);
 	hashmap_entry_init(ent, pack_entry_hash(p, base_offset));
 	hashmap_add(&delta_base_cache, ent);
 }
diff --git a/sub-process.c b/sub-process.c
index 92f8aea70a..a3cfab1a9d 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -5,9 +5,10 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 
-int cmd2process_cmp(const struct subprocess_entry *e1,
-			   const struct subprocess_entry *e2,
-			   const void *unused)
+int cmd2process_cmp(const void *unused_cmp_data,
+		    const struct subprocess_entry *e1,
+		    const struct subprocess_entry *e2,
+		    const void *unused_keydata)
 {
 	return strcmp(e1->cmd, e2->cmd);
 }
diff --git a/sub-process.h b/sub-process.h
index d9a45cd359..96a2cca360 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -20,8 +20,10 @@ struct subprocess_entry {
 
 /* subprocess functions */
 
-int cmd2process_cmp(const struct subprocess_entry *e1,
-	const struct subprocess_entry *e2, const void *unused);
+extern int cmd2process_cmp(const void *unused_cmp_data,
+			   const struct subprocess_entry *e1,
+			   const struct subprocess_entry *e2,
+			   const void *unused_keydata);
 
 typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
 int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
diff --git a/submodule-config.c b/submodule-config.c
index d8f8d5ea32..0e1126183d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -34,17 +34,19 @@ enum lookup_type {
 static struct submodule_cache the_submodule_cache;
 static int is_cache_init;
 
-static int config_path_cmp(const struct submodule_entry *a,
+static int config_path_cmp(const void *unused_cmp_data,
+			   const struct submodule_entry *a,
 			   const struct submodule_entry *b,
-			   const void *unused)
+			   const void *unused_keydata)
 {
 	return strcmp(a->config->path, b->config->path) ||
 	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
 }
 
-static int config_name_cmp(const struct submodule_entry *a,
+static int config_name_cmp(const void *unused_cmp_data,
+			   const struct submodule_entry *a,
 			   const struct submodule_entry *b,
-			   const void *unused)
+			   const void *unused_keydata)
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
index 7aa9440e27..095d7395f3 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -13,14 +13,18 @@ static const char *get_value(const struct test_entry *e)
 	return e->key + strlen(e->key) + 1;
 }
 
-static int test_entry_cmp(const struct test_entry *e1,
-		const struct test_entry *e2, const char* key)
+static int test_entry_cmp(const void *unused_cmp_data,
+			  const struct test_entry *e1,
+			  const struct test_entry *e2,
+			  const char* key)
 {
 	return strcmp(e1->key, key ? key : e2->key);
 }
 
-static int test_entry_cmp_icase(const struct test_entry *e1,
-		const struct test_entry *e2, const char* key)
+static int test_entry_cmp_icase(const void *unused_cmp_data,
+				const struct test_entry *e1,
+				const struct test_entry *e2,
+				const char* key)
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

