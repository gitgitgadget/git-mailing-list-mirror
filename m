Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CEDC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B1122CA1
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgLDS60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:58:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:51842 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgLDS6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 13:58:25 -0500
Received: (qmail 31873 invoked by uid 109); 4 Dec 2020 18:57:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 18:57:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14195 invoked by uid 111); 4 Dec 2020 18:57:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 13:57:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 13:57:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 8/9] commit-graph: replace packed_oid_list with oid_array
Message-ID: <X8qGqHvHbJQL9B22@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our custom packed_oid_list data structure is really just an oid_array in
disguise. Let's switch to using the generic structure, which shortens
and simplifies the code slightly.

There's one slightly awkward part: in the old code we copied a hash
straight from the mmap'd on-disk data into the final object_id. And now
we'll copy to a temporary oid, which we'll then pass to
oid_array_append(). But this is an operation we have to do all over the
commit-graph code already, since it mostly uses object_id structs
internally. I also measured "git commit-graph --append", which triggers
this code path, and it showed no difference.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 62 ++++++++++++--------------------------------------
 1 file changed, 15 insertions(+), 47 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1ac3516cf5..4a718fd6e6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -936,17 +936,11 @@ struct packed_commit_list {
 	int alloc;
 };
 
-struct packed_oid_list {
-	struct object_id *list;
-	int nr;
-	int alloc;
-};
-
 struct write_commit_graph_context {
 	struct repository *r;
 	struct object_directory *odb;
 	char *graph_name;
-	struct packed_oid_list oids;
+	struct oid_array oids;
 	struct packed_commit_list commits;
 	int num_extra_edges;
 	unsigned long approx_nr_objects;
@@ -1240,13 +1234,6 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	return 0;
 }
 
-static int oid_compare(const void *_a, const void *_b)
-{
-	const struct object_id *a = (const struct object_id *)_a;
-	const struct object_id *b = (const struct object_id *)_b;
-	return oidcmp(a, b);
-}
-
 static int add_packed_commits(const struct object_id *oid,
 			      struct packed_git *pack,
 			      uint32_t pos,
@@ -1267,10 +1254,7 @@ static int add_packed_commits(const struct object_id *oid,
 	if (type != OBJ_COMMIT)
 		return 0;
 
-	ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
-	oidcpy(&(ctx->oids.list[ctx->oids.nr]), oid);
-	ctx->oids.nr++;
-
+	oid_array_append(&ctx->oids, oid);
 	set_commit_pos(ctx->r, oid);
 
 	return 0;
@@ -1281,9 +1265,7 @@ static void add_missing_parents(struct write_commit_graph_context *ctx, struct c
 	struct commit_list *parent;
 	for (parent = commit->parents; parent; parent = parent->next) {
 		if (!(parent->item->object.flags & REACHABLE)) {
-			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
-			oidcpy(&ctx->oids.list[ctx->oids.nr], &(parent->item->object.oid));
-			ctx->oids.nr++;
+			oid_array_append(&ctx->oids, &parent->item->object.oid);
 			parent->item->object.flags |= REACHABLE;
 		}
 	}
@@ -1302,7 +1284,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 					ctx->oids.nr);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
+		commit = lookup_commit(ctx->r, &ctx->oids.oid[i]);
 		if (commit)
 			commit->object.flags |= REACHABLE;
 	}
@@ -1319,7 +1301,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 					0);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
+		commit = lookup_commit(ctx->r, &ctx->oids.oid[i]);
 
 		if (!commit)
 			continue;
@@ -1339,7 +1321,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 					ctx->oids.nr);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
+		commit = lookup_commit(ctx->r, &ctx->oids.oid[i]);
 
 		if (commit)
 			commit->object.flags &= ~REACHABLE;
@@ -1567,9 +1549,7 @@ static int fill_oids_from_commits(struct write_commit_graph_context *ctx,
 
 	oidset_iter_init(commits, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
-		ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
-		oidcpy(&ctx->oids.list[ctx->oids.nr], oid);
-		ctx->oids.nr++;
+		oid_array_append(&ctx->oids, oid);
 	}
 
 	return 0;
@@ -1599,16 +1579,14 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 		ctx->progress = start_delayed_progress(
 			_("Finding extra edges in commit graph"),
 			ctx->oids.nr);
-	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
-	for (i = 0; i < ctx->oids.nr; i++) {
+	oid_array_sort(&ctx->oids);
+	for (i = 0; i < ctx->oids.nr; i = oid_array_next_unique(&ctx->oids, i)) {
 		unsigned int num_parents;
 
 		display_progress(ctx->progress, i + 1);
-		if (i > 0 && oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
-			continue;
 
 		ALLOC_GROW(ctx->commits.list, ctx->commits.nr + 1, ctx->commits.alloc);
-		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
+		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.oid[i]);
 
 		if (ctx->split && flags != COMMIT_GRAPH_SPLIT_REPLACE &&
 		    commit_graph_position(ctx->commits.list[ctx->commits.nr]) != COMMIT_NOT_FROM_GRAPH)
@@ -2199,26 +2177,16 @@ int write_commit_graph(struct object_directory *odb,
 	}
 
 	ctx->approx_nr_objects = approximate_object_count();
-	ctx->oids.alloc = ctx->approx_nr_objects / 32;
 
-	if (ctx->split && opts && ctx->oids.alloc > opts->max_commits)
-		ctx->oids.alloc = opts->max_commits;
-
-	if (ctx->append) {
+	if (ctx->append)
 		prepare_commit_graph_one(ctx->r, ctx->odb);
-		if (ctx->r->objects->commit_graph)
-			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
-	}
-
-	if (ctx->oids.alloc < 1024)
-		ctx->oids.alloc = 1024;
-	ALLOC_ARRAY(ctx->oids.list, ctx->oids.alloc);
 
 	if (ctx->append && ctx->r->objects->commit_graph) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
-			const unsigned char *hash = g->chunk_oid_lookup + g->hash_len * i;
-			hashcpy(ctx->oids.list[ctx->oids.nr++].hash, hash);
+			struct object_id oid;
+			hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+			oid_array_append(&ctx->oids, &oid);
 		}
 	}
 
@@ -2274,7 +2242,7 @@ int write_commit_graph(struct object_directory *odb,
 cleanup:
 	free(ctx->graph_name);
 	free(ctx->commits.list);
-	free(ctx->oids.list);
+	oid_array_clear(&ctx->oids);
 
 	if (ctx->commit_graph_filenames_after) {
 		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
-- 
2.29.2.896.g080220a959

