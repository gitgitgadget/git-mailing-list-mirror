From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] git stat: the beginning
Date: Sat,  8 Aug 2009 00:14:52 -0700
Message-ID: <1249715693-9715-3-git-send-email-gitster@pobox.com>
References: <1249715693-9715-1-git-send-email-gitster@pobox.com>
 <1249715693-9715-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 09:15:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZg9L-0003p7-BJ
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbZHHHPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754206AbZHHHPF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:15:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbZHHHO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:14:59 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36FA62294
	for <git@vger.kernel.org>; Sat,  8 Aug 2009 03:15:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E5D12293 for
 <git@vger.kernel.org>; Sat,  8 Aug 2009 03:14:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.159.gd0d612
In-Reply-To: <1249715693-9715-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2F51F04E-83EB-11DE-B07C-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125248>

Tentatively add "git stat" as a new command.  This does not munge the
index with paths parameters before showing the status like "git status"
does.  In later rounds, we will take path parameters as pathspec to limit
the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile         |    1 +
 builtin-commit.c |   56 ++++++++++++++++++++++++++++++++++++++++++++---------
 builtin.h        |    1 +
 git.c            |    1 +
 wt-status.c      |   24 ++++++++++++++--------
 wt-status.h      |    1 +
 6 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index daf4296..39dd334 100644
--- a/Makefile
+++ b/Makefile
@@ -378,6 +378,7 @@ BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
+BUILT_INS += git-stat$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
diff --git a/builtin-commit.c b/builtin-commit.c
index 3a7e35d..10f9d4f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -35,6 +35,11 @@ static const char * const builtin_status_usage[] = {
 	NULL
 };
 
+static const char * const builtin_stat_usage[] = {
+	"git stat [options]",
+	NULL
+};
+
 static unsigned char head_sha1[20], merge_head_sha1[20];
 static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
@@ -693,6 +698,21 @@ static const char *find_author_by_nickname(const char *name)
 	die("No existing author found with '%s'", name);
 }
 
+
+static void handle_untracked_files_arg(void)
+{
+	if (!untracked_files_arg)
+		; /* default already initialized */
+	else if (!strcmp(untracked_files_arg, "no"))
+		show_untracked_files = SHOW_NO_UNTRACKED_FILES;
+	else if (!strcmp(untracked_files_arg, "normal"))
+		show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+	else if (!strcmp(untracked_files_arg, "all"))
+		show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+	else
+		die("Invalid untracked files mode '%s'", untracked_files_arg);
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[],
 				      const char *prefix)
@@ -795,16 +815,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	else
 		die("Invalid cleanup mode %s", cleanup_arg);
 
-	if (!untracked_files_arg)
-		; /* default already initialized */
-	else if (!strcmp(untracked_files_arg, "no"))
-		show_untracked_files = SHOW_NO_UNTRACKED_FILES;
-	else if (!strcmp(untracked_files_arg, "normal"))
-		show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
-	else if (!strcmp(untracked_files_arg, "all"))
-		show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
-	else
-		die("Invalid untracked files mode '%s'", untracked_files_arg);
+	handle_untracked_files_arg();
 
 	if (all && argc > 0)
 		die("Paths with -a does not make sense.");
@@ -814,6 +825,31 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	return argc;
 }
 
+int cmd_stat(int argc, const char **argv, const char *prefix)
+{
+	struct wt_status s;
+	static struct option builtin_stat_options[] = {
+		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
+		  "mode",
+		  "show untracked files, optional modes: all, normal, no. (Default: all)",
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_stat_options,
+			     builtin_stat_usage, 0);
+	handle_untracked_files_arg();
+
+	read_cache();
+	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
+	wt_status_prepare(&s);
+	wt_status_collect_changes(&s);
+
+	wt_status_print_body(&s);
+	return 0;
+}
+
 static int dry_run_commit(int argc, const char **argv, const char *prefix)
 {
 	int commitable;
diff --git a/builtin.h b/builtin.h
index 20427d2..eeaf0b6 100644
--- a/builtin.h
+++ b/builtin.h
@@ -95,6 +95,7 @@ extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_stat(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 807d875..de7fcf6 100644
--- a/git.c
+++ b/git.c
@@ -350,6 +350,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "stat", cmd_stat, RUN_SETUP | NEED_WORK_TREE },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
diff --git a/wt-status.c b/wt-status.c
index 97fedfa..6eb32df 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -537,6 +537,20 @@ static void wt_status_print_tracking(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
 
+void wt_status_print_body(struct wt_status *s)
+{
+	wt_status_print_unmerged(s);
+	wt_status_print_updated(s);
+	wt_status_print_changed(s);
+	if (wt_status_submodule_summary)
+		wt_status_print_submodule_summary(s);
+	if (show_untracked_files)
+		wt_status_print_untracked(s);
+	else if (s->commitable)
+		fprintf(s->fp,
+			"# Untracked files not listed (use -u option to show untracked files)\n");
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	unsigned char sha1[20];
@@ -567,15 +581,7 @@ void wt_status_print(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 	}
 
-	wt_status_print_unmerged(s);
-	wt_status_print_updated(s);
-	wt_status_print_changed(s);
-	if (wt_status_submodule_summary)
-		wt_status_print_submodule_summary(s);
-	if (show_untracked_files)
-		wt_status_print_untracked(s);
-	else if (s->commitable)
-		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
+	wt_status_print_body(s);
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
diff --git a/wt-status.h b/wt-status.h
index f80142f..ebbf06a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -50,6 +50,7 @@ extern int wt_status_use_color;
 extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+void wt_status_print_body(struct wt_status *s);
 void wt_status_collect_changes(struct wt_status *s);
 
 #endif /* STATUS_H */
-- 
1.6.4.159.gd0d612
