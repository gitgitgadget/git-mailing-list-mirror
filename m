Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F101F461
	for <e@80x24.org>; Sat,  7 Sep 2019 05:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394351AbfIGFBf (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 01:01:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:42748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2394279AbfIGFBe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 01:01:34 -0400
Received: (qmail 28050 invoked by uid 109); 7 Sep 2019 05:01:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 05:01:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9591 invoked by uid 111); 7 Sep 2019 05:03:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 01:03:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 01:01:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/2] commit-graph: don't show progress percentages while
 expanding reachable commits
Message-ID: <20190907050132.GA23904@sigill.intra.peff.net>
References: <20190907045848.GA24515@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190907045848.GA24515@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Commit 49bbc57a57 (commit-graph write: emit a percentage for all
progress, 2019-01-19) was a bit overeager when it added progress
percentages to the "Expanding reachable commits in commit graph" phase
as well, because most of the time the number of commits that phase has
to iterate over is not known in advance and grows significantly, and,
consequently, we end up with nonsensical numbers:

  $ git commit-graph write --reachable
  Expanding reachable commits in commit graph: 138606% (824706/595), done.
  [...]

  $ git rev-parse v5.0 | git commit-graph write --stdin-commits
  Expanding reachable commits in commit graph: 81264400% (812644/1), done.
  [...]

Even worse, because the percentage grows so quickly, the progress code
outputs much more often than it should (because it ticks every second,
or every 1%), slowing the whole process down. My time for "git
commit-graph write --reachable" on linux.git went from 13.463s to
12.521s with this patch, ~7% savings.

Therefore, don't show progress percentages in the "Expanding reachable
commits in commit graph" phase.

Note that the current code does sometimes do the right thing, if we
picked up all commits initially (e.g., omitting "--reachable" in a
fully-packed repository would get the correct count without any parent
traversal). So it may be possible to come up with a way to tell when we
could use a percentage here. But in the meantime, let's make sure we
robustly avoid printing nonsense.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Compared to the original from:

  https://public-inbox.org/git/20190322102817.19708-1-szeder.dev@gmail.com/

I rebased it to handle code movement, added in the timing data, and
tried to summarize the discussion from the thread.

 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index f2888c203b..d6a5c8cf1c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1050,7 +1050,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
 					_("Expanding reachable commits in commit graph"),
-					ctx->oids.nr);
+					0);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
-- 
2.23.0.474.gb1abd76f7a
