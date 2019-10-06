Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607F41F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 23:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfJFXbb (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:31:31 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39532 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfJFXbb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:31:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 387F31F4D2;
        Sun,  6 Oct 2019 23:30:47 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 16/20] hashmap: hashmap_{put,remove} return hashmap_entry *
Date:   Sun,  6 Oct 2019 23:30:39 +0000
Message-Id: <20191006233043.3516-17-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And add *_entry variants to perform container_of as necessary
to simplify most callers.

Signed-off-by: Eric Wong <e@80x24.org>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
---
 hashmap.c               |  8 +++++---
 hashmap.h               | 15 ++++++++++++---
 range-diff.c            |  4 +++-
 remote.c                |  3 ++-
 submodule-config.c      |  4 +++-
 t/helper/test-hashmap.c |  9 +++++++--
 6 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/hashmap.c b/hashmap.c
index deb5fdf28c..1b60f97cf2 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -219,8 +219,9 @@ void hashmap_add(struct hashmap *map, struct hashmap_entry *entry)
 	}
 }
 
-void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
-		const void *keydata)
+struct hashmap_entry *hashmap_remove(struct hashmap *map,
+					const struct hashmap_entry *key,
+					const void *keydata)
 {
 	struct hashmap_entry *old;
 	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
@@ -242,7 +243,8 @@ void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
 	return old;
 }
 
-void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry)
+struct hashmap_entry *hashmap_put(struct hashmap *map,
+				struct hashmap_entry *entry)
 {
 	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
 	hashmap_add(map, entry);
diff --git a/hashmap.h b/hashmap.h
index 8d4b3907b4..bc3b10e097 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -349,7 +349,11 @@ void hashmap_add(struct hashmap *map, struct hashmap_entry *entry);
  * `entry` is the entry to add or replace.
  * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
  */
-void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
+struct hashmap_entry *hashmap_put(struct hashmap *map,
+				struct hashmap_entry *entry);
+
+#define hashmap_put_entry(map, keyvar, type, member) \
+	container_of_or_null(hashmap_put(map, &(keyvar)->member), type, member)
 
 /*
  * Removes a hashmap entry matching the specified key. If the hashmap contains
@@ -358,8 +362,13 @@ void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
  *
  * Argument explanation is the same as in `hashmap_get`.
  */
-void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
-		const void *keydata);
+struct hashmap_entry *hashmap_remove(struct hashmap *map,
+					const struct hashmap_entry *key,
+					const void *keydata);
+
+#define hashmap_remove_entry(map, keyvar, keydata, type, member) \
+	container_of_or_null(hashmap_remove(map, &(keyvar)->member, keydata), \
+				type, member)
 
 /*
  * Returns the `bucket` an entry is stored in.
diff --git a/range-diff.c b/range-diff.c
index c51cfd5556..e5e7820bfe 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -229,7 +229,9 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 		util->patch = b->items[i].string;
 		util->diff = util->patch + util->diff_offset;
 		hashmap_entry_init(&util->e, strhash(util->diff));
-		other = hashmap_remove(&map, &util->e, NULL);
+		other = hashmap_remove_entry(&map, util, NULL,
+					struct patch_util,
+					e /* member name */);
 		if (other) {
 			if (other->matching >= 0)
 				BUG("already assigned!");
diff --git a/remote.c b/remote.c
index fa9cadcfbd..5fcddcd88d 100644
--- a/remote.c
+++ b/remote.c
@@ -162,7 +162,8 @@ static struct remote *make_remote(const char *name, int len)
 	remotes[remotes_nr++] = ret;
 
 	hashmap_entry_init(&ret->ent, lookup_entry.hash);
-	replaced = hashmap_put(&remotes_hash, &ret->ent);
+	replaced = hashmap_put_entry(&remotes_hash, ret, struct remote,
+					ent /* member name */);
 	assert(replaced == NULL);  /* no previous entry overwritten */
 	return ret;
 }
diff --git a/submodule-config.c b/submodule-config.c
index 5319933e1d..a289d195f6 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -141,7 +141,9 @@ static void cache_remove_path(struct submodule_cache *cache,
 	struct submodule_entry *removed;
 	hashmap_entry_init(&e.ent, hash);
 	e.config = submodule;
-	removed = hashmap_remove(&cache->for_path, &e.ent, NULL);
+	removed = hashmap_remove_entry(&cache->for_path, &e, NULL,
+					struct submodule_entry,
+					ent /* member name */);
 	free(removed);
 }
 
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 4ec5e11556..07a93a2aec 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -189,7 +189,9 @@ int cmd__hashmap(int argc, const char **argv)
 			entry = alloc_test_entry(hash, p1, p2);
 
 			/* add / replace entry */
-			entry = hashmap_put(&map, &entry->ent);
+			entry = hashmap_put_entry(&map, entry,
+						struct test_entry,
+						ent /* member name */);
 
 			/* print and free replaced entry, if any */
 			puts(entry ? get_value(entry) : "NULL");
@@ -212,10 +214,13 @@ int cmd__hashmap(int argc, const char **argv)
 
 			/* setup static key */
 			struct hashmap_entry key;
+			struct hashmap_entry *rm;
 			hashmap_entry_init(&key, hash);
 
 			/* remove entry from hashmap */
-			entry = hashmap_remove(&map, &key, p1);
+			rm = hashmap_remove(&map, &key, p1);
+			entry = rm ? container_of(rm, struct test_entry, ent)
+					: NULL;
 
 			/* print result and free entry*/
 			puts(entry ? get_value(entry) : "NULL");
