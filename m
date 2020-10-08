Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD2FC43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 12:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFC320B1F
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 12:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgJHMHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 08:07:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbgJHMHA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 08:07:00 -0400
Received: (qmail 28279 invoked by uid 109); 8 Oct 2020 12:06:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Oct 2020 12:06:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22902 invoked by uid 111); 8 Oct 2020 12:06:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Oct 2020 08:06:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Oct 2020 08:06:58 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
Message-ID: <20201008120658.GA2689590@coredump.intra.peff.net>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
 <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 11:52:03AM +0200, Thomas Braun wrote:

> > Is it possible to share the contents of your .git directory? If not, can
> > you look in .git/objects/info/ and see if there are multiple
> > commit-graph files (and if so, possibly share those; they don't contain
> > any identifying info).
> 
> Yes sure, I can share that [1]. Thanks for looking into that.
> 
> [1]:
> http://byte-physics.de/Downloads/dotGitWriteCommitGraphDuplicatedCommitIssue.tar.gz

Thanks, I was able to easily reproduce with:

  # make a cheap copy of the repo; if our test succeeds it modifies the
  # graph files, so just try it on a fresh copy each time
  rm -rf repo.git
  cp -al /path/to/extracted/tarball/.git repo.git
  git -C repo.git -c fetch.writecommitgraph fetch .

which yields:

  From .
   * branch                HEAD       -> FETCH_HEAD
  fatal: unexpected duplicate commit id 31a13139875bc5f49ddcbd42b4b4d3dc18c16576

The good news is that this isn't a regression in v2.29. The bad news is
that it's been broken for many versions. :)

To solve your immediate problem, you can just remove the whole
.git/objects/info/commit-graphs directory. It doesn't have any data that
can't be regenerated from the actual objects.

The rest of this email is my look at what the actual bug is.

Bisecting finds a very curious culprit: 0bd52e27e3 (commit-graph.h:
store an odb in 'struct write_commit_graph_context', 2020-02-03). That
commit causes us to use a more consistent object directory name. As a
result, this loop in split_graph_merge_strategy():

        while (g && (g->num_commits <= size_mult * num_commits ||
                    (max_commits && num_commits > max_commits))) {
                if (strcmp(g->obj_dir, ctx->odb->path))
                        break;

                num_commits += g->num_commits;
                g = g->base_graph;

                ctx->num_commit_graphs_after--;
        }

does not trigger the "break" on the strcmp, whereas before that commit
it did. As a result, our "after" graph count is smaller (2 versus 4).
And then later in merge_commit_graphs(), we know we're shrinking the
number of graphs, so we add in the contents of those graph files.

So I _think_ everything being done by that patch is correct, and we
didn't see the problem before simply because we were erroneously not
rolling up the graph files. And once we do, we can see that indeed we
have the same commit in two files. If I instrument the commit-graph code
like this (I couldn't find a command to dump incremental graph file
data; is there one?):

diff --git a/commit-graph.c b/commit-graph.c
index cbfeece112..4d22fa3b41 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1603,13 +1603,16 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
 
 	ALLOC_GROW(ctx->commits.list, ctx->commits.nr + g->num_commits, ctx->commits.alloc);
 
+	warning("opening graph file %s", g->filename);
+
 	for (i = 0; i < g->num_commits; i++) {
 		struct object_id oid;
 		struct commit *result;
 
 		display_progress(ctx->progress, i + 1);
 
 		load_oid_from_graph(g, i + offset, &oid);
+		warning("has oid %s", oid_to_hex(&oid));
 
 		/* only add commits if they still exist in the repo */
 		result = lookup_commit_reference_gently(ctx->r, &oid, 1);

I see:

  warning: opening graph file objects/info/commit-graphs/graph-6ed4c0bfb0adcc15a7dc58159b3652a23d6d8c14.graph
  ...
  warning: has oid 31a13139875bc5f49ddcbd42b4b4d3dc18c16576
  ...
  warning: opening graph file objects/info/commit-graphs/graph-6444f51143e12b3f34c031e60a672d2b29d1c09e.graph
  ...
  warning: has oid 31a13139875bc5f49ddcbd42b4b4d3dc18c16576

I'm not sure how that happened, and whether it's a bug that we got into
this state at all. But regardless, it seems unfriendly that we can't
get out of it while merging the graphs. Doing this obviously makes the
problem go away:

diff --git a/commit-graph.c b/commit-graph.c
index cb042bdba8..ae1f94ccc4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2023,8 +2023,11 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
 		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
 			  &ctx->commits.list[i]->object.oid)) {
-			die(_("unexpected duplicate commit id %s"),
-			    oid_to_hex(&ctx->commits.list[i]->object.oid));
+			/*
+			 * quietly ignore duplicates; these could come from
+			 * incremental graph files mentioning the same commit.
+			 */
+			continue;
 		} else {
 			unsigned int num_parents;
 

but it's not clear to me if that's papering over another bug, or
gracefully handling a situation that we ought to be.

-Peff
