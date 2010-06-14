From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] revert: add --stdin option to read commits from stdin
Date: Mon, 14 Jun 2010 05:22:50 +0200
Message-ID: <20100614032251.20121.83253.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 05:33:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO0Qg-0004Gb-1H
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 05:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab0FNDdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 23:33:37 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:35168 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab0FNDdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 23:33:36 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 32BA2818047;
	Mon, 14 Jun 2010 05:33:28 +0200 (CEST)
X-git-sha1: 588077f6f3842ad03ab7276cdb40ef03953b49bd 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149066>

This can be useful to do something like:

git rev-list --reverse master -- README | git cherry-pick -n --stdin

without using xargs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
	This applies on top of pu as it is related to my cherry-pick
	many commits series.

 Documentation/git-cherry-pick.txt   |   14 +++++++++++++-
 Documentation/git-revert.txt        |    6 +++++-
 builtin/revert.c                    |    9 ++++++---
 t/t3508-cherry-pick-many-commits.sh |   10 ++++++++++
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index bcb4c75..54e6833 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,8 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 
 SYNOPSIS
 --------
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
+'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] [--stdin]
+		<commit>...
 
 DESCRIPTION
 -----------
@@ -79,6 +80,10 @@ effect to your index in a row.
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
+--stdin::
+	In addition to the '<commit>' listed on the command
+	line, read them from the standard input.
+
 EXAMPLES
 --------
 git cherry-pick master::
@@ -113,6 +118,13 @@ git cherry-pick --ff ..next::
 	are in next but not HEAD to the current branch, creating a new
 	commit for each new change.
 
+git rev-list --reverse master -- README | git cherry-pick -n --stdin::
+
+	Apply the changes introduced by all commits on the master
+	branch that touched README to the working tree and index,
+	so the result can be inspected and made into a single new
+	commit if suitable.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index dea4f53..84b4a68 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -7,7 +7,7 @@ git-revert - Revert some existing commits
 
 SYNOPSIS
 --------
-'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
+'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] [--stdin] <commit>...
 
 DESCRIPTION
 -----------
@@ -80,6 +80,10 @@ effect to your index in a row.
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
 
+--stdin::
+	In addition to the '<commit>' listed on the command
+	line, read them from the standard input.
+
 EXAMPLES
 --------
 git revert HEAD~3::
diff --git a/builtin/revert.c b/builtin/revert.c
index 853e9e4..2b3d5a5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -41,7 +41,7 @@ static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static int commit_argc;
 static const char **commit_argv;
-static int allow_rerere_auto;
+static int allow_rerere_auto, read_stdin;
 
 static const char *me;
 static const char *strategy;
@@ -63,6 +63,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
+		OPT_BOOLEAN(0, "stdin", &read_stdin, "read commits from stdin"),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
@@ -79,7 +80,7 @@ static void parse_args(int argc, const char **argv)
 	}
 
 	commit_argc = parse_options(argc, argv, NULL, options, usage_str, 0);
-	if (commit_argc < 1)
+	if (commit_argc < 1 && !read_stdin)
 		usage_with_options(usage_str, options);
 
 	commit_argv = argv;
@@ -527,10 +528,12 @@ static void prepare_revs(struct rev_info *revs)
 {
 	int argc = 0;
 	int i;
-	const char **argv = xmalloc((commit_argc + 4) * sizeof(*argv));
+	const char **argv = xmalloc((commit_argc + 5) * sizeof(*argv));
 
 	argv[argc++] = NULL;
 	argv[argc++] = "--no-walk";
+	if (read_stdin)
+		argv[argc++] = "--stdin";
 	if (action != REVERT)
 		argv[argc++] = "--reverse";
 	for (i = 0; i < commit_argc; i++)
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 3b87efe..27096f1 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -92,4 +92,14 @@ test_expect_failure 'cherry-pick -3 fourth works' '
 	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
 '
 
+test_expect_success 'cherry-pick --stdin works' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git rev-list --reverse first..fourth | git cherry-pick --stdin &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+'
+
 test_done
-- 
1.7.1.468.g77401.dirty
