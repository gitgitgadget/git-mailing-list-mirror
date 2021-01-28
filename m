Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8AFC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8462764DC4
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhA1GU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:20:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:41640 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhA1GU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:20:27 -0500
Received: (qmail 9670 invoked by uid 109); 28 Jan 2021 06:19:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:19:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25361 invoked by uid 111); 28 Jan 2021 06:19:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:19:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:19:42 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] hash_pos(): convert to oid_pos()
Message-ID: <YBJXfl86Juv5kn16@coredump.intra.peff.net>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJVuckmbGriVa//@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of our callers are actually looking up an object_id, not a bare
hash. Likewise, the arrays they are looking in are actual arrays of
object_id (not just raw bytes of hashes, as we might find in a pack
.idx; those are handled by bsearch_hash()).

Using an object_id gives us more type safety, and makes the callers
slightly shorter. It also gets rid of the word "sha1" from several
access functions, though we could obviously also rename those with
s/sha1/hash/.

Signed-off-by: Jeff King <peff@peff.net>
---
If we don't want to make this change, I think it's still worth sweeping
through the callers and changing the names of their access functions.

 builtin/name-rev.c  |  8 ++++----
 commit-graph.c      | 28 ++++++++++++++--------------
 commit.c            | 10 +++++-----
 hash-lookup.c       | 18 +++++++++---------
 hash-lookup.h       | 10 +++++-----
 oid-array.c         |  6 +++---
 pack-bitmap-write.c |  6 +++---
 7 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 3fe71a8c01..27138fdce4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -390,10 +390,10 @@ static void name_tips(void)
 	}
 }
 
-static const unsigned char *nth_tip_table_ent(size_t ix, void *table_)
+static const struct object_id *nth_tip_table_ent(size_t ix, void *table_)
 {
 	struct tip_table_entry *table = table_;
-	return table[ix].oid.hash;
+	return &table[ix].oid;
 }
 
 static const char *get_exact_ref_match(const struct object *o)
@@ -408,8 +408,8 @@ static const char *get_exact_ref_match(const struct object *o)
 		tip_table.sorted = 1;
 	}
 
-	found = hash_pos(o->oid.hash, tip_table.table, tip_table.nr,
-			 nth_tip_table_ent);
+	found = oid_pos(&o->oid, tip_table.table, tip_table.nr,
+			nth_tip_table_ent);
 	if (0 <= found)
 		return tip_table.table[found].refname;
 	return NULL;
diff --git a/commit-graph.c b/commit-graph.c
index f3486ec18f..248f1efb73 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1012,10 +1012,10 @@ static int write_graph_chunk_oids(struct hashfile *f,
 	return 0;
 }
 
