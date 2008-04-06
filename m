From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 3/4] git log and git rev-list: Add --graph option
Date: Sun,  6 Apr 2008 11:42:10 -0700
Message-ID: <1207507332-1866-3-git-send-email-adam@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
 <1207507332-1866-2-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 20:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZpa-0004Dg-8K
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbYDFSmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 14:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbYDFSmX
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:42:23 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:56657 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbYDFSmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:42:16 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 261A11B40DB;
	Sun,  6 Apr 2008 14:42:14 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 26DA81B4175;
	Sun,  6 Apr 2008 14:42:13 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 207C014100BD; Sun,  6 Apr 2008 11:42:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207507332-1866-2-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78910>

The --graph option causes a text-based representation of the history
graph to be printed on the left-hand side of the output.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
The --graph option can be used with any --pretty format.  If this change
is too intrusive for people's liking, a smaller change could probably be
done that only adds --pretty=graph and --pretty=graph:<user_fmt>
options.

At the moment, --graph and --reverse are mutually exclusive.  With
Junio's new --children patch for git log, it probably shouldn't be too
hard to get them working together.

 Documentation/technical/api-history-graph.txt |   61 +++++++++++++++++------
 builtin-rev-list.c                            |   50 +++++++++++++++++--
 log-tree.c                                    |   65 +++++++++++++++++++++++--
 revision.c                                    |   28 ++++++++++-
 revision.h                                    |    3 +
 5 files changed, 180 insertions(+), 27 deletions(-)

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
index 34f45b0..c5f9054 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -4,26 +4,34 @@ history graph API
 The graph API is used to draw a text-based representation of the commit
 history.  The API generates the graph in a line-by-line fashion.
 
-Calling sequence
-----------------
+Functions
+---------
 
-* Create a `struct git_graph` by calling `graph_init()`
+Core functions:
 
-* Use the revision walking API to walk through a group of contiguous commits.
+* `graph_init()` creates a new `struct git_graph`
+
+* `graph_release()` destroys a `struct git_graph`, and frees the memory
+  associated with it.
 
-* For each commit you walk through, call `graph_update()`.  Then call
-  `graph_next_line()` repeatedly, until `graph_is_commit_finished()` returns
-  non-zero.  Each call go `graph_next_line()` will output a single line of the
-  graph.  The resulting lines will not contain any newlines.
-  `graph_next_line()` returns 1 if the resulting line contains the current
-  commit, or 0 if this is merely a line needed to adjust the graph before or
-  after the current commit.  This return value can be used to determine where
-  to print the commit summary information alongside the graph output.
+* `graph_update()` moves the graph to a new commit.
 
-Utility functions
------------------
+* `graph_next_line()` outputs the next line of the graph into a strbuf.  It does
+  not add a terminating newline.
 
-The following functions are wrappers around `graph_next_line()` and
+* `graph_padding_line()` outputs a line of vertical padding in the graph.  It
+  is similar to `graph_next_line()`, but is guaranteed to never print the line
+  containing the current commit.  Where `graph_next_line()` would print the
+  commit line next, `graph_padding_line()` prints a line that simply extends
+  all branch lines downwards one row, leaving their positions unchanged.
+
+* `graph_is_commit_finished()` determines if the graph has output all lines
+  necessary for the current commit.  If `graph_update()` is called before all
+  lines for the current commit have been printed, the next call to
+  `graph_next_line()` will output an ellipsis, to indicate that a portion of the
+  graph was omitted.
+
+The following utility functions are wrappers around `graph_next_line()` and
 `graph_is_commit_finished()`.  They always print the output to stdout.
 They can all be called with a NULL graph argument, in which case no graph output
 will be printed.
@@ -37,6 +45,9 @@ will be printed.
 * `graph_show_oneline()` calls `graph_next_line()` and prints the result to
   stdout.  The line printed does not contain a terminating newline.
 
+* `graph_show_padding()` calls `graph_padding_line()` and prints the result to
+  stdout.  The line printed does not contain a terminating newline.
+
 * `graph_show_remainder()` calls `graph_next_line()` until
   `graph_is_commit_finished()` returns non-zero.  Output is printed to stdout.
   The last line printed does not contain a terminating newline.  Returns 1 if
@@ -53,6 +64,26 @@ Data structure
 `struct git_graph` is an opaque data type used to store the current graph
 state.
 
