Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7751F461
	for <e@80x24.org>; Sat,  7 Sep 2019 05:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394370AbfIGFEl (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 01:04:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:42760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2394250AbfIGFEl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 01:04:41 -0400
Received: (qmail 28074 invoked by uid 109); 7 Sep 2019 05:04:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 05:04:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9624 invoked by uid 111); 7 Sep 2019 05:06:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 01:06:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 01:04:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/2] commit-graph: turn off save_commit_buffer
Message-ID: <20190907050439.GB23904@sigill.intra.peff.net>
References: <20190907045848.GA24515@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907045848.GA24515@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph tool may read a lot of commits, but it only cares about
parsing their metadata (parents, trees, etc) and doesn't ever show the
messages to the user. And so it should not need save_commit_buffer,
which is meant for holding onto the object data of parsed commits so
that we can show them later. In fact, it's quite harmful to do so.
According to massif, the max heap of "git commit-graph write
--reachable" in linux.git before/after this patch (removing the commit
graph file in between) goes from ~1.1GB to ~270MB.

Which isn't surprising, since the difference is about the sum of the
uncompressed sizes of all commits in the repository, and this was
equivalent to leaking them.

This obviously helps if you're under memory pressure, but even without
it, things go faster. My before/after times for that command (without
massif) went from 12.521s to 11.874s, a speedup of ~5%.

Signed-off-by: Jeff King <peff@peff.net>
---
We didn't actually notice this on linux.git, but rather on a repository
with 130 million commits (don't ask). With this patch, I was able to
generate the commit-graph file with a peak heap of ~25GB, which is ~200
bytes per commit.

I'll bet we could do better with some effort, but obviously this case
was just pathological. For most cases this should be cheaper than a
normal repack (which probably spends that much memory on each object,
not just commits).

 builtin/commit-graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 57863619b7..052696f1af 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -251,6 +251,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     builtin_commit_graph_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	save_commit_buffer = 0;
+
 	if (argc > 0) {
 		if (!strcmp(argv[0], "read"))
 			return graph_read(argc, argv);
-- 
2.23.0.474.gb1abd76f7a
