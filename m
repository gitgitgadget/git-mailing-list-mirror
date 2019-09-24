Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7421F463
	for <e@80x24.org>; Tue, 24 Sep 2019 01:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503756AbfIXBDt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:03:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59316 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392394AbfIXBDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:03:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 953FF1F9FA;
        Tue, 24 Sep 2019 01:03:26 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 09/19] hashmap_put takes "struct hashmap_entry *"
Date:   Tue, 24 Sep 2019 01:03:14 +0000
Message-Id: <20190924010324.22619-10-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is less error-prone than "void *" as the compiler now
detects invalid types being passed.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/fast-export.c   | 2 +-
 hashmap.c               | 2 +-
 hashmap.h               | 2 +-
 merge-recursive.c       | 4 ++--
 oidmap.c                | 2 +-
 refs.c                  | 5 ++++-
 remote.c                | 2 +-
 revision.c              | 2 +-
 sequencer.c             | 2 +-
 submodule-config.c      | 2 +-
 t/helper/test-hashmap.c | 2 +-
 11 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c693cf6a8c..192e21dae4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -160,7 +160,7 @@ static const void *anonymize_mem(struct hashmap *map,
 		ret->orig_len = *len;
 		ret->anon = generate(orig, len);
 		ret->anon_len = *len;
-		hashmap_put(map, ret);
+		hashmap_put(map, &ret->hash);
 	}
 
 	*len = ret->anon_len;
diff --git a/hashmap.c b/hashmap.c
index bdf33e0381..9b83e73d03 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -241,7 +241,7 @@ void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
 	return old;
 }
 
-void *hashmap_put(struct hashmap *map, void *entry)
+void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry)
 {
 	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
 	hashmap_add(map, entry);
diff --git a/hashmap.h b/hashmap.h
index 5e0818c134..cb630447bb 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -340,7 +340,7 @@ void hashmap_add(struct hashmap *map, struct hashmap_entry *entry);
  * `entry` is the entry to add or replace.
  * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
  */
-void *hashmap_put(struct hashmap *map, void *entry);
+void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
 
 /*
  * Removes a hashmap entry matching the specified key. If the hashmap contains
diff --git a/merge-recursive.c b/merge-recursive.c
index f60451d396..a685b4fb69 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2229,7 +2229,7 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs)
 		if (!entry) {
 			entry = xmalloc(sizeof(*entry));
 			dir_rename_entry_init(entry, old_dir);
-			hashmap_put(dir_renames, entry);
+			hashmap_put(dir_renames, &entry->ent);
 		} else {
 			free(old_dir);
 		}
@@ -2360,7 +2360,7 @@ static void compute_collisions(struct hashmap *collisions,
 						sizeof(struct collision_entry));
 			hashmap_entry_init(&collision_ent->ent,
 						strhash(new_path));
-			hashmap_put(collisions, collision_ent);
+			hashmap_put(collisions, &collision_ent->ent);
 			collision_ent->target_file = new_path;
 		} else {
 			free(new_path);
diff --git a/oidmap.c b/oidmap.c
index 6d6e840d03..cd22b3a8bf 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -51,5 +51,5 @@ void *oidmap_put(struct oidmap *map, void *entry)
 		oidmap_init(map, 0);
 
 	hashmap_entry_init(&to_put->internal_entry, oidhash(&to_put->oid));
-	return hashmap_put(&map->map, to_put);
+	return hashmap_put(&map->map, &to_put->internal_entry);
 }
diff --git a/refs.c b/refs.c
index c43ec59c6e..3e55031256 100644
--- a/refs.c
+++ b/refs.c
@@ -1863,10 +1863,13 @@ static void register_ref_store_map(struct hashmap *map,
 				   struct ref_store *refs,
 				   const char *name)
 {
+	struct ref_store_hash_entry *entry;
+
 	if (!map->tablesize)
 		hashmap_init(map, ref_store_hash_cmp, NULL, 0);
 
-	if (hashmap_put(map, alloc_ref_store_hash_entry(name, refs)))
+	entry = alloc_ref_store_hash_entry(name, refs);
+	if (hashmap_put(map, &entry->ent))
 		BUG("%s ref_store '%s' initialized twice", type, name);
 }
 
diff --git a/remote.c b/remote.c
index bd81cb71bc..8ca23d95dc 100644
--- a/remote.c
+++ b/remote.c
@@ -159,7 +159,7 @@ static struct remote *make_remote(const char *name, int len)
 	remotes[remotes_nr++] = ret;
 
 	hashmap_entry_init(&ret->ent, lookup_entry.hash);
-	replaced = hashmap_put(&remotes_hash, ret);
+	replaced = hashmap_put(&remotes_hash, &ret->ent);
 	assert(replaced == NULL);  /* no previous entry overwritten */
 	return ret;
 }
diff --git a/revision.c b/revision.c
index 4336281286..a7e2339064 100644
--- a/revision.c
+++ b/revision.c
@@ -153,7 +153,7 @@ static void paths_and_oids_insert(struct hashmap *map,
 		hashmap_entry_init(&entry->ent, hash);
 		entry->path = xstrdup(key.path);
 		oidset_init(&entry->trees, 16);
-		hashmap_put(map, entry);
+		hashmap_put(map, &entry->ent);
 	}
 
 	oidset_insert(&entry->trees, oid);
diff --git a/sequencer.c b/sequencer.c
index ee11cda7e7..b4ef70e260 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5254,7 +5254,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 			entry->i = i;
 			hashmap_entry_init(&entry->entry,
 					strhash(entry->subject));
-			hashmap_put(&subject2item, entry);
+			hashmap_put(&subject2item, &entry->entry);
 		}
 	}
 
diff --git a/submodule-config.c b/submodule-config.c
index 7486745a6a..9248c5ea5b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -125,7 +125,7 @@ static void cache_put_path(struct submodule_cache *cache,
 	struct submodule_entry *e = xmalloc(sizeof(*e));
 	hashmap_entry_init(&e->ent, hash);
 	e->config = submodule;
-	hashmap_put(&cache->for_path, e);
+	hashmap_put(&cache->for_path, &e->ent);
 }
 
 static void cache_remove_path(struct submodule_cache *cache,
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 49e715f1cd..de2bd083b9 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -187,7 +187,7 @@ int cmd__hashmap(int argc, const char **argv)
 			entry = alloc_test_entry(hash, p1, p2);
 
 			/* add / replace entry */
-			entry = hashmap_put(&map, entry);
+			entry = hashmap_put(&map, &entry->ent);
 
 			/* print and free replaced entry, if any */
 			puts(entry ? get_value(entry) : "NULL");
