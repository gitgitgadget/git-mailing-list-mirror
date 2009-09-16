From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/4] reset: add test cases for "--merge-safe" option
Date: Wed, 16 Sep 2009 06:14:42 +0200
Message-ID: <20090916041443.3737.58488.chriscool@tuxfamily.org>
References: <20090916035131.3737.33020.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Bonzini <bonzini@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 06:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnm0Y-0007HV-0I
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 06:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbZIPEUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 00:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZIPEUe
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 00:20:34 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:54708 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbZIPEU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 00:20:29 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C90A38180D6;
	Wed, 16 Sep 2009 06:20:24 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BA9978180F2;
	Wed, 16 Sep 2009 06:20:21 +0200 (CEST)
X-git-sha1: ab576f763fab04caa44da080d838ae81871d0aad 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090916035131.3737.33020.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128603>

This shows that with the "--merge-safe" option, changes that are
both in the work tree and the index are kept in the work tree after
the reset (but discarded in the index). As with the "--merge" option,
changes that are in both the work tree and the index are discarded
after the reset.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |   50 +++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 1ec32f9..5b6db41 100755
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
@@ -55,13 +69,43 @@ test_expect_success 'reset --merge discards changes added to index (2)' '
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
-     echo "line 6" >> file1 &&
+     echo "line 5" >> file1 &&
      test_tick &&
-     git commit -m "add line 6" file1 &&
+     git commit -m "add line 5" file1 &&
      sed -e "s/line 1/changed line 1/" <file1 >file3 &&
      mv file3 file1 &&
      test_must_fail git reset --merge HEAD^ 2>err.log &&
+     grep file1 err.log | grep "not uptodate" &&
+     git reset --hard HEAD^
+'
+
+test_expect_success 'reset --merge-safe fails with changes in file it touches' '
+     echo "line 5" >> file1 &&
+     test_tick &&
+     git commit -m "add line 5" file1 &&
+     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+     mv file3 file1 &&
+     test_must_fail git reset --merge-safe HEAD^ 2>err.log &&
      grep file1 err.log | grep "not uptodate"
 '
 
-- 
1.6.5.rc0.150.g38fe6
