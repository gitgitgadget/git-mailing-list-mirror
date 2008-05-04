From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 3/3] log and rev-list: add --graph option
Date: Sun,  4 May 2008 03:36:54 -0700
Message-ID: <1209897414-10091-4-git-send-email-adam@adamsimpkins.net>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
 <1209897414-10091-2-git-send-email-adam@adamsimpkins.net>
 <1209897414-10091-3-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 12:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsbca-00071l-54
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 12:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbYEDKhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 06:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbYEDKhj
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 06:37:39 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:50477 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbYEDKhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 06:37:00 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 94CE51B4037;
	Sun,  4 May 2008 06:36:59 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 19C0A1B401D;
	Sun,  4 May 2008 06:36:59 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 6383914100C4; Sun,  4 May 2008 03:36:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.128.gc15ea
In-Reply-To: <1209897414-10091-3-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81166>

This new option causes a text-based representation of the history to be
printed to the left of the normal output.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 Documentation/rev-list-options.txt            |   10 +++
 Documentation/technical/api-history-graph.txt |   13 +++--
 builtin-rev-list.c                            |   50 +++++++++++++++-
 log-tree.c                                    |   76 ++++++++++++++++++++++--
 revision.c                                    |   26 ++++++++-
 revision.h                                    |    6 ++-
 6 files changed, 163 insertions(+), 18 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2648a55..ce6a101 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -75,6 +75,16 @@ you would get an output line this:
 	-xxxxxxx... 1st on a
 -----------------------------------------------------------------------
 
+--graph::
+
+	Draw a text-based graphical representation of the commit history
+	on the left hand side of the output.  This may cause extra lines
+	to be printed in between commits, in order for the graph history
+	to be drawn properly.
++
+This implies the '--topo-order' option by default, but the
+'--date-order' option may also be specified.
+
 Diff Formatting
 ~~~~~~~~~~~~~~~
 
diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
index 5f6465f..ce1c08e 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -74,14 +74,17 @@ state.
 Calling sequence
 ----------------
 
-* Create a `struct git_graph` by calling `graph_init()`.
+* Create a `struct git_graph` by calling `graph_init()`.  When using the
+  revision walking API, this is done automatically by `setup_revisions()` if
+  the '--graph' option is supplied.
 
 * Use the revision walking API to walk through a group of contiguous commits.
+  The `get_revision()` function automatically calls `graph_update()` each time
+  it is invoked.
 
-* For each commit traversed, call `graph_update()` to move the graph to the
-  next commit.  Once `graph_update()` has been called, call `graph_next_line()`
-  repeatedly, until `graph_is_commit_finished()` returns non-zero.  Each call
-  to `graph_next_line()` will output a single line of the graph.  The resulting
+* For each commit, call `graph_next_line()` repeatedly, until
+  `graph_is_commit_finished()` returns non-zero.  Each call go
+  `graph_next_line()` will output a single line of the graph.  The resulting
   lines will not contain any newlines.  `graph_next_line()` returns 1 if the
   resulting line contains the current commit, or 0 if this is merely a line
   needed to adjust the graph before or after the current commit.  This return
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 476a870..f868290 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -10,6 +10,7 @@
 #include "list-objects.h"
 #include "builtin.h"
 #include "log-tree.h"
+#include "graph.h"
 
 /* bits #0-15 in revision.h */
 
@@ -52,12 +53,13 @@ static struct rev_info revs;
 
 static int bisect_list;
 static int show_timestamp;
-static int hdr_termination;
 static const char *header_prefix;
 
 static void finish_commit(struct commit *commit);
 static void show_commit(struct commit *commit)
 {
+	graph_show_commit(revs.graph);
+
 	if (show_timestamp)
 		printf("%lu ", commit->date);
 	if (header_prefix)
@@ -96,9 +98,50 @@ static void show_commit(struct commit *commit)
 		pretty_print_commit(revs.commit_format, commit,
 				    &buf, revs.abbrev, NULL, NULL,
 				    revs.date_mode, 0);
-		if (buf.len)
-			printf("%s%c", buf.buf, hdr_termination);
+		if (revs.graph) {
+			if (buf.len) {
+				if (revs.commit_format != CMIT_FMT_ONELINE)
+					graph_show_oneline(revs.graph);
+
+				graph_show_commit_msg(revs.graph, &buf);
+
+				/*
+				 * Add a newline after the commit message.
+				 *
+				 * Usually, this newline produces a blank
+				 * padding line between entries, in which case
+				 * we need to add graph padding on this line.
+				 *
+				 * However, the commit message may not end in a
+				 * newline.  In this case the newline simply
+				 * ends the last line of the commit message,
+				 * and we don't need any graph output.  (This
+				 * always happens with CMIT_FMT_ONELINE, and it
+				 * happens with CMIT_FMT_USERFORMAT when the
+				 * format doesn't explicitly end in a newline.)
+				 */
+				if (buf.len && buf.buf[buf.len - 1] == '\n')
+					graph_show_padding(revs.graph);
+				putchar('\n');
+			} else {
+				/*
+				 * If the message buffer is empty, just show
+				 * the rest of the graph output for this
+				 * commit.
+				 */
+				if (graph_show_remainder(revs.graph))
+					putchar('\n');
+			}
+		} else {
+			if (buf.len) {
+				fwrite(buf.buf, sizeof(char), buf.len, stdout);
+				putchar('\n');
+			}
+		}
 		strbuf_release(&buf);
+	} else {
+		if (graph_show_remainder(revs.graph))
+			putchar('\n');
 	}
 	maybe_flush_or_die(stdout, "stdout");
 	finish_commit(commit);
