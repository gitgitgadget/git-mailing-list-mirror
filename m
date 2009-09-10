From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] reset: add test cases for "--merge-dirty" option
Date: Thu, 10 Sep 2009 22:23:32 +0200
Message-ID: <20090910202333.3722.13214.chriscool@tuxfamily.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlqC8-0001fl-8Q
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 22:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZIJUYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 16:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbZIJUYB
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 16:24:01 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49980 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977AbZIJUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 16:23:58 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E4ECB81818D;
	Thu, 10 Sep 2009 22:23:53 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D78E5818188;
	Thu, 10 Sep 2009 22:23:50 +0200 (CEST)
X-git-sha1: 38fe63c614f6a11b844d542dbe7269af0ebdf7d1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090910200334.3722.20140.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128145>

This shows that with the "--merge-dirty" option, changes that are
both in the work tree and the index are kept in the work tree after
the reset (but discarded in the index). As with the "--merge" option,
changes that are in both the work tree and the index are discarded
after the reset.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |   54 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 45714ae..1e6d634 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2009 Christian Couder
 #
 
-test_description='Tests for "git reset --merge"'
+test_description='Tests for "git reset" with --merge and --merge-dirty'
 
 exec </dev/null
 
@@ -19,7 +19,7 @@ test_expect_success 'creating initial files' '
      git commit -m "Initial commit"
 '
 
-test_expect_success 'ok with changes in file not changed by reset' '
+test_expect_success '--merge: ok if changes in file not touched by reset' '
      echo "line 4" >> file1 &&
      echo "line 4" >> file2 &&
      test_tick &&
@@ -32,7 +32,21 @@ test_expect_success 'ok with changes in file not changed by reset' '
      grep 4 file2
 '
 
-test_expect_success 'discard changes added to index 1' '
+test_expect_success '--merge-dirty: ok if changes in file untouched by reset' '
+     git reset --hard HEAD^ &&
+     echo "line 4" >> file1 &&
+     echo "line 4" >> file2 &&
+     test_tick &&
+     git commit -m "add line 4" file1 &&
+     git reset --merge-dirty HEAD^ &&
+     ! grep 4 file1 &&
+     grep 4 file2 &&
+     git reset --merge-dirty HEAD@{1} &&
+     grep 4 file1 &&
+     grep 4 file2
+'
+
+test_expect_success '--merge: discard changes added to index 1' '
      echo "line 5" >> file1 &&
      git add file1 &&
      git reset --merge HEAD^ &&
@@ -47,7 +61,7 @@ test_expect_success 'discard changes added to index 1' '
      grep 4 file1
 '
 
-test_expect_success 'discard changes added to index 2' '
+test_expect_success '--merge: discard changes added to index 2' '
      echo "line 4" >> file2 &&
      git add file2 &&
      git reset --merge HEAD^ &&
@@ -57,7 +71,37 @@ test_expect_success 'discard changes added to index 2' '
      grep 4 file1
 '
 
-test_expect_success 'not ok with changes in file changed by reset' '
+test_expect_success '--merge-dirty: not ok with touched changes in index' '
+     echo "line 4" >> file2 &&
+     echo "line 5" >> file1 &&
+     git add file1 &&
+     test_must_fail git reset --merge-dirty HEAD^ &&
+     git reset --hard HEAD
+'
+
+test_expect_success '--merge-dirty: keep untouched changes' '
+     echo "line 4" >> file2 &&
+     git add file2 &&
+     git reset --merge-dirty HEAD^ &&
+     grep 4 file2 &&
+     git reset --merge HEAD@{1} &&
+     grep 4 file2 &&
+     grep 4 file1 &&
+     git reset --hard HEAD
+'
+
+test_expect_success '--merge: not ok with changes in file changed by reset' '
+     echo "line 6" >> file1 &&
+     test_tick &&
+     git commit -m "add line 6" file1 &&
+     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+     mv file3 file1 &&
+     test_must_fail git reset --merge HEAD^ 2>err.log &&
+     grep file1 err.log | grep "not uptodate"
+'
+
+test_expect_success '--merge-dirty: not ok with changes in file changed by reset' '
+     git reset --hard HEAD^ &&
      echo "line 6" >> file1 &&
      test_tick &&
      git commit -m "add line 6" file1 &&
-- 
1.6.4.271.ge010d
