From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/6] reset: add test cases for "--keep-local-changes" option
Date: Tue, 08 Dec 2009 08:56:13 +0100
Message-ID: <20091208075616.4475.28704.chriscool@tuxfamily.org>
References: <20091208075005.4475.26582.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 09:05:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHv4O-00014T-RP
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 09:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbZLHIEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 03:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755911AbZLHIEv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 03:04:51 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38863 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919AbZLHIEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 03:04:45 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 69172818150;
	Tue,  8 Dec 2009 09:04:41 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4CBE18180AC;
	Tue,  8 Dec 2009 09:04:39 +0100 (CET)
X-git-sha1: c64e814583b2a01911f7a90c171474ea51b22a42 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091208075005.4475.26582.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134841>

This shows that with the "--keep-local-changes" option, changes that
are both in the work tree and the index are kept in the work tree
after the reset (but discarded in the index). As with the "--merge"
option, changes that are in both the work tree and the index are
discarded after the reset.

In the case of unmerged entries, we can see that
"git reset --merge HEAD" is disallowed while it works using
"--keep-local-changes" instead.

And this shows that otherwise "--merge" and "--keep-local-changes"
have the same behavior.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 6afaf73..c8f72cd 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2009 Christian Couder
 #
 
-test_description='Tests for "git reset --merge"'
+test_description='Tests for "git reset" with --merge and --keep-local-changes'
 
 . ./test-lib.sh
 
@@ -30,6 +30,20 @@ test_expect_success 'reset --merge is ok with changes in file it does not touch'
      grep 4 file2
 '
 
+test_expect_success 'reset --keep-local-changes is ok with changes in file it does not touch' '
+     git reset --hard HEAD^ &&
+     echo "line 4" >> file1 &&
+     echo "line 4" >> file2 &&
+     test_tick &&
+     git commit -m "add line 4" file1 &&
+     git reset --keep-local-changes HEAD^ &&
+     ! grep 4 file1 &&
+     grep 4 file2 &&
+     git reset --keep-local-changes HEAD@{1} &&
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
 
+test_expect_success 'reset --keep-local-changes fails with changes in index in files it touches' '
+     echo "line 4" >> file2 &&
+     echo "line 5" >> file1 &&
+     git add file1 &&
+     test_must_fail git reset --keep-local-changes HEAD^ &&
+     git reset --hard HEAD
+'
+
+test_expect_success 'reset --keep-local-changes keeps changes it does not touch' '
+     echo "line 4" >> file2 &&
+     git add file2 &&
+     git reset --keep-local-changes HEAD^ &&
+     grep 4 file2 &&
+     git reset --keep-local-changes HEAD@{1} &&
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
 
+test_expect_success 'reset --keep-local-changes fails with changes in file it touches' '
+     echo "line 5" >> file1 &&
+     test_tick &&
+     git commit -m "add line 5" file1 &&
+     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+     mv file3 file1 &&
+     test_must_fail git reset --keep-local-changes HEAD^ 2>err.log &&
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
 
+test_expect_success '"reset --keep-local-changes HEAD^" is ok with pending merge' '
+     test_must_fail git merge branch1 &&
+     git reset --keep-local-changes HEAD^ &&
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
 
+test_expect_success '"reset --keep-local-changes HEAD" is ok with pending merge' '
+     test_must_fail git merge branch1 &&
+     git reset --keep-local-changes HEAD &&
+     test -z "$(git diff --cached)" &&
+     test -n "$(git diff)" &&
+     git reset --hard HEAD
+'
+
 test_done
-- 
1.6.5.1.gaf97d
