From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v7 2/3] Add testcases for the --detect-bulk-moves diffcore flag.
Date: Sat, 23 Oct 2010 23:07:01 +0200
Message-ID: <1287868022-24872-3-git-send-email-ydirson@altern.org>
References: <1287868022-24872-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 23 23:07:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9lJf-0007Ei-UU
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 23:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab0JWVH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 17:07:28 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38817 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755053Ab0JWVHY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 17:07:24 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1C868D48062;
	Sat, 23 Oct 2010 23:07:17 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P9lJ2-00018d-0Z; Sat, 23 Oct 2010 23:07:14 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1287868022-24872-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159828>

This notably includes a couple of tests for cases known not to be
working correctly yet.

This patch has been improved by the following contributions:
- Jonathan Nieder: reworked style of test script
- Jonathan Nieder: use "git commit" in test instead of only plumbing,
  and use test_tick
- Sverre Rabbelier: anonymize hashes

Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 t/t4046-diff-rename-factorize.sh |  296 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 296 insertions(+), 0 deletions(-)
 create mode 100755 t/t4046-diff-rename-factorize.sh

diff --git a/t/t4046-diff-rename-factorize.sh b/t/t4046-diff-rename-factorize.sh
new file mode 100755
index 0000000..88e5b5b
--- /dev/null
+++ b/t/t4046-diff-rename-factorize.sh
@@ -0,0 +1,296 @@
+#!/bin/sh
+#
+# Copyright (c) 2008,2010 Yann Dirson
+# Copyright (c) 2005 Junio C Hamano
+#
+
+# TODO for dir renames:
+# * two dirs or more moving all their files to a single dir
+# * simultaneous bulkmove and rename
+
+test_description='Test rename factorization in diff engine.
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m "original empty commit"
+
+	mkdir a &&
+	printf "Line %s\n" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 >a/path0 &&
+	sed <a/path0 >a/path1 s/Line/Record/ &&
+	sed <a/path0 >a/path2 s/Line/Stuff/ &&
+	sed <a/path0 >a/path3 s/Line/Blurb/ &&
+
+	git update-index --add a/path* &&
+	test_tick &&
+	git commit -m "original set of files"
+
+	: rename the directory &&
+	git mv a b
+'
+test_expect_success 'diff-index --detect-bulk-moves after directory move.' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	a/*	b/
+	:100644 100644 X X R#	a/path0	b/path0
+	:100644 100644 X X R#	a/path1	b/path1
+	:100644 100644 X X R#	a/path2	b/path2
+	:100644 100644 X X R#	a/path3	b/path3
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup non-100% rename' '
+	echo "Line 16" >>b/path0 &&
+	git mv b/path2 b/2path &&
+	git rm -f b/path3 &&
+	echo anything >b/path100 &&
+	git add b/path100
+'
+test_expect_success 'diff-index --detect-bulk-moves after content changes.' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	a/*	b/
+	:100644 000000 X X D#	a/path3
+	:100644 100644 X X R#	a/path2	b/2path
+	:100644 100644 X X R#	a/path0	b/path0
+	:100644 100644 X X R#	a/path1	b/path1
+	:000000 100644 X X A#	b/path100
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup bulk move that is not directory move' '
+	git reset -q --hard &&
+
+	mkdir c &&
+	(
+		for i in 0 1 2; do
+			cp a/path$i c/apath$i || exit
+		done
+	) &&
+	git update-index --add c/apath* &&
+	test_tick &&
+	git commit -m "first set of changes" &&
+
+	git mv c/* a/
+'
+test_expect_success 'diff-index --detect-bulk-moves without full-dir rename.' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	c/*	a/
+	:100644 100644 X X R#	c/apath0	a/apath0
+	:100644 100644 X X R#	c/apath1	a/apath1
+	:100644 100644 X X R#	c/apath2	a/apath2
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup bulk move with new file in source dir' '
+	echo > c/anotherpath "How much wood?" &&
+	git update-index --add c/another*
+'
+test_expect_success 'diff-index --detect-bulk-moves with new file in source dir.' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	c/*	a/
+	:100644 100644 X X R#	c/apath0	a/apath0
+	:100644 100644 X X R#	c/apath1	a/apath1
+	:100644 100644 X X R#	c/apath2	a/apath2
+	:000000 100644 X X A#	c/anotherpath
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup bulk move with interfering copy' '
+	rm c/anotherpath &&
+	git update-index --remove c/anotherpath &&
+	mkdir b &&
+	cp a/apath0 b/apath9 &&
+	echo >> a/apath0 "more" &&
+	git update-index --add a/apath0 b/apath9
+'
+# scores select the "wrong" one as "moved" (only a suboptimal detection)
+test_expect_failure 'diff-index --detect-bulk-moves with interfering copy.' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	c/*	a/
+	:100644 100644 X X R#	c/apath0	a/apath0
+	:100644 100644 X X R#	c/apath1	a/apath1
+	:100644 100644 X X R#	c/apath2	a/apath2
+	:100644 100644 X X C#	c/apath0	b/apath9
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup bulk move to toplevel' '
+	git reset -q --hard &&
+	git mv c/* .
+'
+test_expect_success 'diff-index --detect-bulk-moves bulk move to toplevel.' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	c/*	./
+	:100644 100644 X X R#	c/apath0	apath0
+	:100644 100644 X X R#	c/apath1	apath1
+	:100644 100644 X X R#	c/apath2	apath2
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup move including a subdir, with some content changes' '
+	git reset -q --hard &&
+	mv c a/ &&
+	git update-index --add --remove a/c/* c/apath0 c/apath1 c/apath2 &&
+	test_tick &&
+	git commit -m "move as subdir" &&
+
+	git mv a b &&
+	echo foo >>b/c/apath0 &&
+	git update-index --add b/c/apath*
+'
+test_expect_success 'diff-index --detect-bulk-moves on a move including a subdir.' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	a/*	b/
+	:040000 040000 X X R#	a/c/*	b/c/
+	:100644 100644 X X R#	a/c/apath0	b/c/apath0
+	:100644 100644 X X R#	a/c/apath1	b/c/apath1
+	:100644 100644 X X R#	a/c/apath2	b/c/apath2
+	:100644 100644 X X R#	a/path0	b/path0
+	:100644 100644 X X R#	a/path1	b/path1
+	:100644 100644 X X R#	a/path2	b/path2
+	:100644 100644 X X R#	a/path3	b/path3
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup move of only a subdir' '
+	git reset -q --hard &&
+	git mv a/c a/d &&
+	: rename a subdirectory of a/.
+'
+test_expect_success 'moving a subdir only' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	a/c/*	a/d/
+	:100644 100644 X X R#	a/c/apath0	a/d/apath0
+	:100644 100644 X X R#	a/c/apath1	a/d/apath1
+	:100644 100644 X X R#	a/c/apath2	a/d/apath2
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup move without a subdir' '
+	git reset -q --hard &&
+	mkdir b &&
+	: rename files in the directory but not subdir. &&
+	git mv a/path* b/
+'
+test_expect_success 'moving files but not subdirs is not mistaken for dir move' '
+	cat >expected <<-EOF &&
+	:100644 100644 X X R#	a/path0	b/path0
+	:100644 100644 X X R#	a/path1	b/path1
+	:100644 100644 X X R#	a/path2	b/path2
+	:100644 100644 X X R#	a/path3	b/path3
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup move of files and subdirs to different places' '
+	git reset -q --hard &&
+	git mv a/c b &&
+	git mv a d
+'
+test_expect_success 'moving subdirs into one dir and files into another is not mistaken for dir move' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	a/c/*	b/
+	:100644 100644 X X R#	a/c/apath0	b/apath0
+	:100644 100644 X X R#	a/c/apath1	b/apath1
+	:100644 100644 X X R#	a/c/apath2	b/apath2
+	:100644 100644 X X R#	a/path0	d/path0
+	:100644 100644 X X R#	a/path1	d/path1
+	:100644 100644 X X R#	a/path2	d/path2
+	:100644 100644 X X R#	a/path3	d/path3
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+# the same with different ordering
+test_expect_success 'setup move of files and subdirs to different places' '
+	git mv d 0
+'
+test_expect_success 'moving subdirs into one dir and files into another is not mistaken for dir move' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	a/c/*	b/
+	:100644 100644 X X R#	a/path0	0/path0
+	:100644 100644 X X R#	a/path1	0/path1
+	:100644 100644 X X R#	a/path2	0/path2
+	:100644 100644 X X R#	a/path3	0/path3
+	:100644 100644 X X R#	a/c/apath0	b/apath0
+	:100644 100644 X X R#	a/c/apath1	b/apath1
+	:100644 100644 X X R#	a/c/apath2	b/apath2
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+test_expect_success 'setup move of dir with only subdirs' '
+	git reset -q --hard &&
+	mkdir a/b &&
+	mv a/path* a/b/ &&
+	git update-index --add --remove a/path0 a/path1 a/path2 a/path3 a/b/path* &&
+	test_tick &&
+	git commit -m "move all toplevel files down one level" &&
+
+	git mv a z
+'
+# TODO: only a suboptimal non-detection
+test_expect_failure 'moving a dir with no direct children files' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	a/*	z/
+	:040000 040000 X X R#	a/b/*	z/b/
+	:040000 040000 X X R#	a/c/*	z/c/
+	:100644 100644 X X R#	a/b/path0	z/b/path0
+	:100644 100644 X X R#	a/b/path1	z/b/path1
+	:100644 100644 X X R#	a/b/path2	z/b/path2
+	:100644 100644 X X R#	a/b/path3	z/b/path3
+	:100644 100644 X X R#	a/c/apath0	z/c/apath0
+	:100644 100644 X X R#	a/c/apath1	z/c/apath1
+	:100644 100644 X X R#	a/c/apath2	z/c/apath2
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+# now test moving all files from toplevel into subdir (does not hides file moves) (needs consensus on syntax)
+# Note: this is a special case of move of a dir into one of its own subdirs, which in
+# turn is a variant of new files/dirs being added into a dir after all its contents
+# are moved away
+
+test_expect_success 'setup move from toplevel to subdir' '
+	git reset -q --hard HEAD~3 &&
+	mv a/* . &&
+	git update-index --add --remove a/path0 a/path1 a/path2 a/path3 path* &&
+	test_tick &&
+	git commit -m "move all files to toplevel" &&
+
+	mkdir z &&
+	git mv path* z/
+'
+test_expect_success '--detect-bulk-moves everything from toplevel.' '
+	cat >expected <<-EOF &&
+	:040000 040000 X X R#	./*	z/
+	:100644 100644 X X R#	path0	z/path0
+	:100644 100644 X X R#	path1	z/path1
+	:100644 100644 X X R#	path2	z/path2
+	:100644 100644 X X R#	path3	z/path3
+	EOF
+	git diff-index --detect-bulk-moves HEAD >current &&
+	compare_diff_raw expected current
+'
+
+test_done
-- 
1.7.2.3
