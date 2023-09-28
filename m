Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE06CE7AFE
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 04:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjI1Ejz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1Ejy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 00:39:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F1121
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 21:39:52 -0700 (PDT)
Received: (qmail 3733 invoked by uid 109); 28 Sep 2023 04:39:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Sep 2023 04:39:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9678 invoked by uid 111); 28 Sep 2023 04:39:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Sep 2023 00:39:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Sep 2023 00:39:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 6/6] commit-graph: report incomplete chains during
 verification
Message-ID: <20230928043951.GF58367@coredump.intra.peff.net>
References: <20230928043746.GB57926@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928043746.GB57926@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The load_commit_graph_chain_fd_st() function will stop loading chains
when it sees an error. But if it has loaded any graph slice at all, it
will return it. This is a good thing for normal use (we use what data we
can, and this is just an optimization). But it's a bad thing for
"commit-graph verify", which should be careful about finding any
irregularities. We do complain to stderr with a warning(), but the
verify command still exits with a successful return code.

The new tests here cover corruption of both the base and tip slices of
the chain. The corruption of the base file already works (it is the
first file we look at, so when we see the error we return NULL). The
"tip" case is what is fixed by this patch (it complains to stderr but
still returns the base slice).

Likewise the existing tests for corruption of the commit-graph-chain
file itself need to be updated. We already exited non-zero correctly for
the "base" case, but the "tip" case can now do so, too.

Note that this also causes us to adjust a test later in the file that
similarly corrupts a tip (though confusingly the test script calls this
"base"). It checks stderr but erroneously expects the whole "verify"
command to exit with a successful code.

Signed-off-by: Jeff King <peff@peff.net>
---
v2 now covers failed get_oid_hex() call on non-base lines.

 builtin/commit-graph.c        | 10 +++++++++-
 commit-graph.c                |  7 +++++--
 commit-graph.h                |  3 ++-
 t/t5324-split-commit-graph.sh | 32 +++++++++++++++++++++++++++++---
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 50c15d9bfe..f5e66e9969 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -74,6 +74,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	int fd;
 	struct stat st;
 	int flags = 0;
+	int incomplete_chain = 0;
 	int ret;
 
 	static struct option builtin_commit_graph_verify_options[] = {
@@ -122,13 +123,20 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	else if (opened == OPENED_GRAPH)
 		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
 	else
-		graph = load_commit_graph_chain_fd_st(the_repository, fd, &st);
+		graph = load_commit_graph_chain_fd_st(the_repository, fd, &st,
+						      &incomplete_chain);
 
 	if (!graph)
 		return 1;
 
 	ret = verify_commit_graph(the_repository, graph, flags);
 	free_commit_graph(graph);
+
+	if (incomplete_chain) {
+		error("one or more commit-graph chain files could not be loaded");
+		ret |= 1;
+	}
+
 	return ret;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index b1d3e5bf94..1a56efcf69 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -563,7 +563,8 @@ int open_commit_graph_chain(const char *chain_file,
 }
 
 struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
-						   int fd, struct stat *st)
+						   int fd, struct stat *st,
+						   int *incomplete_chain)
 {
 	struct commit_graph *graph_chain = NULL;
 	struct strbuf line = STRBUF_INIT;
@@ -618,6 +619,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	fclose(fp);
 	strbuf_release(&line);
 
+	*incomplete_chain = !valid;
 	return graph_chain;
 }
 
@@ -630,8 +632,9 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	struct commit_graph *g = NULL;
 
 	if (open_commit_graph_chain(chain_file, &fd, &st)) {
+		int incomplete;
 		/* ownership of fd is taken over by load function */
-		g = load_commit_graph_chain_fd_st(r, fd, &st);
+		g = load_commit_graph_chain_fd_st(r, fd, &st, &incomplete);
 	}
 
 	free(chain_file);
diff --git a/commit-graph.h b/commit-graph.h
index 3b662fd2b5..20ada7e891 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -107,7 +107,8 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 int fd, struct stat *st,
 						 struct object_directory *odb);
 struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
-						   int fd, struct stat *st);
+						   int fd, struct stat *st,
+						   int *incomplete_chain);
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index be58545810..06bb897f02 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -285,6 +285,32 @@ test_expect_success 'verify hashes along chain, even in shallow' '
 	)
 '
 
+test_expect_success 'verify notices chain slice which is bogus (base)' '
+	git clone --no-hardlinks . verify-chain-bogus-base &&
+	(
+		cd verify-chain-bogus-base &&
+		git commit-graph verify &&
+		base_file=$graphdir/graph-$(sed -n 1p $graphdir/commit-graph-chain).graph &&
+		echo "garbage" >$base_file &&
+		test_must_fail git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		grep "commit-graph file is too small" err
+	)
+'
+
+test_expect_success 'verify notices chain slice which is bogus (tip)' '
+	git clone --no-hardlinks . verify-chain-bogus-tip &&
+	(
+		cd verify-chain-bogus-tip &&
+		git commit-graph verify &&
+		tip_file=$graphdir/graph-$(sed -n 2p $graphdir/commit-graph-chain).graph &&
+		echo "garbage" >$tip_file &&
+		test_must_fail git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		grep "commit-graph file is too small" err
+	)
+'
+
 test_expect_success 'verify --shallow does not check base contents' '
 	git clone --no-hardlinks . verify-shallow &&
 	(
@@ -306,7 +332,7 @@ test_expect_success 'warn on base graph chunk incorrect' '
 		git commit-graph verify &&
 		base_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
 		corrupt_file "$base_file" $(test_oid base) "\01" &&
-		git commit-graph verify --shallow 2>test_err &&
+		test_must_fail git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "commit-graph chain does not match" err
 	)
@@ -332,11 +358,11 @@ test_expect_success 'verify after commit-graph-chain corruption (tip)' '
 	(
 		cd verify-chain-tip &&
 		corrupt_file "$graphdir/commit-graph-chain" 70 "G" &&
-		git commit-graph verify 2>test_err &&
+		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "invalid commit-graph chain" err &&
 		corrupt_file "$graphdir/commit-graph-chain" 70 "A" &&
-		git commit-graph verify 2>test_err &&
+		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "unable to find all commit-graph files" err
 	)
-- 
2.42.0.773.ga6e30199be
