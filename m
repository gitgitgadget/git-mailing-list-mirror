From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Revert "graph.c: mark private file-scope symbols as static"
Date: Sat,  2 Mar 2013 12:46:05 +0000
Message-ID: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 02 13:46:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBlq0-0006U2-6L
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 13:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab3CBMqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 07:46:25 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:41221 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab3CBMqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 07:46:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 5C7F322F43;
	Sat,  2 Mar 2013 12:46:24 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8dAfV8k90Jyv; Sat,  2 Mar 2013 12:46:23 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id AD8C922CFD;
	Sat,  2 Mar 2013 12:46:17 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc1.339.g93ec2c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217326>

This reverts commit ba35480439d05b8f6cca50527072194fe3278bbb.

CGit uses these symbols to output the correct HTML around graph
elements.  Making these symbols private means that CGit cannot be
updated to use Git 1.8.0 or newer, so let's not do that.

Signed-off-by: John Keeping <john@keeping.me.uk>
---

I realise that Git isn't a library so making the API useful for outside
projects isn't a priority, but making these two methods public makes
life a lot easier for CGit.

Additionally, it seems that Johan added graph_set_column_colors
specifically so that CGit should use it - there's no value to having
that as a method just for its use in graph.c and he was the author of
CGit commit 268b34a (ui-log: Colorize commit graph, 2010-11-15).

 graph.c | 32 ++------------------------------
 graph.h | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/graph.c b/graph.c
index 2a3fc5c..b24d04c 100644
--- a/graph.c
+++ b/graph.c
@@ -8,34 +8,6 @@
 /* Internal API */
 
 /*
- * Output the next line for a graph.
- * This formats the next graph line into the specified strbuf.  It is not
- * terminated with a newline.
- *
- * Returns 1 if the line includes the current commit, and 0 otherwise.
- * graph_next_line() will return 1 exactly once for each time
- * graph_update() is called.
- */
-static int graph_next_line(struct git_graph *graph, struct strbuf *sb);
-
-/*
- * Set up a custom scheme for column colors.
- *
- * The default column color scheme inserts ANSI color escapes to colorize
- * the graph. The various color escapes are stored in an array of strings
- * where each entry corresponds to a color, except for the last entry,
- * which denotes the escape for resetting the color back to the default.
- * When generating the graph, strings from this array are inserted before
- * and after the various column characters.
- *
- * This function allows you to enable a custom array of color escapes.
- * The 'colors_max' argument is the index of the last "reset" entry.
- *
- * This functions must be called BEFORE graph_init() is called.
- */
-static void graph_set_column_colors(const char **colors, unsigned short colors_max);
-
-/*
  * Output a padding line in the graph.
  * This is similar to graph_next_line().  However, it is guaranteed to
  * never print the current commit line.  Instead, if the commit line is
@@ -90,7 +62,7 @@ enum graph_state {
 static const char **column_colors;
 static unsigned short column_colors_max;
 
-static void graph_set_column_colors(const char **colors, unsigned short colors_max)
+void graph_set_column_colors(const char **colors, unsigned short colors_max)
 {
 	column_colors = colors;
 	column_colors_max = colors_max;
@@ -1144,7 +1116,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 		graph_update_state(graph, GRAPH_PADDING);
 }
 
-static int graph_next_line(struct git_graph *graph, struct strbuf *sb)
+int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
 	switch (graph->state) {
 	case GRAPH_PADDING:
diff --git a/graph.h b/graph.h
index 19b0f66..aff960c 100644
--- a/graph.h
+++ b/graph.h
@@ -4,6 +4,22 @@
 /* A graph is a pointer to this opaque structure */
 struct git_graph;
 
+/*
+ * Set up a custom scheme for column colors.
+ *
+ * The default column color scheme inserts ANSI color escapes to colorize
+ * the graph. The various color escapes are stored in an array of strings
+ * where each entry corresponds to a color, except for the last entry,
+ * which denotes the escape for resetting the color back to the default.
+ * When generating the graph, strings from this array are inserted before
+ * and after the various column characters.
+ *
+ * This function allows you to enable a custom array of color escapes.
+ * The 'colors_max' argument is the index of the last "reset" entry.
+ *
+ * This functions must be called BEFORE graph_init() is called.
+ */
+void graph_set_column_colors(const char **colors, unsigned short colors_max);
 
 /*
  * Create a new struct git_graph.
@@ -33,6 +49,17 @@ void graph_update(struct git_graph *graph, struct commit *commit);
  */
 int graph_is_commit_finished(struct git_graph const *graph);
 
+/*
+ * Output the next line for a graph.
+ * This formats the next graph line into the specified strbuf.  It is not
+ * terminated with a newline.
+ *
+ * Returns 1 if the line includes the current commit, and 0 otherwise.
+ * graph_next_line() will return 1 exactly once for each time
+ * graph_update() is called.
+ */
+int graph_next_line(struct git_graph *graph, struct strbuf *sb);
+
 
 /*
  * graph_show_*: helper functions for printing to stdout
-- 
1.8.2.rc1.339.g93ec2c9
