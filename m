From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 2/4] graph API: Added additional utility functions to the graph API
Date: Sun,  6 Apr 2008 11:42:09 -0700
Message-ID: <1207507332-1866-2-git-send-email-adam@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 20:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZpZ-0004Dg-II
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYDFSmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 14:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYDFSmR
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:42:17 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:56651 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbYDFSmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:42:15 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 9DA7D1B4177;
	Sun,  6 Apr 2008 14:42:13 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id F40C31B4119;
	Sun,  6 Apr 2008 14:42:12 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 1539F14100BA; Sun,  6 Apr 2008 11:42:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78912>

Added several graph_show_* functions that print directly to stdout instead
of to a strbuf.  Also added functions for explicitly adding vertical padding
in the graph.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 Documentation/technical/api-history-graph.txt |   28 +++++
 graph.c                                       |  140 +++++++++++++++++++++++++
 graph.h                                       |   51 +++++++++
 3 files changed, 219 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
index 56a0a1e..34f45b0 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -20,6 +20,34 @@ Calling sequence
   after the current commit.  This return value can be used to determine where
   to print the commit summary information alongside the graph output.
 
+Utility functions
+-----------------
+
+The following functions are wrappers around `graph_next_line()` and
+`graph_is_commit_finished()`.  They always print the output to stdout.
+They can all be called with a NULL graph argument, in which case no graph output
+will be printed.
+
+* `graph_show_commit()` calls `graph_next_line()` until it returns non-zero.
+  This prints all graph lines up to, and including, the line containing this
+  commit.  Output is printed to stdout.  The last line printed does not contain
+  a terminating newline.  This should not be called if the commit line has
+  already been printed, or it will loop forever.
+
+* `graph_show_oneline()` calls `graph_next_line()` and prints the result to
+  stdout.  The line printed does not contain a terminating newline.
+
+* `graph_show_remainder()` calls `graph_next_line()` until
+  `graph_is_commit_finished()` returns non-zero.  Output is printed to stdout.
+  The last line printed does not contain a terminating newline.  Returns 1 if
+  output was printed, and 0 if no output was necessary.
+
+* `graph_show_strbuf()` prints the specified strbuf to stdout, prefixing all
+  lines but the first with a graph line.  The caller is responsible for ensuring
+  graph output for the first line has already been printed to stdout.  (This can
+  be done with `graph_show_commit()` or `graph_show_oneline()`.)  If a NULL
+  graph is supplied, the strbuf is printed as-is.
+
 Data structure
 --------------
 `struct git_graph` is an opaque data type used to store the current graph
diff --git a/graph.c b/graph.c
index d8cb7d4..e6d1d3a 100644
--- a/graph.c
+++ b/graph.c
@@ -705,7 +705,147 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 	return 0;
 }
 
+void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
+{
+	int i, j;
+
+	if (graph->state != GRAPH_COMMIT) {
+		graph_next_line(graph, sb);
+		return;
+	}
+
+	/*
+	 * Output the row containing this commit
+	 * Iterate up to and including graph->num_columns,
+	 * since the current commit may not be in any of the existing
+	 * columns.  (This happens when the current commit doesn't have any
+	 * children that we have already processed.)
+	 */
+	for (i = 0; i < graph->num_columns; ++i) {
+		struct commit *col_commit = graph->columns[i].commit;
+		if (col_commit == graph->commit) {
+			strbuf_addch(sb, '|');
+
+			if (graph->num_parents < 3)
+				strbuf_addch(sb, ' ');
+			else {
+				int num_spaces = ((graph->num_parents - 2) * 2);
+				for (j = 0; j < num_spaces; ++j)
+					strbuf_addch(sb, ' ');
+			}
+		} else {
+			strbuf_addstr(sb, "| ");
+		}
+	}
+
+	graph_pad_horizontally(graph, sb);
+}
+
 int graph_is_commit_finished(struct git_graph const *graph)
 {
 	return (graph->state == GRAPH_PADDING);
 }
