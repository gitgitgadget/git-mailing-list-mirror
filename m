Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D541F463
	for <e@80x24.org>; Tue, 24 Sep 2019 01:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503759AbfIXBDy (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:03:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59380 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391859AbfIXBDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:03:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0ACED1F9FD;
        Tue, 24 Sep 2019 01:03:27 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 11/19] hashmap_get_next returns "struct hashmap_entry *"
Date:   Tue, 24 Sep 2019 01:03:16 +0000
Message-Id: <20190924010324.22619-12-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a step towards removing the requirement for
hashmap_entry being the first field of a struct.

Signed-off-by: Eric Wong <e@80x24.org>
---
 diff.c                  | 19 ++++++++++++-------
 diffcore-rename.c       | 11 +++++++----
 hashmap.c               |  2 +-
 hashmap.h               | 12 ++++++++----
 name-hash.c             |  8 +++++---
 t/helper/test-hashmap.c | 10 ++++++----
 6 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index 72d3c6aa19..663b5d01f8 100644
--- a/diff.c
+++ b/diff.c
@@ -1035,8 +1035,10 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 {
 	int i;
 	char *got_match = xcalloc(1, pmb_nr);
+	struct hashmap_entry *ent = &match->ent;
 
-	for (; match; match = hashmap_get_next(hm, &match->ent)) {
+	for (; ent; ent = hashmap_get_next(hm, ent)) {
+		match = container_of(ent, struct moved_entry, ent);
 		for (i = 0; i < pmb_nr; i++) {
 			struct moved_entry *prev = pmb[i].match;
 			struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1135,8 +1137,9 @@ static void mark_color_as_moved(struct diff_options *o,
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
 		struct hashmap *hm = NULL;
+		struct hashmap_entry *ent = NULL;
 		struct moved_entry *key;
-		struct moved_entry *match = NULL;
+		struct moved_entry *match;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
 		enum diff_symbol last_symbol = 0;
 
@@ -1144,20 +1147,20 @@ static void mark_color_as_moved(struct diff_options *o,
 		case DIFF_SYMBOL_PLUS:
 			hm = del_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, &key->ent, NULL);
+			ent = hashmap_get(hm, &key->ent, NULL);
 			free(key);
 			break;
 		case DIFF_SYMBOL_MINUS:
 			hm = add_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, &key->ent, NULL);
+			ent = hashmap_get(hm, &key->ent, NULL);
 			free(key);
 			break;
 		default:
 			flipped_block = 0;
 		}
 
-		if (!match) {
+		if (!ent) {
 			int i;
 
 			adjust_last_block(o, n, block_length);
@@ -1169,6 +1172,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			last_symbol = l->s;
 			continue;
 		}
+		match = container_of(ent, struct moved_entry, ent);
 
 		if (o->color_moved == COLOR_MOVED_PLAIN) {
 			last_symbol = l->s;
@@ -1189,8 +1193,9 @@ static void mark_color_as_moved(struct diff_options *o,
 			 * The current line is the start of a new block.
 			 * Setup the set of potential blocks.
 			 */
-			for (; match; match = hashmap_get_next(hm,
-								&match->ent)) {
+			for (; ent; ent = hashmap_get_next(hm, ent)) {
+				match = container_of(ent, struct moved_entry,
+							ent);
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4670a40179..71aa240a68 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -274,7 +274,7 @@ static int find_identical_files(struct hashmap *srcs,
 				struct diff_options *options)
 {
 	int renames = 0;
-
+	struct hashmap_entry *ent;
 	struct diff_filespec *target = rename_dst[dst_index].two;
 	struct file_similarity *p, *best = NULL;
 	int i = 100, best_score = -1;
@@ -282,12 +282,15 @@ static int find_identical_files(struct hashmap *srcs,
 	/*
 	 * Find the best source match for specified destination.
 	 */
-	p = hashmap_get_from_hash(srcs,
+	ent = hashmap_get_from_hash(srcs,
 				  hash_filespec(options->repo, target),
 				  NULL);
-	for (; p; p = hashmap_get_next(srcs, &p->entry)) {
+	for (; ent; ent = hashmap_get_next(srcs, ent)) {
 		int score;
-		struct diff_filespec *source = p->filespec;
+		struct diff_filespec *source;
+
+		p = container_of(ent, struct file_similarity, entry);
+		source = p->filespec;
 
 		/* False hash collision? */
 		if (!oideq(&source->oid, &target->oid))
diff --git a/hashmap.c b/hashmap.c
index 9b83e73d03..22bc7c5b3b 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -192,7 +192,7 @@ void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
 	return *find_entry_ptr(map, key, keydata);
 }
 
-void *hashmap_get_next(const struct hashmap *map,
+struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
 			const struct hashmap_entry *entry)
 {
 	struct hashmap_entry *e = entry->next;
diff --git a/hashmap.h b/hashmap.h
index cb630447bb..eb38587a63 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -55,15 +55,19 @@
  *
  *         if (!strcmp("print_all_by_key", action)) {
  *             struct long2string k, *e;
+ *             struct hashmap_entry *ent;
  *             hashmap_entry_init(&k->ent, memhash(&key, sizeof(long)));
  *             k.key = key;
  *
  *             flags &= ~COMPARE_VALUE;
- *             e = hashmap_get(&map, &k, NULL);
- *             if (e) {
+ *             ent = hashmap_get(&map, &k, NULL);
+ *             if (ent) {
+ *                 e = container_of(ent, struct long2string, ent);
  *                 printf("first: %ld %s\n", e->key, e->value);
- *                 while ((e = hashmap_get_next(&map, e)))
+ *                 while ((ent = hashmap_get_next(&map, ent))) {
+ *                     e = container_of(ent, struct long2string, ent);
  *                     printf("found more: %ld %s\n", e->key, e->value);
+ *                 }
  *             }
  *         }
  *
@@ -320,7 +324,7 @@ static inline void *hashmap_get_from_hash(const struct hashmap *map,
  * `entry` is the hashmap_entry to start the search from, obtained via a previous
  * call to `hashmap_get` or `hashmap_get_next`.
  */
-void *hashmap_get_next(const struct hashmap *map,
+struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
 			const struct hashmap_entry *entry);
 
 /*
diff --git a/name-hash.c b/name-hash.c
index 44d788f1ce..dbacb34f50 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -702,15 +702,17 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	struct cache_entry *ce;
+	struct hashmap_entry *ent;
 
 	lazy_init_name_hash(istate);
 
-	ce = hashmap_get_from_hash(&istate->name_hash,
+	ent = hashmap_get_from_hash(&istate->name_hash,
 				   memihash(name, namelen), NULL);
-	while (ce) {
+	while (ent) {
+		ce = container_of(ent, struct cache_entry, ent);
 		if (same_name(ce, name, namelen, icase))
 			return ce;
-		ce = hashmap_get_next(&istate->name_hash, &ce->ent);
+		ent = hashmap_get_next(&istate->name_hash, ent);
 	}
 	return NULL;
 }
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index de2bd083b9..d85b8dc58e 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -194,16 +194,18 @@ int cmd__hashmap(int argc, const char **argv)
 			free(entry);
 
 		} else if (!strcmp("get", cmd) && p1) {
+			struct hashmap_entry *e;
 
 			/* lookup entry in hashmap */
-			entry = hashmap_get_from_hash(&map, hash, p1);
+			e = hashmap_get_from_hash(&map, hash, p1);
 
 			/* print result */
-			if (!entry)
+			if (!e)
 				puts("NULL");
-			while (entry) {
+			while (e) {
+				entry = container_of(e, struct test_entry, ent);
 				puts(get_value(entry));
-				entry = hashmap_get_next(&map, &entry->ent);
+				e = hashmap_get_next(&map, e);
 			}
 
 		} else if (!strcmp("remove", cmd) && p1) {
