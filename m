From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: [PATCH] graph.c: make many functions static
Date: Thu, 19 Jun 2008 08:21:10 +0900
Message-ID: <20080619082110.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 01:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97NT-0001wH-M0
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 01:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbYFRXqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 19:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbYFRXqy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 19:46:54 -0400
Received: from karen.lavabit.com ([72.249.41.33]:37460 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbYFRXqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 19:46:50 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 85B3EC7B2A;
	Wed, 18 Jun 2008 18:21:44 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 8KX8Z5763ZGE; Wed, 18 Jun 2008 18:21:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Y+vNVulpoF6ziqpV7LmpyseV9jvKAdCIY7Puj2b3YpNHpN/GucV4LivyGfpsh5sCO+wAKKXHIaq+McxnL6MqJYP98WylkuY5j41syifi6a0iO7DyAi84n04Nrr8ewKq+dpuH7AeMTv7sptAzNLXbnpITH1PhPK1dGHxppIqFze4=;
  h=From:Date:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85426>

These function are not used anywhere.  Also removes graph_release()
that is never called.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 graph.c |   57 +++++++++++++++++++++++++++++++++++++++++++--------------
 graph.h |   40 ----------------------------------------
 2 files changed, 43 insertions(+), 54 deletions(-)

diff --git a/graph.c b/graph.c
index e2633f8..5f82170 100644
--- a/graph.c
+++ b/graph.c
@@ -4,6 +4,43 @@
 #include "diff.h"
 #include "revision.h"
 
+/* Internal API */
+
+/*
+ * Output the next line for a graph.
+ * This formats the next graph line into the specified strbuf.  It is not
+ * terminated with a newline.
+ *
+ * Returns 1 if the line includes the current commit, and 0 otherwise.
+ * graph_next_line() will return 1 exactly once for each time
+ * graph_update() is called.
+ */
+static int graph_next_line(struct git_graph *graph, struct strbuf *sb);
+
+/*
+ * Output a padding line in the graph.
+ * This is similar to graph_next_line().  However, it is guaranteed to
+ * never print the current commit line.  Instead, if the commit line is
+ * next, it will simply output a line of vertical padding, extending the
+ * branch lines downwards, but leaving them otherwise unchanged.
+ */
+static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
+
+/*
+ * Print a strbuf to stdout.  If the graph is non-NULL, all lines but the
+ * first will be prefixed with the graph output.
+ *
+ * If the strbuf ends with a newline, the output will end after this
+ * newline.  A new graph line will not be printed after the final newline.
+ * If the strbuf is empty, no output will be printed.
+ *
+ * Since the first line will not include the graph ouput, the caller is
+ * responsible for printing this line's graph (perhaps via
+ * graph_show_commit() or graph_show_oneline()) before calling
+ * graph_show_strbuf().
+ */
+static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
+
 /*
  * TODO:
  * - Add colors to the graph.
@@ -180,14 +217,6 @@ struct git_graph *graph_init(struct rev_info *opt)
 	return graph;
 }
 
-void graph_release(struct git_graph *graph)
-{
-	free(graph->columns);
-	free(graph->new_columns);
-	free(graph->mapping);
-	free(graph);
-}
-
 static void graph_update_state(struct git_graph *graph, enum graph_state s)
 {
 	graph->prev_state = graph->state;
@@ -685,7 +714,7 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	strbuf_addch(sb, '*');
 }
 
-void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
 	int i, j;
@@ -760,7 +789,7 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
 	int i, j;
@@ -801,7 +830,7 @@ void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int i;
 	int *tmp_mapping;
@@ -906,7 +935,7 @@ void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
 		graph_update_state(graph, GRAPH_PADDING);
 }
 
-int graph_next_line(struct git_graph *graph, struct strbuf *sb)
+static int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
 	switch (graph->state) {
 	case GRAPH_PADDING:
@@ -933,7 +962,7 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 	return 0;
 }
 
-void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int i, j;
 
@@ -1055,7 +1084,7 @@ int graph_show_remainder(struct git_graph *graph)
 }
 
 
-void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
+static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
 {
 	char *p;
 
diff --git a/graph.h b/graph.h
index eab4e3d..bc30d68 100644
--- a/graph.h
+++ b/graph.h
@@ -11,11 +11,6 @@ struct git_graph;
 struct git_graph *graph_init(struct rev_info *opt);
 
 /*
- * Destroy a struct git_graph and free associated memory.
- */
-void graph_release(struct git_graph *graph);
-
-/*
  * Update a git_graph with a new commit.
  * This will cause the graph to begin outputting lines for the new commit
  * the next time graph_next_line() is called.
@@ -27,26 +22,6 @@ void graph_release(struct git_graph *graph);
 void graph_update(struct git_graph *graph, struct commit *commit);
 
 /*
- * Output the next line for a graph.
- * This formats the next graph line into the specified strbuf.  It is not
- * terminated with a newline.
- *
- * Returns 1 if the line includes the current commit, and 0 otherwise.
- * graph_next_line() will return 1 exactly once for each time
- * graph_update() is called.
- */
-int graph_next_line(struct git_graph *graph, struct strbuf *sb);
-
-/*
- * Output a padding line in the graph.
- * This is similar to graph_next_line().  However, it is guaranteed to
- * never print the current commit line.  Instead, if the commit line is
- * next, it will simply output a line of vertical padding, extending the
- * branch lines downwards, but leaving them otherwise unchanged.
- */
-void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
-
-/*
  * Determine if a graph has finished outputting lines for the current
  * commit.
  *
@@ -90,21 +65,6 @@ void graph_show_padding(struct git_graph *graph);
 int graph_show_remainder(struct git_graph *graph);
 
 /*
- * Print a strbuf to stdout.  If the graph is non-NULL, all lines but the
- * first will be prefixed with the graph output.
- *
- * If the strbuf ends with a newline, the output will end after this
- * newline.  A new graph line will not be printed after the final newline.
- * If the strbuf is empty, no output will be printed.
- *
- * Since the first line will not include the graph ouput, the caller is
- * responsible for printing this line's graph (perhaps via
- * graph_show_commit() or graph_show_oneline()) before calling
- * graph_show_strbuf().
- */
-void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
-
-/*
  * Print a commit message strbuf and the remainder of the graph to stdout.
  *
  * This is similar to graph_show_strbuf(), but it always prints the
-- 
1.5.5.4
