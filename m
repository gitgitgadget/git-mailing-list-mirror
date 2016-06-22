Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A1E20189
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbcFVPDD (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:03:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:59818 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbcFVPCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:07 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LskfZ-1bMV2x37er-012LHo; Wed, 22 Jun 2016 17:01:46
 +0200
Date:	Wed, 22 Jun 2016 17:01:44 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 04/10] graph: respect the diffopt.file setting
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <ac66b20d0b78e6002c4b38525a47ba8afd09c5c0.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AML0kTTkd4UmHkO9HQ/gg2HLF62YS8X2nr1gJoT8c48yZ8fdQ2c
 EMtPqSJTJ5wfI9ItF8DOsoWfrpKhvVk3eh9jJJ6rhj29q6C0Tc5I8J9VkbBSmeduP0UO8Q7
 e+unrPxfGz4rWfXVWSdv/0b/hlz5sEjCKZASdLx1CJ0MmD3/VPSTO6ocs4BEIQzGwbSbv2v
 ci0MltN3v7HMRF2yu19ng==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TZiu8HOR4OA=:rB/l/hx2kEeWFLCF86/BUN
 6vLm8QJnrodnmwKzKXZDW1zBkmzI1jUlPn1z2rxPjRu/RgZzxInvMbGqAOOrDj2U7ZlsqFPhP
 0IpDgyRfPJ0L611rG2FrS18Y/SWpFDHQn7cBLonnppwAd0fw2lmPdr4TczdK06+zK5Sk4e4hS
 QcCbCTKpM0sh8F6pIaJBX7AC0RHb+AVH8gieeARYLISZDpnYD8WvW3LlkbxcyRMup+DbaMGZC
 rAJdfCc1xCSCgckio4BETBcUEasCB9kM4fc+fobLA5ULI1HluCV6rcQ5I5milkyedxe7+nwT7
 ByAQmwQgCuIRsW79VBagVd1oXwnmB7rLgdo8hDvLWigjUmgG9ocU1b/d2HgPEBfLQcOgOmxkh
 n998uTxHitWQMDP34ll4RgbfUMvP2Zy7k2UG2oMfr8/5Xo+1sU1PmdjjBvWDg0YqVnOVyRNAd
 D2PlThsJTfw5pyq57CyIApojW7hyo0TqGZuI86DjopcIIWHd7BQ3Fnuf0h1LNDxymHLFhBXci
 OLwlMbXEUeY8ji64oLu8cCRraFKb1u2YHsVO/mFzpDfSbe3K8Vhfu0wdhwPdpPVcrq9jHcJKa
 p7Hdg4Yi8QEqudApxuk1h7PLS3aUK/DZXiQGISfV4dMetQ0NX/aNoH+0HRnBHphLGdiGvMo3q
 qaF7tCCe7wCKHCpKZz2ZZSvIU+c8lAyM5AG0GaufbRr1Ba1KlHg6GNlaBYufjVokEjNNFYBdH
 7sOpPGkpUw8+wwzfXnfGmeHgGvWzu3UZDutvyRD4vyfNHmEq3sWezYe97wFvuYTWaVtmGlq6N
 /J0Fwl6
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


