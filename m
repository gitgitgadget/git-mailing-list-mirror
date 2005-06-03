From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: do only basic tests in t/t5000-git-tar-tree.sh
Date: Fri, 3 Jun 2005 18:21:23 +0200
Message-ID: <20050603162123.GA11107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 18:22:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeEue-00068i-FT
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 18:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVFCQXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 12:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVFCQXc
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 12:23:32 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:40842 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261344AbVFCQVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 12:21:24 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 8A4FF47B; Fri,  3 Jun 2005 18:21:23 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-tar-tree: remove tests of long path handling out of t5000-tar-tree.sh
and make test script cope with tar programs displaying file modification
date as hh:mm (newer variants show it as hh:mm:ss).

This makes the test cover only basic functionality that is expected to
be handled even by older tar programs.  Tests for long filenames (which
require pax extended headers) can be added separately.

I ran this test successfully with GNU tar 1.13, 1.14 and 1.15.1.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -5,17 +5,13 @@
 
 test_description='git-tar-tree and git-get-tar-commit-id test
 
-This test covers the topics of long paths, file contents, commit date
-handling and commit id embedding:
-
-  Paths longer than 100 characters require the use of a pax extended
-  header to store them.  The test creates files with pathes both longer
-  and shorter than 100 chars, and also checks symlinks with long and
-  short pathes both as their own name and as target path.
+This test covers the topics of file contents, commit date handling and
+commit id embedding:
 
   The contents of the repository is compared to the extracted tar
   archive.  The repository contains simple text files, symlinks and a
-  binary file (/bin/sh).
+  binary file (/bin/sh).  Only pathes shorter than 99 characters are
+  used.
 
   git-tar-tree applies the commit date to every file in the archive it
   creates.  The test sets the commit date to a specific value and checks
@@ -33,20 +29,10 @@
 test_expect_success \
     'populate workdir' \
     'mkdir a b c &&
-     p48=1.......10........20........30........40......48 &&
-     p50=1.......10........20........30........40........50 &&
-     p98=${p48}${p50} &&
      echo simple textfile >a/a &&
-     echo 100 chars in path >a/${p98} &&
-     echo 101 chars in path >a/${p98}x &&
-     echo 102 chars in path >a/${p98}xx &&
-     echo 103 chars in path >a/${p98}xxx &&
      mkdir a/bin &&
-     cp /bin/sh a/bin/sh &&
+     cp /bin/sh a/bin &&
      ln -s a a/l1 &&
-     ln -s ${p98}xx a/l100 &&
-     ln -s ${p98}xxx a/l101 &&
-     ln -s ${p98}xxx a/l${p98} &&
      (cd a && find .) | sort >a.lst'
 
 test_expect_success \
@@ -64,7 +50,8 @@
 
 test_expect_success \
     'validate file modification time' \
-    'tar tvf b.tar a/a | awk \{print\ \$4,\$5\} >b.mtime &&
+    'tar tvf b.tar a/a |
+     awk \{print\ \$4,\ length\(\$5\)\<7\ ?\ \$5\":00\"\ :\ \$5\} >b.mtime &&
      echo "2005-05-27 22:00:00" >expected.mtime &&
      diff expected.mtime b.mtime'
 
