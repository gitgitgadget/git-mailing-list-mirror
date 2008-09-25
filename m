From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] graph.c: make many functions static
Date: Thu, 25 Sep 2008 18:41:08 +0900
Message-ID: <20080925184108.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 11:42:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KinN1-0006NZ-JB
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 11:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbYIYJlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 05:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbYIYJlk
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 05:41:40 -0400
Received: from karen.lavabit.com ([72.249.41.33]:43300 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbYIYJlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 05:41:39 -0400
Received: from f.earth.lavabit.com (f.earth.lavabit.com [192.168.111.15])
	by karen.lavabit.com (Postfix) with ESMTP id 9BD36C8A41;
	Thu, 25 Sep 2008 04:41:38 -0500 (CDT)
Received: from 2236.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id ZC3FOLJ6X83K; Thu, 25 Sep 2008 04:41:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=BpGfYitmsUpbRPqllCUY54tec8OUst9Tnnpah00WbSA95B+DpPkJDWM2sDMUX1+pqAABqYGHxMrr35ZYb9N62Ahez/orEpWxWU1DdWBbFYOpczFHPJPndV2lOt+mWGp7A0X7QbXl863ozFd56Cc7mt/Q0Mdu2B0yEVyNt7lYFEI=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96739>

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
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
