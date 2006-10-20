From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] cogito: Honor either post-commit script name; fail if both are executable
Date: Fri, 20 Oct 2006 18:15:51 +0200
Message-ID: <874ptzhsjs.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 20 18:16:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gax2J-0002da-Mj
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 18:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWJTQPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 12:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWJTQPw
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 12:15:52 -0400
Received: from mx.meyering.net ([82.230.74.64]:12756 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S932253AbWJTQPw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 12:15:52 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 307147AF8; Fri, 20 Oct 2006 18:15:51 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29500>

Hi,

I promised this patch some time ago, made the changes,
and then never sent them.  This is slightly different
from the current implementation in that it fails when both
scripts are executable.  Also, it factors out the script names and
adds tests.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 cg-commit        |   43 ++++++++++++++++++++++++++++++-------------
 t/t9800-hooks.sh |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/cg-commit b/cg-commit
index 01a4eb7..ee4769e 100755
--- a/cg-commit
+++ b/cg-commit
@@ -148,11 +148,11 @@ #	If the file exists it will be used as
 #	the commit message. The template file makes it possible to
 #	automatically add `Signed-off-by` line to the log message.
 #
-# $GIT_DIR/hooks/commit-post::
+# $GIT_DIR/hooks/post-commit:: (legacy: commit-post)
 #	If the file exists and is executable it will be executed upon
 #	completion of the commit. The script is passed two arguments.
 #	The first argument is the commit ID and the second is the
-#	branchname. A sample `commit-post` script might look like:
+#	branchname. A sample `post-commit` script might look like:
 #
 #	#!/bin/sh
 #	id=$1
@@ -680,18 +680,35 @@ elif [ "$newhead" ]; then
 		branchname="$(cat "$_git/branch-name")"
 	fi
 	[ -z "$branchname" ] && [ "$_git_head" != "master" ] && branchname="$_git_head"
-	if [ -x "$_git/hooks/commit-post" -o -x "$_git/hooks/post-commit" ] && [ ! "$no_hooks" ]; then
-		if [ "$(git-repo-config --bool cogito.hooks.commit.post.allmerged)" = "true" ]; then
-			# We just hope that for the initial commit, the user didn't
-			# manage to install the hook yet.
-			for merged in $(git-rev-list $newhead ^$oldhead | tac); do
-				[ -x "$_git/hooks/commit-post" ] && "$_git/hooks/commit-post" "$merged" "$branchname"
-				[ -x "$_git/hooks/post-commit" ] && "$_git/hooks/post-commit" "$merged" "$branchname"
-			done
-		else
-			[ -x "$_git/hooks/commit-post" ] && "$_git/hooks/commit-post" "$newhead" "$branchname"
-			[ -x "$_git/hooks/post-commit" ] && "$_git/hooks/post-commit" "$newhead" "$branchname"
+
+	if [ "$no_hooks" ]; then
+		exit 0
+	fi
+
+	# Decide which spelling to use for the post-commit hook script name.
+	post_commit="$_git/hooks/post-commit"
+	old_name="$_git/hooks/commit-post"
+	if [ -x "$post_commit" ]; then
+		if [ -x "$old_name" ]; then
+			die "both $post_commit and $old_name are executable."
 		fi
+		# This is the expected case: use $post_commit
+	else
+		if [ ! -x "$old_name" ]; then
+			# neither is executable: do nothing
+			exit 0
+		fi
+		post_commit=$old_name
+	fi
+
+	if [ "$(git-repo-config --bool cogito.hooks.commit.post.allmerged)" = "true" ]; then
+		# We just hope that for the initial commit, the user didn't
+		# manage to install the hook yet.
+		for merged in $(git-rev-list $newhead ^$oldhead | tac); do
+			"$post_commit" "$merged" "$branchname"
+		done
+	else
+		"$post_commit" "$newhead" "$branchname"
 	fi
 
 	exit 0
diff --git a/t/t9800-hooks.sh b/t/t9800-hooks.sh
new file mode 100755
index 0000000..a54e35f
--- /dev/null
+++ b/t/t9800-hooks.sh
@@ -0,0 +1,37 @@
+#!/usr/bin/env bash
+#
+# Copyright (c) 2006 Jim Meyering
+#
+test_description="Test the commit hooks."
+
+. ./test-lib.sh
+rm -rf .git
+
+echo x > f
+test_expect_success 'initialize repo' \
+	'(cg-init -m"Initial commit")'
+
+commit_post=.git/hooks/commit-post
+post_commit=.git/hooks/post-commit
+cat > $post_commit <<\EOF
+#!/bin/sh
+echo $0
+exit 0
+EOF
+cp $post_commit $commit_post
+
+chmod a+x $post_commit
+test_expect_success 'test the post-commit name' \
+	'(echo 1 >> f; test "`cg-commit -m x|grep git/hooks`" = $post_commit)'
+
+chmod a-x $post_commit
+chmod a+x $commit_post
+
+test_expect_success 'test the legacy commit-post name' \
+	'(echo 2 >> f; test "`cg-commit -m x|grep git/hooks`" = $commit_post)'
+
+chmod a+x $post_commit
+test_expect_failure 'fail when both are executable' \
+	'(echo 3 >> f; cg-commit -m x)'
+
+test_done
-- 
1.4.3.ge193
