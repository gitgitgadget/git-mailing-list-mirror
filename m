Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56251F859
	for <e@80x24.org>; Thu, 25 Aug 2016 23:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbcHYXf1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 19:35:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:61121 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754625AbcHYXfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 19:35:16 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP; 25 Aug 2016 16:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,578,1464678000"; 
   d="scan'208";a="161062163"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2016 16:32:46 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v11 3/8] graph: add support for --line-prefix on all graph-aware output
Date:   Thu, 25 Aug 2016 16:32:38 -0700
Message-Id: <20160825233243.30700-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
In-Reply-To: <20160825233243.30700-1-jacob.e.keller@intel.com>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Add an extension to git-diff and git-log (and any other graph-aware
displayable output) such that "--line-prefix=<string>" will print the
additional line-prefix on every line of output.

To make this work, we have to fix a few bugs in the graph API that force
graph_show_commit_msg to be used only when you have a valid graph.
Additionally, we extend the default_diff_output_prefix handler to work
even when no graph is enabled.

This is somewhat of a hack on top of the graph API, but I think it
should be acceptable here.

This will be used by a future extension of submodule display which
displays the submodule diff as the actual diff between the pre and post
commit in the submodule project.

Add some tests for both git-log and git-diff to ensure that the prefix
is honored correctly.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/diff-options.txt                     |   3 +
 builtin/rev-list.c                                 |  70 ++---
 diff.c                                             |   7 +
 diff.h                                             |   2 +
 graph.c                                            |  98 ++++---
 graph.h                                            |  22 +-
 log-tree.c                                         |   5 +-
 t/t4013-diff-various.sh                            |   6 +
 ...diff.diff_--line-prefix=abc_master_master^_side |  29 ++
 t/t4013/diff.diff_--line-prefix_--cached_--_file0  |  15 +
 t/t4202-log.sh                                     | 323 +++++++++++++++++++++
 11 files changed, 502 insertions(+), 78 deletions(-)
 create mode 100644 t/t4013/diff.diff_--line-prefix=abc_master_master^_side
 create mode 100644 t/t4013/diff.diff_--line-prefix_--cached_--_file0

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 705a87394200..cc4342e2034d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -569,5 +569,8 @@ endif::git-format-patch[]
 --no-prefix::
 	Do not show any source or destination prefix.
 
+--line-prefix=<prefix>::
+	Prepend an additional prefix to every line of output.
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0ba82b1635b6..8479f6ed28aa 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -122,48 +122,40 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.fmt = revs->commit_format;
 		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &buf);
-		if (revs->graph) {
-			if (buf.len) {
-				if (revs->commit_format != CMIT_FMT_ONELINE)
-					graph_show_oneline(revs->graph);
+		if (buf.len) {
+			if (revs->commit_format != CMIT_FMT_ONELINE)
+				graph_show_oneline(revs->graph);
 
-				graph_show_commit_msg(revs->graph, &buf);
+			graph_show_commit_msg(revs->graph, stdout, &buf);
 
-				/*
-				 * Add a newline after the commit message.
-				 *
-				 * Usually, this newline produces a blank
-				 * padding line between entries, in which case
-				 * we need to add graph padding on this line.
-				 *
-				 * However, the commit message may not end in a
-				 * newline.  In this case the newline simply
-				 * ends the last line of the commit message,
-				 * and we don't need any graph output.  (This
-				 * always happens with CMIT_FMT_ONELINE, and it
-				 * happens with CMIT_FMT_USERFORMAT when the
-				 * format doesn't explicitly end in a newline.)
-				 */
-				if (buf.len && buf.buf[buf.len - 1] == '\n')
-					graph_show_padding(revs->graph);
-				putchar('\n');
-			} else {
-				/*
-				 * If the message buffer is empty, just show
-				 * the rest of the graph output for this
-				 * commit.
-				 */
-				if (graph_show_remainder(revs->graph))
-					putchar('\n');
-				if (revs->commit_format == CMIT_FMT_ONELINE)
-					putchar('\n');
-			}
+			/*
+			 * Add a newline after the commit message.
+			 *
+			 * Usually, this newline produces a blank
+			 * padding line between entries, in which case
+			 * we need to add graph padding on this line.
+			 *
+			 * However, the commit message may not end in a
+			 * newline.  In this case the newline simply
+			 * ends the last line of the commit message,
+			 * and we don't need any graph output.  (This
+			 * always happens with CMIT_FMT_ONELINE, and it
+			 * happens with CMIT_FMT_USERFORMAT when the
+			 * format doesn't explicitly end in a newline.)
+			 */
+			if (buf.len && buf.buf[buf.len - 1] == '\n')
+				graph_show_padding(revs->graph);
+			putchar('\n');
 		} else {
-			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
-			    buf.len) {
-				fwrite(buf.buf, 1, buf.len, stdout);
-				putchar(info->hdr_termination);
-			}
+			/*
+			 * If the message buffer is empty, just show
+			 * the rest of the graph output for this
+			 * commit.
+			 */
+			if (graph_show_remainder(revs->graph))
+				putchar('\n');
+			if (revs->commit_format == CMIT_FMT_ONELINE)
+				putchar('\n');
 		}
 		strbuf_release(&buf);
 	} else {
diff --git a/diff.c b/diff.c
index 50bef1f07658..e57cf39ad109 100644
--- a/diff.c
+++ b/diff.c
@@ -18,6 +18,7 @@
 #include "ll-merge.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "graph.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -3966,6 +3967,12 @@ int diff_opt_parse(struct diff_options *options,
 		options->a_prefix = optarg;
 		return argcount;
 	}
