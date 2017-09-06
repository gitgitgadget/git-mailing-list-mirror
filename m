Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAF71F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 15:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbdIFPoH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 11:44:07 -0400
Received: from siwi.pair.com ([209.68.5.199]:24404 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753900AbdIFPoG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 11:44:06 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AD408845B0;
        Wed,  6 Sep 2017 11:44:04 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0A4EF845AF;
        Wed,  6 Sep 2017 11:44:03 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jeffhost@microsoft.com,
        martin.agren@gmail.com, peff@peff.net
Subject: [PATCH v2] hashmap: add API to disable item counting when threaded
Date:   Wed,  6 Sep 2017 15:43:48 +0000
Message-Id: <20170906154348.14287-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170906154348.14287-1-git@jeffhostetler.com>
References: <20170830185922.10107-1-git@jeffhostetler.com>
 <20170906154348.14287-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is to address concerns raised by ThreadSanitizer on the mailing list
about threaded unprotected R/W access to map.size with my previous "disallow
rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).

See:
https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/

Add API to hashmap to disable item counting and thus automatic rehashing.
Also include API to later re-enable them.

When item counting is disabled, the map.size field is invalid.  So to
prevent accidents, the field has been renamed and an accessor function
hashmap_get_size() has been added.  All direct references to this
field have been been updated.  And the name of the field changed
to map.private_size to communicate this.

Here is the relevant output from ThreadSanitizer showing the problem:

WARNING: ThreadSanitizer: data race (pid=10554)
  Read of size 4 at 0x00000082d488 by thread T2 (mutexes: write M16):
    #0 hashmap_add hashmap.c:209
    #1 hash_dir_entry_with_parent_and_prefix name-hash.c:302
    #2 handle_range_dir name-hash.c:347
    #3 handle_range_1 name-hash.c:415
    #4 lazy_dir_thread_proc name-hash.c:471
    #5 <null> <null>

  Previous write of size 4 at 0x00000082d488 by thread T1 (mutexes: write M31):
    #0 hashmap_add hashmap.c:209
    #1 hash_dir_entry_with_parent_and_prefix name-hash.c:302
    #2 handle_range_dir name-hash.c:347
    #3 handle_range_1 name-hash.c:415
    #4 handle_range_dir name-hash.c:380
    #5 handle_range_1 name-hash.c:415
    #6 lazy_dir_thread_proc name-hash.c:471
    #7 <null> <null>

Martin gives instructions for running TSan on test t3008 in this post:
https://public-inbox.org/git/CAN0heSoJDL9pWELD6ciLTmWf-a=oyxe4EXXOmCKvsG5MSuzxsA@mail.gmail.com/

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 attr.c                  | 15 ++++++-----
 builtin/describe.c      |  2 +-
 hashmap.c               | 26 +++++++++++-------
 hashmap.h               | 72 ++++++++++++++++++++++++++++++++++---------------
 name-hash.c             | 10 +++++--
 t/helper/test-hashmap.c |  3 ++-
 6 files changed, 88 insertions(+), 40 deletions(-)

