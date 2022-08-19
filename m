Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E2C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348335AbiHSKJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348336AbiHSKI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92099B2480
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:48 -0700 (PDT)
Received: (qmail 17678 invoked by uid 109); 19 Aug 2022 10:08:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 940 invoked by uid 111); 19 Aug 2022 10:08:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/11] hashmap: mark unused callback parameters
Message-ID: <Yv9hLg3lGQIMZMG1@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hashmap comparison functions must conform to a particular callback
interface, but many don't use all of their parameters. Especially the
void cmp_data pointer, but some do not use keydata either (because they
can easily form a full struct to pass when doing lookups). Let's mark
these to make -Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c     |  2 +-
 attr.c                |  4 ++--
 bloom.c               |  4 ++--
 builtin/describe.c    |  2 +-
 builtin/difftool.c    | 10 +++++-----
 builtin/fast-export.c |  2 +-
 builtin/fast-import.c |  2 +-
 builtin/fetch.c       |  2 +-
 compat/terminal.c     |  2 +-
 config.c              |  4 ++--
 diff.c                |  2 +-
 dir.c                 |  4 ++--
 environment.c         |  4 ++--
 hashmap.c             | 10 +++++-----
 merge-recursive.c     | 10 +++++-----
 name-hash.c           |  4 ++--
 object-store.h        |  2 +-
 oidmap.c              |  2 +-
 packfile.c            |  2 +-
 patch-ids.c           |  2 +-
 range-diff.c          |  6 ++++--
 ref-filter.c          |  2 +-
 refs.c                |  2 +-
 remote.c              |  4 ++--
 revision.c            |  4 ++--
 sequencer.c           |  5 +++--
 strmap.c              |  4 ++--
 sub-process.c         |  4 ++--
 submodule-config.c    |  8 ++++----
 29 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 22fcd3412c..2fcad67654 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -430,7 +430,7 @@ struct pathname_entry {
 	struct file_item *item;
 };
 
