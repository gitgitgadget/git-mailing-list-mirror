Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409591F859
	for <e@80x24.org>; Tue,  9 Aug 2016 22:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbcHIWcX (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 18:32:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:55035 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932461AbcHIWcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 18:32:22 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 09 Aug 2016 15:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,496,1464678000"; 
   d="scan'208";a="746542278"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2016 15:32:21 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH RFC] diff: add SUBMODULE_DIFF format to display submodule diff
Date:	Tue,  9 Aug 2016 15:32:19 -0700
Message-Id: <20160809223219.17982-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.1004.gdad50a3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

For projects which have frequent updates to submodules it is often
useful to be able to see a submodule update commit as a difference.
Teach diff's --submodule= a new "diff" format which will execute a diff
for the submodule between the old and new commit, and display it as
a standard diff. This allows users to easily see what changed in
a submodule without having to dig into the submodule themselves.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
There are no tests yet. Stefan suggested the use of child_process, but I
really believe there has to be some way of getting the diff without
having to run a sub process (as this means we also can't do the diff
without a checked out submodule). It doesn't properly handle options
either, so a better solution would be much appreciated.

I also would prefer if the diff actually prefixed the files with
"path/to/submodule" so that it was obvious where the file was located in
the directory.

Suggestions welcome.

 Documentation/diff-config.txt  |  3 +-
 Documentation/diff-options.txt |  6 ++--
 diff.c                         | 21 +++++++++++--
 diff.h                         |  2 +-
 submodule.c                    | 67 ++++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |  5 ++++
 6 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index d5a5b17d5088..f5d693afad6c 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -123,7 +123,8 @@ diff.suppressBlankEmpty::
 diff.submodule::
 	Specify the format in which differences in submodules are
 	shown.  The "log" format lists the commits in the range like
-	linkgit:git-submodule[1] `summary` does.  The "short" format
+	linkgit:git-submodule[1] `summary` does.  The "diff" format shows the
+	diff between the beginning and end of the range. The "short" format
 	format just shows the names of the commits at the beginning
 	and end of the range.  Defaults to short.
 
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 705a87394200..b17348407805 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -215,8 +215,10 @@ any of those replacements occurred.
 	the commits in the range like linkgit:git-submodule[1] `summary` does.
 	Omitting the `--submodule` option or specifying `--submodule=short`,
 	uses the 'short' format. This format just shows the names of the commits
-	at the beginning and end of the range.  Can be tweaked via the
-	`diff.submodule` configuration variable.
+	at the beginning and end of the range. When `--submodule=diff` is
+	given, the 'diff' format is used. This format shows the diff between
+	the old and new submodule commmit from the perspective of the
+	submodule.  Can be tweaked via the `diff.submodule` configuration variable.
 
 --color[=<when>]::
 	Show colored diff.
diff --git a/diff.c b/diff.c
index b43d3dd2ecb7..74d43931c8df 100644
--- a/diff.c
+++ b/diff.c
@@ -130,12 +130,18 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 
 static int parse_submodule_params(struct diff_options *options, const char *value)
 {
-	if (!strcmp(value, "log"))
+	if (!strcmp(value, "log")) {
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
-	else if (!strcmp(value, "short"))
+		DIFF_OPT_CLR(options, SUBMODULE_DIFF);
+	else if (!strcmp(value, "diff")) {
+		DIFF_OPT_SET(options, SUBMODULE_DIFF);
 		DIFF_OPT_CLR(options, SUBMODULE_LOG);
-	else
+	} else if (!strcmp(value, "short")) {
+		DIFF_OPT_CLR(options, SUBMODULE_DIFF);
+		DIFF_OPT_CLR(options, SUBMODULE_LOG);
+	} else {
 		return -1;
+	}
 	return 0;
 }
 
@@ -2310,6 +2316,15 @@ static void builtin_diff(const char *name_a,
 				two->dirty_submodule,
 				meta, del, add, reset);
 		return;
+	} else if (DIFF_OPT_TST(o, SUBMODULE_DIFF) &&
+			(!one->mode || S_ISGITLINK(one->mode)) &&
+			(!two->mode || S_ISGITLINK(two->mode))) {
+		show_submodule_diff(o->file, one->path ? one->path : two->path,
+				line_prefix,
+				one->oid.hash, two->oid.hash,
+				two->dirty_submodule,
+				meta, reset);
+		return;
 	}
 
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
diff --git a/diff.h b/diff.h
index 125447be09eb..a80f3e5bafe9 100644
--- a/diff.h
+++ b/diff.h
@@ -69,7 +69,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
-/* (1 <<  9) unused */
+#define DIFF_OPT_SUBMODULE_DIFF      (1 <<  9)
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
 #define DIFF_OPT_NO_INDEX            (1 << 12)
diff --git a/submodule.c b/submodule.c
index 1b5cdfb7e784..4a322513d27c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -333,6 +333,73 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+static int prepare_submodule_diff(struct strbuf *buf, const char *path,
+		unsigned char one[20], unsigned char two[20])
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	cp.git_cmd = 1;
+	cp.dir = path;
+	cp.out = -1;
+	cp.no_stdin = 1;
+	argv_array_push(&cp.args, "diff");
+	argv_array_push(&cp.args, sha1_to_hex(one));
+	argv_array_push(&cp.args, sha1_to_hex(two));
+
+	if (start_command(&cp))
+		return -1;
+
+	if (strbuf_read(buf, cp.out, 0) < 0)
+		return -1;
+
+	if (finish_command(&cp))
+		return -1;
+
+	return 0;
+}
+
+void show_submodule_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *reset)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *message = NULL;
+
+	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+		fprintf(f, "%sSubmodule %s contains untracked content\n",
+			line_prefix, path);
+	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+		fprintf(f, "%sSubmodule %s contains modified content\n",
+			line_prefix, path);
+
+	if (!hashcmp(one, two)) {
+		strbuf_release(&sb);
+		return;
+	}
+
+	if (add_submodule_odb(path))
+		message = "(not checked out)";
+	else if (prepare_submodule_diff(&buf, path, one, two))
+		message = "(diff failed)";
+
+	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
+			find_unique_abbrev(one, DEFAULT_ABBREV));
+	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
+	if (message)
+		strbuf_addf(&sb, " %s%s\n", message, reset);
+	else
+		strbuf_addf(&sb, ":%s\n", reset);
+	fwrite(sb.buf, sb.len, 1, f);
+
+	if (!message) /* only NULL if we succeeded in obtaining a diff */
+		fwrite(buf.buf, buf.len, 1, f);
+
+	strbuf_release(&buf);
+	strbuf_release(&sb);
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/submodule.h b/submodule.h
index 2af939099819..f9180712ae2c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,11 @@ int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
+void show_submodule_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *reset);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
-- 
2.9.2.1004.gdad50a3

