From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Add testcases for the --factorize-renames diffcore flag.
Date: Thu, 30 Oct 2008 23:16:51 +0100
Message-ID: <20081030221651.3325.79397.stgit@gandelf.nowhere.earth>
References: <20081030220532.3325.54457.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 23:18:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvfqY-0002ff-KD
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 23:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706AbYJ3WRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 18:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758675AbYJ3WRK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 18:17:10 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:46356 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757529AbYJ3WRG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 18:17:06 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id ABC291976B
	for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:17:04 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 6A87819749
	for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:17:03 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 75FED1F0C2
	for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:16:51 +0100 (CET)
In-Reply-To: <20081030220532.3325.54457.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99527>

This notably includes a couple of tests for cases known not to be
working correctly yet.
---

 t/t4030-diff-rename-factorize.sh |  209 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 209 insertions(+), 0 deletions(-)
 create mode 100755 t/t4030-diff-rename-factorize.sh

diff --git a/t/t4030-diff-rename-factorize.sh b/t/t4030-diff-rename-factorize.sh
new file mode 100755
index 0000000..fcf8fb6
--- /dev/null
+++ b/t/t4030-diff-rename-factorize.sh
@@ -0,0 +1,209 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Yann Dirson
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Test rename factorization in diff engine.
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+test_expect_success \
+    'commit the index.'  \
+    'git update-ref HEAD $(echo "original empty commit" | git commit-tree $(git write-tree))'
+
+mkdir a
+echo >a/path0 'Line 1
+Line 2
+Line 3
+Line 4
+Line 5
+Line 6
+Line 7
+Line 8
+Line 9
+Line 10
+line 11
+Line 12
+Line 13
+Line 14
+Line 15
+'
+sed <a/path0 >a/path1 s/Line/Record/
+sed <a/path0 >a/path2 s/Line/Stuff/
+sed <a/path0 >a/path3 s/Line/Blurb/
+
+test_expect_success \
+    'update-index --add file inside a directory.' \
+    'git update-index --add a/path*'
+
+test_expect_success \
+    'write that tree.' \
+    'tree=$(git write-tree) && test -n "$tree"'
+
+test_expect_success \
+    'commit the index.'  \
+    'git update-ref HEAD $(echo "original set of files" | git commit-tree $tree)'
+
+mv a b
+test_expect_success \
+    'renamed the directory.' \
+    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 b/path*'
+
+test_expect_success \
+    'git diff-index --factorize-renames after directory move.' \
+    'git diff-index --factorize-renames $tree >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+EOF
+
+test_expect_success \
+    'validate the output for directory move.' \
+    'compare_diff_patch current.filtered expected'
+
+# now test non-100% renames
+
+echo 'Line 16' >> b/path0
+mv b/path2 b/2path
+rm b/path3
+echo anything > b/path100
+test_expect_success \
+    'edited dir contents.' \
+    'git update-index --add --remove b/* b/path2 b/path3'
+
+test_expect_success \
+    'git diff-index --factorize-renames after directory move and content changes.' \
+    'git diff-index --factorize-renames $tree >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+:100644 000000 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a 0000000000000000000000000000000000000000 D	a/path3
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/2path
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 4db595d12886f90e36765fc1732c17bccb836663 R093	a/path0	b/path0
+:000000 100644 0000000000000000000000000000000000000000 1ba4650885513e62386fd3e23aeb45beeb67d3bb A	b/path100
+EOF
+
+test_expect_success \
+    'validate the output for directory move and content changes.' \
+    'compare_diff_patch current.filtered expected'
+
+git reset --hard
+
+# now test bulk moves that are not directory moves (get consensus before going further ?)
+
+mkdir c
+for i in 0 1 2; do cp a/path$i c/apath$i; done
+test_expect_success \
+    'add files into a new directory.' \
+    'git update-index --add c/apath*'
+
+test_expect_success \
+    'commit all this.'  \
+    'git commit -m "first set of changes"'
+
+mv c/* a/
+test_expect_success \
+    'move all of the new dir contents into a preexisting dir.' \
+    'git update-index --add --remove a/* c/apath0 c/apath1 c/apath2'
+
+test_expect_success \
+    'git diff-index --factorize-renames without full-dir rename.' \
+    'git diff-index --factorize-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	c/*	a/
+EOF
+
+test_expect_failure \
+    'validate the output for bulk rename without full-dir rename.' \
+    'compare_diff_patch current.filtered expected'
+
+git reset --hard
+
+# now test moves to toplevel (seriously broken)
+
+mv c/* .
+test_expect_success \
+    'move all of the new dir contents into toplevel.' \
+    'git update-index --add --remove apath* c/apath0 c/apath1 c/apath2'
+
+test_expect_success \
+    'git diff-index --factorize-renames files bulk-moved to toplevel.' \
+    'git diff-index --factorize-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	c/*	./
+EOF
+
+test_expect_failure \
+    'validate the output for files bulk-moved to toplevel.' \
+    'compare_diff_patch current.filtered expected'
+
+git reset --hard
+
+# now test renaming with subdirs (lacks hiding of renamed subdirs)
+
+mv c a/
+test_expect_success \
+    'move the new dir as subdir of another.' \
+    'git update-index --add --remove a/c/* c/apath0 c/apath1 c/apath2'
+
+test_expect_success \
+    'commit all this.'  \
+    'git commit -m "move as subdir"'
+
+mv a b
+echo foo >> b/c/apath0
+test_expect_success \
+    'rename the directory with some changes.' \
+    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 a/c/apath0 a/c/apath1 a/c/apath2 b/path* b/c/apath*'
+
+test_expect_success \
+    'git diff-index --factorize-renames on a move including a subdir.' \
+    'git diff-index --factorize-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 00084e5ea68b5ae339b7c4b429e4a70fe25d069b R096	a/c/apath0	b/c/apath0
+EOF
+
+test_expect_failure \
+    'validate the output for a move including a subdir.' \
+    'compare_diff_patch current.filtered expected'
+
+# now test moving all files from toplevel into subdir (does not hides file moves) (needs consensus on syntax)
+#FIXME: maybe handle this as special case of move of a dir into one of its own subdirs ?
+
+git reset --hard HEAD~2
+
+mv a/* .
+test_expect_success \
+    'rename the directory with some changes.' \
+    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 path*'
+
+test_expect_success \
+    'commit all this.'  \
+    'git commit -m "move all files to toplevel"'
+
+mkdir z
+mv path* z/
+test_expect_success \
+    'rename the directory with some changes.' \
+    'git update-index --add --remove path0 path1 path2 path3 z/path*'
+
+test_expect_success \
+    'git diff-index --factorize-renames everything from toplevel.' \
+    'git diff-index --factorize-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	./*	z/
+EOF
+
+test_expect_failure \
+    'validate the output for a move of everything from toplevel.' \
+    'compare_diff_patch current.filtered expected'
+
+test_done
