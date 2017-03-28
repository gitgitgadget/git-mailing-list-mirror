Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A983820966
	for <e@80x24.org>; Tue, 28 Mar 2017 12:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdC1MWw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 08:22:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:28717 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbdC1MWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 08:22:50 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP; 28 Mar 2017 05:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,236,1486454400"; 
   d="scan'208";a="71264314"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2017 05:22:12 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH RFC 2/2] diff: teach diff to expand tabs in output
Date:   Tue, 28 Mar 2017 05:22:09 -0700
Message-Id: <20170328122209.4861-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.12.2.650.ga248b8c51283
In-Reply-To: <20170328122209.4861-1-jacob.e.keller@intel.com>
References: <20170328122209.4861-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

When creating a diff for contents, we prepend a single character to
represent the state of that line. This character can offset how the tabs
in the real content are displayed, which may result in weird alignment
issues when viewing the diffs. Teach the diff core a new option to
expand these tabs, similar to how we already expand log contents.

This new option can be used to display the lines so that the reader can
see the expected results without the confusion of the offset tabstops
caused by the extra character prepended to each line.

Because some of the printing location is tied up into the whitespace
checking code, we also need to teach this code that it may need to
expand tabs as well. We will expand the output at the last moment so
that the whitespace checks see the contents before it is expanded.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I'm really not a fan of how the ws code ended up. It seems pretty ugly
and weird to hack in the expand_tabs stuff here. However, I'm really not
sure how else I could handle this. Additionally, I'm not 100% sure
whether this interacts with format-patch or other machinery which may
well want some way to be excluded. Thoughts? Does anyone have a better
implementation?

I think there also may be some wonky bits when performing the tab
expansion during whitespace checks, due to the way we expand, because I
don't think that the tabexpand function takes into account the "current"
location when adding a string, so it very well may not be correct.... I
am unsure if there is a good way to fix this.

 Documentation/diff-options.txt |  6 ++++
 cache.h                        |  2 +-
 diff.c                         | 23 +++++++++++++--
 diff.h                         |  6 ++++
 t/t4063-diff-expand-tabs.sh    | 65 ++++++++++++++++++++++++++++++++++++++++++
 ws.c                           | 42 ++++++++++++++++++---------
 6 files changed, 126 insertions(+), 18 deletions(-)
 create mode 100755 t/t4063-diff-expand-tabs.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48deef..82e314b20b3d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -329,6 +329,12 @@ endif::git-format-patch[]
 	the diff-patch output format.  Non default number of
 	digits can be specified with `--abbrev=<n>`.
 
+--diff-expand-tabs[=<n>]::
+	When showing diff output, expand any tabs into spaces first before
+	printing. The size of the tabs is determined by <n> which defaults to
+	8 if not provided. --no-diff-expand-tabs or a size of 0 will disable
+	expansion.
+
 -B[<n>][/<m>]::
 --break-rewrites[=[<n>][/<m>]]::
 	Break complete rewrite changes into pairs of delete and
diff --git a/cache.h b/cache.h
index 5c8078291c47..2e221174edd4 100644
--- a/cache.h
+++ b/cache.h
@@ -2155,7 +2155,7 @@ extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
 extern unsigned ws_check(const char *line, int len, unsigned ws_rule);
-extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
+extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws, int expand_tabs);
 extern char *whitespace_error_string(unsigned ws);
 extern void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
 extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
diff --git a/diff.c b/diff.c
index 58cb72d7e72a..488019335df7 100644
--- a/diff.c
+++ b/diff.c
@@ -544,7 +544,14 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputs(set, file);
 		if (!nofirst)
 			fputc(first, file);
-		fwrite(line, len, 1, file);
+		if (o->expand_tabs) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_add_tabexpand(&sb, o->expand_tabs, line, len);
+			fwrite(sb.buf, sb.len, 1, file);
+			strbuf_release(&sb);
+		} else {
+			fwrite(line, len, 1, file);
+		}
 		fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
@@ -595,7 +602,8 @@ static void emit_line_checked(const char *reset,
 		/* Emit just the prefix, then the rest. */
 		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
+			      ecbdata->opt->file, set, reset, ws,
+			      ecbdata->opt->expand_tabs);
 	}
 }
 
