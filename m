From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 2/4] log and rev-list: Fixed newline termination issues with --graph
Date: Mon,  7 Apr 2008 01:01:19 -0700
Message-ID: <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 10:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JimIv-0007zd-F8
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbYDGIBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYDGIBb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:01:31 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:55237 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbYDGIB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:01:27 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id CEBAD1B4052;
	Mon,  7 Apr 2008 04:01:23 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 4166B1B40A2;
	Mon,  7 Apr 2008 04:01:23 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id D927E14100BC; Mon,  7 Apr 2008 01:01:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78958>

Previously, the --graph option had problems when used together with
--pretty=format.  The output was missing a newline at the end of each
entry, before the next graph line.

This change updates the code to treat CMIT_FMT_USERFORMAT just like
CMIT_FMT_ONELINE, even when --graph is not in use.  Like
CMIT_FMT_ONELINE, the pretty_print_commit() output for
CMIT_FMT_USERFORMAT lacks a terminating newline.  Similarly, there
should be no blank line between entries for CMIT_FMT_USERFORMAT.

The old code took care of these cases for CMIT_FMT_ONELINE, but not for
CMIT_FMT_USERFORMAT.  For CMIT_FMT_USERFORMAT, show_log() left each
entry without a terminating newline.  The next call to show_log() would
then try to print an extra blank line between entries.  However, since
the previous entry lacked a newline, the "blank line" simply added a
newline at the end of the previous entry.  For the most part, this made
the output look correct.  The very last entry in the output was always
missing a terminating newline, but piping the output through less would
hide this fact.  (Running with --no-pager would clearly show the missing
newline at the end of the output.)

I believe the old behavior was accidental, rather than intentional.  The
new code always prints a newline at the end of the last entry.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 builtin-rev-list.c |   52 ++++++++++++++---------------
 graph.c            |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 graph.h            |   20 ++++++++++-
 log-tree.c         |   61 ++++++++++++++-------------------
 4 files changed, 163 insertions(+), 63 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4427caa..ac6a6f9 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -53,7 +53,6 @@ static struct rev_info revs;
 
 static int bisect_list;
 static int show_timestamp;
-static int hdr_termination;
 static const char *header_prefix;
 
 static void finish_commit(struct commit *commit);
@@ -103,34 +102,34 @@ static void show_commit(struct commit *commit)
 		pretty_print_commit(revs.commit_format, commit,
 				    &buf, revs.abbrev, NULL, NULL,
 				    revs.date_mode, 0);
-		if (buf.len) {
-			if (revs.graph) {
-				graph_show_strbuf(revs.graph, &buf);
-				 if (revs.commit_format == CMIT_FMT_ONELINE) {
-					 /*
-					  * For CMIT_FMT_ONELINE, the buffer
-					  * doesn't end in a newline, so add one
-					  * first if graph_show_remainder()
-					  * needs to print more lines.
-					  */
-					if (!graph_is_commit_finished(revs.graph)) {
-						putchar('\n');
-						graph_show_remainder(revs.graph);
-					}
-				} else {
-					/*
-					 * For other formats, we want at least
-					 * one line separating commits.  If
-					 * graph_show_remainder() doesn't print
-					 * anything, add a padding line.
-					 */
-					if (!graph_show_remainder(revs.graph))
-						graph_show_padding(revs.graph);
-				}
+		if (revs.graph) {
+			/*
+			 * If revs.graph is non-NULL, we always need to print
+			 * an extra newline, even if msgbuf is empty.
+			 */
+			graph_show_commit_msg(revs.graph, &buf,
+					      revs.commit_format);
+
+			/*
+			 * For CMIT_FMT_ONELINE and CMIT_FMT_USERFORMAT,
+			 * we need to add a terminating newline to the
+			 * output.
+			 *
+			 * For other formats, we want an extra padding line
+			 * after the output.
+			 */
+			if (revs.commit_format == CMIT_FMT_ONELINE ||
+			    revs.commit_format == CMIT_FMT_USERFORMAT) {
+				putchar('\n');
 			} else {
+				graph_show_padding(revs.graph);
+				putchar('\n');
+			}
+		} else {
+			if (buf.len) {
 				fwrite(buf.buf, sizeof(char), buf.len, stdout);
+				putchar('\n');
 			}
-			putchar(hdr_termination);
 		}
 		strbuf_release(&buf);
 	} else {
@@ -630,7 +629,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
-		hdr_termination = '\n';
 		if (revs.commit_format == CMIT_FMT_ONELINE)
 			header_prefix = "";
 		else
diff --git a/graph.c b/graph.c
index 6f99063..3ecc378 100644
--- a/graph.c
+++ b/graph.c
@@ -857,3 +857,96 @@ void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
 		p = next_p;
 	}
 }