+	else if ((argcount = parse_long_opt("line-prefix", av, &optarg))) {
+		options->line_prefix = optarg;
+		options->line_prefix_length = strlen(options->line_prefix);
+		graph_setup_line_prefix(options);
+		return argcount;
+	}
 	else if ((argcount = parse_long_opt("dst-prefix", av, &optarg))) {
 		options->b_prefix = optarg;
 		return argcount;
diff --git a/diff.h b/diff.h
index 747a204d75a4..1f57aad25c71 100644
--- a/diff.h
+++ b/diff.h
@@ -115,6 +115,8 @@ struct diff_options {
 	const char *pickaxe;
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
+	const char *line_prefix;
+	size_t line_prefix_length;
 	unsigned flags;
 	unsigned touched_flags;
 
diff --git a/graph.c b/graph.c
index a46803840511..06f1139f2e20 100644
--- a/graph.c
+++ b/graph.c
@@ -2,7 +2,6 @@
 #include "commit.h"
 #include "color.h"
 #include "graph.h"
-#include "diff.h"
 #include "revision.h"
 
 /* Internal API */
@@ -28,8 +27,15 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
  * responsible for printing this line's graph (perhaps via
  * graph_show_commit() or graph_show_oneline()) before calling
  * graph_show_strbuf().
+ *
+ * Note that unlike some other graph display functions, you must pass the file
+ * handle directly. It is assumed that this is the same file handle as the
+ * file specified by the graph diff options. This is necessary so that
+ * graph_show_strbuf can be called even with a NULL graph.
  */
-static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
+static void graph_show_strbuf(struct git_graph *graph,
+			      FILE *file,
+			      struct strbuf const *sb);
 
 /*
  * TODO:
@@ -59,6 +65,17 @@ enum graph_state {
 	GRAPH_COLLAPSING
 };
 
+static void graph_show_line_prefix(const struct diff_options *diffopt)
+{
+	if (!diffopt || !diffopt->line_prefix)
+		return;
+
+	fwrite(diffopt->line_prefix,
+	       sizeof(char),
+	       diffopt->line_prefix_length,
+	       diffopt->file);
+}
+
 static const char **column_colors;
 static unsigned short column_colors_max;
 
@@ -195,13 +212,28 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 	static struct strbuf msgbuf = STRBUF_INIT;
 
 	assert(opt);
-	assert(graph);
 
 	strbuf_reset(&msgbuf);
-	graph_padding_line(graph, &msgbuf);
+	if (opt->line_prefix)
+		strbuf_add(&msgbuf, opt->line_prefix,
+			   opt->line_prefix_length);
+	if (graph)
+		graph_padding_line(graph, &msgbuf);
 	return &msgbuf;
 }
 
+static const struct diff_options *default_diffopt;
+
+void graph_setup_line_prefix(struct diff_options *diffopt)
+{
+	default_diffopt = diffopt;
+
+	/* setup an output prefix callback if necessary */
+	if (diffopt && !diffopt->output_prefix)
+		diffopt->output_prefix = diff_output_prefix_callback;
+}
+
+
 struct git_graph *graph_init(struct rev_info *opt)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
