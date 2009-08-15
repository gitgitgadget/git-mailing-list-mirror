From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] git stat: the beginning
Date: Sat, 15 Aug 2009 15:39:51 -0700
Message-ID: <1250375997-10657-4-git-send-email-gitster@pobox.com>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com>
 <1250375997-10657-2-git-send-email-gitster@pobox.com>
 <1250375997-10657-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRva-0003is-TI
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbZHOWkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZHOWkI
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZHOWkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 993502AA86
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C673F2AA85 for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:06 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
In-Reply-To: <1250375997-10657-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 953024CE-89EC-11DE-BF91-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126038>

Tentatively add "git stat" as a new command.  This does not munge the
index with paths parameters before showing the status like "git status"
does.  In later rounds, we will take path parameters as pathspec to limit
the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Unchanged since the last round.

 Makefile         |    1 +
 builtin-commit.c |   64 +++++++++++++++++++++++++++++++++++++++++++++--------
 builtin.h        |    1 +
 git.c            |    1 +
 wt-status.c      |   23 +++++++++++-------
 wt-status.h      |    1 +
 6 files changed, 72 insertions(+), 19 deletions(-)

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
index 200ffda..0ef7c8f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -24,6 +24,7 @@
 #include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
+#include "quote.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -35,6 +36,11 @@ static const char * const builtin_status_usage[] = {
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
@@ -691,6 +697,21 @@ static const char *find_author_by_nickname(const char *name)
 	die("No existing author found with '%s'", name);
 }
 
+
+static void handle_untracked_files_arg(struct wt_status *s)
+{
+	if (!untracked_files_arg)
+		; /* default already initialized */
+	else if (!strcmp(untracked_files_arg, "no"))
+		s->show_untracked_files = SHOW_NO_UNTRACKED_FILES;
+	else if (!strcmp(untracked_files_arg, "normal"))
+		s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+	else if (!strcmp(untracked_files_arg, "all"))
+		s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+	else
+		die("Invalid untracked files mode '%s'", untracked_files_arg);
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[],
 				      const char *prefix,
@@ -794,16 +815,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	else
 		die("Invalid cleanup mode %s", cleanup_arg);
 
-	if (!untracked_files_arg)
-		; /* default already initialized */
-	else if (!strcmp(untracked_files_arg, "no"))
-		s->show_untracked_files = SHOW_NO_UNTRACKED_FILES;
-	else if (!strcmp(untracked_files_arg, "normal"))
-		s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
-	else if (!strcmp(untracked_files_arg, "all"))
-		s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
-	else
-		die("Invalid untracked files mode '%s'", untracked_files_arg);
+	handle_untracked_files_arg(s);
 
 	if (all && argc > 0)
 		die("Paths with -a does not make sense.");
@@ -886,6 +898,38 @@ static int git_status_config(const char *k, const char *v, void *cb)
 	return git_diff_ui_config(k, v, NULL);
 }
 
+int cmd_stat(int argc, const char **argv, const char *prefix)
+{
+	struct wt_status s;
+	unsigned char sha1[20];
+	static struct option builtin_stat_options[] = {
+		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
+		  "mode",
+		  "show untracked files, optional modes: all, normal, no. (Default: all)",
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_END(),
+	};
+
+	wt_status_prepare(&s);
+	git_config(git_status_config, &s);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_stat_options,
+			     builtin_stat_usage, 0);
+	handle_untracked_files_arg(&s);
+
+	read_cache();
+	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
+	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
+	wt_status_collect(&s);
+
+	if (s.use_color == -1)
+		s.use_color = git_use_color_default;
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+	wt_status_print_body(&s);
+	return 0;
+}
+
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
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
index 63598ce..c887a90 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -531,6 +531,19 @@ static void wt_status_print_tracking(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
 
+void wt_status_print_body(struct wt_status *s)
+{
+	wt_status_print_unmerged(s);
+	wt_status_print_updated(s);
+	wt_status_print_changed(s);
+	if (s->submodule_summary)
+		wt_status_print_submodule_summary(s);
+	if (s->show_untracked_files)
+		wt_status_print_untracked(s);
+	else if (s->commitable)
+		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	unsigned char sha1[20];
@@ -561,15 +574,7 @@ void wt_status_print(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 	}
 
-	wt_status_print_unmerged(s);
-	wt_status_print_updated(s);
-	wt_status_print_changed(s);
-	if (s->submodule_summary)
-		wt_status_print_submodule_summary(s);
-	if (s->show_untracked_files)
-		wt_status_print_untracked(s);
-	else if (s->commitable)
-		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
+	wt_status_print_body(s);
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
diff --git a/wt-status.h b/wt-status.h
index a0e7517..ab52ce1 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -54,5 +54,6 @@ struct wt_status {
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+void wt_status_print_body(struct wt_status *s);
 
 #endif /* STATUS_H */
-- 
1.6.4.224.g3be84