@@ -2190,7 +2198,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		free(err);
 		emit_line(data->o, set, reset, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
-			      data->o->file, set, reset, ws);
+			      data->o->file, set, reset, ws, 0);
 	} else if (line[0] == ' ') {
 		data->lineno++;
 	} else if (line[0] == '@') {
@@ -4044,6 +4052,15 @@ int diff_opt_parse(struct diff_options *options,
 		else if (40 < options->abbrev)
 			options->abbrev = 40;
 	}
+	else if (!strcmp(arg, "--no-diff-expand-tabs"))
+		options->expand_tabs = 0;
+	else if (!strcmp(arg, "--diff-expand-tabs"))
+		options->expand_tabs = DEFAULT_EXPAND_TAB_WIDTH;
+	else if (skip_prefix(arg, "--diff-expand-tabs=", &arg)) {
+		options->expand_tabs = strtoul(arg, NULL, 10);
+		if (options->expand_tabs < 0)
+			options->expand_tabs = 0;
+	}
 	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
 		options->a_prefix = optarg;
 		return argcount;
diff --git a/diff.h b/diff.h
index e9ccb38c26c7..3de7fe68e6b1 100644
--- a/diff.h
+++ b/diff.h
@@ -147,6 +147,8 @@ struct diff_options {
 	int setup;
 	int abbrev;
 	int ita_invisible_in_index;
+#define DEFAULT_EXPAND_TAB_WIDTH 8
+	int expand_tabs;
 /* white-space error highlighting */
 #define WSEH_NEW 1
 #define WSEH_CONTEXT 2
@@ -308,6 +310,10 @@ extern void diffcore_fix_diff_index(struct diff_options *);
 "  --name-status show names and status of changed files.\n" \
 "  --full-index  show full object name on index lines.\n" \
 "  --abbrev=<n>  abbreviate object names in diff-tree header and diff-raw.\n" \
+"  --diff-expand-tabs=<n>\n" \
+"                expand tabs in the output to spaces, to preserve the\n" \
+"                alignment of tabs as compared to the input. Tabs will expand\n" \
+"                to <n> spaces. If <n> is 0, expansion is disabled.\n" \
 "  -R            swap input file pairs.\n" \
 "  -B            detect complete rewrites.\n" \
 "  -M            detect renames.\n" \
diff --git a/t/t4063-diff-expand-tabs.sh b/t/t4063-diff-expand-tabs.sh
new file mode 100755
index 000000000000..929a6103f6aa
--- /dev/null
+++ b/t/t4063-diff-expand-tabs.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 Jacob Keller
+#
+
+test_description='Test diff tab expansion
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+test_expect_success '--diff-expand-tabs setup' '
+	git reset --hard &&
+	{
+		echo "0. no tabs"
+	} >x &&
+	git update-index --add x &&
+	git commit -a --allow-empty -m preimage &&
+	{
+		echo "0.	some	tabs"
+	} >x &&
+
+	cat >expect.default <<-\EOF &&
+	diff --git a/x b/x
+	index e4d15da..410478b 100644
+	--- a/x
+	+++ b/x
+	@@ -1 +1 @@
+	-0. no tabs
+	+0.      some    tabs
+	EOF
+
+	cat >expect.size-12 <<-\EOF &&
+	diff --git a/x b/x
+	index e4d15da..410478b 100644
+	--- a/x
+	+++ b/x
+	@@ -1 +1 @@
+	-0. no tabs
+	+0.          some        tabs
+	EOF
+
+	cat >expect.size-0 <<-\EOF
+	diff --git a/x b/x
+	index e4d15da..410478b 100644
+	--- a/x
+	+++ b/x
+	@@ -1 +1 @@
+	-0. no tabs
+	+0.	some	tabs
+	EOF
+'
+
+test_expect_success 'test --diff-expand-tabs option' '
+	git diff --diff-expand-tabs >actual &&
+	test_cmp expect.default actual &&
+
+	git diff --diff-expand-tabs=12 >actual &&
+	test_cmp expect.size-12 actual &&
+
+	git diff --diff-expand-tabs=0 >actual &&
+	test_cmp expect.size-0 actual
+'
+
+test_done
diff --git a/ws.c b/ws.c
index a07caedd5a56..316081c7c2ee 100644
--- a/ws.c
+++ b/ws.c
@@ -139,10 +139,24 @@ char *whitespace_error_string(unsigned ws)
 	return strbuf_detach(&err, NULL);
 }
 
+/* Emit the line to the stream, expanding tabs if necessary */
+static void ws_emit(int expand_tabs, const char *line, int len, FILE *stream)
+{
+	if (expand_tabs) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_add_tabexpand(&sb, expand_tabs, line, len);
+		fwrite(sb.buf, sb.len, 1, stream);
+		strbuf_release(&sb);
+	} else {
+		fwrite(line, len, 1, stream);
+	}
+}
+
 /* If stream is non-NULL, emits the line after checking. */
 static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 				FILE *stream, const char *set,
