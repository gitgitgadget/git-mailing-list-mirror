From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/3] revert: accept arbitrary rev-list options
Date: Tue, 15 Jun 2010 05:29:50 +0200
Message-ID: <20100615032952.3977.84899.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 05:38:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOMzC-000767-Bc
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 05:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab0FODij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 23:38:39 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39616 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab0FODii (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 23:38:38 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3B611818047;
	Tue, 15 Jun 2010 05:38:31 +0200 (CEST)
X-git-sha1: fc6707df87ae0f73f5718f107c02094dc39756e1 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149156>

This can be useful to do something like:

git rev-list --reverse master -- README | git cherry-pick -n --stdin

without using xargs.

As an added bonus it makes "git cherry-pick -3 fourth" work.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-cherry-pick.txt   |   14 +++++++++++++-
 Documentation/git-revert.txt        |    7 ++++++-
 builtin/revert.c                    |    3 ++-
 t/t3508-cherry-pick-many-commits.sh |   12 +++++++++++-
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index bcb4c75..0711efd 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,8 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 
 SYNOPSIS
 --------
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
+'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
+		[<rev-list-options>] <commit>...
 
 DESCRIPTION
 -----------
@@ -26,6 +27,10 @@ OPTIONS
 	default, as if the '--no-walk' option was specified, see
 	linkgit:git-rev-list[1].
 
+<rev-list-options>::
+	Unrecognized options are used as options to list commits, see
+	linkgit:git-rev-list[1].
+
 -e::
 --edit::
 	With this option, 'git cherry-pick' will let you edit the commit
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
index dea4f53..e5f129e 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -7,7 +7,8 @@ git-revert - Revert some existing commits
 
 SYNOPSIS
 --------
-'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
+'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s]
+		[<rev-list-options>] <commit>...
 
 DESCRIPTION
 -----------
@@ -36,6 +37,10 @@ OPTIONS
 	default, see linkgit:git-rev-list[1] and its '--no-walk'
 	option.
 
+<rev-list-options>::
+	Unrecognized options are used as options to list commits, see
+	linkgit:git-rev-list[1].
+
 -e::
 --edit::
 	With this option, 'git revert' will let you edit the commit
diff --git a/builtin/revert.c b/builtin/revert.c
index 853e9e4..3f4a20e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -78,7 +78,8 @@ static void parse_args(int argc, const char **argv)
 			die("program error");
 	}
 
-	commit_argc = parse_options(argc, argv, NULL, options, usage_str, 0);
+	commit_argc = parse_options(argc, argv, NULL, options, usage_str,
+				    PARSE_OPT_KEEP_UNKNOWN);
 	if (commit_argc < 1)
 		usage_with_options(usage_str, options);
 
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 26a8730..f90ed3d 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -82,7 +82,7 @@ test_expect_success 'revert fourth fourth~1 fourth~2 works' '
 	git diff --quiet HEAD first
 '
 
-test_expect_failure 'cherry-pick -3 fourth works' '
+test_expect_success 'cherry-pick -3 fourth works' '
 	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
@@ -92,4 +92,14 @@ test_expect_failure 'cherry-pick -3 fourth works' '
 	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
 '
 
+test_expect_success 'cherry-pick --stdin works' '
+	git checkout -f master &&
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
1.7.1.530.g14dc.dirty