@@ -1183,6 +1215,8 @@ void graph_show_commit(struct git_graph *graph)
 	struct strbuf msgbuf = STRBUF_INIT;
 	int shown_commit_line = 0;
 
+	graph_show_line_prefix(default_diffopt);
+
 	if (!graph)
 		return;
 
@@ -1200,8 +1234,10 @@ void graph_show_commit(struct git_graph *graph)
 		shown_commit_line = graph_next_line(graph, &msgbuf);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len,
 			graph->revs->diffopt.file);
-		if (!shown_commit_line)
+		if (!shown_commit_line) {
 			putc('\n', graph->revs->diffopt.file);
+			graph_show_line_prefix(&graph->revs->diffopt);
+		}
 		strbuf_setlen(&msgbuf, 0);
 	}
 
@@ -1212,6 +1248,8 @@ void graph_show_oneline(struct git_graph *graph)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
 
+	graph_show_line_prefix(default_diffopt);
+
 	if (!graph)
 		return;
 
@@ -1224,6 +1262,8 @@ void graph_show_padding(struct git_graph *graph)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
 
+	graph_show_line_prefix(default_diffopt);
+
 	if (!graph)
 		return;
 
@@ -1237,6 +1277,8 @@ int graph_show_remainder(struct git_graph *graph)
 	struct strbuf msgbuf = STRBUF_INIT;
 	int shown = 0;
 
+	graph_show_line_prefix(default_diffopt);
+
 	if (!graph)
 		return 0;
 
@@ -1250,27 +1292,24 @@ int graph_show_remainder(struct git_graph *graph)
 		strbuf_setlen(&msgbuf, 0);
 		shown = 1;
 
-		if (!graph_is_commit_finished(graph))
+		if (!graph_is_commit_finished(graph)) {
 			putc('\n', graph->revs->diffopt.file);
-		else
+			graph_show_line_prefix(&graph->revs->diffopt);
+		} else {
 			break;
+		}
 	}
 	strbuf_release(&msgbuf);
 
 	return shown;
 }
 
-
-static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
+static void graph_show_strbuf(struct git_graph *graph,
+			      FILE *file,
+			      struct strbuf const *sb)
 {
 	char *p;
 
-	if (!graph) {
-		fwrite(sb->buf, sizeof(char), sb->len,
-			graph->revs->diffopt.file);
-		return;
-	}
-
 	/*
 	 * Print the strbuf line by line,
 	 * and display the graph info before each line but the first.
@@ -1285,7 +1324,7 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
 		} else {
 			len = (sb->buf + sb->len) - p;
 		}
-		fwrite(p, sizeof(char), len, graph->revs->diffopt.file);
+		fwrite(p, sizeof(char), len, file);
 		if (next_p && *next_p != '\0')
 			graph_show_oneline(graph);
 		p = next_p;
@@ -1293,29 +1332,20 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
 }
 
 void graph_show_commit_msg(struct git_graph *graph,
+			   FILE *file,
 			   struct strbuf const *sb)
 {
 	int newline_terminated;
 
-	if (!graph) {
-		/*
-		 * If there's no graph, just print the message buffer.
-		 *
-		 * The message buffer for CMIT_FMT_ONELINE and
-		 * CMIT_FMT_USERFORMAT are already missing a terminating
-		 * newline.  All of the other formats should have it.
-		 */
-		fwrite(sb->buf, sizeof(char), sb->len,
-			graph->revs->diffopt.file);
-		return;
-	}
-
-	newline_terminated = (sb->len && sb->buf[sb->len - 1] == '\n');
-
 	/*
 	 * Show the commit message
 	 */
-	graph_show_strbuf(graph, sb);
+	graph_show_strbuf(graph, file, sb);
+
+	if (!graph)
+		return;
+
+	newline_terminated = (sb->len && sb->buf[sb->len - 1] == '\n');
 
 	/*
 	 * If there is more output needed for this commit, show it now
@@ -1327,7 +1357,7 @@ void graph_show_commit_msg(struct git_graph *graph,
 		 * new line.
 		 */
 		if (!newline_terminated)
-			putc('\n', graph->revs->diffopt.file);
+			putc('\n', file);
 
 		graph_show_remainder(graph);
 
@@ -1335,6 +1365,6 @@ void graph_show_commit_msg(struct git_graph *graph,
 		 * If sb ends with a newline, our output should too.
 		 */
 		if (newline_terminated)
-			putc('\n', graph->revs->diffopt.file);
+			putc('\n', file);
 	}
 }
