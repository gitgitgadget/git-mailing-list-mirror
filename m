Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C653D1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 01:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503753AbfIXBDq (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:03:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59292 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392394AbfIXBDq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:03:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4FB8B1F9F9;
        Tue, 24 Sep 2019 01:03:26 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 08/19] hashmap_remove takes "const struct hashmap_entry *"
Date:   Tue, 24 Sep 2019 01:03:13 +0000
Message-Id: <20190924010324.22619-9-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is less error-prone than "const void *" as the compiler
now detects invalid types being passed.

Signed-off-by: Eric Wong <e@80x24.org>
---
 blame.c            | 2 +-
 hashmap.c          | 3 ++-
 hashmap.h          | 2 +-
 merge-recursive.c  | 2 +-
 name-hash.c        | 4 ++--
 packfile.c         | 2 +-
 range-diff.c       | 2 +-
 sub-process.c      | 2 +-
 submodule-config.c | 2 +-
 9 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/blame.c b/blame.c
index 73ffb59403..00f8f3fb0a 100644
--- a/blame.c
+++ b/blame.c
@@ -473,7 +473,7 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 	while ((entry_b = hashmap_iter_next(&iter))) {
 		if ((entry_a = hashmap_get(&a->map, &entry_b->entry, NULL))) {
 			if (entry_a->count <= entry_b->count)
-				hashmap_remove(&a->map, entry_b, NULL);
+				hashmap_remove(&a->map, &entry_b->entry, NULL);
 			else
 				entry_a->count -= entry_b->count;
 		}
diff --git a/hashmap.c b/hashmap.c
index 092236c09a..bdf33e0381 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -218,7 +218,8 @@ void hashmap_add(struct hashmap *map, struct hashmap_entry *entry)
 	}
 }
 
-void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
+void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
+		const void *keydata)
 {
 	struct hashmap_entry *old;
 	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
diff --git a/hashmap.h b/hashmap.h
index 2a4b4a3954..5e0818c134 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -349,7 +349,7 @@ void *hashmap_put(struct hashmap *map, void *entry);
  *
  * Argument explanation is the same as in `hashmap_get`.
  */
-void *hashmap_remove(struct hashmap *map, const void *key,
+void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
 		const void *keydata);
 
 /*
diff --git a/merge-recursive.c b/merge-recursive.c
index 2d31a3e279..f60451d396 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2001,7 +2001,7 @@ static void remove_hashmap_entries(struct hashmap *dir_renames,
 
 	for (i = 0; i < items_to_remove->nr; i++) {
 		entry = items_to_remove->items[i].util;
-		hashmap_remove(dir_renames, entry, NULL);
+		hashmap_remove(dir_renames, &entry->ent, NULL);
 	}
 	string_list_clear(items_to_remove, 0);
 }
diff --git a/name-hash.c b/name-hash.c
index 4eaeded775..44d788f1ce 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -95,7 +95,7 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
 	while (dir && !(--dir->nr)) {
 		struct dir_entry *parent = dir->parent;
-		hashmap_remove(&istate->dir_hash, dir, NULL);
+		hashmap_remove(&istate->dir_hash, &dir->ent, NULL);
 		free(dir);
 		dir = parent;
 	}
@@ -625,7 +625,7 @@ void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
 	if (!istate->name_hash_initialized || !(ce->ce_flags & CE_HASHED))
 		return;
 	ce->ce_flags &= ~CE_HASHED;
-	hashmap_remove(&istate->name_hash, ce, ce);
+	hashmap_remove(&istate->name_hash, &ce->ent, ce);
 
 	if (ignore_case)
 		remove_dir_entry(istate, ce);
diff --git a/packfile.c b/packfile.c
index f7402c470b..3edd648de0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1423,7 +1423,7 @@ static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
  */
 static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 {
-	hashmap_remove(&delta_base_cache, ent, &ent->key);
+	hashmap_remove(&delta_base_cache, &ent->ent, &ent->key);
 	list_del(&ent->lru);
 	delta_base_cached -= ent->size;
 	free(ent);
diff --git a/range-diff.c b/range-diff.c
index 96f955d84d..c51cfd5556 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -229,7 +229,7 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 		util->patch = b->items[i].string;
 		util->diff = util->patch + util->diff_offset;
 		hashmap_entry_init(&util->e, strhash(util->diff));
-		other = hashmap_remove(&map, util, NULL);
+		other = hashmap_remove(&map, &util->e, NULL);
 		if (other) {
 			if (other->matching >= 0)
 				BUG("already assigned!");
diff --git a/sub-process.c b/sub-process.c
index debd86bb68..99fccef592 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -58,7 +58,7 @@ void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
 	kill(entry->process.pid, SIGTERM);
 	finish_command(&entry->process);
 
-	hashmap_remove(hashmap, entry, NULL);
+	hashmap_remove(hashmap, &entry->ent, NULL);
 }
 
 static void subprocess_exit_handler(struct child_process *process)
diff --git a/submodule-config.c b/submodule-config.c
index 58d585cd7d..7486745a6a 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -137,7 +137,7 @@ static void cache_remove_path(struct submodule_cache *cache,
 	struct submodule_entry *removed;
 	hashmap_entry_init(&e.ent, hash);
 	e.config = submodule;
-	removed = hashmap_remove(&cache->for_path, &e, NULL);
+	removed = hashmap_remove(&cache->for_path, &e.ent, NULL);
 	free(removed);
 }
 
