Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E232018B
	for <e@80x24.org>; Tue, 21 Jun 2016 10:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbcFUKlJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:41:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:57233 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbcFUKgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:02 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M86jp-1bbDga1nKz-00vgCf; Tue, 21 Jun 2016 12:35:09
 +0200
Date:	Tue, 21 Jun 2016 12:35:08 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 5/9] graph: respect the diffopt.file setting
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <761d203a775a437832a5178ae4e716a7a34c7e67.1466505223.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IrI5JP9JxlH3HftXIoxlMwCW2UF9WhTcn/2o41jZmkTVpEbq+Nx
 pm/78+q78Y+VnDb0D1JT1Xaks4E2/zO5j68RbK2GuuaAyZd0mVPO0ZDGv86Kvcx/fIU6OJX
 HuftLCp6Uel5RzyPGR1NpKPu8Y1JxIQuXQdmpowTxgVPt8hh6mRlJuKjVoGgD/OpkXfsmNf
 Bx7sq4ay+RQxIm2czeKNQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:RPPBkmkn378=:0cWB7kHEl4Caj58WPuN0yP
 GEBD93iyijDWogPVhGQZYAOn6KBzVDU5YiN9joPT5GvATYsDYkMNTo+Aid8QxFEvAaGzAb2zG
 hw4L+ybEB1459cZ6ydhorwJgh5cBnuhcYq514YLOtl4Eu6we6GARTvXQQZ97aYsKdxp+G43XR
 ommDF9X6HrBdd45HFlTnOVQwbgOfN63VZvTnc2oChKLUUVi/wwZ7kpoWVWacv/Q/5ImkOOSi3
 GfSMDXhXwz3zuTLdqfHFLC0O0fDgMRefe2ANTdD8gYDijHCCfKKYosMcBzdUabrXj3fK6bx+z
 6U3LyXHqvx5zI5u9Z6D1JA/gPp3i3+rCn5HRsA3XpSu7BPY0CHY0f9ztQnghVf0JmJr5p7BWR
 kD56ZAmZN8mldZGasT9bpiaPmZ5mOcR+gFJ9RNNlLaeQDh4qBH01CgbtrHk1fDaWyawWqXl7G
 OkPofYI9iXgxkBZLBQpKeCif+6HE07rlrjRFkIF2XLVoDf0X4gG5Aeqb0gHwtXwPFhuKSfq2i
 uEMQMkS7oDYIojd7ODGkai55wQrwEiMlGzHVy11uID8MPE3MmT1mxM2CemEMhnkhFV8q6+D/+
 yh3aBVcM9MRSDocLODpcLB2drbqvVkwLnGkLxcFg2mfihFKa0ucBEf9LCkn/zEzsnjmjViURl
 zPOMIWa1RiK6pZfuIn++hskVHre+o+NMH5ckzS0pp/5GAq1uXCNiVTCrfWgy9d8VhOQts9Uli
 qu0/+7aeZFF/bhDSfg3zA8ajtseHdR8MovZgedh1VGfgoaBBCryIMr+uqbe8MEOysMcVJQg09
 cn7dnUv
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
index 1350bdd..8ad8ba3 100644
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
+			putc('\n', graph->revs->diffopt.file);
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
+			putc('\n', graph->revs->diffopt.file);
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
+			putc('\n', graph->revs->diffopt.file);
 
 		graph_show_remainder(graph);
 
@@ -1326,6 +1330,6 @@ void graph_show_commit_msg(struct git_graph *graph,
 		 * If sb ends with a newline, our output should too.
 		 */
 		if (newline_terminated)
-			putchar('\n');
+			putc('\n', graph->revs->diffopt.file);
 	}
 }
-- 
2.9.0.118.g0e1a633


