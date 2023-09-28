Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0319CE7AFE
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 04:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjI1EjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI1EjD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 00:39:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891AA122
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 21:39:01 -0700 (PDT)
Received: (qmail 3702 invoked by uid 109); 28 Sep 2023 04:39:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Sep 2023 04:39:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9668 invoked by uid 111); 28 Sep 2023 04:39:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Sep 2023 00:39:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Sep 2023 00:38:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 4/6] commit-graph: detect read errors when verifying graph
 chain
Message-ID: <20230928043859.GD58367@coredump.intra.peff.net>
References: <20230928043746.GB57926@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928043746.GB57926@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because it's OK to not have a graph file at all, the graph_verify()
function needs to tell the difference between a missing file and a real
error.  So when loading a traditional graph file, we call
open_commit_graph() separately from load_commit_graph_chain_fd_st(), and
don't complain if the first one fails with ENOENT.

When the function learned about chain files in 3da4b609bb (commit-graph:
verify chains with --shallow mode, 2019-06-18), we couldn't be as
careful, since the only way to load a chain was with
read_commit_graph_one(), which did both the open/load as a single unit.
So we'll miss errors in chain files we load, thinking instead that there
was just no chain file at all.

Note that we do still report some of these problems to stderr, as the
loading function calls error() and warning(). But we'd exit with a
successful exit code, which is wrong.

We can fix that by using the recently split open/load functions for
chains. That lets us treat the chain file just like a single file with
respect to error handling here.

An existing test (from 3da4b609bb) shows off the problem; we were
expecting "commit-graph verify" to report success, but that makes no
sense. We did not even verify the contents of the graph data, because we
couldn't load it! I don't think this was an intentional exception, but
rather just the test covering what happened to occur.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit-graph.c        | 23 ++++++++++++++++-------
 t/t5324-split-commit-graph.sh |  4 ++--
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c88389df24..50c15d9bfe 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -69,7 +69,8 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb = NULL;
 	char *graph_name;
-	int open_ok;
+	char *chain_name;
+	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
 	int fd;
 	struct stat st;
 	int flags = 0;
@@ -102,21 +103,29 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 
 	odb = find_odb(the_repository, opts.obj_dir);
 	graph_name = get_commit_graph_filename(odb);
-	open_ok = open_commit_graph(graph_name, &fd, &st);
-	if (!open_ok && errno != ENOENT)
+	chain_name = get_commit_graph_chain_filename(odb);
+	if (open_commit_graph(graph_name, &fd, &st))
+		opened = OPENED_GRAPH;
+	else if (errno != ENOENT)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
+	else if (open_commit_graph_chain(chain_name, &fd, &st))
+		opened = OPENED_CHAIN;
+	else if (errno != ENOENT)
+		die_errno(_("could not open commit-graph chain '%s'"), chain_name);
 
 	FREE_AND_NULL(graph_name);
+	FREE_AND_NULL(chain_name);
 	FREE_AND_NULL(options);
 
-	if (open_ok)
+	if (opened == OPENED_NONE)
+		return 0;
+	else if (opened == OPENED_GRAPH)
 		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
 	else
-		graph = read_commit_graph_one(the_repository, odb);
+		graph = load_commit_graph_chain_fd_st(the_repository, fd, &st);
 
-	/* Return failure if open_ok predicted success */
 	if (!graph)
-		return !!open_ok;
+		return 1;
 
 	ret = verify_commit_graph(the_repository, graph, flags);
 	free_commit_graph(graph);
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index a9b2428b56..a5ac0440f1 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -317,11 +317,11 @@ test_expect_success 'verify after commit-graph-chain corruption (base)' '
 	(
 		cd verify-chain-base &&
 		corrupt_file "$graphdir/commit-graph-chain" 30 "G" &&
-		git commit-graph verify 2>test_err &&
+		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "invalid commit-graph chain" err &&
 		corrupt_file "$graphdir/commit-graph-chain" 30 "A" &&
-		git commit-graph verify 2>test_err &&
+		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "unable to find all commit-graph files" err
 	)
-- 
2.42.0.773.ga6e30199be