-static int pathname_entry_cmp(const void *unused_cmp_data,
+static int pathname_entry_cmp(const void *UNUSED(cmp_data),
 			      const struct hashmap_entry *he1,
 			      const struct hashmap_entry *he2,
 			      const void *name)
diff --git a/attr.c b/attr.c
index 8a78dde69e..63e1a756dd 100644
--- a/attr.c
+++ b/attr.c
@@ -61,10 +61,10 @@ struct attr_hash_entry {
 };
 
 /* attr_hashmap comparison function */
-static int attr_hash_entry_cmp(const void *unused_cmp_data,
+static int attr_hash_entry_cmp(const void *UNUSED(cmp_data),
 			       const struct hashmap_entry *eptr,
 			       const struct hashmap_entry *entry_or_key,
-			       const void *unused_keydata)
+			       const void *UNUSED(keydata))
 {
 	const struct attr_hash_entry *a, *b;
 
diff --git a/bloom.c b/bloom.c
index 816f063dca..94fb97e60e 100644
--- a/bloom.c
+++ b/bloom.c
@@ -163,10 +163,10 @@ void init_bloom_filters(void)
 	init_bloom_filter_slab(&bloom_filters);
 }
 
-static int pathmap_cmp(const void *hashmap_cmp_fn_data,
+static int pathmap_cmp(const void *UNUSED(hashmap_cmp_fn_data),
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
-		       const void *keydata)
+		       const void *UNUSED(keydata))
 {
 	const struct pathmap_hash_entry *e1, *e2;
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 3af36483f2..084fa00f2a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -63,7 +63,7 @@ static const char *prio_names[] = {
 	N_("head"), N_("lightweight"), N_("annotated"),
 };
 
-static int commit_name_neq(const void *unused_cmp_data,
+static int commit_name_neq(const void *UNUSED(cmp_data),
 			   const struct hashmap_entry *eptr,
 			   const struct hashmap_entry *entry_or_key,
 			   const void *peeled)
diff --git a/builtin/difftool.c b/builtin/difftool.c
index b3c509b8de..a570200e66 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -125,10 +125,10 @@ struct working_tree_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int working_tree_entry_cmp(const void *unused_cmp_data,
+static int working_tree_entry_cmp(const void *UNUSED(cmp_data),
 				  const struct hashmap_entry *eptr,
 				  const struct hashmap_entry *entry_or_key,
-				  const void *unused_keydata)
+				  const void *UNUSED(keydata))
 {
 	const struct working_tree_entry *a, *b;
 
@@ -148,10 +148,10 @@ struct pair_entry {
 	const char path[FLEX_ARRAY];
 };
 
-static int pair_cmp(const void *unused_cmp_data,
+static int pair_cmp(const void *UNUSED(cmp_data),
 		    const struct hashmap_entry *eptr,
 		    const struct hashmap_entry *entry_or_key,
-		    const void *unused_keydata)
+		    const void *UNUSED(keydata))
 {
 	const struct pair_entry *a, *b;
 
@@ -184,7 +184,7 @@ struct path_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int path_entry_cmp(const void *unused_cmp_data,
+static int path_entry_cmp(const void *UNUSED(cmp_data),
 			  const struct hashmap_entry *eptr,
 			  const struct hashmap_entry *entry_or_key,
 			  const void *key)
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e1748fb98b..bb05b50a5a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -119,7 +119,7 @@ struct anonymized_entry_key {
 	size_t orig_len;
 };
 
-static int anonymized_entry_cmp(const void *unused_cmp_data,
+static int anonymized_entry_cmp(const void *UNUSED(cmp_data),
 				const struct hashmap_entry *eptr,
 				const struct hashmap_entry *entry_or_key,
 				const void *keydata)
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 14113cfd82..76ed0c2db9 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -46,7 +46,7 @@ struct object_entry {
 		depth : DEPTH_BITS;
 };
 
-static int object_entry_hashcmp(const void *map_data,
+static int object_entry_hashcmp(const void *UNUSED(map_data),
 				const struct hashmap_entry *eptr,
 				const struct hashmap_entry *entry_or_key,
 				const void *keydata)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9e7c8099fe..5fddaef480 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -301,7 +301,7 @@ struct refname_hash_entry {
 	char refname[FLEX_ARRAY];
 };
 
-static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data,
+static int refname_hash_entry_cmp(const void *UNUSED(hashmap_cmp_fn_data),
 				  const struct hashmap_entry *eptr,
 				  const struct hashmap_entry *entry_or_key,
 				  const void *keydata)
diff --git a/compat/terminal.c b/compat/terminal.c
index 7db330c52d..0b0caae857 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -477,7 +477,7 @@ struct escape_sequence_entry {
 	char sequence[FLEX_ARRAY];
 };
 
-static int sequence_entry_cmp(const void *hashmap_cmp_fn_data,
+static int sequence_entry_cmp(const void *UNUSED(hashmap_cmp_fn_data),
 			      const struct escape_sequence_entry *e1,
 			      const struct escape_sequence_entry *e2,
 			      const void *keydata)
diff --git a/config.c b/config.c
index 589dec9028..c92f1efd6b 100644
--- a/config.c
+++ b/config.c
@@ -2338,10 +2338,10 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	return 0;
 }
 
-static int config_set_element_cmp(const void *unused_cmp_data,
+static int config_set_element_cmp(const void *UNUSED(cmp_data),
 				  const struct hashmap_entry *eptr,
 				  const struct hashmap_entry *entry_or_key,
-				  const void *unused_keydata)
+				  const void *UNUSED(keydata))
 {
 	const struct config_set_element *e1, *e2;
 
diff --git a/diff.c b/diff.c
index 8a9c9083f3..7c7d53d277 100644
--- a/diff.c
+++ b/diff.c
@@ -917,7 +917,7 @@ struct interned_diff_symbol {
 static int interned_diff_symbol_cmp(const void *hashmap_cmp_fn_data,
 				    const struct hashmap_entry *eptr,
 				    const struct hashmap_entry *entry_or_key,
-				    const void *keydata)
+				    const void *UNUSED(keydata))
 {
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
 	const struct emitted_diff_symbol *a, *b;
diff --git a/dir.c b/dir.c
index 50eeb8b11e..e8b225eed4 100644
--- a/dir.c
+++ b/dir.c
@@ -655,10 +655,10 @@ void parse_path_pattern(const char **pattern,
 	*patternlen = len;
 }
 
-int pl_hashmap_cmp(const void *unused_cmp_data,
+int pl_hashmap_cmp(const void *UNUSED(cmp_data),
 		   const struct hashmap_entry *a,
 		   const struct hashmap_entry *b,
-		   const void *key)
+		   const void *UNUSED(key))
 {
 	const struct pattern_entry *ee1 =
 			container_of(a, struct pattern_entry, ent);
diff --git a/environment.c b/environment.c
index b3296ce7d1..a0ceb6d655 100644
--- a/environment.c
+++ b/environment.c
@@ -333,10 +333,10 @@ static void set_git_dir_1(const char *path)
 	setup_git_env(path);
 }
 
-static void update_relative_gitdir(const char *name,
+static void update_relative_gitdir(const char *UNUSED(name),
 				   const char *old_cwd,
 				   const char *new_cwd,
-				   void *data)
+				   void *UNUSED(data))
 {
 	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
 	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
diff --git a/hashmap.c b/hashmap.c
index 134d2eec80..763aa1d8a3 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -142,10 +142,10 @@ static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
 	return e;
 }
 
-static int always_equal(const void *unused_cmp_data,
-			const struct hashmap_entry *unused1,
-			const struct hashmap_entry *unused2,
-			const void *unused_keydata)
+static int always_equal(const void *UNUSED(cmp_data),
+			const struct hashmap_entry *UNUSED(entry1),
+			const struct hashmap_entry *UNUSED(entry2),
+			const void *UNUSED(keydata))
 {
 	return 0;
 }
@@ -313,7 +313,7 @@ struct pool_entry {
 	unsigned char data[FLEX_ARRAY];
 };
 
-static int pool_entry_cmp(const void *unused_cmp_data,
+static int pool_entry_cmp(const void *UNUSED(cmp_data),
 			  const struct hashmap_entry *eptr,
 			  const struct hashmap_entry *entry_or_key,
 			  const void *keydata)
diff --git a/merge-recursive.c b/merge-recursive.c
index b83a129b43..775ebe2182 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -45,7 +45,7 @@ struct path_hashmap_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int path_hashmap_cmp(const void *cmp_data,
+static int path_hashmap_cmp(const void *UNUSED(cmp_data),
 			    const struct hashmap_entry *eptr,
 			    const struct hashmap_entry *entry_or_key,
 			    const void *keydata)
@@ -89,10 +89,10 @@ static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
 	return hashmap_get_entry(hashmap, &key, ent, NULL);
 }
 
-static int dir_rename_cmp(const void *unused_cmp_data,
+static int dir_rename_cmp(const void *UNUSED(cmp_data),
 			  const struct hashmap_entry *eptr,
 			  const struct hashmap_entry *entry_or_key,
-			  const void *unused_keydata)
+			  const void *UNUSED(keydata))
 {
 	const struct dir_rename_entry *e1, *e2;
 
@@ -134,10 +134,10 @@ static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
 	return hashmap_get_entry(hashmap, &key, ent, NULL);
 }
 
-static int collision_cmp(const void *unused_cmp_data,
+static int collision_cmp(const void *UNUSED(cmp_data),
 			 const struct hashmap_entry *eptr,
 			 const struct hashmap_entry *entry_or_key,
-			 const void *unused_keydata)
+			 const void *UNUSED(keydata))
 {
 	const struct collision_entry *e1, *e2;
 
diff --git a/name-hash.c b/name-hash.c
index 7487d33124..d0da6db564 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -18,7 +18,7 @@ struct dir_entry {
 	char name[FLEX_ARRAY];
 };
 
-static int dir_entry_cmp(const void *unused_cmp_data,
+static int dir_entry_cmp(const void *UNUSED(cmp_data),
 			 const struct hashmap_entry *eptr,
 			 const struct hashmap_entry *entry_or_key,
 			 const void *keydata)
@@ -120,7 +120,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		add_dir_entry(istate, ce);
 }
 
-static int cache_entry_cmp(const void *unused_cmp_data,
+static int cache_entry_cmp(const void *UNUSED(cmp_data),
 			   const struct hashmap_entry *eptr,
 			   const struct hashmap_entry *entry_or_key,
 			   const void *remove)
diff --git a/object-store.h b/object-store.h
index 5222ee5460..cf5494af80 100644
--- a/object-store.h
+++ b/object-store.h
@@ -141,7 +141,7 @@ struct packed_git {
 
 struct multi_pack_index;
 
-static inline int pack_map_entry_cmp(const void *unused_cmp_data,
+static inline int pack_map_entry_cmp(const void *UNUSED(cmp_data),
 				     const struct hashmap_entry *entry,
 				     const struct hashmap_entry *entry2,
 				     const void *keydata)
diff --git a/oidmap.c b/oidmap.c
index 286a04a53c..32aeb0526f 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "oidmap.h"
 
-static int oidmap_neq(const void *hashmap_cmp_fn_data,
+static int oidmap_neq(const void *UNUSED(hashmap_cmp_fn_data),
 		      const struct hashmap_entry *e1,
 		      const struct hashmap_entry *e2,
 		      const void *keydata)
diff --git a/packfile.c b/packfile.c
index 5ae3ce8ea9..d7cf8382de 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1392,7 +1392,7 @@ static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
 	return a->p == b->p && a->base_offset == b->base_offset;
 }
 
-static int delta_base_cache_hash_cmp(const void *unused_cmp_data,
+static int delta_base_cache_hash_cmp(const void *UNUSED(cmp_data),
 				     const struct hashmap_entry *va,
 				     const struct hashmap_entry *vb,
 				     const void *vkey)
diff --git a/patch-ids.c b/patch-ids.c
index 8bf425555d..cdfa513549 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -38,7 +38,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 static int patch_id_neq(const void *cmpfn_data,
 			const struct hashmap_entry *eptr,
 			const struct hashmap_entry *entry_or_key,
-			const void *unused_keydata)
+			const void *UNUSED(keydata))
 {
 	/* NEEDSWORK: const correctness? */
 	struct diff_options *opt = (void *)cmpfn_data;
diff --git a/range-diff.c b/range-diff.c
index f63b3ffc20..1528fdd0db 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -224,8 +224,10 @@ static int read_patches(const char *range, struct string_list *list,
 	return ret;
 }
 
-static int patch_util_cmp(const void *dummy, const struct patch_util *a,
-			  const struct patch_util *b, const char *keydata)
+static int patch_util_cmp(const void *UNUSED(cmp_data),
+			  const struct patch_util *a,
+			  const struct patch_util *b,
+			  const char *keydata)
 {
 	return strcmp(a->diff, keydata ? keydata : b->diff);
 }
diff --git a/ref-filter.c b/ref-filter.c
index bdf39fa761..baf252b77d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -89,7 +89,7 @@ struct ref_to_worktree_entry {
 	struct worktree *wt; /* key is wt->head_ref */
 };
 
-static int ref_to_worktree_map_cmpfnc(const void *unused_lookupdata,
+static int ref_to_worktree_map_cmpfnc(const void *UNUSED(lookupdata),
 				      const struct hashmap_entry *eptr,
 				      const struct hashmap_entry *kptr,
 				      const void *keydata_aka_refname)
diff --git a/refs.c b/refs.c
index 38b1165189..5012bba357 100644
--- a/refs.c
+++ b/refs.c
@@ -1815,7 +1815,7 @@ struct ref_store_hash_entry
 	char name[FLEX_ARRAY];
 };
 
-static int ref_store_hash_cmp(const void *unused_cmp_data,
+static int ref_store_hash_cmp(const void *UNUSED(cmp_data),
 			      const struct hashmap_entry *eptr,
 			      const struct hashmap_entry *entry_or_key,
 			      const void *keydata)
diff --git a/remote.c b/remote.c
index 029fc630b9..ef12aba91d 100644
--- a/remote.c
+++ b/remote.c
@@ -86,7 +86,7 @@ struct remotes_hash_key {
 	int len;
 };
 
-static int remotes_hash_cmp(const void *unused_cmp_data,
+static int remotes_hash_cmp(const void *UNUSED(cmp_data),
 			    const struct hashmap_entry *eptr,
 			    const struct hashmap_entry *entry_or_key,
 			    const void *keydata)
@@ -170,7 +170,7 @@ struct branches_hash_key {
 	int len;
 };
 
-static int branches_hash_cmp(const void *unused_cmp_data,
+static int branches_hash_cmp(const void *UNUSED(cmp_data),
 			     const struct hashmap_entry *eptr,
 			     const struct hashmap_entry *entry_or_key,
 			     const void *keydata)
diff --git a/revision.c b/revision.c
index 6c7250d6a8..5eb71e32d0 100644
--- a/revision.c
+++ b/revision.c
@@ -119,10 +119,10 @@ struct path_and_oids_entry {
 	struct oidset trees;
 };
 
-static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
+static int path_and_oids_cmp(const void *UNUSED(hashmap_cmp_fn_data),
 			     const struct hashmap_entry *eptr,
 			     const struct hashmap_entry *entry_or_key,
-			     const void *keydata)
+			     const void *UNUSED(keydata))
 {
 	const struct path_and_oids_entry *e1, *e2;
 
diff --git a/sequencer.c b/sequencer.c
index 5f22b7cd37..e5b52651f8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5254,7 +5254,8 @@ struct labels_entry {
 	char label[FLEX_ARRAY];
 };
 
-static int labels_cmp(const void *fndata, const struct hashmap_entry *eptr,
+static int labels_cmp(const void *UNUSED(fndata),
+		      const struct hashmap_entry *eptr,
 		      const struct hashmap_entry *entry_or_key, const void *key)
 {
 	const struct labels_entry *a, *b;
@@ -6131,7 +6132,7 @@ struct subject2item_entry {
 	char subject[FLEX_ARRAY];
 };
 
-static int subject2item_cmp(const void *fndata,
+static int subject2item_cmp(const void *UNUSED(fndata),
 			    const struct hashmap_entry *eptr,
 			    const struct hashmap_entry *entry_or_key,
 			    const void *key)
diff --git a/strmap.c b/strmap.c
index ee48635708..4e79734e4f 100644
--- a/strmap.c
+++ b/strmap.c
@@ -2,10 +2,10 @@
 #include "strmap.h"
 #include "mem-pool.h"
 
-int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
+int cmp_strmap_entry(const void *UNUSED(hashmap_cmp_fn_data),
 		     const struct hashmap_entry *entry1,
 		     const struct hashmap_entry *entry2,
-		     const void *keydata)
+		     const void *UNUSED(keydata))
 {
 	const struct strmap_entry *e1, *e2;
 
diff --git a/sub-process.c b/sub-process.c
index cae56ae6b8..bd6a372a67 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -5,10 +5,10 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 
-int cmd2process_cmp(const void *unused_cmp_data,
+int cmd2process_cmp(const void *UNUSED(cmp_data),
 		    const struct hashmap_entry *eptr,
 		    const struct hashmap_entry *entry_or_key,
-		    const void *unused_keydata)
+		    const void *UNUSED(keydata))
 {
 	const struct subprocess_entry *e1, *e2;
 
diff --git a/submodule-config.c b/submodule-config.c
index c2ac7e7bf3..d7a8ca0269 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -38,10 +38,10 @@ enum lookup_type {
 	lookup_path
 };
 
-static int config_path_cmp(const void *unused_cmp_data,
+static int config_path_cmp(const void *UNUSED(cmp_data),
 			   const struct hashmap_entry *eptr,
 			   const struct hashmap_entry *entry_or_key,
-			   const void *unused_keydata)
+			   const void *UNUSED(keydata))
 {
 	const struct submodule_entry *a, *b;
 
@@ -52,10 +52,10 @@ static int config_path_cmp(const void *unused_cmp_data,
 	       !oideq(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
 }
 
-static int config_name_cmp(const void *unused_cmp_data,
+static int config_name_cmp(const void *UNUSED(cmp_data),
 			   const struct hashmap_entry *eptr,
 			   const struct hashmap_entry *entry_or_key,
-			   const void *unused_keydata)
+			   const void *UNUSED(keydata))
 {
 	const struct submodule_entry *a, *b;
 
-- 
2.37.2.928.g0821088f4a