+Calling sequence
+----------------
+
+* Create a `struct git_graph` by calling `graph_init()`.  When using the
+  revision walking API, this is done automatically by `setup_revisions()` if
+  the '--graph' option is supplied.
+
+* Use the revision walking API to walk through a group of contiguous commits.
+  The `get_revision()` function automatically calls `graph_update()` each time
+  it is invoked.
+
+* For each commit, call `graph_next_line()` repeatedly, until
+  `graph_is_commit_finished()` returns non-zero.  Each call go
+  `graph_next_line()` will output a single line of the graph.  The resulting
+  lines will not contain any newlines.  `graph_next_line()` returns 1 if the
+  resulting line contains the current commit, or 0 if this is merely a line
+  needed to adjust the graph before or after the current commit.  This return
+  value can be used to determine where to print the commit summary information
+  alongside the graph output.
+
 Limitations
 -----------
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index edc0bd3..4427caa 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -10,6 +10,7 @@
 #include "list-objects.h"
 #include "builtin.h"
 #include "log-tree.h"
+#include "graph.h"
 
 /* bits #0-15 in revision.h */
 
@@ -58,6 +59,8 @@ static const char *header_prefix;
 static void finish_commit(struct commit *commit);
 static void show_commit(struct commit *commit)
 {
+	graph_show_commit(revs.graph);
+
 	if (show_timestamp)
 		printf("%lu ", commit->date);
 	if (header_prefix)
@@ -85,20 +88,55 @@ static void show_commit(struct commit *commit)
 		}
 	}
 	show_decorations(commit);
-	if (revs.commit_format == CMIT_FMT_ONELINE)
-		putchar(' ');
-	else
-		putchar('\n');
 
 	if (revs.verbose_header && commit->buffer) {
 		struct strbuf buf;
+
+		if (revs.commit_format == CMIT_FMT_ONELINE) {
+			putchar(' ');
+		} else {
+			putchar('\n');
+			graph_show_oneline(revs.graph);
+		}
+
 		strbuf_init(&buf, 0);
 		pretty_print_commit(revs.commit_format, commit,
 				    &buf, revs.abbrev, NULL, NULL,
 				    revs.date_mode, 0);
-		if (buf.len)
-			printf("%s%c", buf.buf, hdr_termination);
+		if (buf.len) {
+			if (revs.graph) {
+				graph_show_strbuf(revs.graph, &buf);
+				 if (revs.commit_format == CMIT_FMT_ONELINE) {
+					 /*
+					  * For CMIT_FMT_ONELINE, the buffer
+					  * doesn't end in a newline, so add one
+					  * first if graph_show_remainder()
+					  * needs to print more lines.
+					  */
+					if (!graph_is_commit_finished(revs.graph)) {
+						putchar('\n');
+						graph_show_remainder(revs.graph);
+					}
+				} else {
+					/*
+					 * For other formats, we want at least
+					 * one line separating commits.  If
+					 * graph_show_remainder() doesn't print
+					 * anything, add a padding line.
+					 */
+					if (!graph_show_remainder(revs.graph))
+						graph_show_padding(revs.graph);
+				}
+			} else {
+				fwrite(buf.buf, sizeof(char), buf.len, stdout);
+			}
+			putchar(hdr_termination);
+		}
 		strbuf_release(&buf);
+	} else {
+		putchar('\n');
+		if (graph_show_remainder(revs.graph))
+			putchar('\n');
 	}
 	maybe_flush_or_die(stdout, "stdout");
 	finish_commit(commit);
diff --git a/log-tree.c b/log-tree.c
index 5b29639..5b78d1b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
+#include "graph.h"
 #include "log-tree.h"
 #include "reflog-walk.h"
 
@@ -221,6 +222,8 @@ void show_log(struct rev_info *opt, const char *sep)
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
+		graph_show_commit(opt->graph);
+
 		if (commit->object.flags & BOUNDARY)
 			putchar('-');
 		else if (commit->object.flags & UNINTERESTING)
@@ -235,6 +238,10 @@ void show_log(struct rev_info *opt, const char *sep)
 		if (opt->parents)
 			show_parents(commit, abbrev_commit);
 		show_decorations(commit);
+		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
+			putchar('\n');
+			graph_show_remainder(opt->graph);
+		}
 		putchar(opt->diffopt.line_termination);
 		return;
 	}
@@ -251,11 +258,19 @@ void show_log(struct rev_info *opt, const char *sep)
 	extra = "";
 	if (*sep != '\n' && opt->commit_format == CMIT_FMT_ONELINE)
 		extra = "\n";
-	if (opt->shown_one && opt->commit_format != CMIT_FMT_ONELINE)
+	if (opt->shown_one && opt->commit_format != CMIT_FMT_ONELINE) {
+		graph_show_padding(opt->graph);
 		putchar(opt->diffopt.line_termination);
+	}
 	opt->shown_one = 1;
 
 	/*
+	 * If the history graph was requested,
+	 * print the graph, up to this commit's line
+	 */
+	graph_show_commit(opt->graph);
+
+	/*
 	 * Print header line of header..
 	 */
 
