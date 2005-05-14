From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Test GIT environment use.
Date: Sat, 14 May 2005 01:45:42 -0700
Message-ID: <7vekca42mh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 10:46:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWsHo-0000bJ-VM
	for gcvg-git@gmane.org; Sat, 14 May 2005 10:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVENIqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 04:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVENIqJ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 04:46:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26766 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262706AbVENIpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 04:45:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514084544.QJKA7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 04:45:44 -0400
To: pasky@ucw.cz, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This test makes sure that use of deprecated environment variables still
works, using both new and old names makes new one take
precedence, and GIT_DIR and GIT_ALTERNATE_OBJECT_DIRECTORIES mechanisms
work.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

t/t0110-environment-names.sh |  134 +++++++++++++++++++++++++++++++++++++++++++
1 files changed, 134 insertions(+)
t/t0110-environment-names.sh (. --> 100755)

--- a/t/t0110-environment-names.sh
+++ b/t/t0110-environment-names.sh
@@ -0,0 +1,134 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Using new and old environment names.
+
+This test makes sure that use of deprecated environment variables
+still works, using both new and old names makes new one take precedence,
+and GIT_DIR and GIT_ALTERNATE_OBJECT_DIRECTORIES mechanism works.'
+
+env_vars='GIT_AUTHOR_DATE:AUTHOR_DATE
+GIT_AUTHOR_EMAIL:AUTHOR_EMAIL
+GIT_AUTHOR_NAME:AUTHOR_NAME
+GIT_COMMITTER_EMAIL:COMMIT_AUTHOR_EMAIL
+GIT_COMMITTER_NAME:COMMIT_AUTHOR_NAME
+GIT_ALTERNATE_OBJECT_DIRECTORIES:SHA1_FILE_DIRECTORIES
+GIT_OBJECT_DIRECTORY:SHA1_FILE_DIRECTORY
+'
+
+. ./test-lib.sh
+
+export_them () {
+	for ev in $env_vars
+	do
+		new=$(expr "$ev" : '\(.*\):')
+		old=$(expr "$ev" : '.*:\(.*\)')
+		# Build and eval the following:
+		# case "${VAR+set}" in set) export VAR;; esac
+		evstr='case "${'$new'+set}" in set) export '$new';; esac'
+		eval "$evstr"
+		evstr='case "${'$old'+set}" in set) export '$old';; esac'
+		eval "$evstr"
+	done
+}
+
+SHA1_FILE_DIRECTORY=.svn/objects ;# whoa
+export SHA1_FILE_DIRECTORY
+
+rm -fr .git
+mkdir .svn
+test_expect_success \
+    'using SHA1_FILE_DIRECTORY in git-init-db' \
+    'git-init-db && test -d .svn/objects/cb'
+
+unset SHA1_FILE_DIRECTORY
+GIT_DIR=.svn
+export GIT_DIR
+rm -fr .git .svn
+mkdir .svn
+test_expect_success \
+    'using GIT_DIR in git-init-db' \
+    'git-init-db && test -d .svn/objects/cb'
+
+date >path0
+test_expect_success \
+    'using GIT_DIR in git-update-cache' \
+    'git-update-cache --add path0 && test -f .svn/index'
+
+sedScript='s|\(..\)|.svn/objects/\1/|'
+
+test_expect_success \
+    'using GIT_DIR in git-write-tree' \
+    'tree=$(git-write-tree) &&
+     test -f $(echo "$tree" | sed -e "$sedScript")'
+
+AUTHOR_DATE='Sat May 14 00:00:00 2005 -0000'
+AUTHOR_EMAIL='author@example.xz'
+AUTHOR_NAME='A U Thor'
+COMMIT_AUTHOR_EMAIL='author@example.xz'
+COMMIT_AUTHOR_NAME='A U Thor'
+export_them
+
+test_expect_success \
+    'using GIT_DIR and old variable names in git-commit-tree' \
+    'commit=$(echo foo | git-commit-tree $tree) &&
+     test -f $(echo "$commit" | sed -e "$sedScript")'
+
+test_expect_success \
+    'using GIT_DIR in git-cat-file' \
+    'git-cat-file commit $commit >current'
+
+cat >expected <<\EOF
+author A U Thor <author@example.xz>
+committer A U Thor <author@example.xz>
+EOF
+test_expect_success \
+    'verify old AUTHOR variables were used correctly in commit' \
+    'sed -ne '\''/^\(author\|committer\)/s|>.*|>|p'\'' current |
+     cmp - expected'
+
+unset GIT_DIR
+test_expect_success \
+    'git-init-db without GIT_DIR' \
+    'git-init-db && test -d .git && test -d .git/objects/ef'
+
+SHA1_FILE_DIRECTORIES=.svn/objects
+export SHA1_FILE_DIRECTORIES
+
+test_expect_success \
+    'using SHA1_FILE_DIRECTORIES with git-ls-tree' \
+    'git-ls-tree $commit && git-ls-tree $tree'
+
+GIT_AUTHOR_DATE='Sat May 14 12:00:00 2005 -0000'
+GIT_AUTHOR_EMAIL='rohtua@example.xz'
+GIT_AUTHOR_NAME='R O Htua'
+GIT_COMMITTER_EMAIL='rohtua@example.xz'
+GIT_COMMITTER_NAME='R O Htua'
+export_them
+
+sedScript='s|\(..\)|.git/objects/\1/|'
+test_expect_success \
+    'using new author variables with git-commit-tree' \
+    'commit2=$(echo foo | git-commit-tree $tree) &&
+     test -f $(echo "$commit2" | sed -e "$sedScript")'
+
+GIT_ALTERNATE_OBJECT_DIRECTORIES=.git/objects
+GIT_DIR=nowhere
+export GIT_DIR GIT_ALTERNATE_OBJECT_DIRECTORIES
+
+test_expect_success \
+    'git-cat-file with GIT_DIR and GIT_ALTERNATE_OBJECT_DIRECTORIES' \
+    'git-cat-file commit $commit2 >current'
+
+cat >expected <<\EOF
+author R O Htua <rohtua@example.xz>
+committer R O Htua <rohtua@example.xz>
+EOF
+test_expect_success \
+    'verify new AUTHOR variables were used correctly in commit.' \
+    'sed -ne '\''/^\(author\|committer\)/s|>.*|>|p'\'' current |
+     cmp - expected'
+
+test_done
------------------------------------------------

