From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 12/15] t7508: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:11 +0100
Message-ID: <b067bae5607f94705b4e12a1911bebc48ebb96f3.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:07:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJs8b-0007x5-Nh
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab3CXVHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:07:01 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:52442 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab3CXVHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:07:00 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1E35F94025A;
	Sun, 24 Mar 2013 22:06:50 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6n0k007311;
	Sun, 24 Mar 2013 22:06:49 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6neX007310;
	Sun, 24 Mar 2013 22:06:49 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218985>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t7508-status.sh | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index aecb4d1..e2ffdac 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -131,8 +131,7 @@ cat >expect <<\EOF
 EOF
 
 test_expect_success 'status (advice.statusHints false)' '
-	test_when_finished "git config --unset advice.statusHints" &&
-	git config advice.statusHints false &&
+	test_config advice.statusHints false &&
 	git status >output &&
 	test_i18ncmp expect output
 
@@ -332,8 +331,7 @@ test_expect_success 'status -uno' '
 '
 
 test_expect_success 'status (status.showUntrackedFiles no)' '
-	git config status.showuntrackedfiles no
-	test_when_finished "git config --unset status.showuntrackedfiles" &&
+	test_config status.showuntrackedfiles no &&
 	git status >output &&
 	test_i18ncmp expect output
 '
@@ -348,12 +346,11 @@ cat >expect <<EOF
 #
 # Untracked files not listed
 EOF
-git config advice.statusHints false
 test_expect_success 'status -uno (advice.statusHints false)' '
+	test_config advice.statusHints false &&
 	git status -uno >output &&
 	test_i18ncmp expect output
 '
-git config --unset advice.statusHints
 
 cat >expect << EOF
  M dir1/modified
@@ -400,8 +397,7 @@ test_expect_success 'status -unormal' '
 '
 
 test_expect_success 'status (status.showUntrackedFiles normal)' '
-	git config status.showuntrackedfiles normal
-	test_when_finished "git config --unset status.showuntrackedfiles" &&
+	test_config status.showuntrackedfiles normal
 	git status >output &&
 	test_i18ncmp expect output
 '
@@ -459,8 +455,7 @@ test_expect_success 'status -uall' '
 '
 
 test_expect_success 'status (status.showUntrackedFiles all)' '
-	git config status.showuntrackedfiles all
-	test_when_finished "git config --unset status.showuntrackedfiles" &&
+	test_config status.showuntrackedfiles all
 	git status >output &&
 	test_i18ncmp expect output
 '
@@ -485,10 +480,9 @@ test_expect_success 'status -s -uall' '
 	test_cmp expect output
 '
 test_expect_success 'status -s (status.showUntrackedFiles all)' '
-	git config status.showuntrackedfiles all
+	test_config status.showuntrackedfiles all &&
 	git status -s >output &&
 	rm -rf dir3 &&
-	git config --unset status.showuntrackedfiles &&
 	test_cmp expect output
 '
 
@@ -588,15 +582,13 @@ cat >expect <<\EOF
 EOF
 
 test_expect_success 'status with color.ui' '
-	git config color.ui always &&
-	test_when_finished "git config --unset color.ui" &&
+	test_config color.ui always &&
 	git status | test_decode_color >output &&
 	test_i18ncmp expect output
 '
 
 test_expect_success 'status with color.status' '
-	git config color.status always &&
-	test_when_finished "git config --unset color.status" &&
+	test_config color.status always &&
 	git status | test_decode_color >output &&
 	test_i18ncmp expect output
 '
@@ -720,8 +712,7 @@ EOF
 
 test_expect_success 'status without relative paths' '
 
-	git config status.relativePaths false &&
-	test_when_finished "git config --unset status.relativePaths" &&
+	test_config status.relativePaths false &&
 	(cd dir1 && git status) >output &&
 	test_i18ncmp expect output
 
@@ -740,8 +731,7 @@ EOF
 
 test_expect_success 'status -s without relative paths' '
 
-	git config status.relativePaths false &&
-	test_when_finished "git config --unset status.relativePaths" &&
+	test_config status.relativePaths false &&
 	(cd dir1 && git status -s) >output &&
 	test_cmp expect output
 
@@ -1038,15 +1028,14 @@ test_expect_success '--ignore-submodules=untracked suppresses submodules with un
 '
 
 test_expect_success '.gitmodules ignore=untracked suppresses submodules with untracked content' '
-	git config diff.ignoreSubmodules dirty &&
+	test_config diff.ignoreSubmodules dirty &&
 	git status >output &&
 	test_i18ncmp expect output &&
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
 	test_i18ncmp expect output &&
-	git config -f .gitmodules  --remove-section submodule.subname &&
-	git config --unset diff.ignoreSubmodules
+	git config -f .gitmodules  --remove-section submodule.subname
 '
 
 test_expect_success '.git/config ignore=untracked suppresses submodules with untracked content' '
@@ -1066,15 +1055,14 @@ test_expect_success '--ignore-submodules=dirty suppresses submodules with untrac
 '
 
 test_expect_success '.gitmodules ignore=dirty suppresses submodules with untracked content' '
-	git config diff.ignoreSubmodules dirty &&
+	test_config diff.ignoreSubmodules dirty &&
 	git status >output &&
 	! test -s actual &&
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
 	test_i18ncmp expect output &&
-	git config -f .gitmodules  --remove-section submodule.subname &&
-	git config --unset diff.ignoreSubmodules
+	git config -f .gitmodules  --remove-section submodule.subname
 '
 
 test_expect_success '.git/config ignore=dirty suppresses submodules with untracked content' '
@@ -1291,15 +1279,13 @@ cat > expect << EOF
 EOF
 
 test_expect_success "status (core.commentchar with submodule summary)" '
-	test_when_finished "git config --unset core.commentchar" &&
-	git config core.commentchar ";" &&
+	test_config core.commentchar ";" &&
 	git status >output &&
 	test_i18ncmp expect output
 '
 
 test_expect_success "status (core.commentchar with two chars with submodule summary)" '
-	test_when_finished "git config --unset core.commentchar" &&
-	git config core.commentchar ";;" &&
+	test_config core.commentchar ";;" &&
 	git status >output &&
 	test_i18ncmp expect output
 '
-- 
1.7.11.7
