From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Tests for env variable rename and update-cache f/d
 conflicts.
Date: Thu, 12 May 2005 01:06:56 -0700
Message-ID: <7vu0l8j2an.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 10:01:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW8cg-00059n-67
	for gcvg-git@gmane.org; Thu, 12 May 2005 10:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVELIIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 04:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVELIIM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 04:08:12 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64163 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261304AbVELIHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 04:07:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512080656.EYHZ20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 04:06:56 -0400
To: pasky@ucw.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

These are test cases to prevent regression from happening for
the recent two changes we made.  They depend on the test suite
infrastructure I have sent in earlier.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

t/t0100-environment-names.sh |   82 +++++++++++++++++++++++++++++++++++++++++++
t/t0200-update-cache.sh      |   46 ++++++++++++++++++++++++
2 files changed, 128 insertions(+)

Created: t/t0100-environment-names.sh (mode:100755)
--- /dev/null
+++ b/t/t0100-environment-names.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. ./test-lib.sh
+test_description "$@" 'general environment name warning test.
+
+This test makes sure that use of deprecated environment variables
+trigger the warnings from gitenv().'
+
+env_vars='GIT_AUTHOR_DATE:AUTHOR_DATE
+GIT_AUTHOR_EMAIL:AUTHOR_EMAIL
+GIT_AUTHOR_NAME:AUTHOR_NAME
+GIT_COMMITTER_EMAIL:COMMIT_AUTHOR_EMAIL
+GIT_COMMITTER_NAME:COMMIT_AUTHOR_NAME
+GIT_ALTERNATE_OBJECT_DIRECTORIES:SHA1_FILE_DIRECTORIES
+GIT_OBJECT_DIRECTORY:SHA1_FILE_DIRECTORY'
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
+date >path0
+git-update-cache --add path0
+tree=$(git-write-tree)
+
+AUTHOR_DATE='Wed May 11 23:55:18 2005'
+AUTHOR_EMAIL='author@example.xz'
+AUTHOR_NAME='A U Thor'
+COMMIT_AUTHOR_EMAIL='author@example.xz'
+COMMIT_AUTHOR_NAME='A U Thor'
+SHA1_FILE_DIRECTORY=.git/objects
+
+export_them
+
+test_debug 'echo with only old variables exported.'
+
+echo 'foo' | git-commit-tree $tree >/dev/null 2>errmsg
+cat >expected-err <<\EOF
+warning: Attempting to use SHA1_FILE_DIRECTORY
+warning: GIT environment variables have been renamed.
+warning: Please adjust your scripts and environment.
+warning: old AUTHOR_DATE => new GIT_AUTHOR_DATE
+warning: old AUTHOR_EMAIL => new GIT_AUTHOR_EMAIL
+warning: old AUTHOR_NAME => new GIT_AUTHOR_NAME
+warning: old COMMIT_AUTHOR_EMAIL => new GIT_COMMITTER_EMAIL
+warning: old COMMIT_AUTHOR_NAME => new GIT_COMMITTER_NAME
+warning: old SHA1_FILE_DIRECTORY => new GIT_OBJECT_DIRECTORY
+EOF
+sed -ne '/^warning: /p' <errmsg >generated-err
+test_debug 'cat errmsg'
+test_expect_success 'cmp generated-err expected-err'
+
+test_debug 'echo with new variables exported.'
+
+for ev in $env_vars
+do
+	new=$(expr "$ev" : '\(.*\):')
+	old=$(expr "$ev" : '.*:\(.*\)')
+	# Build and eval the following:
+	# NEWENV=$OLDENV
+	evstr="$new=\$$old"
+	eval "$evstr"
+done
+export_them
+echo 'foo' | git-commit-tree $tree >/dev/null 2>errmsg
+sed -ne '/^warning: /p' <errmsg >generated-err
+test_debug 'cat errmsg'
+test_expect_success 'cmp generated-err /dev/null'
+
+test_done
Created: t/t0200-update-cache.sh (mode:100755)
--- /dev/null
+++ b/t/t0200-update-cache.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. ./test-lib.sh
+test_description "$@" 'git-update-cache nonsense-path test.
+
+This test creates the following structure in the cache:
+
+    path0       - a file
+    path1       - a symlink
+    path2/file2 - a file in a directory
+    path3/file3 - a file in a directory
+
+and tries to git-update-cache --add the following:
+
+    path0/file0 - a file in a directory
+    path1/file1 - a file in a directory
+    path2       - a file
+    path3       - a symlink
+
+All of the attempts should fail.
+'
+
+mkdir path2 path3
+date >path0
+ln -s xyzzy path1
+date >path2/file2
+date >path3/file3
+
+git-update-cache --add -- path0 path1 path2/file2 path3/file3
+
+rm -fr path?
+
+mkdir path0 path1
+date >path2
+ln -s frotz path3
+date >path0/file0
+date >path1/file1
+
+for p in path0/file0 path1/file1 path2 path3
+do
+	test_expect_failure "git-update-cache --add -- $p"
+done
+test_done

