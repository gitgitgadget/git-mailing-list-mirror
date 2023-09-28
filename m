Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C2CE7AFB
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 04:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjI1Ehu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1Eht (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 00:37:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02134121
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 21:37:47 -0700 (PDT)
Received: (qmail 3654 invoked by uid 109); 28 Sep 2023 04:37:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Sep 2023 04:37:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9638 invoked by uid 111); 28 Sep 2023 04:37:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Sep 2023 00:37:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Sep 2023 00:37:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 0/6] some "commit-graph verify" fixes for chains
Message-ID: <20230928043746.GB57926@coredump.intra.peff.net>
References: <20230926055452.GA1341109@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926055452.GA1341109@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 01:54:52AM -0400, Jeff King wrote:

>   [1/6]: commit-graph: factor out chain opening function
>   [2/6]: commit-graph: check mixed generation validation when loading chain file
>   [3/6]: t5324: harmonize sha1/sha256 graph chain corruption
>   [4/6]: commit-graph: detect read errors when verifying graph chain
>   [5/6]: commit-graph: tighten chain size check
>   [6/6]: commit-graph: report incomplete chains during verification

Here's a re-roll that fixes a missed case in patch 6 (I sent more
details elsewhere in the thread).

Range-diff is below, but the changes are:

  - patch 3 extends its tests to cover corrupting both the first and
    second lines of the file. The test and directory renaming spills
    over into the range-diff context for the other patches (and I
    renamed the directory used in the "too-short chain file" test in
    patch 5 to align better with the others).

  - patch 6 covers the case that get_oid_hex() fails (previously it only
    detected that a parsed hex failed to result in us loading a valid
    graph file). The range-diff is IMHO quite hard to read here, but the
    patch itself is quite simple.

1:  baa20e6391 = 1:  a4893f325f commit-graph: factor out chain opening function
2:  b77cc15584 = 2:  722181d8ed commit-graph: check mixed generation validation when loading chain file
3:  af350d1d41 < -:  ---------- t5324: harmonize sha1/sha256 graph chain corruption
-:  ---------- > 3:  7de47054c7 t5324: harmonize sha1/sha256 graph chain corruption
4:  54ce3863f8 ! 4:  313c051a38 commit-graph: detect read errors when verifying graph chain
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv, con
      	free_commit_graph(graph);
     
      ## t/t5324-split-commit-graph.sh ##
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'verify after commit-graph-chain corruption' '
    +@@ t/t5324-split-commit-graph.sh: test_expect_success 'verify after commit-graph-chain corruption (base)' '
      	(
    - 		cd verify-chain &&
    + 		cd verify-chain-base &&
      		corrupt_file "$graphdir/commit-graph-chain" 30 "G" &&
     -		git commit-graph verify 2>test_err &&
     +		test_must_fail git commit-graph verify 2>test_err &&
5:  273f5e8b87 ! 5:  6d9efd761a commit-graph: tighten chain size check
    @@ commit-graph.c: int open_commit_graph_chain(const char *chain_file,
      	return 1;
     
      ## t/t5324-split-commit-graph.sh ##
    -@@ t/t5324-split-commit-graph.sh: test_expect_success 'verify after commit-graph-chain corruption' '
    +@@ t/t5324-split-commit-graph.sh: test_expect_success 'verify after commit-graph-chain corruption (tip)' '
      	)
      '
      
     +test_expect_success 'verify notices too-short chain file' '
    -+	git clone --no-hardlinks . verify-chain-garbage &&
    ++	git clone --no-hardlinks . verify-chain-short &&
     +	(
    -+		cd verify-chain-garbage &&
    ++		cd verify-chain-short &&
     +		git commit-graph verify &&
     +		echo "garbage" >$graphdir/commit-graph-chain &&
     +		test_must_fail git commit-graph verify 2>test_err &&
6:  2661efed03 ! 6:  8fc82e2254 commit-graph: report incomplete chains during verification
    @@ Commit message
         "tip" case is what is fixed by this patch (it complains to stderr but
         still returns the base slice).
     
    +    Likewise the existing tests for corruption of the commit-graph-chain
    +    file itself need to be updated. We already exited non-zero correctly for
    +    the "base" case, but the "tip" case can now do so, too.
    +
         Note that this also causes us to adjust a test later in the file that
         similarly corrupts a tip (though confusingly the test script calls this
         "base"). It checks stderr but erroneously expects the whole "verify"
    @@ commit-graph.c: int open_commit_graph_chain(const char *chain_file,
      {
      	struct commit_graph *graph_chain = NULL;
      	struct strbuf line = STRBUF_INIT;
    - 	struct object_id *oids;
    - 	int i = 0, valid = 1, count;
    - 	FILE *fp = xfdopen(fd, "r");
    - 
    -+	*incomplete_chain = 0;
    -+
    - 	count = st->st_size / (the_hash_algo->hexsz + 1);
    - 	CALLOC_ARRAY(oids, count);
    - 
     @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
    + 	fclose(fp);
    + 	strbuf_release(&line);
    + 
    ++	*incomplete_chain = !valid;
    + 	return graph_chain;
    + }
      
    - 		if (!valid) {
    - 			warning(_("unable to find all commit-graph files"));
    -+			*incomplete_chain = 1;
    - 			break;
    - 		}
    - 	}
     @@ commit-graph.c: static struct commit_graph *load_commit_graph_chain(struct repository *r,
      	struct commit_graph *g = NULL;
      
    @@ t/t5324-split-commit-graph.sh: test_expect_success 'warn on base graph chunk inc
      		grep -v "^+" test_err >err &&
      		test_i18ngrep "commit-graph chain does not match" err
      	)
    +@@ t/t5324-split-commit-graph.sh: test_expect_success 'verify after commit-graph-chain corruption (tip)' '
    + 	(
    + 		cd verify-chain-tip &&
    + 		corrupt_file "$graphdir/commit-graph-chain" 70 "G" &&
    +-		git commit-graph verify 2>test_err &&
    ++		test_must_fail git commit-graph verify 2>test_err &&
    + 		grep -v "^+" test_err >err &&
    + 		test_i18ngrep "invalid commit-graph chain" err &&
    + 		corrupt_file "$graphdir/commit-graph-chain" 70 "A" &&
    +-		git commit-graph verify 2>test_err &&
    ++		test_must_fail git commit-graph verify 2>test_err &&
    + 		grep -v "^+" test_err >err &&
    + 		test_i18ngrep "unable to find all commit-graph files" err
    + 	)

  [1/6]: commit-graph: factor out chain opening function
  [2/6]: commit-graph: check mixed generation validation when loading chain file
  [3/6]: t5324: harmonize sha1/sha256 graph chain corruption
  [4/6]: commit-graph: detect read errors when verifying graph chain
  [5/6]: commit-graph: tighten chain size check
  [6/6]: commit-graph: report incomplete chains during verification

 builtin/commit-graph.c        |  31 +++++++---
 commit-graph.c                | 109 +++++++++++++++++++++-------------
 commit-graph.h                |   4 ++
 t/t5324-split-commit-graph.sh |  69 ++++++++++++++++++---
 4 files changed, 158 insertions(+), 55 deletions(-)

-Peff
