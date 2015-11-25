From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v5] blame: add support for --[no-]progress option
Date: Tue, 24 Nov 2015 22:36:05 -0600
Message-ID: <1448426165-5139-1-git-send-email-eantoranz@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org, tboegi@web.de,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 05:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1RoX-0007Vk-UW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 05:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbbKYEgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 23:36:16 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36387 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbbKYEgO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 23:36:14 -0500
Received: by ykdr82 with SMTP id r82so44068871ykd.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 20:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XY5ea9utJ21D5y2sbEBCoIhGFzPMNMLPlzy2+1TS3N8=;
        b=AhD+SCZ+NLcwkrzWe6JCbrAtxJ1TTdf2ACRixSXWIWwVd3S9c3qI9AiMWcAJtO/zCM
         thy2huULJcoFytPlc05wpd0jP7+5u9d1MogBtRGgoANHGl6OgcpjvvQaaBhe3xy8zPX+
         wuQ8p+hRN/OWwrj9liMuoK1zpt9NWO1DuS7FoUAbQ7dUivzs1Tjc3EWO1As/HCI8+GiN
         Mni1AdpoakfafDas+MfjBU0FKn1km6ThHvDqyw2I44RDsnOLG24sbqGgm0IA3g1Lr5FV
         2s6rKco3ARU53CRJO+1sYtw8Sla7+h2qQliH+Bg0EtdGXS/iyX0U0r7dmjw981Pz8j9f
         rwyA==
X-Received: by 10.129.101.131 with SMTP id z125mr34501060ywb.184.1448426174301;
        Tue, 24 Nov 2015 20:36:14 -0800 (PST)
Received: from linuxerio.cabletica.com (ip100-190-15-186.ct.co.cr. [186.15.190.100])
        by smtp.gmail.com with ESMTPSA id n76sm18486585ywn.0.2015.11.24.20.36.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Nov 2015 20:36:13 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281677>

* created struct progress_info in builtin/blame.c
  this struct holds the information used to display progress so
  that only one additional parameter is passed to
  found_guilty_entry().

* --[no-]progress option is also inherited by git-annotate.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/blame-options.txt |  7 +++++++
 Documentation/git-blame.txt     |  3 ++-
 builtin/blame.c                 | 40 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 45 insertions(+), 5 deletions(-)

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
index e6e947c..b0154c2 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
+	    [--[no-]progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
+	    [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/builtin/blame.c b/builtin/blame.c
index 83612f5..954d32c 100644
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
+	if (pi)
+		display_progress(pi->progress, pi->blamed_lines += ent->num_lines);
 }
 
 /*
@@ -1768,6 +1778,16 @@ static void assign_blame(struct scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	struct commit *commit = prio_queue_get(&sb->commits);
+	struct progress_info *pi = NULL;
+
+	if (show_progress) {
+		pi = malloc(sizeof(*pi));
+		if (pi) {
+			pi->progress = start_progress_delay(_("Blaming lines"),
+			                                    sb->num_lines, 50, 1);
+			pi->blamed_lines = 0;
+		}
+	}
 
 	while (commit) {
 		struct blame_entry *ent;
@@ -1809,7 +1829,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 			suspect->guilty = 1;
 			for (;;) {
 				struct blame_entry *next = ent->next;
-				found_guilty_entry(ent);
+				found_guilty_entry(ent, pi);
 				if (next) {
 					ent = next;
 					continue;
@@ -1825,6 +1845,11 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		if (DEBUG) /* sanity */
 			sanity_check_refcnt(sb);
 	}
+
+	if (pi) {
+		stop_progress(&pi->progress);
+		free(pi);
+	};
 }
 
 static const char *format_time(unsigned long time, const char *tz_str,
@@ -2520,6 +2545,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
+		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
 		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
 		OPT_BIT('f', "show-name", &output_option, N_("Show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, N_("Show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
@@ -2555,6 +2581,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
+	show_progress = -1;
 
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
@@ -2579,6 +2606,11 @@ parse_done:
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
+	if (incremental || (output_option & OUTPUT_PORCELAIN))
+		show_progress = 0;
+	else if (show_progress < 0)
+		show_progress = isatty(2);
+
 	if (0 < abbrev)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
@@ -2830,11 +2862,11 @@ parse_done:
 
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
