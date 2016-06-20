Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277D820179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbcFTK7H (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:59:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:51791 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370AbcFTK7C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:59:02 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0McDl1-1avM6J2fqR-00JY15; Mon, 20 Jun 2016 12:58:56
 +0200
Date:	Mon, 20 Jun 2016 12:55:34 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/7] graph: respect the diffopt.file setting
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <f2b1795827bcb055028332cfdf04d996d8b6e0e6.1466420060.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Zrvw+4FAwAggKS0WavzlCI9unpJX97degdJVEeslQdU0v0MdomX
 H/esYl3BYTfYFNH4NyfhrVBWBU5c20NDu9KACMI8d2KTKLCri2cro5p2KG6J26euodCRDbS
 piyZz4YbRQfG1wOpI/1nY1xRKvYK3bGeFve4/NZkXuWdMU/BromEYcmiWUy/kCWztdtlJME
 H+clMhy/f3/c72R2B7CDQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CDz5q1VB3ZE=:QL5pbBYEQU1Apr7Jk4RKy1
 7ZhriRLp3EMo8nD8eIvPdhtp1DGCKhsDkARomJCRSmxQee6CPXIQjLVu9d6ZpXQdCNWi1TIQZ
 K++ztSjutHuQBCw/Kexsip3ODxhA7+Csfl5Mfg8PbuTCzdfjVM7p62uOO2fvanTh36+tayME2
 LlovJuIpmlyR/+EiTBZV8WgGP3U2ICvy+HbW1+JwJrNhKVi/rSvF3KlojM3mGZuo05QduspQ1
 yzJQ0Zw0WKHjdlzl5kLmq7+XYPzpdVYpSgzlFG9Ngo3XuvAii0mu5PUnPd0wb2Ek/QWqAqgcr
 g0D16bpz7v3qOms03nwwfDBqEdWoacrQ50pZfRPyTKwRKCc3ElnApc3Dm/cAalhPL6GPU5iiv
 7fbhv3WIgCzw8GWxIsHBC9Ji+Zo/2TM0nLCj6v/lBPCwvQlykxIrTwsbZY0fkmneIOFl586Zv
 ydHvd9FpivI0md7NWzf1rDHI4fbQdvdOuF5G2jYE3ZXJy66pOZxxqvN6AmSUf/sT8NwfSVgvC
 wdl/aBTsdAlkJvYjbJFl+euDIDq+eizRGkRM+shojQJBaB4K0WPH7eYxzGdR6gJEBe8KRhEoO
 9S7eQwD5GZtVFk0ze+UKLkAkl8rR1oQpuxeCsjeXQ3kZSUqIr4vvCvZqCkY2g7FNr47c8NZsi
 5U80kB8T6Bj/MyxFE4KCbVQthj5ky3hdhDxM8/2fathLjOBYGBL3zE+66XH4fCZJspG+9LtGB
 2fWuzKVHvx7J1zkG+Rdrk+qjF7SkuD5anksToUBpTz840EdKrvn7I5VVOkpz+mHFTWl1+pkFv
 koUcA+k
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When the caller overrides diffopt.file (which defaults to stdout),
the diff machinery already redirects its output, and the graph display
should also write to that file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 graph.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/graph.c b/graph.c
index 1350bdd..8ae56bc 100644
--- a/graph.c
+++ b/graph.c
@@ -17,8 +17,8 @@
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
 
 /*
- * Print a strbuf to stdout.  If the graph is non-NULL, all lines but the
- * first will be prefixed with the graph output.
+ * Print a strbuf.  If the graph is non-NULL, all lines but the first will be
+ * prefixed with the graph output.
  *
  * If the strbuf ends with a newline, the output will end after this
  * newline.  A new graph line will not be printed after the final newline.
@@ -1193,9 +1193,10 @@ void graph_show_commit(struct git_graph *graph)
 
 	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
 		shown_commit_line = graph_next_line(graph, &msgbuf);
-		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len,
+			graph->revs->diffopt.file);
 		if (!shown_commit_line)
-			putchar('\n');
+			fputc('\n', graph->revs->diffopt.file);
 		strbuf_setlen(&msgbuf, 0);
 	}
 
@@ -1210,7 +1211,7 @@ void graph_show_oneline(struct git_graph *graph)
 		return;
 
 	graph_next_line(graph, &msgbuf);
-	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, graph->revs->diffopt.file);
 	strbuf_release(&msgbuf);
 }
 
@@ -1222,7 +1223,7 @@ void graph_show_padding(struct git_graph *graph)
 		return;
 
 	graph_padding_line(graph, &msgbuf);
-	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, graph->revs->diffopt.file);
 	strbuf_release(&msgbuf);
 }
 
@@ -1239,12 +1240,13 @@ int graph_show_remainder(struct git_graph *graph)
 
 	for (;;) {
 		graph_next_line(graph, &msgbuf);
-		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len,
+			graph->revs->diffopt.file);
 		strbuf_setlen(&msgbuf, 0);
 		shown = 1;
 
 		if (!graph_is_commit_finished(graph))
-			putchar('\n');
+			fputc('\n', graph->revs->diffopt.file);
 		else
 			break;
 	}
@@ -1259,7 +1261,8 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
 	char *p;
 
 	if (!graph) {
-		fwrite(sb->buf, sizeof(char), sb->len, stdout);
+		fwrite(sb->buf, sizeof(char), sb->len,
+			graph->revs->diffopt.file);
 		return;
 	}
 
@@ -1277,7 +1280,7 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
 		} else {
 			len = (sb->buf + sb->len) - p;
 		}
-		fwrite(p, sizeof(char), len, stdout);
+		fwrite(p, sizeof(char), len, graph->revs->diffopt.file);
 		if (next_p && *next_p != '\0')
 			graph_show_oneline(graph);
 		p = next_p;
@@ -1297,7 +1300,8 @@ void graph_show_commit_msg(struct git_graph *graph,
 		 * CMIT_FMT_USERFORMAT are already missing a terminating
 		 * newline.  All of the other formats should have it.
 		 */
-		fwrite(sb->buf, sizeof(char), sb->len, stdout);
+		fwrite(sb->buf, sizeof(char), sb->len,
+			graph->revs->diffopt.file);
 		return;
 	}
 
@@ -1318,7 +1322,7 @@ void graph_show_commit_msg(struct git_graph *graph,
 		 * new line.
 		 */
 		if (!newline_terminated)
-			putchar('\n');
+			fputc('\n', graph->revs->diffopt.file);
 
 		graph_show_remainder(graph);
 
@@ -1326,6 +1330,6 @@ void graph_show_commit_msg(struct git_graph *graph,
 		 * If sb ends with a newline, our output should too.
 		 */
 		if (newline_terminated)
-			putchar('\n');
+			fputc('\n', graph->revs->diffopt.file);
 	}
 }
-- 
2.9.0.119.g370c5a9


