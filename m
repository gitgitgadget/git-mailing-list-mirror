Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06921F744
	for <e@80x24.org>; Sat, 18 Jun 2016 10:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbcFRKEI (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 06:04:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:50875 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbcFRKEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 06:04:07 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MbxJ8-1aw81c28Pe-00JL5Z; Sat, 18 Jun 2016 12:04:02
 +0200
Date:	Sat, 18 Jun 2016 12:04:01 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] graph: respect the diffopt.file setting
In-Reply-To: <cover.1466244194.git.johannes.schindelin@gmx.de>
Message-ID: <f2b1795827bcb055028332cfdf04d996d8b6e0e6.1466244194.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZYHp8PxF/np9mVXW9TVSVKr1sUUoF5iXQAlDP9dtiTpcGtp0UuF
 q5AYjOzxjaQKPka3igxw9GaAm1vxxFvkI03IwyZ6fcrbhpq9HcPYZ72rwc5Cxj7rIJvOJsy
 t4KqGIoRM9mxOOOm4JblR7Bv7RmFw0NMrOI69foookSpTEgZ91K7+t09h6Tnmy5vxaj8/1F
 a1lFFoFkHXac13YDWi0Jw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kYPml3HsPh8=:S+G1MKXCJnxrBdsM/eOMtl
 CRGvVa4us0l9MYO2x3SxdxH0IXx17th9pAxoMVhRmd9gut3z2EiDsSDRLZYmm1NoMRL2geey6
 arwf4gsbEl0pTMTTQg4gB+69C2tj0QG5JWe6eNumCe9b6LoCo3+lfPeRyiugutbScBE1kb3Yw
 VV2DQibZbu1f4X5D4p4lHSq+AaKcCc1npsbJvprzwCqt4tOZ/Esg2eOobheTv723qfzwy37xf
 l5XfIMoJPUyNptLpNQjxWIP1Xvz5jvvWiUSuoatL7Ue433fArfhVYz04Si0/DyTfMfNUZusYx
 3E0U9gVi/nerGoeOToh66pm+SvzyKmDERd8YvPY+dQRr8Qj50HB89LN9jogt0oX48707a2NS6
 ea01J6FIZCa7+SlQU1GevQNupXq81RGF2ZUJ0DHAL5eTGXRWlOUbLLn+yQXZHi2l33At/x28s
 v//i2Fck9YPX7SkqG/CRGJS49JUBUPgronj6nwpZwXX18ra0x3NX6cx2APkaFzW98CZwDePgK
 rUqhr85Ba8f1VgPCaV0yEV82o+8aPNsHGcMbyxxsbqYKTcdmKTcZxEhfCz54pIpvIuZkrQnia
 wE/DOp7MqpVUTp9dtlZVL/e5D7FueJkgzA6Ju6kbCOMkKDxGMwsPCyw62AgT0miq8XffIIQHH
 UQru5FV732IqAC0V90d6MN+lGoEdfAggMPsJ/YUDOYxBJOFlS8aqBfTnTf/ZtsvITCcNaoBF9
 mEuVRePNdBeQKq92G5EiUGWyY113qzclnjR4c9pHunerCQa1jZliqWGt5ZJfPql0zpr+1IFAJ
 s/j91hb
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
2.9.0.118.gce770ba.dirty


