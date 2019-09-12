Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937F21F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbfILOof (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:44:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:47944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732654AbfILOof (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:44:35 -0400
Received: (qmail 13969 invoked by uid 109); 12 Sep 2019 14:44:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 14:44:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8323 invoked by uid 111); 12 Sep 2019 14:46:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2019 10:46:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Sep 2019 10:44:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH v2 1/2] commit-graph: bump DIE_ON_LOAD check to actual
 load-time
Message-ID: <20190912144434.GA25101@sigill.intra.peff.net>
References: <20190912144122.GA27815@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190912144122.GA27815@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 43d3561805 (commit-graph write: don't die if the existing graph
is corrupt, 2019-03-25) added an environment variable we use only in the
test suite, $GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD. But it put the check for
this variable at the very top of prepare_commit_graph(), which is called
every time we want to use the commit graph. Most importantly, it comes
_before_ we check the fast-path "did we already try to load?", meaning
we end up calling getenv() for every single use of the commit graph,
rather than just when we load.

getenv() is allowed to have unexpected side effects, but that shouldn't
be a problem here; we're lazy-loading the graph so it's clear that at
least _one_ invocation of this function is going to call it.

But it is inefficient. getenv() typically has to do a linear search
through the environment space.

We could memoize the call, but it's simpler still to just bump the check
down to the actual loading step. That's fine for our sole user in t5318,
and produces this minor real-world speedup:

  [before]
  Benchmark #1: git -C linux rev-list HEAD >/dev/null
    Time (mean ± σ):      1.460 s ±  0.017 s    [User: 1.174 s, System: 0.285 s]
    Range (min … max):    1.440 s …  1.491 s    10 runs

  [after]
  Benchmark #1: git -C linux rev-list HEAD >/dev/null
    Time (mean ± σ):      1.391 s ±  0.005 s    [User: 1.118 s, System: 0.273 s]
    Range (min … max):    1.385 s …  1.399 s    10 runs

Of course that actual speedup depends on how big your environment is. We
can game it like this:

  for i in $(seq 10000); do
    export dummy$i=$i
  done

in which case I get:

  [before]
  Benchmark #1: git -C linux rev-list HEAD >/dev/null
    Time (mean ± σ):      6.257 s ±  0.061 s    [User: 6.005 s, System: 0.250 s]
    Range (min … max):    6.174 s …  6.337 s    10 runs

  [after]
  Benchmark #1: git -C linux rev-list HEAD >/dev/null
  Time (mean ± σ):      1.403 s ±  0.005 s    [User: 1.146 s, System: 0.256 s]
  Range (min … max):    1.396 s …  1.412 s    10 runs

So this is really more about avoiding the pathological case than
providing a big real-world speedup.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9b02d2c426..baeaf0d1bf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -468,14 +468,14 @@ static int prepare_commit_graph(struct repository *r)
 {
 	struct object_directory *odb;
 
-	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
-		die("dying as requested by the '%s' variable on commit-graph load!",
-		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
-
 	if (r->objects->commit_graph_attempted)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
 
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
+		die("dying as requested by the '%s' variable on commit-graph load!",
+		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
+
 	prepare_repo_settings(r);
 
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-- 
2.23.0.667.gcccf1fbb03

