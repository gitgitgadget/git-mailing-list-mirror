From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/2] add support for branch.<name>.integrationonly
Date: Thu, 20 Sep 2007 14:53:09 +0200
Message-ID: <1190292789-16203-3-git-send-email-hjemli@gmail.com>
References: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
 <1190292789-16203-2-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 14:54:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYLYA-00029R-Mv
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 14:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbXITMxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 08:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbXITMxR
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 08:53:17 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:61150 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755559AbXITMxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 08:53:15 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l8KCqe64013119;
	Thu, 20 Sep 2007 14:52:41 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190292789-16203-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58774>

This setting can be used to set --no-ff as default merge policy for
selected branches. There is also a new new merge-option, --ff, which can
be used to override the default.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/config.txt        |    7 ++++
 Documentation/git-svn.txt       |    4 ++
 Documentation/merge-options.txt |   14 +++++++--
 git-merge.sh                    |   19 ++++++++++-
 t/t6029-merge-integration.sh    |   64 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 015910f..fa7c3c1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -337,6 +337,13 @@ branch.<name>.merge::
 	branch.<name>.merge to the desired branch, and use the special setting
 	`.` (a period) for branch.<name>.remote.
 
+branch.<name>.integrationonly::
+	When merging into branch <name>, this setting specifies whether
+	fast-forward merges are disallowed. The setting can be overridden
+	by the --ff and --no-ff options of gitlink:git-merge[1]. See
+	gitlink:git-svn[1] for information about this setting when
+	working with subversion branches. Defaults to false.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f or -n.  Defaults
 	to false.
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 619023d..55828a3 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -487,6 +487,10 @@ merge using the --no-ff option:
        $ git reset --hard HEAD@{1}   ## undo the fast-forward merge
        $ git merge --no-ff <branch>
 
+Alternatively, one can configure the appropriate local branches to use
+--no-ff as default by setting branch.<name>.integrationonly=true in
+$GIT_DIR/config.
+
 
 DESIGN PHILOSOPHY
 -----------------
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index b34b888..f83bba9 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -26,7 +26,15 @@
 	is used instead (`git-merge-recursive` when merging a single
 	head, `git-merge-octopus` otherwise).
 
+--ff::
+	Explicitly allow fast-forward merges. This can be used to
+	override the merge policy of the current branch, as specified
+	by the branch.<branch>.integrationonly configuration setting (see 
+	gitlink:git-config[1] for further details).
+
 --no-ff::
-	Force the creation of a merge commit even when the merge would
-	have resolved as a fast-forward operation. See gitlink:git-svn[1]
-	for a use-case for this option.
+	Explicitly disallow fast-forward merges. This can be used to
+	override the merge policy of the current branch, as specified
+	by the branch.<branch>.integrationonly configuration setting (see 
+	gitlink:git-config[1] for further details, and gitlink:git-svn[1]
+	for a use-case for this option).
diff --git a/git-merge.sh b/git-merge.sh
index 70ca5ff..4775767 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--summary] [--no-commit] [--no-ff] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--summary] [--no-commit] [--ff] [--no-ff] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -23,7 +23,7 @@ no_fast_forward_strategies='subtree ours'
 no_trivial_strategies='recursive recur subtree ours'
 use_strategies=
 
-allow_fast_forward=t
+allow_fast_forward=
 allow_trivial_merge=t
 
 dropsave() {
@@ -165,6 +165,9 @@ do
 		merge_msg="$1"
 		have_message=t
 		;;
+	--ff)
+		allow_fast_forward=t
+		;;
 	--no-ff)
 		allow_fast_forward=f
 		;;
@@ -245,6 +248,18 @@ do
 done
 set x $remoteheads ; shift
 
+if test -z "$allow_fast_forward"
+then
+	branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+	integrate=$(git config --bool "branch.$branch.integrationonly")
+	if test -n "$branch" -a "$integrate" = "true"
+	then
+		allow_fast_forward=f
+	else
+		allow_fast_forward=t
+	fi
+fi
+
 case "$use_strategies" in
 '')
 	case "$#" in
diff --git a/t/t6029-merge-integration.sh b/t/t6029-merge-integration.sh
index 6ba7dd9..c5ffa34 100755
--- a/t/t6029-merge-integration.sh
+++ b/t/t6029-merge-integration.sh
@@ -31,6 +31,8 @@ test_expect_success 'merge c1' '
 
 '
 
+test_debug 'gitk'
+
 test_expect_success 'merge --no-ff c1' '
 
 	git reset --hard c0 &&
@@ -41,6 +43,66 @@ test_expect_success 'merge --no-ff c1' '
 
 '
 
-test_debug 'gitk &'
+test_debug 'gitk'
+
+test_expect_success 'setup integrationonly' '
+
+	git config branch.master.integrationonly true
+
+'	
+
+test_expect_success 'merge c1' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge c1 &&
+	test $c0 = $(git rev-parse HEAD^1) &&
+	test $c1 = $(git rev-parse HEAD^2)
+
+'
+
+test_debug 'gitk'
+
+test_expect_success 'merge c1 --ff' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge --ff c1 &&
+	test $c0 = $(git rev-parse HEAD^) &&
+	test $c1 = $(git rev-parse HEAD)
+
+'
+
+test_debug 'gitk'
+
+test_expect_success 'revert integrationonly' '
+
+	git config branch.master.integrationonly false
+
+'	
+
+test_expect_success 'merge c1' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge c1 &&
+	test $c0 = $(git rev-parse HEAD^) &&
+	test $c1 = $(git rev-parse HEAD)
+
+'
+
+test_debug 'gitk'
+
+test_expect_success 'merge c1 --no-ff' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge --no-ff c1 &&
+	test $c0 = $(git rev-parse HEAD^1) &&
+	test $c1 = $(git rev-parse HEAD^2)
+
+'
+
+test_debug 'gitk'
 
 test_done
-- 
1.5.3.2.82.g75c8d
