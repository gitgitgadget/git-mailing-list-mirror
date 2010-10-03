From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v4 2/4] Add testcases for the --detect-dir-renames diffcore flag.
Date: Sun,  3 Oct 2010 22:42:07 +0200
Message-ID: <1286138529-6780-3-git-send-email-ydirson@altern.org>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 22:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2VEh-000189-I4
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 22:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051Ab0JCUcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 16:32:35 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:32964 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab0JCUcd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 16:32:33 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 46B76D48028;
	Sun,  3 Oct 2010 22:32:27 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2VNu-0001qS-6W; Sun, 03 Oct 2010 22:42:14 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286138529-6780-2-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157921>

From: Yann Dirson <ydirson@free.fr>

This notably includes a couple of tests for cases known not to be
working correctly yet.
---
 t/t4046-diff-rename-factorize.sh |  326 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 326 insertions(+), 0 deletions(-)
 create mode 100755 t/t4046-diff-rename-factorize.sh

diff --git a/t/t4046-diff-rename-factorize.sh b/t/t4046-diff-rename-factorize.sh
new file mode 100755
index 0000000..51b0b0b
--- /dev/null
+++ b/t/t4046-diff-rename-factorize.sh
@@ -0,0 +1,326 @@
+#!/bin/sh
+#
+# Copyright (c) 2008,2010 Yann Dirson
+# Copyright (c) 2005 Junio C Hamano
+#
+
+# TODO - missing tests:
+# * two dirs or more moving all their files to a single dir
+# * simultaneous bulkmove and rename
+# * add a new file under a dir that was moved in the same commit
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
+    'git diff-index --detect-dir-renames after directory move.' \
+    'git diff-index --detect-dir-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	b/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/path2
+:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	b/path3
+EOF
+
+test_expect_success \
+    'validate the output for directory move.' \
+    'compare_diff_patch expected current.filtered'
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
+    'git diff-index --detect-dir-renames after directory move and content changes.' \
+    'git diff-index --detect-dir-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+:100644 000000 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a 0000000000000000000000000000000000000000 D	a/path3
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/2path
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 4db595d12886f90e36765fc1732c17bccb836663 R093	a/path0	b/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
+:000000 100644 0000000000000000000000000000000000000000 1ba4650885513e62386fd3e23aeb45beeb67d3bb A	b/path100
+EOF
+
+test_expect_success \
+    'validate the output for directory move and content changes.' \
+    'compare_diff_patch expected current.filtered'
+
+git reset -q --hard
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
+    'git diff-index --detect-dir-renames without full-dir rename.' \
+    'git diff-index --detect-dir-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	c/*	a/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	c/apath0	a/apath0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	c/apath1	a/apath1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	c/apath2	a/apath2
+EOF
+
+test_expect_failure \
+    'validate the output for bulk rename without full-dir rename.' \
+    'compare_diff_patch expected current.filtered'
+
+git reset -q --hard
+
+# now test moves to toplevel
+
+mv c/* .
+test_expect_success \
+    'move all of the new dir contents into toplevel.' \
+    'git update-index --add --remove apath* c/apath0 c/apath1 c/apath2'
+
+test_expect_success \
+    'git diff-index --detect-dir-renames files bulk-moved to toplevel.' \
+    'git diff-index --detect-dir-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	c/*	./
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	c/apath0	apath0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	c/apath1	apath1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	c/apath2	apath2
+EOF
+
+test_expect_failure \
+    'validate the output for files bulk-moved to toplevel.' \
+    'compare_diff_patch expected current.filtered'
+
+git reset -q --hard
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
+    'git diff-index --detect-dir-renames on a move including a subdir.' \
+    'git diff-index --detect-dir-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 00084e5ea68b5ae339b7c4b429e4a70fe25d069b R096	a/c/apath0	b/c/apath0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/c/apath1	b/c/apath1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/c/apath2	b/c/apath2
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	b/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/path2
+:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	b/path3
+EOF
+
+test_expect_failure \
+    'validate the output for a move including a subdir.' \
+    'compare_diff_patch expected current.filtered'
+
+git reset -q --hard
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
+    'git diff-index --detect-dir-renames on a move without a subdir.' \
+    'git diff-index --detect-dir-renames HEAD >current'
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
+    'compare_diff_patch expected current.filtered'
+
+git reset -q --hard
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
+    'git diff-index --detect-dir-renames on a split of subdir and files into different places.' \
+    'git diff-index --detect-dir-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/c/	b/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/c/apath0	b/apath0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/c/apath1	b/apath1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/c/apath2	b/apath2
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	d/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	d/path1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	d/path2
+:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	d/path3
+EOF
+
+test_expect_failure \
+    'validate the output for a split of subdir and files into different places.' \
+    'compare_diff_patch expected current.filtered'
+
+# now test moving a dir with no files but only subdirs
+# (only factorizes lowest-level directories - not a big deal, just not perfect)
+
+git reset -q --hard
+mkdir a/b
+mv a/path* a/b/
+test_expect_success \
+    'setup the directory with only subdirs, no direct child files.' \
+    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 a/b/path*'
+test_expect_success \
+    'commit all this.'  \
+    'git commit -m "move all toplevel files down one level"'
+
+test_expect_success \
+    'move this dir.'  \
+    'git mv a z'
+
+test_expect_success \
+    'git diff-index --detect-dir-renames with only subdirs' \
+    'git diff-index --detect-dir-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	z/
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/b/	z/b/
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/c/	z/c/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/b/path0	z/b/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/b/path1	z/b/path1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/b/path2	z/b/path2
+:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/b/path3	z/b/path3
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/c/apath0	z/c/apath0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/c/apath1	z/c/apath1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/c/apath2	z/c/apath2
+EOF
+
+test_expect_failure \
+    'validate the output for a move with only subdirs.' \
+    'compare_diff_patch expected current.filtered'
+
+# now test moving all files from toplevel into subdir (does not hides file moves) (needs consensus on syntax)
+# Note: this is a special case of move of a dir into one of its own subdirs, which in
+# turn is a variant of new files/dirs being added into a dir after all its contents
+# are moved away
+
+git reset -q --hard HEAD~3
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
+    'git diff-index --detect-dir-renames everything from toplevel.' \
+    'git diff-index --detect-dir-renames HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	./*	z/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	path0	z/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	path1	z/path1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	path2	z/path2
+:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	path3	z/path3
+EOF
+
+test_expect_failure \
+    'validate the output for a move of everything from toplevel.' \
+    'compare_diff_patch expected current.filtered'
+
+test_done
-- 
1.7.2.3