-static const unsigned char *commit_to_sha1(size_t index, void *table)
+static const struct object_id *commit_to_oid(size_t index, void *table)
 {
 	struct commit **commits = table;
-	return commits[index]->object.oid.hash;
+	return &commits[index]->object.oid;
 }
 
 static int write_graph_chunk_data(struct hashfile *f,
@@ -1043,10 +1043,10 @@ static int write_graph_chunk_data(struct hashfile *f,
 		if (!parent)
 			edge_value = GRAPH_PARENT_NONE;
 		else {
-			edge_value = hash_pos(parent->item->object.oid.hash,
-					      ctx->commits.list,
-					      ctx->commits.nr,
-					      commit_to_sha1);
+			edge_value = oid_pos(&parent->item->object.oid,
+					     ctx->commits.list,
+					     ctx->commits.nr,
+					     commit_to_oid);
 
 			if (edge_value >= 0)
 				edge_value += ctx->new_num_commits_in_base;
@@ -1074,10 +1074,10 @@ static int write_graph_chunk_data(struct hashfile *f,
 		else if (parent->next)
 			edge_value = GRAPH_EXTRA_EDGES_NEEDED | num_extra_edges;
 		else {
-			edge_value = hash_pos(parent->item->object.oid.hash,
-					      ctx->commits.list,
-					      ctx->commits.nr,
-					      commit_to_sha1);
+			edge_value = oid_pos(&parent->item->object.oid,
+					     ctx->commits.list,
+					     ctx->commits.nr,
+					     commit_to_oid);
 
 			if (edge_value >= 0)
 				edge_value += ctx->new_num_commits_in_base;
@@ -1143,10 +1143,10 @@ static int write_graph_chunk_extra_edges(struct hashfile *f,
 
 		/* Since num_parents > 2, this initializer is safe. */
 		for (parent = (*list)->parents->next; parent; parent = parent->next) {
-			int edge_value = hash_pos(parent->item->object.oid.hash,
-						  ctx->commits.list,
-						  ctx->commits.nr,
-						  commit_to_sha1);
+			int edge_value = oid_pos(&parent->item->object.oid,
+						 ctx->commits.list,
+						 ctx->commits.nr,
+						 commit_to_oid);
 
 			if (edge_value >= 0)
 				edge_value += ctx->new_num_commits_in_base;
diff --git a/commit.c b/commit.c
index fa26729ba5..39eab5b36b 100644
--- a/commit.c
+++ b/commit.c
@@ -105,17 +105,17 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
-static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
+static const struct object_id *commit_graft_oid_access(size_t index, void *table)
 {
 	struct commit_graft **commit_graft_table = table;
-	return commit_graft_table[index]->oid.hash;
+	return &commit_graft_table[index]->oid;
 }
 
 int commit_graft_pos(struct repository *r, const struct object_id *oid)
 {
-	return hash_pos(oid->hash, r->parsed_objects->grafts,
-			r->parsed_objects->grafts_nr,
-			commit_graft_sha1_access);
+	return oid_pos(oid, r->parsed_objects->grafts,
+		       r->parsed_objects->grafts_nr,
+		       commit_graft_oid_access);
 }
 
 int register_commit_graft(struct repository *r, struct commit_graft *graft,
diff --git a/hash-lookup.c b/hash-lookup.c
index 1191856a32..d15bb34574 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -1,9 +1,9 @@
 #include "cache.h"
 #include "hash-lookup.h"
 
-static uint32_t take2(const unsigned char *hash)
+static uint32_t take2(const struct object_id *oid, size_t ofs)
 {
-	return ((hash[0] << 8) | hash[1]);
+	return ((oid->hash[ofs] << 8) | oid->hash[ofs + 1]);
 }
 
 /*
@@ -47,11 +47,11 @@ static uint32_t take2(const unsigned char *hash)
  */
 /*
  * The table should contain "nr" elements.
- * The hash of element i (between 0 and nr - 1) should be returned
+ * The oid of element i (between 0 and nr - 1) should be returned
  * by "fn(i, table)".
  */
-int hash_pos(const unsigned char *hash, void *table, size_t nr,
-	     hash_access_fn fn)
+int oid_pos(const struct object_id *oid, void *table, size_t nr,
+	    oid_access_fn fn)
 {
 	size_t hi = nr;
 	size_t lo = 0;
@@ -64,9 +64,9 @@ int hash_pos(const unsigned char *hash, void *table, size_t nr,
 		size_t lov, hiv, miv, ofs;
 
 		for (ofs = 0; ofs < the_hash_algo->rawsz - 2; ofs += 2) {
-			lov = take2(fn(0, table) + ofs);
-			hiv = take2(fn(nr - 1, table) + ofs);
-			miv = take2(hash + ofs);
+			lov = take2(fn(0, table), ofs);
+			hiv = take2(fn(nr - 1, table), ofs);
+			miv = take2(oid, ofs);
 			if (miv < lov)
 				return -1;
 			if (hiv < miv)
@@ -88,7 +88,7 @@ int hash_pos(const unsigned char *hash, void *table, size_t nr,
 
 	do {
 		int cmp;
-		cmp = hashcmp(fn(mi, table), hash);
+		cmp = oidcmp(fn(mi, table), oid);
 		if (!cmp)
 			return mi;
 		if (cmp > 0)
diff --git a/hash-lookup.h b/hash-lookup.h
index 5d476dec72..7b3ecad1f0 100644
--- a/hash-lookup.h
+++ b/hash-lookup.h
@@ -1,12 +1,12 @@
 #ifndef HASH_LOOKUP_H
 #define HASH_LOOKUP_H
 
-typedef const unsigned char *hash_access_fn(size_t index, void *table);
+typedef const struct object_id *oid_access_fn(size_t index, void *table);
 
-int hash_pos(const unsigned char *hash,
-	     void *table,
-	     size_t nr,
-	     hash_access_fn fn);
+int oid_pos(const struct object_id *oid,
+	    void *table,
+	    size_t nr,
+	    oid_access_fn fn);
 
 /*
  * Searches for hash in table, using the given fanout table to determine the
diff --git a/oid-array.c b/oid-array.c
index 889b311f22..a19235afbf 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -22,16 +22,16 @@ void oid_array_sort(struct oid_array *array)
 	array->sorted = 1;
 }
 
-static const unsigned char *sha1_access(size_t index, void *table)
+static const struct object_id *oid_access(size_t index, void *table)
 {
 	struct object_id *array = table;
-	return array[index].hash;
+	return &array[index];
 }
 
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
 	oid_array_sort(array);
-	return hash_pos(oid->hash, array->oid, array->nr, sha1_access);
+	return oid_pos(oid, array->oid, array->nr, oid_access);
 }
 
 void oid_array_clear(struct oid_array *array)
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 92460a6126..f21259dfc8 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -610,10 +610,10 @@ static inline void dump_bitmap(struct hashfile *f, struct ewah_bitmap *bitmap)
 		die("Failed to write bitmap index");
 }
 
-static const unsigned char *sha1_access(size_t pos, void *table)
+static const struct object_id *oid_access(size_t pos, void *table)
 {
 	struct pack_idx_entry **index = table;
-	return index[pos]->oid.hash;
+	return &index[pos]->oid;
 }
 
 static void write_selected_commits_v1(struct hashfile *f,
@@ -626,7 +626,7 @@ static void write_selected_commits_v1(struct hashfile *f,
 		struct bitmapped_commit *stored = &writer.selected[i];
 
 		int commit_pos =
-			hash_pos(stored->commit->object.oid.hash, index, index_nr, sha1_access);
+			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
 
 		if (commit_pos < 0)
 			BUG("trying to write commit not in index");
-- 
2.30.0.758.gfe500d6872

