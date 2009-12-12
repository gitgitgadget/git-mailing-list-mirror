From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 5/7] reset: add test cases for "--keep" option
Date: Sat, 12 Dec 2009 05:32:56 +0100
Message-ID: <20091212043259.3930.62225.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sat Dec 12 05:31:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJdo-0000Ke-NL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761047AbZLLEbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757018AbZLLEbJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:31:09 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36866 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757092AbZLLEax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:30:53 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1D093818070;
	Sat, 12 Dec 2009 05:30:48 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C3EAD818044;
	Sat, 12 Dec 2009 05:30:45 +0100 (CET)
X-git-sha1: 5d52d9b2fa82d57315e41c9d1cc946a660f6cf11 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135122>

This shows that with the "--keep" option, changes that are both in
the work tree and the index are kept in the work tree after the
reset (but discarded in the index). As with the "--merge" option,
changes that are in both the work tree and the index are discarded
after the reset.

In the case of unmerged entries, we can see that
"git reset --merge HEAD" is disallowed while it works using
"--keep" instead.

And this shows that otherwise "--merge" and "--keep" have the same
behavior.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 6afaf73..bd2ef94 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2009 Christian Couder
 #
 
-test_description='Tests for "git reset --merge"'
+test_description='Tests for "git reset" with --merge and --keep'
 
 . ./test-lib.sh
 
@@ -30,6 +30,20 @@ test_expect_success 'reset --merge is ok with changes in file it does not touch'
      grep 4 file2
 '
 
+test_expect_success 'reset --keep is ok with changes in file it does not touch' '
+     git reset --hard HEAD^ &&
+     echo "line 4" >> file1 &&
+     echo "line 4" >> file2 &&
+     test_tick &&
+     git commit -m "add line 4" file1 &&
+     git reset --keep HEAD^ &&
+     ! grep 4 file1 &&
+     grep 4 file2 &&
+     git reset --keep HEAD@{1} &&
+     grep 4 file1 &&
+     grep 4 file2
+'
+
 test_expect_success 'reset --merge discards changes added to index (1)' '
      echo "line 5" >> file1 &&
      git add file1 &&
@@ -55,6 +69,25 @@ test_expect_success 'reset --merge discards changes added to index (2)' '
      grep 4 file1
 '
 
+test_expect_success 'reset --keep fails with changes in index in files it touches' '
+     echo "line 4" >> file2 &&
+     echo "line 5" >> file1 &&
+     git add file1 &&
+     test_must_fail git reset --keep HEAD^ &&
+     git reset --hard HEAD
+'
+
+test_expect_success 'reset --keep keeps changes it does not touch' '
+     echo "line 4" >> file2 &&
+     git add file2 &&
+     git reset --keep HEAD^ &&
+     grep 4 file2 &&
+     git reset --keep HEAD@{1} &&
+     grep 4 file2 &&
+     grep 4 file1 &&
+     git reset --hard HEAD
+'
+
 test_expect_success 'reset --merge fails with changes in file it touches' '
      echo "line 5" >> file1 &&
      test_tick &&
@@ -66,6 +99,17 @@ test_expect_success 'reset --merge fails with changes in file it touches' '
      git reset --hard HEAD^
 '
 
+test_expect_success 'reset --keep fails with changes in file it touches' '
+     echo "line 5" >> file1 &&
+     test_tick &&
+     git commit -m "add line 5" file1 &&
+     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+     mv file3 file1 &&
+     test_must_fail git reset --keep HEAD^ 2>err.log &&
+     grep file1 err.log | grep "not uptodate" &&
+     git reset --hard HEAD^
+'
+
 test_expect_success 'setup 2 different branches' '
      git branch branch1 &&
      git branch branch2 &&
@@ -87,10 +131,26 @@ test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
      git reset --hard HEAD@{1}
 '
 
+test_expect_success '"reset --keep HEAD^" is ok with pending merge' '
+     test_must_fail git merge branch1 &&
+     git reset --keep HEAD^ &&
+     test -z "$(git diff --cached)" &&
+     test -n "$(git diff)" &&
+     git reset --hard HEAD@{1}
+'
+
 test_expect_success '"reset --merge HEAD" fails with pending merge' '
      test_must_fail git merge branch1 &&
      test_must_fail git reset --merge HEAD &&
      git reset --hard HEAD
 '
 
+test_expect_success '"reset --keep HEAD" is ok with pending merge' '
+     test_must_fail git merge branch1 &&
+     git reset --keep HEAD &&
+     test -z "$(git diff --cached)" &&
+     test -n "$(git diff)" &&
+     git reset --hard HEAD
+'
+
 test_done
-- 
1.6.6.rc1.8.gd33ec