+
+void graph_show_commit_msg(struct git_graph *graph,
+			   struct strbuf const *sb,
+			   enum cmit_fmt commit_format)
+{
+	if (!graph) {
+		/*
+		 * If there's no graph, just print the message buffer.
+		 *
+		 * The message buffer for CMIT_FMT_ONELINE and
+		 * CMIT_FMT_USERFORMAT are already missing a terminating
+		 * newline.  All of the other formats should have it.
+		 */
+		fwrite(sb->buf, sizeof(char), sb->len, stdout);
+		return;
+	}
+
+	/*
+	 * If the message buffer is empty, just print the graph output.
+	 * For example, this can happen with CMIT_FMT_USERFORMAT if the
+	 * format is the empty string.
+	 *
+	 * We need a newline first before the next graph line.
+	 */
+	if (!sb->len) {
+		if (!graph_is_commit_finished(graph)) {
+			putchar('\n');
+			graph_show_remainder(graph);
+		}
+		if (commit_format != CMIT_FMT_ONELINE &&
+		    commit_format != CMIT_FMT_USERFORMAT)
+			putchar('\n');
+		return;
+	}
+
+	/*
+	 * Show the commit message
+	 */
+	graph_show_strbuf(graph, sb);
+
+	/*
+	 * Show the remainder of the graph output,
+	 * and make sure we terminate the output properly.
+	 */
+	if (commit_format == CMIT_FMT_ONELINE ||
+	    commit_format == CMIT_FMT_USERFORMAT) {
+		/*
+		 * For CMIT_FMT_ONELINE and CMIT_FMT_USERFORMAT, we need to
+		 * make sure that the printed output still needs a
+		 * terminating newline.
+		 */
+		if (sb->buf[sb->len - 1] == '\n') {
+			/*
+			 * If the buf already ends in a newline (which can
+			 * happen with CMIT_FMT_USERFORMAT if the format
+			 * ends in "%n"), we need to print the graph output
+			 * for the start of the new line after the newline.
+			 *
+			 * Call graph_show_remainder() to let it do this.
+			 * If it doesn't print anything, call
+			 * graph_show_oneline() to force an extra line to
+			 * be printed.
+			 */
+			if (!graph_show_remainder(graph))
+				graph_show_oneline(graph);
+		} else {
+			/*
+			 * The buffer output didn't end in a newline.
+			 *
+			 * If there is more output to print, add a newline
+			 * before calling graph_show_remainder().
+			 * Otherwise, we're done.
+			 */
+			if (!graph_is_commit_finished(graph)) {
+				putchar('\n');
+				graph_show_remainder(graph);
+			}
+		}
+	} else {
+		/*
+		 * For other formats, the output we print needs to end in a
+		 * newline.  The message buffer should already end in a
+		 * newline.
+		 *
+		 * Call graph_show_remainder() to print the rest of the
+		 * graph.  If it prints anything out, we need to add a
+		 * terminating newline at the end of its output.
+		 */
+		assert(sb->buf[sb->len - 1] == '\n');
+		if (graph_show_remainder(graph))
+			putchar('\n');
+	}
+}
diff --git a/graph.h b/graph.h
index c1f6892..aa02fca 100644
--- a/graph.h
+++ b/graph.h
@@ -93,11 +93,29 @@ int graph_show_remainder(struct git_graph *graph);
  * Print a strbuf to stdout.  If the graph is non-NULL, all lines but the
  * first will be prefixed with the graph output.
  *
- * Since the firat line will not include the graph ouput, the caller is
+ * If the strbuf ends with a newline, the output will end after this
+ * newline.  A new graph line will not be printed after the final newline.
+ *
+ * Since the first line will not include the graph ouput, the caller is
  * responsible for printing this line's graph (perhaps via
  * graph_show_commit() or graph_show_oneline()) before calling
  * graph_show_strbuf().
  */
 void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
 
