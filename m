From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/7] reset: add a few tests for "git reset --merge"
Date: Sat, 12 Dec 2009 05:32:53 +0100
Message-ID: <20091212043259.3930.19134.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJdp-0000Ke-O7
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761170AbZLLEbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757214AbZLLEbG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:31:06 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36820 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756072AbZLLEau (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:30:50 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B7E0E818034;
	Sat, 12 Dec 2009 05:30:47 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6C99381805A;
	Sat, 12 Dec 2009 05:30:44 +0100 (CET)
X-git-sha1: 7552e2d60920c254b2f29ba65cce548c64244192 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135121>

Commit 9e8eceab ("Add 'merge' mode to 'git reset'", 2008-12-01),
added the --merge option to git reset, but there were no test cases
for it.

This was not a big problem because "git reset" was just forking and
execing "git read-tree", but this will change in a following patch.

So let's add a few test cases to make sure that there will be no
regression.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |   94 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
new file mode 100755
index 0000000..8190da1
--- /dev/null
+++ b/t/t7110-reset-merge.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Christian Couder
+#
+
+test_description='Tests for "git reset --merge"'
+
+. ./test-lib.sh
+
+test_expect_success 'creating initial files' '
+     echo "line 1" >> file1 &&
+     echo "line 2" >> file1 &&
+     echo "line 3" >> file1 &&
+     cp file1 file2 &&
+     git add file1 file2 &&
+     test_tick &&
+     git commit -m "Initial commit"
+'
+
+test_expect_success 'reset --merge is ok with changes in file it does not touch' '
+     echo "line 4" >> file1 &&
+     echo "line 4" >> file2 &&
+     test_tick &&
+     git commit -m "add line 4" file1 &&
+     git reset --merge HEAD^ &&
+     ! grep 4 file1 &&
+     grep 4 file2 &&
+     git reset --merge HEAD@{1} &&
+     grep 4 file1 &&
+     grep 4 file2
+'
+
+test_expect_success 'reset --merge discards changes added to index (1)' '
+     echo "line 5" >> file1 &&
+     git add file1 &&
+     git reset --merge HEAD^ &&
+     ! grep 4 file1 &&
+     ! grep 5 file1 &&
+     grep 4 file2 &&
+     echo "line 5" >> file2 &&
+     git add file2 &&
+     git reset --merge HEAD@{1} &&
+     ! grep 4 file2 &&
+     ! grep 5 file1 &&
+     grep 4 file1
+'
+
+test_expect_success 'reset --merge discards changes added to index (2)' '
+     echo "line 4" >> file2 &&
+     git add file2 &&
+     git reset --merge HEAD^ &&
+     ! grep 4 file2 &&
+     git reset --merge HEAD@{1} &&
+     ! grep 4 file2 &&
+     grep 4 file1
+'
+
+test_expect_success 'reset --merge fails with changes in file it touches' '
+     echo "line 5" >> file1 &&
+     test_tick &&
+     git commit -m "add line 5" file1 &&
+     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+     mv file3 file1 &&
+     test_must_fail git reset --merge HEAD^ 2>err.log &&
+     grep file1 err.log | grep "not uptodate" &&
+     git reset --hard HEAD^
+'
+
+test_expect_success 'setup 2 different branches' '
+     git branch branch1 &&
+     git branch branch2 &&
+     git checkout branch1 &&
+     echo "line 5 in branch1" >> file1 &&
+     test_tick &&
+     git commit -a -m "change in branch1" &&
+     git checkout branch2 &&
+     echo "line 5 in branch2" >> file1 &&
+     test_tick &&
+     git commit -a -m "change in branch2"
+'
+
+test_expect_success '"reset --merge HEAD^" fails with pending merge' '
+     test_must_fail git merge branch1 &&
+     test_must_fail git reset --merge HEAD^ &&
+     git reset --hard HEAD
+'
+
+test_expect_success '"reset --merge HEAD" fails with pending merge' '
+     test_must_fail git merge branch1 &&
+     test_must_fail git reset --merge HEAD &&
+     git reset --hard HEAD
+'
+
+test_done
-- 
1.6.6.rc1.8.gd33ec