diff --git a/attr.c b/attr.c
index 56961f0..195aa6d 100644
--- a/attr.c
+++ b/attr.c
@@ -149,10 +149,12 @@ struct all_attrs_item {
 static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 {
 	int i;
+	unsigned int size;
 
 	hashmap_lock(map);
 
-	if (map->map.size < check->all_attrs_nr)
+	size = hashmap_get_size(&map->map);
+	if (size < check->all_attrs_nr)
 		die("BUG: interned attributes shouldn't be deleted");
 
 	/*
@@ -161,13 +163,13 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	 * field), reallocate the provided attr_check instance's all_attrs
 	 * field and fill each entry with its corresponding git_attr.
 	 */
-	if (map->map.size != check->all_attrs_nr) {
+	if (size != check->all_attrs_nr) {
 		struct attr_hash_entry *e;
 		struct hashmap_iter iter;
 		hashmap_iter_init(&map->map, &iter);
 
-		REALLOC_ARRAY(check->all_attrs, map->map.size);
-		check->all_attrs_nr = map->map.size;
+		REALLOC_ARRAY(check->all_attrs, size);
+		check->all_attrs_nr = size;
 
 		while ((e = hashmap_iter_next(&iter))) {
 			const struct git_attr *a = e->value;
@@ -235,10 +237,11 @@ static const struct git_attr *git_attr_internal(const char *name, int namelen)
 
 	if (!a) {
 		FLEX_ALLOC_MEM(a, name, name, namelen);
-		a->attr_nr = g_attr_hashmap.map.size;
+		a->attr_nr = hashmap_get_size(&g_attr_hashmap.map);
 
 		attr_hashmap_add(&g_attr_hashmap, a->name, namelen, a);
-		assert(a->attr_nr == (g_attr_hashmap.map.size - 1));
+		assert(a->attr_nr ==
+		       (hashmap_get_size(&g_attr_hashmap.map) - 1));
 	}
 
 	hashmap_unlock(&g_attr_hashmap);
diff --git a/builtin/describe.c b/builtin/describe.c
index 89ea1cd..1e3cbc7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -505,7 +505,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, NULL, 0);
 	for_each_rawref(get_name, NULL);
-	if (!names.size && !always)
+	if (!hashmap_get_size(&names) && !always)
 		die(_("No names found, cannot describe anything."));
 
 	if (argc == 0) {
diff --git a/hashmap.c b/hashmap.c
index 9b6a128..d42f01f 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -116,9 +116,6 @@ static void rehash(struct hashmap *map, unsigned int newsize)
 	unsigned int i, oldsize = map->tablesize;
 	struct hashmap_entry **oldtable = map->table;
 
-	if (map->disallow_rehash)
-		return;
-
 	alloc_table(map, newsize);
 	for (i = 0; i < oldsize; i++) {
 		struct hashmap_entry *e = oldtable[i];
@@ -166,6 +163,12 @@ void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 	while (initial_size > size)
 		size <<= HASHMAP_RESIZE_BITS;
 	alloc_table(map, size);
+
+	/*
+	 * Keep track of the number of items in the map and
+	 * allow the map to automatically grow as necessary.
+	 */
+	map->do_count_items = 1;
 }
 
 void hashmap_free(struct hashmap *map, int free_entries)
@@ -206,9 +209,11 @@ void hashmap_add(struct hashmap *map, void *entry)
 	map->table[b] = entry;
 
 	/* fix size and rehash if appropriate */
-	map->size++;
-	if (map->size > map->grow_at)
-		rehash(map, map->tablesize << HASHMAP_RESIZE_BITS);
+	if (map->do_count_items) {
+		map->private_size++;
+		if (map->private_size > map->grow_at)
+			rehash(map, map->tablesize << HASHMAP_RESIZE_BITS);
+	}
 }
 
 void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
@@ -224,9 +229,12 @@ void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
 	old->next = NULL;
 
 	/* fix size and rehash if appropriate */
-	map->size--;
-	if (map->size < map->shrink_at)
-		rehash(map, map->tablesize >> HASHMAP_RESIZE_BITS);
+	if (map->do_count_items) {
+		map->private_size--;
+		if (map->private_size < map->shrink_at)
+			rehash(map, map->tablesize >> HASHMAP_RESIZE_BITS);
+	}
+
 	return old;
 }
 
diff --git a/hashmap.h b/hashmap.h
index 7a8fa7f..7cb29a6 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -183,7 +183,7 @@ struct hashmap {
 	const void *cmpfn_data;
 
 	/* total number of entries (0 means the hashmap is empty) */
-	unsigned int size;
+	unsigned int private_size; /* use hashmap_get_size() */
 
 	/*
 	 * tablesize is the allocated size of the hash table. A non-0 value
@@ -196,8 +196,7 @@ struct hashmap {
 	unsigned int grow_at;
 	unsigned int shrink_at;
 
-	/* See `hashmap_disallow_rehash`. */
-	unsigned disallow_rehash : 1;
+	unsigned int do_count_items : 1;
 };
 
 /* hashmap functions */
@@ -253,6 +252,18 @@ static inline void hashmap_entry_init(void *entry, unsigned int hash)
 }
 
 /*
+ * Return the number of items in the map.
+ */
+static inline unsigned int hashmap_get_size(struct hashmap *map)
+{
+	if (map->do_count_items)
+		return map->private_size;
+
+	BUG("hashmap_get_size: size not set");
+	return 0;
+}
+
+/*
  * Returns the hashmap entry for the specified key, or NULL if not found.
  *
  * `map` is the hashmap structure.
@@ -345,24 +356,6 @@ extern void *hashmap_remove(struct hashmap *map, const void *key,
 int hashmap_bucket(const struct hashmap *map, unsigned int hash);
 
 /*
- * Disallow/allow rehashing of the hashmap.
- * This is useful if the caller knows that the hashmap needs multi-threaded
- * access.  The caller is still required to guard/lock searches and inserts
- * in a manner appropriate to their usage.  This simply prevents the table
- * from being unexpectedly re-mapped.
- *
- * It is up to the caller to ensure that the hashmap is initialized to a
- * reasonable size to prevent poor performance.
- *
- * A call to allow rehashing does not force a rehash; that might happen
- * with the next insert or delete.
- */
-static inline void hashmap_disallow_rehash(struct hashmap *map, unsigned value)
-{
-	map->disallow_rehash = value;
-}
-
-/*
  * Used to iterate over all entries of a hashmap. Note that it is
  * not safe to add or remove entries to the hashmap while
  * iterating.
@@ -387,6 +380,43 @@ static inline void *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }
 
+/*
+ * Disable item counting and automatic rehashing when adding/removing items.
+ *
+ * Normally, the hashmap keeps track of the number of items in the map
+ * and uses it to dynamically resize it.  This (both the counting and
+ * the resizing) can cause problems when the map is being used by
+ * threaded callers (because the hashmap code does not know about the
+ * locking strategy used by the threaded callers and therefore, does
+ * not know how to protect the "private_size" counter).
+ */
+static inline void hashmap_disable_item_counting(struct hashmap *map)
+{
+	map->do_count_items = 0;
+}
+
+/*
+ * Re-enable item couting when adding/removing items.
+ * If counting is currently disabled, it will force count them.
+ * It WILL NOT automatically rehash them.
+ */
+static inline void hashmap_enable_item_counting(struct hashmap *map)
+{
+	void *item;
+	unsigned int n = 0;
+	struct hashmap_iter iter;
+
+	if (map->do_count_items)
+		return;
+
+	hashmap_iter_init(map, &iter);
+	while ((item = hashmap_iter_next(&iter)))
+		n++;
+
+	map->do_count_items = 1;
+	map->private_size = n;
+}
+
 /* String interning */
 
 /*
diff --git a/name-hash.c b/name-hash.c
index 0e10f3e..3ac2e57 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -580,9 +580,15 @@ static void lazy_init_name_hash(struct index_state *istate)
 			NULL, istate->cache_nr);
 
 	if (lookup_lazy_params(istate)) {
-		hashmap_disallow_rehash(&istate->dir_hash, 1);
+		/*
+		 * Disable item counting and automatic rehashing because
+		 * we do per-chain (mod n) locking rather than whole hashmap
+		 * locking and we need to prevent the table-size from changing
+		 * and bucket items from being redistributed.
+		 */
+		hashmap_disable_item_counting(&istate->dir_hash);
 		threaded_lazy_init_name_hash(istate);
-		hashmap_disallow_rehash(&istate->dir_hash, 0);
+		hashmap_enable_item_counting(&istate->dir_hash);
 	} else {
 		int nr;
 		for (nr = 0; nr < istate->cache_nr; nr++)
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 095d739..4956d1d 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -237,7 +237,8 @@ int cmd_main(int argc, const char **argv)
 		} else if (!strcmp("size", cmd)) {
 
 			/* print table sizes */
-			printf("%u %u\n", map.tablesize, map.size);
+			printf("%u %u\n", map.tablesize,
+			       hashmap_get_size(&map));
 
 		} else if (!strcmp("intern", cmd) && l1) {
 
-- 
2.9.3