@@ -287,8 +302,19 @@ void show_log(struct rev_info *opt, const char *sep)
 						  abbrev_commit));
 		show_decorations(commit);
 		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
-		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
+		if (opt->commit_format == CMIT_FMT_ONELINE) {
+			putchar(' ');
+		} else {
+			putchar('\n');
+			graph_show_oneline(opt->graph);
+		}
 		if (opt->reflog_info) {
+			/*
+			 * setup_revisions() ensures that opt->reflog_info
+			 * and opt->graph cannot both be set,
+			 * so we don't need to worry about printing the
+			 * graph info here.
+			 */
 			show_reflog_message(opt->reflog_info,
 				    opt->commit_format == CMIT_FMT_ONELINE,
 				    opt->date_mode);
@@ -314,11 +340,40 @@ void show_log(struct rev_info *opt, const char *sep)
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
-	if (opt->show_log_size)
+	if (opt->show_log_size) {
 		printf("log size %i\n", (int)msgbuf.len);
+		graph_show_oneline(opt->graph);
+	}
 
-	if (msgbuf.len)
-		printf("%s%s%s", msgbuf.buf, extra, sep);
+	if (msgbuf.len) {
+		if (opt->graph) {
+			graph_show_strbuf(opt->graph, &msgbuf);
+			if (opt->commit_format == CMIT_FMT_ONELINE) {
+				/*
+				 * For CMIT_FMT_ONELINE, the buffer doesn't
+				 * end in a newline, so add one first if
+				 * graph_show_remainder() needs to print
+				 * more lines.
+				 */
+				if (!graph_is_commit_finished(opt->graph)) {
+					putchar('\n');
+					graph_show_remainder(opt->graph);
+				}
+			} else {
+				/*
+				 * For other formats, we want at least one
+				 * line separating commits.  If
+				 * graph_show_remainder() doesn't print
+				 * anything, add a padding line.
+				 */
+				if (graph_show_remainder(opt->graph))
+					putchar('\n');
+			}
+		} else {
+			fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		}
+		printf("%s%s", extra, sep);
+	}
 	strbuf_release(&msgbuf);
 }
 
diff --git a/revision.c b/revision.c
index 196fedc..6c9622c 100644
--- a/revision.c
+++ b/revision.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "refs.h"
 #include "revision.h"
+#include "graph.h"
 #include "grep.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
@@ -1201,6 +1202,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->commit_format = get_commit_format(arg+8);
 				continue;
 			}
+			if (!prefixcmp(arg, "--graph")) {
+				revs->topo_order = 1;
+				revs->graph = graph_init();
+				continue;
+			}
 			if (!strcmp(arg, "--root")) {
 				revs->show_root_diff = 1;
 				continue;
@@ -1395,6 +1401,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->reverse && revs->reflog_info)
 		die("cannot combine --reverse with --walk-reflogs");
 
+	/*
+	 * Limitations on the graph functionality
+	 */
+	if (revs->reverse && revs->graph)
+		die("cannot combine --reverse with --graph");
+
+	if (revs->reflog_info && revs->graph)
+		die("cannot combine --walk-reflogs with --graph");
+
+	if (revs->graph && revs->prune_data)
+		die("cannot use --graph when pruning commit list");
+
 	return left;
 }
 
@@ -1596,7 +1614,7 @@ static void gc_boundary(struct object_array *array)
 	}
 }
 
-struct commit *get_revision(struct rev_info *revs)
+static struct commit *get_revision_internal(struct rev_info *revs)
 {
 	struct commit *c = NULL;
 	struct commit_list *l;
@@ -1703,3 +1721,11 @@ struct commit *get_revision(struct rev_info *revs)
 
 	return c;
 }
+
+struct commit *get_revision(struct rev_info *revs)
+{
+	struct commit *c = get_revision_internal(revs);
+	if (c && revs->graph)
+		graph_update(revs->graph, c);
+	return c;
+}
diff --git a/revision.h b/revision.h
index c8b3b94..d06b991 100644
--- a/revision.h
+++ b/revision.h
@@ -87,6 +87,9 @@ struct rev_info {
 	/* Filter by commit log message */
 	struct grep_opt	*grep_filter;
 
+	/* Display history graph */
+	struct git_graph *graph;
+
 	/* special limits */
 	int skip_count;
 	int max_count;
-- 
1.5.3.6
