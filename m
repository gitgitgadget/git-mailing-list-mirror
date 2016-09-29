Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E952620986
	for <e@80x24.org>; Thu, 29 Sep 2016 08:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755595AbcI2IiW (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 04:38:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:49790 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755590AbcI2IiS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 04:38:18 -0400
Received: (qmail 10478 invoked by uid 109); 29 Sep 2016 08:38:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 08:38:17 +0000
Received: (qmail 32119 invoked by uid 111); 29 Sep 2016 08:38:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 04:38:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 04:38:15 -0400
Date:   Thu, 29 Sep 2016 04:38:15 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] graph: helper functions for printing commit header
Message-ID: <20160929083815.xgbdv62srna3cbg5@sigill.intra.peff.net>
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The idea here is to make it possible to print something
right _before_ a commit in the graph. It's a bit ugly, but
it seems to work.

Signed-off-by: Jeff King <peff@peff.net>
---
 graph.c | 14 +++++++++++++-
 graph.h |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index d4e8519..56daa70 100644
--- a/graph.c
+++ b/graph.c
@@ -1218,7 +1218,7 @@ int graph_is_commit_finished(struct git_graph const *graph)
 	return (graph->state == GRAPH_PADDING);
 }
 
-void graph_show_commit(struct git_graph *graph)
+static void graph_show_commit_1(struct git_graph *graph, int only_pre)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
 	int shown_commit_line = 0;
@@ -1239,6 +1239,8 @@ void graph_show_commit(struct git_graph *graph)
 	}
 
 	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
+		if (only_pre && graph->state == GRAPH_COMMIT)
+			break;
 		shown_commit_line = graph_next_line(graph, &msgbuf);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len,
 			graph->revs->diffopt.file);
@@ -1252,6 +1254,16 @@ void graph_show_commit(struct git_graph *graph)
 	strbuf_release(&msgbuf);
 }
 
+void graph_show_precommit(struct git_graph *graph)
+{
+	graph_show_commit_1(graph, 1);
+}
+
+void graph_show_commit(struct git_graph *graph)
+{
+	graph_show_commit_1(graph, 0);
+}
+
 void graph_show_oneline(struct git_graph *graph)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
diff --git a/graph.h b/graph.h
index af62339..e13e97f 100644
--- a/graph.h
+++ b/graph.h
@@ -97,6 +97,12 @@ int graph_width(struct git_graph *graph);
  */
 void graph_show_commit(struct git_graph *graph);
 
+/*
+ * Same as graph_show_commit, but stop just _before_ printing
+ * the actual commit line.
+ */
+void graph_show_precommit(struct git_graph *graph);
+
 /*
  * If the graph is non-NULL, print one line of the history graph to stdout.
  * Does not print a terminating newline on the last line.
-- 
2.10.0.566.g5365f87

