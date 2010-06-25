From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] Add the option "--ignore-submodules" to "git status"
Date: Fri, 25 Jun 2010 16:56:47 +0200
Message-ID: <4C24C3AF.8000800@web.de>
References: <4C24C34B.20403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 25 16:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSAKs-000430-Vw
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 16:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411Ab0FYO4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 10:56:51 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:50410 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab0FYO4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 10:56:49 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 112ED1588AF7E;
	Fri, 25 Jun 2010 16:56:48 +0200 (CEST)
Received: from [80.128.126.113] (helo=[192.168.178.26])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OSAKl-0006VX-00; Fri, 25 Jun 2010 16:56:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C24C34B.20403@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/gZoEjYiqCF+OVh8DsGD4LFPDMcxLySY8hOSYj
	swIBbufHZ4QsV9a1Uy/xNYngeiWqUyqixuz/ntYEEoWwtOayps
	j3t2SyqgxlRsGKZCQjyw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149691>

In some use cases it is not desirable that "git status" considers
submodules that only contain untracked content as dirty. This may happen
e.g. when the submodule is not under the developers control and not all
build generated files have been added to .gitignore by the upstream
developers. Using the "untracked" parameter for the "--ignore-submodules"
option disables checking for untracked content and lets git diff report
them as changed only when they have new commits or modified content.

Sometimes it is not wanted to have submodules show up as changed when they
just contain changes to their work tree (this was the behavior before
1.7.0). An example for that are scripts which just want to check for
submodule commits while ignoring any changes to the work tree. Also users
having large submodules known not to change might want to use this option,
as the - sometimes substantial - time it takes to scan the submodule work
tree(s) is saved when using the "dirty" parameter.

And if you want to ignore any changes to submodules, you can now do that
by using this option without parameters or with "all" (when the config
option status.submodulesummary is set, using "all" will also suppress the
output of the submodule summary).

A new function handle_ignore_submodules_arg() is introduced to parse this
option new to "git status" in a single location, as "git diff" already
knew it.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-status.txt |   11 ++++
 builtin/commit.c             |    7 ++-
 diff.c                       |   15 +----
 submodule.c                  |   13 ++++
 submodule.h                  |    3 +
 t/t7508-status.sh            |  127 ++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  |   10 +++-
 wt-status.h                  |    1 +
 8 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index fd0fe7c..2fd054c 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -53,6 +53,17 @@ See linkgit:git-config[1] for configuration variable
 used to change the default for when the option is not
 specified.

+--ignore-submodules[=<when>]::
+	Ignore changes to submodules when looking for changes. <when> can be
+	either "untracked", "dirty" or "all", which is the default. When
+	"untracked" is used submodules are not considered dirty when they only
+	contain untracked content (but they are still scanned for modified
+	content). Using "dirty" ignores all changes to the work tree of submodules,
+	only changes to the commits stored in the superproject are shown (this was
+	the behavior before 1.7.0). Using "all" hides all changes to submodules
+	(and suppresses the output of submodule summaries when the config option
+	`status.submodulesummary` is set).
+
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
 	the `--porcelain` output format if no other format is given.
diff --git a/builtin/commit.c b/builtin/commit.c
index 3d99cf9..bd547f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -72,7 +72,7 @@ static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
-static char *untracked_files_arg, *force_date;
+static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -1059,6 +1059,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_BOOLEAN(0, "ignored", &show_ignored_in_status,
 			    "show ignored files"),
+		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, "when",
+		  "ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)",
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_END(),
 	};

@@ -1089,6 +1092,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)

 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.in_merge = in_merge;
+	s.ignore_submodule_arg = ignore_submodule_arg;
 	wt_status_collect(&s);

 	if (s.relative_paths)
@@ -1107,6 +1111,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
+		s.ignore_submodule_arg = ignore_submodule_arg;
 		wt_status_print(&s);
 		break;
 	}
