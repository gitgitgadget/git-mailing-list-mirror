Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E92566A
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6000 invoked by uid 109); 5 Jan 2024 05:41:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Jan 2024 05:41:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1705 invoked by uid 111); 5 Jan 2024 05:41:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Jan 2024 00:41:44 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Jan 2024 00:41:42 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Scott Leggett <scott@sl.id.au>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] commit-graph: retain commit slab when closing NULL
 commit_graph
Message-ID: <20240105054142.GA2035092@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This fixes a regression introduced in ac6d45d11f (commit-graph: move
slab-clearing to close_commit_graph(), 2023-10-03), in which running:

  git -c fetch.writeCommitGraph=true fetch --recurse-submodules

multiple times in a freshly cloned repository causes a segfault. What
happens in the second (and subsequent) runs is this:

  1. We make a "struct commit" for any ref tips which we're storing
     (even if we already have them, they still go into FETCH_HEAD).

     Because the first run will have created a commit graph, we'll find
     those commits in the graph.

     The commit struct is therefore created with a NULL "maybe_tree"
     entry, because we can load its oid from the graph later. But to do
     that we need to remember that we got the commit from the graph,
     which is recorded in a global commit_graph_data_slab object.

  2. Because we're using --recurse-submodules, we'll try to fetch each
     of the possible submodules. That implies creating a separate
     "struct repository" in-process for each submodule, which will
     require a later call to repo_clear().

     The call to repo_clear() calls raw_object_store_clear(), which in
     turn calls close_object_store(), which in turn calls
     close_commit_graph(). And the latter frees the commit graph data
     slab.

  3. Later, when trying to write out a new commit graph, we'll ask for
     their tree oid via get_commit_tree_oid(), which will see that the
     object is parsed but with a NULL maybe_tree field. We'd then
     usually pull it from the graph file, but because the slab was
     cleared, we don't realize that we can do so! We end up returning
     NULL and segfaulting.

     (It seems questionable that we'd write a graph entry for such a
     commit anyway, since we know we already have one. I didn't
     double-check, but that may simply be another side effect of having
     cleared the slab).

The bug is in step (2) above. We should not be clearing the slab when
cleaning up the submodule repository structs. Prior to ac6d45d11f, we
did not do so because it was done inside a helper function that returned
early when it saw NULL. So the behavior change from that commit is that
we'll now _always_ clear the slab via repo_clear(), even if the
repository being closed did not have a commit graph (and thus would have
a NULL commit_graph struct).

The most immediate fix is to add in a NULL check in close_commit_graph(),
making it a true noop when passed in an object_store with a NULL
commit_graph (it's OK to just return early, since the rest of its code
is already a noop when passed NULL). That restores the pre-ac6d45d11f
behavior. And that's what this patch does, along with a test that
exercises it (we already have a test that uses submodules along with
fetch.writeCommitGraph, but the bug only triggers when there is a
subsequent fetch and when that fetch uses --recurse-submodules).

So that fixes the regression in the least-risky way possible.

I do think there's some fragility here that we might want to follow up
on. We have a global commit_graph_data_slab that contains graph
positions, and our global commit structs depend on the that slab
remaining valid. But close_commit_graph() is just about closing _one_
object store's graph. So it's dangerous to call that function and clear
the slab without also throwing away any "struct commit" we might have
parsed that depends on it.

Which at first glance seems like a bug we could already trigger. In the
situation described here, there is no commit graph in the submodule
repository, so our commit graph is NULL (in fact, in our test script
there is no submodule repo at all, so we immediately return from
repo_init() and call repo_clear() only to free up memory). But what
would happen if there was one? Wouldn't we see a non-NULL commit_graph
entry, and then clear the global slab anyway?

The answer is "no", but for very bizarre reasons. Remember that
repo_clear() calls raw_object_store_clear(), which then calls
close_object_store() and thus close_commit_graph(). But before it does
so, raw_object_store_clear() does something else: it frees the commit
graph and sets it to NULL! So by this code path we'll _never_ see a
non-NULL commit_graph struct, and thus never clear the slab.

So it happens to work out. But it still seems questionable to me that we
would clear a global slab (which might still be in use) when closing the
commit graph. This clearing comes from 957ba814bf (commit-graph: when
closing the graph, also release the slab, 2021-09-08), and was fixing a
case where we really did need it to be closed (and in that case we
presumably call close_object_store() more directly).

So I suspect there may still be a bug waiting to happen there, as any
object loaded before the call to close_object_store() may be stranded
with a bogus maybe_tree entry (and thus looking at it after the call
might cause an error). But I'm not sure how to trigger it, nor what the
fix should look like (you probably would need to "unparse" any objects
pulled from the graph). And so this patch punts on that for now in favor
of fixing the recent regression in the most direct way, which should not
have any other fallouts.

Signed-off-by: Jeff King <peff@peff.net>
---
I prepared this on top of jk/commit-graph-leak-fixes, which is the
branch in v2.43.0 that introduced the regression.

 commit-graph.c   | 3 +++
 t/t5510-fetch.sh | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index e4d09da090..f26503295a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -727,6 +727,9 @@ struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 
 void close_commit_graph(struct raw_object_store *o)
 {
+	if (!o->commit_graph)
+		return;
+
 	clear_commit_graph_data_slab(&commit_graph_data_slab);
 	free_commit_graph(o->commit_graph);
 	o->commit_graph = NULL;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 19c36b57f4..bcf524d549 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -802,7 +802,8 @@ test_expect_success 'fetch.writeCommitGraph with submodules' '
 		cd super-clone &&
 		rm -rf .git/objects/info &&
 		git -c fetch.writeCommitGraph=true fetch origin &&
-		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain
+		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain &&
+		git -c fetch.writeCommitGraph=true fetch --recurse-submodules origin
 	)
 '
 
-- 
2.43.0.514.g7147b80757
