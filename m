From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/4] reset: add test cases for "--merge-safe" option
Date: Thu, 17 Sep 2009 06:14:39 +0200
Message-ID: <20090917041440.4048.10260.chriscool@tuxfamily.org>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 06:15:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo8Oj-0001qq-6S
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 06:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbZIQEO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 00:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbZIQEO5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 00:14:57 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:41050 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbZIQEOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 00:14:55 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 372898180BC;
	Thu, 17 Sep 2009 06:14:50 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E9FA48180B5;
	Thu, 17 Sep 2009 06:14:47 +0200 (CEST)
X-git-sha1: 40d813066fef47c3ad0285666f21818927601d63 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090917040835.4048.51057.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128707>

This shows that with the "--merge-safe" option, changes that are
both in the work tree and the index are kept in the work tree after
the reset (but discarded in the index). As with the "--merge" option,
changes that are in both the work tree and the index are discarded
after the reset.

And this shows that otherwise "--merge" and "--merge-safe" have the
same behavior.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |   54 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 6211096..794a506 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2009 Christian Couder
 #
 
-test_description='Tests for "git reset --merge"'
+test_description='Tests for "git reset" with --merge and --merge-safe'
 
 . ./test-lib.sh
 
@@ -30,6 +30,20 @@ test_expect_success 'reset --merge is ok with changes in file it does not touch'
      grep 4 file2
 '
 
+test_expect_success 'reset --merge-safe is ok with changes in file it does not touch' '
+     git reset --hard HEAD^ &&
+     echo "line 4" >> file1 &&
+     echo "line 4" >> file2 &&
+     test_tick &&
+     git commit -m "add line 4" file1 &&
+     git reset --merge-safe HEAD^ &&
+     ! grep 4 file1 &&
+     grep 4 file2 &&
+     git reset --merge-safe HEAD@{1} &&
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
 
+test_expect_success 'reset --merge-safe fails with changes in index in files it touches' '
+     echo "line 4" >> file2 &&
+     echo "line 5" >> file1 &&
+     git add file1 &&
+     test_must_fail git reset --merge-safe HEAD^ &&
+     git reset --hard HEAD
+'
+
+test_expect_success 'reset --merge-safe keeps changes it does not touch' '
+     echo "line 4" >> file2 &&
+     git add file2 &&
+     git reset --merge-safe HEAD^ &&
+     grep 4 file2 &&
+     git reset --merge-safe HEAD@{1} &&
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
 
+test_expect_success 'reset --merge-safe fails with changes in file it touches' '
+     echo "line 5" >> file1 &&
+     test_tick &&
+     git commit -m "add line 5" file1 &&
+     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+     mv file3 file1 &&
+     test_must_fail git reset --merge-safe HEAD^ 2>err.log &&
+     grep file1 err.log | grep "not uptodate" &&
+     git reset --hard HEAD^
+'
+
 test_expect_success 'setup 2 different branches' '
      git branch branch1 &&
      git branch branch2 &&
@@ -87,4 +131,12 @@ test_expect_success 'reset --merge is ok with pending merge' '
      git reset --hard HEAD@{1}
 '
 
+test_expect_success 'reset --merge-safe is ok with pending merge' '
+     test_must_fail git merge branch1 &&
+     git reset --merge-safe HEAD^ &&
+     test -z "$(git diff --cached)" &&
+     test -n "$(git diff)" &&
+     git reset --hard HEAD@{1}
+'
+
 test_done
-- 
1.6.5.rc0.150.g38fe6