diff --git a/diff.c b/diff.c
index 9d70f9d..3aa695d 100644
--- a/diff.c
+++ b/diff.c
@@ -3168,17 +3168,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--no-textconv"))
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules"))
-		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
-	else if (!prefixcmp(arg, "--ignore-submodules=")) {
-		if (!strcmp(arg + 20, "all"))
-			DIFF_OPT_SET(options, IGNORE_SUBMODULES);
-		else if (!strcmp(arg + 20, "untracked"))
-			DIFF_OPT_SET(options, IGNORE_UNTRACKED_IN_SUBMODULES);
-		else if (!strcmp(arg + 20, "dirty"))
-			DIFF_OPT_SET(options, IGNORE_DIRTY_SUBMODULES);
-		else
-			die("bad --ignore-submodules argument: %s", arg + 20);
-	} else if (!strcmp(arg, "--submodule"))
+		handle_ignore_submodules_arg(options, "all");
+	else if (!prefixcmp(arg, "--ignore-submodules="))
+		handle_ignore_submodules_arg(options, arg + 20);
+	else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
 	else if (!prefixcmp(arg, "--submodule=")) {
 		if (!strcmp(arg + 12, "log"))
diff --git a/submodule.c b/submodule.c
index 676d48f..61cb6e2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -46,6 +46,19 @@ done:
 	return ret;
 }

+void handle_ignore_submodules_arg(struct diff_options *diffopt,
+				  const char *arg)
+{
+	if (!strcmp(arg, "all"))
+		DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
+	else if (!strcmp(arg, "untracked"))
+		DIFF_OPT_SET(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
+	else if (!strcmp(arg, "dirty"))
+		DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
+	else
+		die("bad --ignore-submodules argument: %s", arg);
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
diff --git a/submodule.h b/submodule.h
index dbda270..6fd3bb4 100644
--- a/submodule.h
+++ b/submodule.h
@@ -1,6 +1,9 @@
 #ifndef SUBMODULE_H
 #define SUBMODULE_H

+struct diff_options;
+
+void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 9e08107..a72fe3a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -808,4 +808,131 @@ test_expect_success POSIXPERM 'status succeeds in a read-only repository' '
 	(exit $status)
 '

+cat > expect << EOF
+# On branch master
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+
+test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
+	echo modified > sm/untracked &&
+	git status --ignore-submodules=untracked > output &&
+	test_cmp expect output
+'
+
+test_expect_success '--ignore-submodules=dirty suppresses submodules with untracked content' '
+	git status --ignore-submodules=dirty > output &&
+	test_cmp expect output
+'
+
+test_expect_success '--ignore-submodules=dirty suppresses submodules with modified content' '
+	echo modified > sm/foo &&
+	git status --ignore-submodules=dirty > output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+# On branch master
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
+#
+#	modified:   dir1/modified
+#	modified:   sm (modified content)
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+
+test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
+	git status --ignore-submodules=untracked > output &&
+	test_cmp expect output
+'
+
+head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --verify HEAD)
+
+cat > expect << EOF
+# On branch master
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
+#
+#	modified:   dir1/modified
+#	modified:   sm (new commits)
+#
+# Submodules changed but not updated:
+#
+# * sm $head...$head2 (1):
+#   > 2nd commit
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+
+test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
+	git status --ignore-submodules=untracked > output &&
+	test_cmp expect output
+'
+
+test_expect_success "--ignore-submodules=dirty doesn't suppress submodule summary" '
+	git status --ignore-submodules=dirty > output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+# On branch master
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working directory)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+
+test_expect_success "--ignore-submodules=all suppresses submodule summary" '
+	git status --ignore-submodules=all > output &&
+	test_cmp expect output
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 9d9cb95..373213e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -10,6 +10,7 @@
 #include "run-command.h"
 #include "remote.h"
 #include "refs.h"
+#include "submodule.h"

 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -312,6 +313,8 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
 	if (!s->show_untracked_files)
 		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
+	if (s->ignore_submodule_arg)
+		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.prune_data = s->pathspec;
@@ -328,6 +331,9 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);

+	if (s->ignore_submodule_arg)
+		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
+
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data = s;
@@ -646,7 +652,9 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_updated(s);
 	wt_status_print_unmerged(s);
 	wt_status_print_changed(s);
-	if (s->submodule_summary) {
+	if (s->submodule_summary &&
+	    (!s->ignore_submodule_arg ||
+	     strcmp(s->ignore_submodule_arg, "all"))) {
 		wt_status_print_submodule_summary(s, 0);  /* staged */
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
diff --git a/wt-status.h b/wt-status.h
index 4cd74c4..9df9c9f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -45,6 +45,7 @@ struct wt_status {
 	int submodule_summary;
 	int show_ignored_files;
 	enum untracked_status_type show_untracked_files;
+	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_REMOTE_BRANCH+1][COLOR_MAXLEN];

 	/* These are computed during processing of the individual sections */
-- 
1.7.1.757.g0ad3c.dirty
