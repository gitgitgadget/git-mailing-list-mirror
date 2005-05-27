From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] testcase for git-tar-tree
Date: Fri, 27 May 2005 22:36:02 +0200
Message-ID: <20050527203602.GA16785@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 22:35:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DblWy-0004Qy-VW
	for gcvg-git@gmane.org; Fri, 27 May 2005 22:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVE0UgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVE0UgQ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 16:36:16 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:21921 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262578AbVE0UgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 16:36:03 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 7750339F; Fri, 27 May 2005 22:36:02 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add testcase for git-tar-tree and git-get-tar-commit-id.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Index: t/t3200-tar-tree.sh
===================================================================
--- /dev/null  (tree:f6db9be9d431080d9e7f61edb616b8bac8c9618f)
+++ ba1de5878d8e0cd1c7c728379e033ea6bf8567e5/t/t3200-tar-tree.sh  (mode:100755)
@@ -0,0 +1,106 @@
+#!/bin/sh
+#
+# Copyright (C) 2005 Rene Scharfe
+#
+
+test_description='git-tar-tree and git-get-tar-commit-id test
+
+This test covers the topics of long paths, file contents, commit date
+handling and commit id embedding:
+
+  Paths longer than 100 characters require the use of a pax extended
+  header to store them.  The test creates files with pathes both longer
+  and shorter than 100 chars, and also checks symlinks with long and
+  short pathes both as their own name and as target path.
+
+  The contents of the repository is compared to the extracted tar
+  archive.  The repository contains simple text files, symlinks and a
+  binary file (/bin/sh).
+
+  git-tar-tree applies the commit date to every file in the archive it
+  creates.  The test sets the commit date to a specific value and checks
+  if the tar archive contains that value.
+
+  When giving git-tar-tree a commit id (in contrast to a tree id) it
+  embeds this commit id into the tar archive as a comment.  The test
+  checks the ability of git-get-tar-commit-id to figure it out from the
+  tar file.
+
+'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'populate workdir' \
+    'mkdir a b c &&
+     p48=1.......10........20........30........40......48 &&
+     p50=1.......10........20........30........40........50 &&
+     p98=${p48}${p50} &&
+     echo simple textfile >a/a &&
+     echo 100 chars in path >a/${p98} &&
+     echo 101 chars in path >a/${p98}x &&
+     echo 102 chars in path >a/${p98}xx &&
+     echo 103 chars in path >a/${p98}xxx &&
+     mkdir a/bin &&
+     cp /bin/sh a/bin/sh &&
+     ln -s a a/l1 &&
+     ln -s ${p98}xx a/l100 &&
+     ln -s ${p98}xxx a/l101 &&
+     ln -s ${p98}xxx a/l${p98} &&
+     (cd a && find .) | sort >a.lst'
+
+test_expect_success \
+    'add files to repository' \
+    'find a -type f | xargs git-update-cache --add &&
+     find a -type l | xargs git-update-cache --add &&
+     treeid=`git-write-tree` &&
+     echo $treeid >treeid &&
+     TZ= GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
+     git-commit-tree $treeid </dev/null >.git/HEAD'
+
+test_expect_success \
+    'git-tar-tree' \
+    'git-tar-tree HEAD >b.tar'
+
+test_expect_success \
+    'validate file modification time' \
+    'tar tvf b.tar a/a | awk \{print\ \$4,\$5\} >b.mtime &&
+     echo "2005-05-27 22:00:00" >expected.mtime &&
+     diff expected.mtime b.mtime'
+
+test_expect_success \
+    'git-get-tar-commit-id' \
+    'git-get-tar-commit-id <b.tar >b.commitid &&
+     diff .git/HEAD b.commitid'
+
+test_expect_success \
+    'extract tar archive' \
+    '(cd b && tar xf -) <b.tar'
+
+test_expect_success \
+    'validate filenames' \
+    '(cd b/a && find .) | sort >b.lst &&
+     diff a.lst b.lst'
+
+test_expect_success \
+    'validate file contents' \
+    'diff -r a b/a'
+
+test_expect_success \
+    'git-tar-tree with prefix' \
+    'git-tar-tree HEAD prefix >c.tar'
+
+test_expect_success \
+    'extract tar archive with prefix' \
+    '(cd c && tar xf -) <c.tar'
+
+test_expect_success \
+    'validate filenames with prefix' \
+    '(cd c/prefix/a && find .) | sort >c.lst &&
+     diff a.lst c.lst'
+
+test_expect_success \
+    'validate file contents with prefix' \
+    'diff -r a c/prefix/a'
+
+test_done
