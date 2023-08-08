Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D3BC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjHHUUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjHHUUK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:20:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE8A28A
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 12:25:41 -0700 (PDT)
Received: (qmail 4721 invoked by uid 109); 8 Aug 2023 19:25:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 19:25:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23210 invoked by uid 111); 8 Aug 2023 19:25:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 15:25:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 15:25:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: leak in jt/path-filter-fix, was Re: What's cooking in git.git
 (Aug 2023, #01; Wed, 2)
Message-ID: <20230808192540.GA319679@coredump.intra.peff.net>
References: <xmqqfs518gdh.fsf@gitster.g>
 <20230808192240.GA4091261@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808192240.GA4091261@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 03:22:41PM -0400, Jeff King wrote:

> Subject: [PATCH] commit-graph: fix small leak with invalid changedPathsVersion
> 
> When writing a commit graph, we sanity-check the value of
> commitgraph.changedPathsVersion and return early if it's invalid. But we
> only do so after allocating the write_commit_graph_context, meaing we
> leak it. We could "goto cleanup" to fix this, but instead let's push
> this check to the top of the function with the other early checks which
> return before doing any work.

I am tempted to do this on top, but maybe it is just churn. I dunno.

-- >8 --
Subject: [PATCH] commit-graph: store write context on stack rather than heap

In write_commit_graph(), we allocate our context struct on the heap.
But there's no reason to do so, since it's small and we always free it
when exiting the function. Converting it to a stack variable is slightly
more efficient, but also can prevent some leaks (such as the one fixed
in the previous commit, though to be fair this only helps for such a
limited leak; once any sub-fields of the struct require allocation, it
has to be cleaned up).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 140 ++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 71 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ccc21c6708..b8db056f37 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2358,7 +2358,7 @@ int write_commit_graph(struct object_directory *odb,
 		       const struct commit_graph_opts *opts)
 {
 	struct repository *r = the_repository;
-	struct write_commit_graph_context *ctx;
+	struct write_commit_graph_context ctx;
 	uint32_t i;
 	int res = 0;
 	int replace = 0;
@@ -2379,16 +2379,16 @@ int write_commit_graph(struct object_directory *odb,
 		return 0;
 	}
 
-	CALLOC_ARRAY(ctx, 1);
-	ctx->r = r;
-	ctx->odb = odb;
-	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
-	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
-	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
-	ctx->opts = opts;
-	ctx->total_bloom_filter_data_size = 0;
-	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
-	ctx->num_generation_data_overflows = 0;
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.r = r;
+	ctx.odb = odb;
+	ctx.append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
+	ctx.report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
+	ctx.split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
+	ctx.opts = opts;
+	ctx.total_bloom_filter_data_size = 0;
+	ctx.write_generation_data = (get_configured_generation_version(r) == 2);
+	ctx.num_generation_data_overflows = 0;
 
 	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
 		? 2 : 1;
@@ -2398,14 +2398,14 @@ int write_commit_graph(struct object_directory *odb,
 						  bloom_settings.num_hashes);
 	bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
 							 bloom_settings.max_changed_paths);
-	ctx->bloom_settings = &bloom_settings;
+	ctx.bloom_settings = &bloom_settings;
 
 	init_topo_level_slab(&topo_levels);
-	ctx->topo_levels = &topo_levels;
+	ctx.topo_levels = &topo_levels;
 
-	prepare_commit_graph(ctx->r);
-	if (ctx->r->objects->commit_graph) {
-		struct commit_graph *g = ctx->r->objects->commit_graph;
+	prepare_commit_graph(ctx.r);
+	if (ctx.r->objects->commit_graph) {
+		struct commit_graph *g = ctx.r->objects->commit_graph;
 
 		while (g) {
 			g->topo_levels = &topo_levels;
@@ -2414,128 +2414,126 @@ int write_commit_graph(struct object_directory *odb,
 	}
 
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
-		ctx->changed_paths = 1;
+		ctx.changed_paths = 1;
 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
 		struct commit_graph *g;
 
-		g = ctx->r->objects->commit_graph;
+		g = ctx.r->objects->commit_graph;
 
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->bloom_filter_settings) {
-			ctx->changed_paths = 1;
-			ctx->bloom_settings = g->bloom_filter_settings;
+			ctx.changed_paths = 1;
+			ctx.bloom_settings = g->bloom_filter_settings;
 		}
 	}
 
-	if (ctx->split) {
-		struct commit_graph *g = ctx->r->objects->commit_graph;
+	if (ctx.split) {
+		struct commit_graph *g = ctx.r->objects->commit_graph;
 
 		while (g) {
-			ctx->num_commit_graphs_before++;
+			ctx.num_commit_graphs_before++;
 			g = g->base_graph;
 		}
 
-		if (ctx->num_commit_graphs_before) {
-			ALLOC_ARRAY(ctx->commit_graph_filenames_before, ctx->num_commit_graphs_before);
-			i = ctx->num_commit_graphs_before;
-			g = ctx->r->objects->commit_graph;
+		if (ctx.num_commit_graphs_before) {
+			ALLOC_ARRAY(ctx.commit_graph_filenames_before, ctx.num_commit_graphs_before);
+			i = ctx.num_commit_graphs_before;
+			g = ctx.r->objects->commit_graph;
 
 			while (g) {
-				ctx->commit_graph_filenames_before[--i] = xstrdup(g->filename);
+				ctx.commit_graph_filenames_before[--i] = xstrdup(g->filename);
 				g = g->base_graph;
 			}
 		}
 
-		if (ctx->opts)
-			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
+		if (ctx.opts)
+			replace = ctx.opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
-	ctx->approx_nr_objects = repo_approximate_object_count(the_repository);
+	ctx.approx_nr_objects = repo_approximate_object_count(the_repository);
 
-	if (ctx->append && ctx->r->objects->commit_graph) {
-		struct commit_graph *g = ctx->r->objects->commit_graph;
+	if (ctx.append && ctx.r->objects->commit_graph) {
+		struct commit_graph *g = ctx.r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
 			oidread(&oid, g->chunk_oid_lookup + g->hash_len * i);
-			oid_array_append(&ctx->oids, &oid);
+			oid_array_append(&ctx.oids, &oid);
 		}
 	}
 
 	if (pack_indexes) {
-		ctx->order_by_pack = 1;
-		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
+		ctx.order_by_pack = 1;
+		if ((res = fill_oids_from_packs(&ctx, pack_indexes)))
 			goto cleanup;
 	}
 
 	if (commits) {
-		if ((res = fill_oids_from_commits(ctx, commits)))
+		if ((res = fill_oids_from_commits(&ctx, commits)))
 			goto cleanup;
 	}
 
 	if (!pack_indexes && !commits) {
-		ctx->order_by_pack = 1;
-		fill_oids_from_all_packs(ctx);
+		ctx.order_by_pack = 1;
+		fill_oids_from_all_packs(&ctx);
 	}
 
-	close_reachable(ctx);
+	close_reachable(&ctx);
 
-	copy_oids_to_commits(ctx);
+	copy_oids_to_commits(&ctx);
 
-	if (ctx->commits.nr >= GRAPH_EDGE_LAST_MASK) {
+	if (ctx.commits.nr >= GRAPH_EDGE_LAST_MASK) {
 		error(_("too many commits to write graph"));
 		res = -1;
 		goto cleanup;
 	}
 
-	if (!ctx->commits.nr && !replace)
+	if (!ctx.commits.nr && !replace)
 		goto cleanup;
 
-	if (ctx->split) {
-		split_graph_merge_strategy(ctx);
+	if (ctx.split) {
+		split_graph_merge_strategy(&ctx);
 
 		if (!replace)
-			merge_commit_graphs(ctx);
+			merge_commit_graphs(&ctx);
 	} else
-		ctx->num_commit_graphs_after = 1;
+		ctx.num_commit_graphs_after = 1;
 
-	ctx->trust_generation_numbers = validate_mixed_generation_chain(ctx->r->objects->commit_graph);
+	ctx.trust_generation_numbers = validate_mixed_generation_chain(ctx.r->objects->commit_graph);
 
-	compute_topological_levels(ctx);
-	if (ctx->write_generation_data)
-		compute_generation_numbers(ctx);
+	compute_topological_levels(&ctx);
+	if (ctx.write_generation_data)
+		compute_generation_numbers(&ctx);
 
-	if (ctx->changed_paths)
-		compute_bloom_filters(ctx);
+	if (ctx.changed_paths)
+		compute_bloom_filters(&ctx);
 
-	res = write_commit_graph_file(ctx);
+	res = write_commit_graph_file(&ctx);
 
-	if (ctx->split)
-		mark_commit_graphs(ctx);
+	if (ctx.split)
+		mark_commit_graphs(&ctx);
 
-	expire_commit_graphs(ctx);
+	expire_commit_graphs(&ctx);
 
 cleanup:
-	free(ctx->graph_name);
-	free(ctx->commits.list);
-	oid_array_clear(&ctx->oids);
+	free(ctx.graph_name);
+	free(ctx.commits.list);
+	oid_array_clear(&ctx.oids);
 	clear_topo_level_slab(&topo_levels);
 
-	if (ctx->commit_graph_filenames_after) {
-		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
-			free(ctx->commit_graph_filenames_after[i]);
-			free(ctx->commit_graph_hash_after[i]);
+	if (ctx.commit_graph_filenames_after) {
+		for (i = 0; i < ctx.num_commit_graphs_after; i++) {
+			free(ctx.commit_graph_filenames_after[i]);
+			free(ctx.commit_graph_hash_after[i]);
 		}
 
-		for (i = 0; i < ctx->num_commit_graphs_before; i++)
-			free(ctx->commit_graph_filenames_before[i]);
+		for (i = 0; i < ctx.num_commit_graphs_before; i++)
+			free(ctx.commit_graph_filenames_before[i]);
 
-		free(ctx->commit_graph_filenames_after);
-		free(ctx->commit_graph_filenames_before);
-		free(ctx->commit_graph_hash_after);
+		free(ctx.commit_graph_filenames_after);
+		free(ctx.commit_graph_filenames_before);
+		free(ctx.commit_graph_hash_after);
 	}
 
-	free(ctx);
-
 	return res;
 }
 
-- 
2.42.0.rc0.376.g66bfc4f195

