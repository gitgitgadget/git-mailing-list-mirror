Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC981F461
	for <e@80x24.org>; Mon, 26 Aug 2019 02:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfHZCnr (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 22:43:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36350 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfHZCnr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 22:43:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 60AE01F4BC;
        Mon, 26 Aug 2019 02:43:33 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 05/11] hashmap_get_next takes "const struct hashmap_entry *"
Date:   Mon, 26 Aug 2019 02:43:26 +0000
Message-Id: <20190826024332.3403-6-e@80x24.org>
In-Reply-To: <20190826024332.3403-1-e@80x24.org>
References: <20190826024332.3403-1-e@80x24.org>
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
 diff.c                  | 5 +++--
 diffcore-rename.c       | 2 +-
 hashmap.c               | 5 +++--
 hashmap.h               | 3 ++-
 name-hash.c             | 2 +-
 t/helper/test-hashmap.c | 2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 02491ee684..1168f0cbb9 100644
--- a/diff.c
+++ b/diff.c
@@ -1036,7 +1036,7 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 	int i;
 	char *got_match = xcalloc(1, pmb_nr);
 
-	for (; match; match = hashmap_get_next(hm, match)) {
+	for (; match; match = hashmap_get_next(hm, &match->ent)) {
 		for (i = 0; i < pmb_nr; i++) {
 			struct moved_entry *prev = pmb[i].match;
 			struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1189,7 +1189,8 @@ static void mark_color_as_moved(struct diff_options *o,
 			 * The current line is the start of a new block.
 			 * Setup the set of potential blocks.
 			 */
-			for (; match; match = hashmap_get_next(hm, match)) {
+			for (; match; match = hashmap_get_next(hm,
+								&match->ent)) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 44a3ab1e31..2a1449013b 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -285,7 +285,7 @@ static int find_identical_files(struct hashmap *srcs,
 	p = hashmap_get_from_hash(srcs,
 				  hash_filespec(options->repo, target),
 				  NULL);
-	for (; p; p = hashmap_get_next(srcs, p)) {
+	for (; p; p = hashmap_get_next(srcs, &p->entry)) {
 		int score;
 		struct diff_filespec *source = p->filespec;
 
diff --git a/hashmap.c b/hashmap.c
index 777beda347..958a7dfe14 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -191,9 +191,10 @@ void *hashmap_get(const struct hashmap *map, const void *key, const void *keydat
 	return *find_entry_ptr(map, key, keydata);
 }
 
-void *hashmap_get_next(const struct hashmap *map, const void *entry)
+void *hashmap_get_next(const struct hashmap *map,
+			const struct hashmap_entry *entry)
 {
-	struct hashmap_entry *e = ((struct hashmap_entry *) entry)->next;
+	struct hashmap_entry *e = entry->next;
 	for (; e; e = e->next)
 		if (entry_equals(map, entry, e, NULL))
 			return e;
diff --git a/hashmap.h b/hashmap.h
index d635e0815a..8f55782dc9 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -318,7 +318,8 @@ static inline void *hashmap_get_from_hash(const struct hashmap *map,
  * `entry` is the hashmap_entry to start the search from, obtained via a previous
  * call to `hashmap_get` or `hashmap_get_next`.
  */
-void *hashmap_get_next(const struct hashmap *map, const void *entry);
+void *hashmap_get_next(const struct hashmap *map,
+			const struct hashmap_entry *entry);
 
 /*
  * Adds a hashmap entry. This allows to add duplicate entries (i.e.
diff --git a/name-hash.c b/name-hash.c
index 8b33c5cb59..e90660c94f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -711,7 +711,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	while (ce) {
 		if (same_name(ce, name, namelen, icase))
 			return ce;
-		ce = hashmap_get_next(&istate->name_hash, ce);
+		ce = hashmap_get_next(&istate->name_hash, &ce->ent);
 	}
 	return NULL;
 }
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 0c9fd7c996..bf063a2521 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -203,7 +203,7 @@ int cmd__hashmap(int argc, const char **argv)
 				puts("NULL");
 			while (entry) {
 				puts(get_value(entry));
-				entry = hashmap_get_next(&map, entry);
+				entry = hashmap_get_next(&map, &entry->ent);
 			}
 
 		} else if (!strcmp("remove", cmd) && p1) {
-- 
EW