diff --git a/graph.h b/graph.h
index 3f48c19b6208..af623390b605 100644
--- a/graph.h
+++ b/graph.h
@@ -1,9 +1,22 @@
 #ifndef GRAPH_H
 #define GRAPH_H
+#include "diff.h"
 
 /* A graph is a pointer to this opaque structure */
 struct git_graph;
 
+/*
+ * Called to setup global display of line_prefix diff option.
+ *
+ * Passed a diff_options structure which indicates the line_prefix and the
+ * file to output the prefix to. This is sort of a hack used so that the
+ * line_prefix will be honored by all flows which also honor "--graph"
+ * regardless of whether a graph has actually been setup. The normal graph
+ * flow will honor the exact diff_options passed, but a NULL graph will cause
+ * display of a line_prefix to stdout.
+ */
+void graph_setup_line_prefix(struct diff_options *diffopt);
+
 /*
  * Set up a custom scheme for column colors.
  *
@@ -113,7 +126,14 @@ int graph_show_remainder(struct git_graph *graph);
  * missing a terminating newline (including if it is empty), the output
  * printed by graph_show_commit_msg() will also be missing a terminating
  * newline.
+ *
+ * Note that unlike some other graph display functions, you must pass the file
+ * handle directly. It is assumed that this is the same file handle as the
+ * file specified by the graph diff options. This is necessary so that
+ * graph_show_commit_msg can be called even with a NULL graph.
  */
-void graph_show_commit_msg(struct git_graph *graph, struct strbuf const *sb);
+void graph_show_commit_msg(struct git_graph *graph,
+			   FILE *file,
+			   struct strbuf const *sb);
 
 #endif /* GRAPH_H */
diff --git a/log-tree.c b/log-tree.c
index bfb735c84556..8c2415747a26 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -715,10 +715,7 @@ void show_log(struct rev_info *opt)
 	else
 		opt->missing_newline = 0;
 
