Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7CCE8FDB2
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbjJCUZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJCUZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:25:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC9A7
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:25:06 -0700 (PDT)
Received: (qmail 14841 invoked by uid 109); 3 Oct 2023 20:25:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:25:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14892 invoked by uid 111); 3 Oct 2023 20:25:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:25:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:25:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/10] some commit-graph leak fixes
Message-ID: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed while working on the jk/commit-graph-verify-fix topic that
free_commit_graph() leaks any slices of a commit-graph-chain except for
the first. I naively hoped that fixing that would make t5324 leak-free,
but it turns out there were a number of other leaks, so I fixed those,
too. A couple of them were in the merge code, which in turn means a
bunch of new test scripts are now leak-free.

Even though I saw the problem on that other topic, there's no dependency
here; this series can be applied directly to master (or possibly even
maint, though I didn't try).

  [01/10]: t6700: mark test as leak-free
  [02/10]: commit-reach: free temporary list in get_octopus_merge_bases()
  [03/10]: merge: free result of repo_get_merge_bases()
  [04/10]: commit-graph: move slab-clearing to close_commit_graph()
  [05/10]: commit-graph: free all elements of graph chain
  [06/10]: commit-graph: delay base_graph assignment in add_graph_to_chain()
  [07/10]: commit-graph: free graph struct that was not added to chain
  [08/10]: commit-graph: free write-context entries before overwriting
  [09/10]: commit-graph: free write-context base_graph_name during cleanup
  [10/10]: commit-graph: clear oidset after finishing write

 builtin/commit-graph.c             |  1 +
 builtin/merge.c                    |  5 +++-
 commit-graph.c                     | 40 ++++++++++++++----------------
 commit-reach.c                     |  1 +
 t/t4214-log-graph-octopus.sh       |  1 +
 t/t4215-log-skewed-merges.sh       |  1 +
 t/t5324-split-commit-graph.sh      |  2 ++
 t/t5328-commit-graph-64bit-time.sh |  2 ++
 t/t5521-pull-options.sh            |  1 +
 t/t6009-rev-list-parent.sh         |  1 +
 t/t6416-recursive-corner-cases.sh  |  1 +
 t/t6433-merge-toplevel.sh          |  1 +
 t/t6437-submodule-merge.sh         |  1 +
 t/t6700-tree-depth.sh              |  2 ++
 t/t7602-merge-octopus-many.sh      |  1 +
 t/t7603-merge-reduce-heads.sh      |  1 +
 t/t7607-merge-state.sh             |  1 +
 t/t7608-merge-messages.sh          |  1 +
 18 files changed, 42 insertions(+), 22 deletions(-)

-Peff