+/*
+ * Print a commit message strbuf and the remainder of the graph to stdout.
+ *
+ * This is similar to graph_show_strbuf(), but it always prints the
+ * remainder of the graph, and it has additional logic necessary for use by
+ * the "log" and "rev-list" commands.
+ *
+ * If cmt_format is CMIT_FMT_ONELINE or CMIT_FMT_USERFORMAT, the resulting
+ * output will still need a terminating newline.  The caller is responsible
+ * for adding this.  Otherwise, no terminating newline is needed.
+ */
+void graph_show_commit_msg(struct git_graph *graph,
+			   struct strbuf const *sb,
+			   enum cmit_fmt commit_format);
+
 #endif /* GRAPH_H */
diff --git a/log-tree.c b/log-tree.c
index 5b78d1b..0d7e521 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -247,18 +247,24 @@ void show_log(struct rev_info *opt, const char *sep)
 	}
 
 	/*
-	 * The "oneline" format has several special cases:
-	 *  - The pretty-printed commit lacks a newline at the end
-	 *    of the buffer, but we do want to make sure that we
-	 *    have a newline there. If the separator isn't already
-	 *    a newline, add an extra one.
-	 *  - unlike other log messages, the one-line format does
-	 *    not have an empty line between entries.
+	 * The "oneline" and "userformat" formats have several special
+	 * cases:
+	 *  - The pretty-printed commit needs an additional a newline at
+	 *    the end of the buffer.  (The "oneline" output never ends in a
+	 *    newline.  The "userformat" output may, but only if the user's
+	 *    format explicitly ends in "%n".)  If the separator isn't
+	 *    already a newline, add an extra one.
+	 *  - unlike other log messages, the one-line and userformat
+	 *    formats do not have an empty line between entries.
 	 */
 	extra = "";
-	if (*sep != '\n' && opt->commit_format == CMIT_FMT_ONELINE)
+	if (*sep != '\n' &&
+	    (opt->commit_format == CMIT_FMT_ONELINE ||
+	     opt->commit_format == CMIT_FMT_USERFORMAT))
 		extra = "\n";
-	if (opt->shown_one && opt->commit_format != CMIT_FMT_ONELINE) {
+	if (opt->shown_one &&
+	    (opt->commit_format != CMIT_FMT_ONELINE &&
+	     opt->commit_format != CMIT_FMT_USERFORMAT)) {
 		graph_show_padding(opt->graph);
 		putchar(opt->diffopt.line_termination);
 	}
@@ -345,34 +351,19 @@ void show_log(struct rev_info *opt, const char *sep)
 		graph_show_oneline(opt->graph);
 	}
 
-	if (msgbuf.len) {
-		if (opt->graph) {
-			graph_show_strbuf(opt->graph, &msgbuf);
-			if (opt->commit_format == CMIT_FMT_ONELINE) {
-				/*
-				 * For CMIT_FMT_ONELINE, the buffer doesn't
-				 * end in a newline, so add one first if
-				 * graph_show_remainder() needs to print
-				 * more lines.
-				 */
-				if (!graph_is_commit_finished(opt->graph)) {
-					putchar('\n');
-					graph_show_remainder(opt->graph);
-				}
-			} else {
-				/*
-				 * For other formats, we want at least one
-				 * line separating commits.  If
-				 * graph_show_remainder() doesn't print
-				 * anything, add a padding line.
-				 */
-				if (graph_show_remainder(opt->graph))
-					putchar('\n');
-			}
-		} else {
+	if (opt->graph) {
+		/*
+		 * If opt->graph is non-NULL, we always need to print
+		 * extra and sep, even if msgbuf is empty.
+		 */
+		graph_show_commit_msg(opt->graph, &msgbuf,
+				      opt->commit_format);
+		printf("%s%s", extra, sep);
+	} else {
+		if (msgbuf.len) {
 			fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+			printf("%s%s", extra, sep);
 		}
-		printf("%s%s", extra, sep);
 	}
 	strbuf_release(&msgbuf);
 }
-- 
1.5.3.6