-				const char *reset, const char *ws)
+				const char *reset, const char *ws,
+				int expand_tabs)
 {
 	unsigned result = 0;
 	int written = 0;
@@ -187,20 +201,20 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 			result |= WS_SPACE_BEFORE_TAB;
 			if (stream) {
 				fputs(ws, stream);
-				fwrite(line + written, i - written, 1, stream);
+				ws_emit(expand_tabs, line + written, i - written, stream);
 				fputs(reset, stream);
-				fwrite(line + i, 1, 1, stream);
+				ws_emit(expand_tabs, line + i, 1, stream);
 			}
 		} else if (ws_rule & WS_TAB_IN_INDENT) {
 			result |= WS_TAB_IN_INDENT;
 			if (stream) {
-				fwrite(line + written, i - written, 1, stream);
+				ws_emit(expand_tabs, line + written, i - written, stream);
 				fputs(ws, stream);
-				fwrite(line + i, 1, 1, stream);
+				ws_emit(expand_tabs, line + i, 1, stream);
 				fputs(reset, stream);
 			}
 		} else if (stream) {
-			fwrite(line + written, i - written + 1, 1, stream);
+			ws_emit(expand_tabs, line + written, i - written + 1, stream);
 		}
 		written = i + 1;
 	}
@@ -210,7 +224,7 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		result |= WS_INDENT_WITH_NON_TAB;
 		if (stream) {
 			fputs(ws, stream);
-			fwrite(line + written, i - written, 1, stream);
+			ws_emit(expand_tabs, line + written, i - written, stream);
 			fputs(reset, stream);
 		}
 		written = i;
@@ -225,16 +239,16 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		/* Emit non-highlighted (middle) segment. */
 		if (trailing_whitespace - written > 0) {
 			fputs(set, stream);
-			fwrite(line + written,
-			    trailing_whitespace - written, 1, stream);
+			ws_emit(expand_tabs, line + written,
+			    trailing_whitespace - written, stream);
 			fputs(reset, stream);
 		}
 
 		/* Highlight errors in trailing whitespace. */
 		if (trailing_whitespace != len) {
 			fputs(ws, stream);
-			fwrite(line + trailing_whitespace,
-			    len - trailing_whitespace, 1, stream);
+			ws_emit(expand_tabs, line + trailing_whitespace,
+			    len - trailing_whitespace, stream);
 			fputs(reset, stream);
 		}
 		if (trailing_carriage_return)
@@ -247,14 +261,14 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 
 void ws_check_emit(const char *line, int len, unsigned ws_rule,
 		   FILE *stream, const char *set,
-		   const char *reset, const char *ws)
+		   const char *reset, const char *ws, int expand_tabs)
 {
-	(void)ws_check_emit_1(line, len, ws_rule, stream, set, reset, ws);
+	(void)ws_check_emit_1(line, len, ws_rule, stream, set, reset, ws, expand_tabs);
 }
 
 unsigned ws_check(const char *line, int len, unsigned ws_rule)
 {
-	return ws_check_emit_1(line, len, ws_rule, NULL, NULL, NULL, NULL);
+	return ws_check_emit_1(line, len, ws_rule, NULL, NULL, NULL, NULL, 0);
 }
 
 int ws_blank_line(const char *line, int len, unsigned ws_rule)
-- 
2.12.2.650.ga248b8c51283

