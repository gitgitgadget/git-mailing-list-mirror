Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45C620986
	for <e@80x24.org>; Thu, 29 Sep 2016 08:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755585AbcI2IiC (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 04:38:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:49788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755573AbcI2Ihy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 04:37:54 -0400
Received: (qmail 10460 invoked by uid 109); 29 Sep 2016 08:37:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 08:37:53 +0000
Received: (qmail 32114 invoked by uid 111); 29 Sep 2016 08:38:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 04:38:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 04:37:51 -0400
Date:   Thu, 29 Sep 2016 04:37:51 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] graph: fix extra spaces in graph_padding_line
Message-ID: <20160929083750.ohjl5jdtgso7okan@sigill.intra.peff.net>
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The graph_padding_line() function outputs a series of "|"
columns, and then pads with spaces to graph->width by
calling graph_pad_horizontally(). However, we tell the
latter that we wrote graph->num_columns characters, which is
not true; we also needed spaces between the columns. Let's
keep a count of how many characters we've written, which is
what all the other callers of graph_pad_horizontally() do.

Without this, any output that is written at the end of a
padding line will be bumped out by at least an extra
graph->num_columns spaces. Presumably nobody ever noticed
the bug because there's no code path that actually writes to
the end of a padding line.

Signed-off-by: Jeff King <peff@peff.net>
---
 graph.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/graph.c b/graph.c
index 06f1139..d4e8519 100644
--- a/graph.c
+++ b/graph.c
@@ -1175,6 +1175,7 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int i;
+	int chars_written = 0;
 
 	if (graph->state != GRAPH_COMMIT) {
 		graph_next_line(graph, sb);
@@ -1190,14 +1191,21 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	 */
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
+
 		strbuf_write_column(sb, col, '|');
-		if (col->commit == graph->commit && graph->num_parents > 2)
-			strbuf_addchars(sb, ' ', (graph->num_parents - 2) * 2);
-		else
+		chars_written++;
+
+		if (col->commit == graph->commit && graph->num_parents > 2) {
+			int len = (graph->num_parents - 2) * 2;
+			strbuf_addchars(sb, ' ', len);
+			chars_written += len;
+		} else {
 			strbuf_addch(sb, ' ');
+			chars_written++;
+		}
 	}
 
-	graph_pad_horizontally(graph, sb, graph->num_columns);
+	graph_pad_horizontally(graph, sb, chars_written);
 
 	/*
 	 * Update graph->prev_state since we have output a padding line
-- 
2.10.0.566.g5365f87

