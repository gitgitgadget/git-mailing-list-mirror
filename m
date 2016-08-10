Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405B62018E
	for <e@80x24.org>; Wed, 10 Aug 2016 21:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbcHJVRT (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:17:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:7585 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbcHJVRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 17:17:14 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 10 Aug 2016 14:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,501,1464678000"; 
   d="scan'208";a="153862832"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2016 14:17:13 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 2/2] diff: add SUBMODULE_DIFF format to display submodule diff
Date:	Wed, 10 Aug 2016 14:17:10 -0700
Message-Id: <20160810211710.23173-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.872.g0b694e0.dirty
In-Reply-To: <20160810211710.23173-1-jacob.e.keller@intel.com>
References: <20160810211710.23173-1-jacob.e.keller@intel.com>
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
Changes since v2:
* dropped the prepare_submodule_diff as it's not really needed
* added --line-prefix to properly prefix every line
* added correct use of a_prefix and b_prefix
* use dup and fileno instead so that we don't have to copy output

I still need to sort out some tests, and I ran into one interesting
issue: I had to do make-install in order to get the sub command to
process the new diff option... is that normal? I think that may cause
issues during tests as well... Shouldn't we use the same binaries we're
running from and not search in the install path when running a sub
command?

 Documentation/diff-config.txt  |  3 +-
 Documentation/diff-options.txt |  6 ++--
 diff.c                         | 39 ++++++++++++++++--------
 diff.h                         |  2 +-
 submodule.c                    | 67 ++++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |  6 ++++
 6 files changed, 107 insertions(+), 16 deletions(-)

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
index e7b729f3644f..988068225463 100644
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
index 6fe5c6d084a3..2d23767739a4 100644
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
+	} else if (!strcmp(value, "diff")) {
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
 
@@ -2305,6 +2311,15 @@ static void builtin_diff(const char *name_a,
 	struct strbuf header = STRBUF_INIT;
 	const char *line_prefix = diff_line_prefix(o);
 
+	diff_set_mnemonic_prefix(o, "a/", "b/");
+	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		a_prefix = o->b_prefix;
+		b_prefix = o->a_prefix;
+	} else {
+		a_prefix = o->a_prefix;
+		b_prefix = o->b_prefix;
+	}
+
 	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
 			(!one->mode || S_ISGITLINK(one->mode)) &&
 			(!two->mode || S_ISGITLINK(two->mode))) {
@@ -2316,6 +2331,15 @@ static void builtin_diff(const char *name_a,
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
+				meta, a_prefix, b_prefix, reset);
+		return;
 	}
 
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
@@ -2323,15 +2347,6 @@ static void builtin_diff(const char *name_a,
 		textconv_two = get_textconv(two);
 	}
 
-	diff_set_mnemonic_prefix(o, "a/", "b/");
-	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
-		a_prefix = o->b_prefix;
-		b_prefix = o->a_prefix;
-	} else {
-		a_prefix = o->a_prefix;
-		b_prefix = o->b_prefix;
-	}
-
 	/* Never use a non-valid filename anywhere if at all possible */
 	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
 	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
diff --git a/diff.h b/diff.h
index 6a91a1139686..65df44b1fcba 100644
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
index 1b5cdfb7e784..36f8fd00c3ce 100644
--- a/submodule.c
+++ b/submodule.c
@@ -333,6 +333,73 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+void show_submodule_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *a_prefix, const char *b_prefix,
+		const char *reset)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf submodule_git_dir = STRBUF_INIT;
+	const char *git_dir, *message = NULL;
+	int create_dirty_diff = 0;
+	FILE *diff;
+	char c;
+
+	if ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+	    (dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
+		create_dirty_diff = 1;
+
+	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
+			find_unique_abbrev(one, DEFAULT_ABBREV));
+	strbuf_addf(&sb, "%s:%s\n", !create_dirty_diff ?
+		    find_unique_abbrev(two, DEFAULT_ABBREV) : "", reset);
+	fwrite(sb.buf, sb.len, 1, f);
+
+	strbuf_addf(&submodule_git_dir, "%s/.git", path);
+	git_dir = read_gitfile(submodule_git_dir.buf);
+	if (!git_dir)
+		git_dir = submodule_git_dir.buf;
+	if (!is_directory(git_dir)) {
+		strbuf_reset(&submodule_git_dir);
+		strbuf_addf(&submodule_git_dir, ".git/modules/%s", path);
+		git_dir = submodule_git_dir.buf;
+	}
+
+	fflush(f);
+
+	cp.git_cmd = 1;
+	if (!create_dirty_diff)
+		cp.dir = git_dir;
+	else
+		cp.dir = path;
+	cp.out = dup(fileno(f));
+	cp.no_stdin = 1;
+	argv_array_push(&cp.args, "diff");
+	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
+	argv_array_pushf(&cp.args, "--src-prefix=%s%s/", a_prefix, path);
+	argv_array_pushf(&cp.args, "--dst-prefix=%s%s/", b_prefix, path);
+	argv_array_push(&cp.args, sha1_to_hex(one));
+
+	/*
+	 * If the submodule has untracked or modified contents don't add the
+	 * current stored commit. Thus, we will diff between the previous
+	 * value and the current tip of working tree. The result is a complete
+	 * diff which shows all changes to the submodule, not just changes
+	 * that have been committed to the super project.
+	 */
+	if (!create_dirty_diff)
+		argv_array_push(&cp.args, sha1_to_hex(two));
+
+	if (run_command(&cp))
+		fprintf(f, "(diff failed)\n");
+
+	strbuf_release(&submodule_git_dir);
+	strbuf_release(&sb);
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/submodule.h b/submodule.h
index 2af939099819..f32a25c667ab 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,12 @@ int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
+void show_submodule_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *a_prefix, const char *b_prefix,
+		const char *reset);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
-- 
2.9.2.872.g0b694e0.dirty

