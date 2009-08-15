From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] git status: not "commit --dry-run" anymore
Date: Sat, 15 Aug 2009 15:39:56 -0700
Message-ID: <1250375997-10657-9-git-send-email-gitster@pobox.com>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com>
 <1250375997-10657-2-git-send-email-gitster@pobox.com>
 <1250375997-10657-3-git-send-email-gitster@pobox.com>
 <1250375997-10657-4-git-send-email-gitster@pobox.com>
 <1250375997-10657-5-git-send-email-gitster@pobox.com>
 <1250375997-10657-6-git-send-email-gitster@pobox.com>
 <1250375997-10657-7-git-send-email-gitster@pobox.com>
 <1250375997-10657-8-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRve-0003is-1M
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZHOWkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbZHOWkS
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZHOWkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:15 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B1C5C4FE
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93EDBC4FD for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:16 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
In-Reply-To: <1250375997-10657-8-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9B01EC98-89EC-11DE-93AF-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126040>

This removes tentative "git stat" and make it take over "git status".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This alone fails some tests; 9/9 will be squashed in in the final round.

 Documentation/git-status.txt |   79 ++++++++++++++++++++++++++++++++++++-----
 builtin-commit.c             |   29 ++-------------
 builtin.h                    |    1 -
 git.c                        |    1 -
 4 files changed, 73 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 84f60f3..b5939d6 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -8,7 +8,7 @@ git-status - Show the working tree status
 
 SYNOPSIS
 --------
-'git status' <options>...
+'git status' [<options>...] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -20,25 +20,85 @@ are what you _would_ commit by running `git commit`; the second and
 third are what you _could_ commit by running 'git-add' before running
 `git commit`.
 
-The command takes the same set of options as 'git-commit'; it
-shows what would be committed if the same options are given to
-'git-commit'.
-
-If there is no path that is different between the index file and
-the current HEAD commit (i.e., there is nothing to commit by running
-`git commit`), the command exits with non-zero status.
+OPTIONS
+-------
+
+-s::
+--short::
+	Give the output in the short-format.
+
+-u[<mode>]::
+--untracked-files[=<mode>]::
+	Show untracked files (Default: 'all').
++
+The mode parameter is optional, and is used to specify
+the handling of untracked files. The possible options are:
++
+--
+	- 'no'     - Show no untracked files
+	- 'normal' - Shows untracked files and directories
+	- 'all'    - Also shows individual files in untracked directories.
+--
++
+See linkgit:git-config[1] for configuration variable
+used to change the default for when the option is not
+specified.
+
+-z::
+	Terminate entries with NUL, instead of LF.  This implies `-s`
+	(short status) output format.
 
 
 OUTPUT
 ------
 The output from this command is designed to be used as a commit
 template comment, and all the output lines are prefixed with '#'.
+The default, long format, is designed to be human readable,
+verbose and descriptive.  They are subject to change in any time.
 
 The paths mentioned in the output, unlike many other git commands, are
 made relative to the current directory if you are working in a
 subdirectory (this is on purpose, to help cutting and pasting). See
 the status.relativePaths config option below.
 
+In short-format, the status of each path is shown as
+
+	XY PATH1 -> PATH2
+
+where `PATH1` is the path in the `HEAD`, and ` -> PATH2` part is
+shown only when `PATH1` corresponds to a different path in the
+index/worktree (i.e. renamed).
+
+For unmerged entries, `X` shows the status of stage #2 (i.e. ours) and `Y`
+shows the status of stage #3 (i.e. theirs).
+
+For entries that do not have conflicts, `X` shows the status of the index,
+and `Y` shows the status of the work tree.  For untracked paths, `XY` are
+`??`.
+
+    X          Y     Meaning
+    -------------------------------------------------
+              [MD]   not updated
+    M        [ MD]   updated in index
+    A        [ MD]   added to index
+    D        [ MD]   deleted from index
+    R        [ MD]   renamed in index
+    C        [ MD]   copied in index
+    [MARC]           index and work tree matches
+    [ MARC]     M    work tree changed since index
+    [ MARC]     D    deleted in work tree
+    -------------------------------------------------
+    D           D    unmerged, both deleted
+    A           U    unmerged, added by us
+    U           D    unmerged, deleted by them
+    U           A    unmerged, added by them
+    D           U    unmerged, deleted by us
+    A           A    unmerged, both added
+    U           U    unmerged, both modified
+    -------------------------------------------------
+    ?           ?    untracked
+    -------------------------------------------------
+
 
 CONFIGURATION
 -------------
@@ -63,8 +123,7 @@ linkgit:gitignore[5]
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org> and
-Junio C Hamano <gitster@pobox.com>.
+Written by Junio C Hamano <gitster@pobox.com>.
 
 Documentation
 --------------
diff --git a/builtin-commit.c b/builtin-commit.c
index 1a360cb..6cb0e40 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -36,11 +36,6 @@ static const char * const builtin_status_usage[] = {
 	NULL
 };
 
-static const char * const builtin_stat_usage[] = {
-	"git stat [options]",
-	NULL
-};
-
 static unsigned char head_sha1[20], merge_head_sha1[20];
 static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
@@ -971,13 +966,13 @@ static void short_untracked(int null_termination, struct string_list_item *it,
 	}
 }
 
-int cmd_stat(int argc, const char **argv, const char *prefix)
+int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
 	static int null_termination, shortstatus;
 	int i;
 	unsigned char sha1[20];
-	static struct option builtin_stat_options[] = {
+	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose),
 		OPT_BOOLEAN('s', "short", &shortstatus,
 			    "show status concicely"),
@@ -996,8 +991,8 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 	git_config(git_status_config, &s);
 	argc = parse_options(argc, argv, prefix,
-			     builtin_stat_options,
-			     builtin_stat_usage, 0);
+			     builtin_status_options,
+			     builtin_status_usage, 0);
 	handle_untracked_files_arg(&s);
 
 	if (*argv)
@@ -1039,22 +1034,6 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-int cmd_status(int argc, const char **argv, const char *prefix)
-{
-	struct wt_status s;
-
-	wt_status_prepare(&s);
-	git_config(git_status_config, &s);
-	if (s.use_color == -1)
-		s.use_color = git_use_color_default;
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
-	argc = parse_and_validate_options(argc, argv, builtin_status_usage,
-					  prefix, &s);
-	return dry_run_commit(argc, argv, prefix, &s);
-}
-
 static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
diff --git a/builtin.h b/builtin.h
index eeaf0b6..20427d2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -95,7 +95,6 @@ extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
-extern int cmd_stat(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index de7fcf6..807d875 100644
--- a/git.c
+++ b/git.c
@@ -350,7 +350,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
-		{ "stat", cmd_stat, RUN_SETUP | NEED_WORK_TREE },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-- 
1.6.4.224.g3be84
