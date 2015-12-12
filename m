From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v6] blame: add support for --[no-]progress option
Date: Sat, 12 Dec 2015 17:57:05 -0600
Message-ID: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org, tboegi@web.de,
	sunshine@sunshineco.com,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 00:57:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7u2x-0006t4-Fe
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 00:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbbLLX5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 18:57:18 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35373 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbLLX5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 18:57:17 -0500
Received: by qkfb125 with SMTP id b125so90014371qkf.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=a/ZD3vOUfFr2W6xpr9Rpg2J4DYWo32nA5+Fb7H/ZZnc=;
        b=wuGa8DH+95s2j3hk5XL8hQHNWjRv9fuhCUZ8CkH6oJk2HtguDInyT8o7fE6R0WM7Y3
         HaSon2Io9o3TmpIBTxq0hcV67sAfpq2oO/r6hWtLXNQGyKeXeqcv2PJWLZZ4xQhnGg2I
         wNgsG6mTNVv0jYDq72lgmvXQQtDXVkCUEVFJ7J+7spXz92hw63Bk7iYQ24YRBa89VCa1
         RE8XbgnzEJ8OmiJps6yj+/ODtIXuPvqTmT/I0bJhQAgNkeYEpdO8LqDLgX5VTfgHTr5T
         5fkQHBrGc90imyU0G3laddbYoK7fCijxo6MHPRlDjqQthQtJfa7OqQVDLneoClyw6P6Q
         cZpw==
X-Received: by 10.129.101.5 with SMTP id z5mr14306497ywb.184.1449964636127;
        Sat, 12 Dec 2015 15:57:16 -0800 (PST)
Received: from linuxerio.cabletica.com (ip100-190-15-186.ct.co.cr. [186.15.190.100])
        by smtp.gmail.com with ESMTPSA id h18sm4384625ywc.0.2015.12.12.15.57.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Dec 2015 15:57:15 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282305>

--progress can't be used with --incremental or
 porcelain formats.

git-annotate inherits the option as well

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/blame-options.txt |  7 +++++++
 Documentation/git-blame.txt     |  3 ++-
 builtin/blame.c                 | 35 +++++++++++++++++++++++++++++++----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 760eab7..ef642b9 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -69,6 +69,13 @@ include::line-range-format.txt[]
 	iso format is used. For supported values, see the discussion
 	of the --date option at linkgit:git-log[1].
 
+--[no-]progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal. This flag
+	enables progress reporting even if not attached to a
+	terminal. Progress information won't be displayed if using
+	`--porcelain` or `--incremental`.
+
 -M|<num>|::
 	Detect moved or copied lines within a file. When a commit
 	moves or copies a block of lines (e.g. the original file
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index e6e947c..ba54175 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
+	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
+	    [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/builtin/blame.c b/builtin/blame.c
index 2afe828..be5d73d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -28,6 +28,7 @@
 #include "line-range.h"
 #include "line-log.h"
 #include "dir.h"
+#include "progress.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -50,6 +51,7 @@ static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
+static int show_progress;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -127,6 +129,11 @@ struct origin {
 	char path[FLEX_ARRAY];
 };
 
+struct progress_info {
+	struct progress *progress;
+	int blamed_lines;
+};
+
 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
 		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
 {
@@ -1746,7 +1753,8 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
  * The blame_entry is found to be guilty for the range.
  * Show it in incremental output.
  */
-static void found_guilty_entry(struct blame_entry *ent)
+static void found_guilty_entry(struct blame_entry *ent,
+			   struct progress_info *pi)
 {
 	if (incremental) {
 		struct origin *suspect = ent->suspect;
@@ -1758,6 +1766,8 @@ static void found_guilty_entry(struct blame_entry *ent)
 		write_filename_info(suspect->path);
 		maybe_flush_or_die(stdout, "stdout");
 	}
+	pi->blamed_lines += ent->num_lines;
+	display_progress(pi->progress, pi->blamed_lines);
 }
 
 /*
@@ -1768,6 +1778,11 @@ static void assign_blame(struct scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	struct commit *commit = prio_queue_get(&sb->commits);
+	struct progress_info pi = { NULL, 0 };
+
+	if (show_progress)
+		pi.progress = start_progress_delay(_("Blaming lines"),
+		                                   sb->num_lines, 50, 1);
 
 	while (commit) {
 		struct blame_entry *ent;
@@ -1809,7 +1824,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 			suspect->guilty = 1;
 			for (;;) {
 				struct blame_entry *next = ent->next;
-				found_guilty_entry(ent);
+				found_guilty_entry(ent, &pi);
 				if (next) {
 					ent = next;
 					continue;
@@ -1825,6 +1840,9 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		if (DEBUG) /* sanity */
 			sanity_check_refcnt(sb);
 	}
+
+	if (pi.progress)
+		stop_progress(&pi.progress);
 }
 
 static const char *format_time(unsigned long time, const char *tz_str,
@@ -2520,6 +2538,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
+		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
 		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
 		OPT_BIT('f', "show-name", &output_option, N_("Show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, N_("Show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
@@ -2555,6 +2574,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
+	show_progress = -1;
 
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
@@ -2579,6 +2599,13 @@ parse_done:
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
+	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
+		if (show_progress > 0)
+			die("--progress can't be used with --incremental or porcelain formats");
+		show_progress = 0;
+	} else if (show_progress < 0)
+		show_progress = isatty(2);
+
 	if (0 < abbrev)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
@@ -2828,11 +2855,11 @@ parse_done:
 
 	read_mailmap(&mailmap, NULL);
 
+	assign_blame(&sb, opt);
+
 	if (!incremental)
 		setup_pager();
 
-	assign_blame(&sb, opt);
-
 	free(final_commit_name);
 
 	if (incremental)
-- 
2.6.2
