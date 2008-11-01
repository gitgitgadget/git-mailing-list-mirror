From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] Add testcases for the --factorize-renames diffcore flag.
Date: Sat, 01 Nov 2008 23:03:25 +0100
Message-ID: <20081101220325.1116.81935.stgit@gandelf.nowhere.earth>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 23:05:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwObN-0005OB-6q
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbYKAWDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 18:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbYKAWDm
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 18:03:42 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:36700 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbYKAWDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 18:03:41 -0400
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id C20CA3EA0E0
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:38 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 8C5A13EA0CE
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:38 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 7EB091F0C1
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:25 +0100 (CET)
In-Reply-To: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99781>

This notably includes a couple of tests for cases known not to be
working correctly yet.
---

 t/t4030-diff-rename-factorize.sh |  259 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 259 insertions(+), 0 deletions(-)
 create mode 100755 t/t4030-diff-rename-factorize.sh

diff --git a/t/t4030-diff-rename-factorize.sh b/t/t4030-diff-rename-factorize.sh
new file mode 100755
index 0000000..302a7ab
--- /dev/null
+++ b/t/t4030-diff-rename-factorize.sh
@@ -0,0 +1,259 @@
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
+    'commit the index.'  \
+    'git update-ref HEAD $(echo "original set of files" | git commit-tree $(git write-tree))'
+
+mv a b
+test_expect_success \
+    'renamed the directory.' \
+    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 b/path*'
+
+test_expect_success \
+    'git diff-index --factorize-renames after directory move.' \
+    'git diff-index --factorize-renames HEAD >current'
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
+    'git diff-index --factorize-renames HEAD >current'
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
+# now test moves to toplevel
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
+# now test renaming with subdirs (does not take subdirs into account)
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
+git reset --hard
+
+# now check that moving all files but not subdirs is not mistaken for dir move
+
+mkdir b
+mv a/path* b/
+test_expect_success \
+    'rename files in the directory but not subdir.' \
+    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 b/path*'
+
+test_expect_success \
+    'git diff-index --factorize-renames on a move without a subdir.' \
+    'git diff-index --factorize-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	b/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/path2
+:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	b/path3
+EOF
+
+test_expect_success \
+    'validate the output for a move without a subdir.' \
+    'compare_diff_patch current.filtered expected'
+
+git reset --hard
+
+# now check that moving subdirs into one dir and files into another is not mistaken for dir move
+# (well, clearly it is ...)
+
+mv a/c b
+mv a d
+test_expect_success \
+    'rename subdir and files into different places.' \
+    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 a/c/apath0 a/c/apath1 a/c/apath2 d/path* b/apath*'
+
+test_expect_success \
+    'git diff-index --factorize-renames on a split of subdir and files into different places.' \
+    'git diff-index --factorize-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	d/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	d/path1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	d/path2
+:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	d/path3
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/c/	b/
+EOF
+
+test_expect_failure \
+    'validate the output for a split of subdir and files into different places.' \
+    'compare_diff_patch current.filtered expected'
+
+# now test moving all files from toplevel into subdir (does not hides file moves) (needs consensus on syntax)
+# Note: this is as special case of move of a dir into one of its own subdirs, which in
+# turn is a special case of new files/dirs being added into a dir after all its contents
+# are moved away
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
