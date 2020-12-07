Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B661C4167B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0AFB23428
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLGTLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:11:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:55268 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgLGTLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:11:43 -0500
Received: (qmail 9050 invoked by uid 109); 7 Dec 2020 19:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 19:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25684 invoked by uid 111); 7 Dec 2020 19:11:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 14:11:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 14:11:02 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 7/9] commit-graph: drop count_distinct_commits() function
Message-ID: <X85+RnO5rJQHnmmB@coredump.intra.peff.net>
References: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a commit graph, we collect a list of object ids in an
array, which we'll eventually copy into an array of "struct commit"
pointers. Before we do that, though, we count the number of distinct
commit entries. There's a subtle bug in this step, though.

We eliminate not only duplicate oids, but also in split mode, any oids
which are not commits or which are already in a graph file. However, the
loop starts at index 1, always counting index 0 as distinct. And indeed
it can't be a duplicate, since we check for those by comparing against
the previous entry, and there isn't one for index 0. But it could be a
commit that's already in a graph file, and we'd overcount the number of
commits by 1 in that case.

That turns out not to be a problem, though. The only things we do with
the count are:

  - check if our count will overflow our data structures. But the limit
    there is 2^31 commits, so while this is a useful check, the
    off-by-one is not likely to matter.

  - pre-allocate the array of commit pointers. But over-allocating by
    one isn't a problem; we'll just waste a few extra bytes.

The bug would be easy enough to fix, but we can observe that neither of
those steps is necessary.

After building the actual commit array, we'll likewise check its count
for overflow. So the extra check of the distinct commit count here is
redundant.

And likewise we use ALLOC_GROW() when building the commit array, so
there's no need to preallocate it (it's possible that doing so is
slightly more efficient, but if we care we can just optimistically
allocate one slot for each oid; I didn't bother here).

So count_distinct_commits() isn't doing anything useful. Let's just get
rid of that step.

Note that a side effect of the function was that we sorted the list of
oids, which we do rely on in copy_oids_to_commits(), since it must also
skip the duplicates. So we'll move the qsort there. I didn't copy the
"TODO" about adding more progress meters. It's actually quite hard to
make a repository large enough for this qsort would take an appreciable
amount of time, so this doesn't seem like a useful note.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 43 ++-----------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6f62a07313..1ac3516cf5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1588,35 +1588,6 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
-{
-	uint32_t i, count_distinct = 1;
-
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-			_("Counting distinct commits in commit graph"),
-			ctx->oids.nr);
-	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
-
-	for (i = 1; i < ctx->oids.nr; i++) {
-		display_progress(ctx->progress, i + 1);
-		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i])) {
-			if (ctx->split) {
-				struct commit *c = lookup_commit(ctx->r, &ctx->oids.list[i]);
-
-				if (!c || commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
-					continue;
-			}
-
-			count_distinct++;
-		}
-	}
-	stop_progress(&ctx->progress);
-
-	return count_distinct;
-}
-
 static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
@@ -1628,6 +1599,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 		ctx->progress = start_delayed_progress(
 			_("Finding extra edges in commit graph"),
 			ctx->oids.nr);
+	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		unsigned int num_parents;
 
@@ -2155,7 +2127,7 @@ int write_commit_graph(struct object_directory *odb,
 		       const struct commit_graph_opts *opts)
 {
 	struct write_commit_graph_context *ctx;
-	uint32_t i, count_distinct = 0;
+	uint32_t i;
 	int res = 0;
 	int replace = 0;
 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
@@ -2268,17 +2240,6 @@ int write_commit_graph(struct object_directory *odb,
 
 	close_reachable(ctx);
 
-	count_distinct = count_distinct_commits(ctx);
-
-	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
-		error(_("the commit graph format cannot write %d commits"), count_distinct);
-		res = -1;
-		goto cleanup;
-	}
-
-	ctx->commits.alloc = count_distinct;
-	ALLOC_ARRAY(ctx->commits.list, ctx->commits.alloc);
-
 	copy_oids_to_commits(ctx);
 
 	if (ctx->commits.nr >= GRAPH_EDGE_LAST_MASK) {
-- 
2.29.2.980.g762a4e4ed3