@@ -592,7 +635,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
-		hdr_termination = '\n';
 		if (revs.commit_format == CMIT_FMT_ONELINE)
 			header_prefix = "";
 		else
diff --git a/log-tree.c b/log-tree.c
index 74829d7..1474d1f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
+#include "graph.h"
 #include "log-tree.h"
 #include "reflog-walk.h"
 
@@ -165,11 +166,16 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 	}
 
 	printf("From %s Mon Sep 17 00:00:00 2001\n", name);
-	if (opt->message_id)
+	graph_show_oneline(opt->graph);
+	if (opt->message_id) {
 		printf("Message-Id: <%s>\n", opt->message_id);
-	if (opt->ref_message_id)
+		graph_show_oneline(opt->graph);
+	}
+	if (opt->ref_message_id) {
 		printf("In-Reply-To: <%s>\nReferences: <%s>\n",
 		       opt->ref_message_id, opt->ref_message_id);
+		graph_show_oneline(opt->graph);
+	}
 	if (opt->mime_boundary) {
 		static char subject_buffer[1024];
 		static char buffer[1024];
@@ -220,6 +226,8 @@ void show_log(struct rev_info *opt)
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
+		graph_show_commit(opt->graph);
+
 		if (commit->object.flags & BOUNDARY)
 			putchar('-');
 		else if (commit->object.flags & UNINTERESTING)
@@ -234,6 +242,10 @@ void show_log(struct rev_info *opt)
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		show_decorations(commit);
+		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
+			putchar('\n');
+			graph_show_remainder(opt->graph);
+		}
 		putchar(opt->diffopt.line_termination);
 		return;
 	}
@@ -243,11 +255,33 @@ void show_log(struct rev_info *opt)
 	 * Otherwise, add a diffopt.line_termination character before all
 	 * entries but the first.  (IOW, as a separator between entries)
 	 */
-	if (opt->shown_one && !opt->use_terminator)
+	if (opt->shown_one && !opt->use_terminator) {
+		/*
+		 * If entries are separated by a newline, the output
+		 * should look human-readable.  If the last entry ended
+		 * with a newline, print the graph output before this
+		 * newline.  Otherwise it will end up as a completely blank
+		 * line and will look like a gap in the graph.
+		 *
+		 * If the entry separator is not a newline, the output is
+		 * primarily intended for programmatic consumption, and we
+		 * never want the extra graph output before the entry
+		 * separator.
+		 */
+		if (opt->diffopt.line_termination == '\n' &&
+		    !opt->missing_newline)
+			graph_show_padding(opt->graph);
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
 
@@ -279,8 +313,19 @@ void show_log(struct rev_info *opt)
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
@@ -304,13 +349,30 @@ void show_log(struct rev_info *opt)
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
-	if (opt->show_log_size)
+	if (opt->show_log_size) {
 		printf("log size %i\n", (int)msgbuf.len);
+		graph_show_oneline(opt->graph);
+	}
 
-	if (msgbuf.len)
+	/*
+	 * Set opt->missing_newline if msgbuf doesn't
+	 * end in a newline (including if it is empty)
+	 */
+	if (!msgbuf.len || msgbuf.buf[msgbuf.len - 1] != '\n')
+		opt->missing_newline = 1;
+	else
+		opt->missing_newline = 0;
+
+	if (opt->graph)
+		graph_show_commit_msg(opt->graph, &msgbuf);
+	else
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
-	if (opt->use_terminator)
+	if (opt->use_terminator) {
+		if (!opt->missing_newline)
+			graph_show_padding(opt->graph);
 		putchar('\n');
+	}
+
 	strbuf_release(&msgbuf);
 }
 
diff --git a/revision.c b/revision.c
index a813304..c947e0f 100644
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
@@ -1203,6 +1204,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				get_commit_format(arg+8, revs);
 				continue;
 			}
+			if (!prefixcmp(arg, "--graph")) {
+				revs->topo_order = 1;
+				revs->rewrite_parents = 1;
+				revs->graph = graph_init();
+				continue;
+			}
 			if (!strcmp(arg, "--root")) {
 				revs->show_root_diff = 1;
 				continue;
@@ -1397,6 +1404,15 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
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
 	return left;
 }
 
@@ -1598,7 +1614,7 @@ static void gc_boundary(struct object_array *array)
 	}
 }
 
-struct commit *get_revision(struct rev_info *revs)
+static struct commit *get_revision_internal(struct rev_info *revs)
 {
 	struct commit *c = NULL;
 	struct commit_list *l;
@@ -1705,3 +1721,11 @@ struct commit *get_revision(struct rev_info *revs)
 
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
index 201bd97..abce500 100644
--- a/revision.h
+++ b/revision.h
@@ -66,7 +66,8 @@ struct rev_info {
 	/* Format info */
 	unsigned int	shown_one:1,
 			abbrev_commit:1,
-			use_terminator:1;
+			use_terminator:1,
+			missing_newline:1;
 	enum date_mode date_mode;
 
 	const char **ignore_packed; /* pretend objects in these are unpacked */
@@ -89,6 +90,9 @@ struct rev_info {
 	/* Filter by commit log message */
 	struct grep_opt	*grep_filter;
 
+	/* Display history graph */
+	struct git_graph *graph;
+
 	/* special limits */
 	int skip_count;
 	int max_count;
-- 
1.5.5.1.128.gc15ea