-	if (opt->graph)
-		graph_show_commit_msg(opt->graph, &msgbuf);
-	else
-		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, opt->diffopt.file);
+	graph_show_commit_msg(opt->graph, opt->diffopt.file, &msgbuf);
 	if (opt->use_terminator && !commit_format_is_empty(opt->commit_format)) {
 		if (!opt->missing_newline)
 			graph_show_padding(opt->graph);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 94ef5000e787..566817e2efdc 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -306,6 +306,8 @@ diff --no-index --name-status dir2 dir
 diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
 diff master master^ side
+# Can't use spaces...
+diff --line-prefix=abc master master^ side
 diff --dirstat master~1 master~2
 diff --dirstat initial rearrange
 diff --dirstat-by-file initial rearrange
@@ -325,6 +327,10 @@ test_expect_success 'diff --cached -- file on unborn branch' '
 	git diff --cached -- file0 >result &&
 	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" result
 '
+test_expect_success 'diff --line-prefix with spaces' '
+	git diff --line-prefix="| | | " --cached -- file0 >result &&
+	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--line-prefix_--cached_--_file0" result
+'
 
 test_expect_success 'diff-tree --stdin with log formatting' '
 	cat >expect <<-\EOF &&
diff --git a/t/t4013/diff.diff_--line-prefix=abc_master_master^_side b/t/t4013/diff.diff_--line-prefix=abc_master_master^_side
new file mode 100644
index 000000000000..99f91e7f0e32
--- /dev/null
+++ b/t/t4013/diff.diff_--line-prefix=abc_master_master^_side
@@ -0,0 +1,29 @@
+$ git diff --line-prefix=abc master master^ side
+abcdiff --cc dir/sub
+abcindex cead32e,7289e35..992913c
+abc--- a/dir/sub
+abc+++ b/dir/sub
+abc@@@ -1,6 -1,4 +1,8 @@@
+abc  A
+abc  B
+abc +C
+abc +D
+abc +E
+abc +F
+abc+ 1
+abc+ 2
+abcdiff --cc file0
+abcindex b414108,f4615da..10a8a9f
+abc--- a/file0
+abc+++ b/file0
+abc@@@ -1,6 -1,6 +1,9 @@@
+abc  1
+abc  2
+abc  3
+abc +4
+abc +5
+abc +6
+abc+ A
+abc+ B
+abc+ C
+$
diff --git a/t/t4013/diff.diff_--line-prefix_--cached_--_file0 b/t/t4013/diff.diff_--line-prefix_--cached_--_file0
new file mode 100644
index 000000000000..f41ba4d36aa1
--- /dev/null
+++ b/t/t4013/diff.diff_--line-prefix_--cached_--_file0
@@ -0,0 +1,15 @@
+| | | diff --git a/file0 b/file0
+| | | new file mode 100644
+| | | index 0000000..10a8a9f
+| | | --- /dev/null
+| | | +++ b/file0
+| | | @@ -0,0 +1,9 @@
+| | | +1
+| | | +2
+| | | +3
+| | | +4
+| | | +5
+| | | +6
+| | | +A
+| | | +B
+| | | +C
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e2db47c36e09..1ccbd5948a73 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -187,6 +187,16 @@ test_expect_success 'git log --no-walk=sorted <commits> sorts by commit time' '
 	test_cmp expect actual
 '
 
+cat > expect << EOF
+=== 804a787 sixth
+=== 394ef78 fifth
+=== 5d31159 fourth
+EOF
+test_expect_success 'git log --line-prefix="=== " --no-walk <commits> sorts by commit time' '
+	git log --line-prefix="=== " --no-walk --oneline 5d31159 804a787 394ef78 > actual &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
 5d31159 fourth
 804a787 sixth
@@ -284,6 +294,21 @@ test_expect_success 'simple log --graph' '
 	test_cmp expect actual
 '
 
+cat > expect <<EOF
+123 * Second
+123 * sixth
+123 * fifth
+123 * fourth
+123 * third
+123 * second
+123 * initial
+EOF
+
+test_expect_success 'simple log --graph --line-prefix="123 "' '
+	git log --graph --line-prefix="123 " --pretty=tformat:%s >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up merge history' '
 	git checkout -b side HEAD~4 &&
 	test_commit side-1 1 1 &&
@@ -313,6 +338,27 @@ test_expect_success 'log --graph with merge' '
 	test_cmp expect actual
 '
 
+cat > expect <<\EOF
+| | | *   Merge branch 'side'
+| | | |\
+| | | | * side-2
+| | | | * side-1
+| | | * | Second
+| | | * | sixth
+| | | * | fifth
+| | | * | fourth
+| | | |/
+| | | * third
+| | | * second
+| | | * initial
+EOF
+
+test_expect_success 'log --graph --line-prefix="| | | " with merge' '
+	git log --line-prefix="| | | " --graph --date-order --pretty=tformat:%s |
+		sed "s/ *\$//" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --raw --graph -m with merge' '
 	git log --raw --graph --oneline -m master | head -n 500 >actual &&
 	grep "initial" actual
@@ -867,6 +913,283 @@ test_expect_success 'log --graph with diff and stats' '
 	test_i18ncmp expect actual.sanitized
 '
 
+cat >expect <<\EOF
+*** *   commit COMMIT_OBJECT_NAME
+*** |\  Merge: MERGE_PARENTS
+*** | | Author: A U Thor <author@example.com>
+*** | |
+*** | |     Merge HEADS DESCRIPTION
+*** | |
+*** | * commit COMMIT_OBJECT_NAME
+*** | | Author: A U Thor <author@example.com>
+*** | |
+*** | |     reach
+*** | | ---
+*** | |  reach.t | 1 +
+*** | |  1 file changed, 1 insertion(+)
+*** | |
+*** | | diff --git a/reach.t b/reach.t
+*** | | new file mode 100644
+*** | | index 0000000..10c9591
+*** | | --- /dev/null
+*** | | +++ b/reach.t
+*** | | @@ -0,0 +1 @@
+*** | | +reach
+*** | |
+*** |  \
+*** *-. \   commit COMMIT_OBJECT_NAME
+*** |\ \ \  Merge: MERGE_PARENTS
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     Merge HEADS DESCRIPTION
+*** | | | |
+*** | | * | commit COMMIT_OBJECT_NAME
+*** | | |/  Author: A U Thor <author@example.com>
+*** | | |
+*** | | |       octopus-b
+*** | | |   ---
+*** | | |    octopus-b.t | 1 +
+*** | | |    1 file changed, 1 insertion(+)
+*** | | |
+*** | | |   diff --git a/octopus-b.t b/octopus-b.t
+*** | | |   new file mode 100644
+*** | | |   index 0000000..d5fcad0
+*** | | |   --- /dev/null
+*** | | |   +++ b/octopus-b.t
+*** | | |   @@ -0,0 +1 @@
+*** | | |   +octopus-b
+*** | | |
+*** | * | commit COMMIT_OBJECT_NAME
+*** | |/  Author: A U Thor <author@example.com>
+*** | |
+*** | |       octopus-a
+*** | |   ---
+*** | |    octopus-a.t | 1 +
+*** | |    1 file changed, 1 insertion(+)
+*** | |
+*** | |   diff --git a/octopus-a.t b/octopus-a.t
+*** | |   new file mode 100644
+*** | |   index 0000000..11ee015
+*** | |   --- /dev/null
+*** | |   +++ b/octopus-a.t
+*** | |   @@ -0,0 +1 @@
+*** | |   +octopus-a
+*** | |
+*** * | commit COMMIT_OBJECT_NAME
+*** |/  Author: A U Thor <author@example.com>
+*** |
+*** |       seventh
+*** |   ---
+*** |    seventh.t | 1 +
+*** |    1 file changed, 1 insertion(+)
+*** |
+*** |   diff --git a/seventh.t b/seventh.t
+*** |   new file mode 100644
+*** |   index 0000000..9744ffc
+*** |   --- /dev/null
+*** |   +++ b/seventh.t
+*** |   @@ -0,0 +1 @@
+*** |   +seventh
+*** |
+*** *   commit COMMIT_OBJECT_NAME
+*** |\  Merge: MERGE_PARENTS
+*** | | Author: A U Thor <author@example.com>
+*** | |
+*** | |     Merge branch 'tangle'
+*** | |
+*** | *   commit COMMIT_OBJECT_NAME
+*** | |\  Merge: MERGE_PARENTS
+*** | | | Author: A U Thor <author@example.com>
+*** | | |
+*** | | |     Merge branch 'side' (early part) into tangle
+*** | | |
+*** | * |   commit COMMIT_OBJECT_NAME
+*** | |\ \  Merge: MERGE_PARENTS
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     Merge branch 'master' (early part) into tangle
+*** | | | |
+*** | * | | commit COMMIT_OBJECT_NAME
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     tangle-a
+*** | | | | ---
+*** | | | |  tangle-a | 1 +
+*** | | | |  1 file changed, 1 insertion(+)
+*** | | | |
+*** | | | | diff --git a/tangle-a b/tangle-a
+*** | | | | new file mode 100644
+*** | | | | index 0000000..7898192
+*** | | | | --- /dev/null
+*** | | | | +++ b/tangle-a
+*** | | | | @@ -0,0 +1 @@
+*** | | | | +a
+*** | | | |
+*** * | | |   commit COMMIT_OBJECT_NAME
+*** |\ \ \ \  Merge: MERGE_PARENTS
+*** | | | | | Author: A U Thor <author@example.com>
+*** | | | | |
+*** | | | | |     Merge branch 'side'
+*** | | | | |
+*** | * | | | commit COMMIT_OBJECT_NAME
+*** | | |_|/  Author: A U Thor <author@example.com>
+*** | |/| |
+*** | | | |       side-2
+*** | | | |   ---
+*** | | | |    2 | 1 +
+*** | | | |    1 file changed, 1 insertion(+)
+*** | | | |
+*** | | | |   diff --git a/2 b/2
+*** | | | |   new file mode 100644
+*** | | | |   index 0000000..0cfbf08
+*** | | | |   --- /dev/null
+*** | | | |   +++ b/2
+*** | | | |   @@ -0,0 +1 @@
+*** | | | |   +2
+*** | | | |
+*** | * | | commit COMMIT_OBJECT_NAME
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     side-1
+*** | | | | ---
+*** | | | |  1 | 1 +
+*** | | | |  1 file changed, 1 insertion(+)
+*** | | | |
+*** | | | | diff --git a/1 b/1
+*** | | | | new file mode 100644
+*** | | | | index 0000000..d00491f
+*** | | | | --- /dev/null
+*** | | | | +++ b/1
+*** | | | | @@ -0,0 +1 @@
+*** | | | | +1
+*** | | | |
+*** * | | | commit COMMIT_OBJECT_NAME
+*** | | | | Author: A U Thor <author@example.com>
+*** | | | |
+*** | | | |     Second
+*** | | | | ---
+*** | | | |  one | 1 +
+*** | | | |  1 file changed, 1 insertion(+)
+*** | | | |
+*** | | | | diff --git a/one b/one
+*** | | | | new file mode 100644
+*** | | | | index 0000000..9a33383
+*** | | | | --- /dev/null
+*** | | | | +++ b/one
+*** | | | | @@ -0,0 +1 @@
+*** | | | | +case
+*** | | | |
+*** * | | | commit COMMIT_OBJECT_NAME
+*** | |_|/  Author: A U Thor <author@example.com>
+*** |/| |
+*** | | |       sixth
+*** | | |   ---
+*** | | |    a/two | 1 -
+*** | | |    1 file changed, 1 deletion(-)
+*** | | |
+*** | | |   diff --git a/a/two b/a/two
+*** | | |   deleted file mode 100644
+*** | | |   index 9245af5..0000000
+*** | | |   --- a/a/two
+*** | | |   +++ /dev/null
+*** | | |   @@ -1 +0,0 @@
+*** | | |   -ni
+*** | | |
+*** * | | commit COMMIT_OBJECT_NAME
+*** | | | Author: A U Thor <author@example.com>
+*** | | |
+*** | | |     fifth
+*** | | | ---
+*** | | |  a/two | 1 +
+*** | | |  1 file changed, 1 insertion(+)
+*** | | |
+*** | | | diff --git a/a/two b/a/two
+*** | | | new file mode 100644
+*** | | | index 0000000..9245af5
+*** | | | --- /dev/null
+*** | | | +++ b/a/two
+*** | | | @@ -0,0 +1 @@
+*** | | | +ni
+*** | | |
+*** * | | commit COMMIT_OBJECT_NAME
+*** |/ /  Author: A U Thor <author@example.com>
+*** | |
+*** | |       fourth
+*** | |   ---
+*** | |    ein | 1 +
+*** | |    1 file changed, 1 insertion(+)
+*** | |
+*** | |   diff --git a/ein b/ein
+*** | |   new file mode 100644
+*** | |   index 0000000..9d7e69f
+*** | |   --- /dev/null
+*** | |   +++ b/ein
+*** | |   @@ -0,0 +1 @@
+*** | |   +ichi
+*** | |
+*** * | commit COMMIT_OBJECT_NAME
+*** |/  Author: A U Thor <author@example.com>
+*** |
+*** |       third
+*** |   ---
+*** |    ichi | 1 +
+*** |    one  | 1 -
+*** |    2 files changed, 1 insertion(+), 1 deletion(-)
+*** |
+*** |   diff --git a/ichi b/ichi
+*** |   new file mode 100644
+*** |   index 0000000..9d7e69f
+*** |   --- /dev/null
+*** |   +++ b/ichi
+*** |   @@ -0,0 +1 @@
+*** |   +ichi
+*** |   diff --git a/one b/one
+*** |   deleted file mode 100644
+*** |   index 9d7e69f..0000000
+*** |   --- a/one
+*** |   +++ /dev/null
+*** |   @@ -1 +0,0 @@
+*** |   -ichi
+*** |
+*** * commit COMMIT_OBJECT_NAME
+*** | Author: A U Thor <author@example.com>
+*** |
+*** |     second
+*** | ---
+*** |  one | 2 +-
+*** |  1 file changed, 1 insertion(+), 1 deletion(-)
+*** |
+*** | diff --git a/one b/one
+*** | index 5626abf..9d7e69f 100644
+*** | --- a/one
+*** | +++ b/one
+*** | @@ -1 +1 @@
+*** | -one
+*** | +ichi
+*** |
+*** * commit COMMIT_OBJECT_NAME
+***   Author: A U Thor <author@example.com>
+***
+***       initial
+***   ---
+***    one | 1 +
+***    1 file changed, 1 insertion(+)
+***
+***   diff --git a/one b/one
+***   new file mode 100644
+***   index 0000000..5626abf
+***   --- /dev/null
+***   +++ b/one
+***   @@ -0,0 +1 @@
+***   +one
+EOF
+
+test_expect_success 'log --line-prefix="*** " --graph with diff and stats' '
+	git log --line-prefix="*** " --no-renames --graph --pretty=short --stat -p >actual &&
+	sanitize_output >actual.sanitized <actual &&
+	test_i18ncmp expect actual.sanitized
+'
+
 test_expect_success 'dotdot is a parent directory' '
 	mkdir -p a/b &&
 	( echo sixth && echo fifth ) >expect &&
-- 
2.10.0.rc0.259.g83512d9