+
+void graph_show_commit(struct git_graph *graph)
+{
+	struct strbuf msgbuf;
+	int shown_commit_line = 0;
+
+	if (!graph)
+		return;
+
+	strbuf_init(&msgbuf, 0);
+
+	while (!shown_commit_line) {
+		shown_commit_line = graph_next_line(graph, &msgbuf);
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		if (!shown_commit_line)
+			putchar('\n');
+		strbuf_setlen(&msgbuf, 0);
+	}
+
+	strbuf_release(&msgbuf);
+}
+
+void graph_show_oneline(struct git_graph *graph)
+{
+	struct strbuf msgbuf;
+
+	if (!graph)
+		return;
+
+	strbuf_init(&msgbuf, 0);
+	graph_next_line(graph, &msgbuf);
+	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	strbuf_release(&msgbuf);
+}
+
+void graph_show_padding(struct git_graph *graph)
+{
+	struct strbuf msgbuf;
+
+	if (!graph)
+		return;
+
+	strbuf_init(&msgbuf, 0);
+	graph_padding_line(graph, &msgbuf);
+	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	strbuf_release(&msgbuf);
+}
+
+int graph_show_remainder(struct git_graph *graph)
+{
+	struct strbuf msgbuf;
+	int shown = 0;
+
+	if (!graph)
+		return 0;
+
+	if (graph_is_commit_finished(graph))
+		return 0;
+
+	strbuf_init(&msgbuf, 0);
+	for (;;) {
+		graph_next_line(graph, &msgbuf);
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		strbuf_setlen(&msgbuf, 0);
+		shown = 1;
+
+		if (!graph_is_commit_finished(graph))
+			putchar('\n');
+		else
+			break;
+	}
+	strbuf_release(&msgbuf);
+
+	return shown;
+}
+
+
+void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
+{
+	if (!graph) {
+		fwrite(sb->buf, sizeof(char), sb->len, stdout);
+		return;
+	}
+
+	/*
+	 * Print the strbuf line by line,
+	 * and display the graph info before each line but the first.
+	 */
+	char *p = sb->buf;
+	while (p) {
+		size_t len;
+		char *next_p = strchr(p, '\n');
+		if (next_p) {
+			next_p++;
+			len = next_p - p;
+		} else {
+			len = (sb->buf + sb->len) - p;
+		}
+		fwrite(p, sizeof(char), len, stdout);
+		if (next_p && *next_p != '\0')
+			graph_show_oneline(graph);
+		p = next_p;
+	}
+}
diff --git a/graph.h b/graph.h
index fc23bf2..817862e 100644
--- a/graph.h
+++ b/graph.h
@@ -43,6 +43,15 @@ void graph_update(struct git_graph *graph, struct commit *commit);
 int graph_next_line(struct git_graph *graph, struct strbuf *sb);
 
 /*
+ * Output a padding line in the graph.
+ * This is similar to graph_next_line().  However, it is guaranteed to
+ * never print the current commit line.  Instead, if the commit line is
+ * next, it will simply output a line of vertical padding, extending the
+ * branch lines downwards, but leaving them otherwise unchanged.
+ */
+void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
+
+/*
  * Determine if a graph has finished outputting lines for the current
  * commit.
  *
@@ -54,4 +63,46 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb);
  */
 int graph_is_commit_finished(struct git_graph const *graph);
 
+
+/*
+ * graph_show_*: helper functions for printing to stdout
+ */
+
+
+/*
+ * If the graph is non-NULL, print the history graph to stdout,
+ * up to and including the line containing this commit.
+ * Does not print a terminating newline on the last line.
+ */
+void graph_show_commit(struct git_graph *graph);
+
+/*
+ * If the graph is non-NULL, print one line of the history graph to stdout.
+ * Does not print a terminating newline on the last line.
+ */
+void graph_show_oneline(struct git_graph *graph);
+
+/*
+ * If the graph is non-NULL, print one line of vertical graph padding to
+ * stdout.  Does not print a terminating newline on the last line.
+ */
+void graph_show_padding(struct git_graph *graph);
+
+/*
+ * If the graph is non-NULL, print the rest of the history graph for this
+ * commit to stdout.  Does not print a terminating newline on the last line.
+ */
+int graph_show_remainder(struct git_graph *graph);
+
+/*
+ * Print a strbuf to stdout.  If the graph is non-NULL, all lines but the
+ * first will be prefixed with the graph output.
+ *
+ * Since the firat line will not include the graph ouput, the caller is
+ * responsible for printing this line's graph (perhaps via
+ * graph_show_commit() or graph_show_oneline()) before calling
+ * graph_show_strbuf().
+ */
+void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
+
 #endif /* GRAPH_H */
-- 
1.5.3.6
