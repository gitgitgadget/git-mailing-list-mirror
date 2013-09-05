From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 5/5] tests: don't set status.oldStyle file-wide
Date: Thu,  5 Sep 2013 11:50:18 +0200
Message-ID: <1378374618-31439-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 05 11:50:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHWDA-0006iO-6V
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 11:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185Ab3IEJuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 05:50:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35591 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965115Ab3IEJuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 05:50:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r859oRZI006967
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Sep 2013 11:50:27 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VHWCr-0006W7-1k; Thu, 05 Sep 2013 11:50:29 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VHWCq-0008CZ-OM; Thu, 05 Sep 2013 11:50:28 +0200
X-Mailer: git-send-email 1.8.4.4.g70bf5e8.dirty
In-Reply-To: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Sep 2013 11:50:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r859oRZI006967
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378979432.59451@hCSqGAM1VU3gONlP52KpTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233947>

The previous commit set status.oldStyle file-wide in t7060-wtstatus.sh
and t7508-status.sh to make the patch small. However, now that
status.oldStyle is not the default, it is better to disable it in tests
so that the most common situation is also the most tested.

While we're there, move the "cat > expect << EOF" blocks inside the
tests.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7060-wtstatus.sh | 113 ++++---
 t/t7508-status.sh   | 889 ++++++++++++++++++++++++++--------------------------
 2 files changed, 493 insertions(+), 509 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index ddebd28..7d467c0 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -4,10 +4,6 @@ test_description='basic work tree status reporting'
 
 . ./test-lib.sh
 
-test_expect_success 'use status.oldStyle by default ' '
-	git config --global status.oldStyle true
-'
-
 test_expect_success setup '
 	git config --global advice.statusuoption false &&
 	test_commit A &&
@@ -33,20 +29,19 @@ test_expect_success 'Report new path with conflict' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-# On branch side
-# You have unmerged paths.
-#   (fix conflicts and run "git commit")
-#
-# Unmerged paths:
-#   (use "git add/rm <file>..." as appropriate to mark resolution)
-#
-#	deleted by us:      foo
-#
+test_expect_success 'M/D conflict does not segfault' '
+	cat >expect <<EOF &&
+On branch side
+You have unmerged paths.
+  (fix conflicts and run "git commit")
+
+Unmerged paths:
+  (use "git add/rm <file>..." as appropriate to mark resolution)
+
+	deleted by us:      foo
+
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
-
-test_expect_success 'M/D conflict does not segfault' '
 	mkdir mdconflict &&
 	(
 		cd mdconflict &&
@@ -139,19 +134,19 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
 	test_commit on_second main.txt on_second &&
 	test_commit master conflict.txt master &&
 	test_must_fail git merge second_branch &&
-	cat >expected <<-\EOF &&
-	# On branch master
-	# You have unmerged paths.
-	#   (fix conflicts and run "git commit")
-	#
-	# Unmerged paths:
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
-	#
-	#	both added:         conflict.txt
-	#	deleted by them:    main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<\EOF &&
+On branch master
+You have unmerged paths.
+  (fix conflicts and run "git commit")
+
+Unmerged paths:
+  (use "git add/rm <file>..." as appropriate to mark resolution)
+
+	both added:         conflict.txt
+	deleted by them:    main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -172,20 +167,20 @@ test_expect_success 'prepare for conflicts' '
 
 test_expect_success 'status when conflicts with add and rm advice (both deleted)' '
 	test_must_fail git merge conflict &&
-	cat >expected <<-\EOF &&
-	# On branch conflict_second
-	# You have unmerged paths.
-	#   (fix conflicts and run "git commit")
-	#
-	# Unmerged paths:
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
-	#
-	#	both deleted:       main.txt
-	#	added by them:      sub_master.txt
-	#	added by us:        sub_second.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<\EOF &&
+On branch conflict_second
+You have unmerged paths.
+  (fix conflicts and run "git commit")
+
+Unmerged paths:
+  (use "git add/rm <file>..." as appropriate to mark resolution)
+
+	both deleted:       main.txt
+	added by them:      sub_master.txt
+	added by us:        sub_second.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -196,22 +191,22 @@ test_expect_success 'status when conflicts with only rm advice (both deleted)' '
 	test_must_fail git merge conflict &&
 	git add sub_master.txt &&
 	git add sub_second.txt &&
-	cat >expected <<-\EOF &&
-	# On branch conflict_second
-	# You have unmerged paths.
-	#   (fix conflicts and run "git commit")
-	#
-	# Changes to be committed:
-	#
-	#	new file:   sub_master.txt
-	#
-	# Unmerged paths:
-	#   (use "git rm <file>..." to mark resolution)
-	#
-	#	both deleted:       main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch conflict_second
+You have unmerged paths.
+  (fix conflicts and run "git commit")
+
+Changes to be committed:
+
+	new file:   sub_master.txt
+
+Unmerged paths:
+  (use "git rm <file>..." to mark resolution)
+
+	both deleted:       main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual &&
 	git reset --hard &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 7c0873d..b3fda1b 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -7,10 +7,6 @@ test_description='git status'
 
 . ./test-lib.sh
 
-test_expect_success 'use status.oldStyle by default ' '
-	git config --global status.oldStyle true
-'
-
 test_expect_success 'status -h in broken repository' '
 	git config --global advice.statusuoption false &&
 	mkdir broken &&
@@ -157,20 +153,20 @@ test_expect_success 'commit ignores status.oldStyle=false in COMMIT_EDITMSG' '
 '
 
 cat >expect <<\EOF
-# On branch master
-# Changes to be committed:
-#	new file:   dir2/added
-#
-# Changes not staged for commit:
-#	modified:   dir1/modified
-#
-# Untracked files:
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
+On branch master
+Changes to be committed:
+	new file:   dir2/added
+
+Changes not staged for commit:
+	modified:   dir1/modified
+
+Untracked files:
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
 EOF
 
 test_expect_success 'status (advice.statusHints false)' '
@@ -228,33 +224,33 @@ test_expect_success 'status with gitignore' '
 	git status -s --ignored >output &&
 	test_cmp expect output &&
 
-	cat >expect <<-\EOF &&
-	# On branch master
-	# Changes to be committed:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#
-	#	new file:   dir2/added
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   dir1/modified
-	#
-	# Untracked files:
-	#   (use "git add <file>..." to include in what will be committed)
-	#
-	#	dir2/modified
-	# Ignored files:
-	#   (use "git add -f <file>..." to include in what will be committed)
-	#
-	#	.gitignore
-	#	dir1/untracked
-	#	dir2/untracked
-	#	expect
-	#	output
-	#	untracked
-	EOF
+	cat >expect <<\EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir2/modified
+Ignored files:
+  (use "git add -f <file>..." to include in what will be committed)
+
+	.gitignore
+	dir1/untracked
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	git status --ignored >output &&
 	test_i18ncmp expect output
 '
@@ -289,30 +285,30 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 	git status -s --ignored >output &&
 	test_cmp expect output &&
 
-	cat >expect <<-\EOF &&
-	# On branch master
-	# Changes to be committed:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#
-	#	new file:   dir2/added
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   dir1/modified
-	#
-	# Ignored files:
-	#   (use "git add -f <file>..." to include in what will be committed)
-	#
-	#	.gitignore
-	#	dir1/untracked
-	#	dir2/modified
-	#	dir2/untracked
-	#	expect
-	#	output
-	#	untracked
-	EOF
+	cat >expect <<\EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Ignored files:
+  (use "git add -f <file>..." to include in what will be committed)
+
+	.gitignore
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	git status --ignored >output &&
 	test_i18ncmp expect output
 '
@@ -353,22 +349,22 @@ test_expect_success 'setup dir3' '
 	: >dir3/untracked2
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files not listed (use -u option to show untracked files)
-EOF
 test_expect_success 'status -uno' '
+	cat >expect <<EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status -uno >output &&
 	test_i18ncmp expect output
 '
@@ -379,17 +375,17 @@ test_expect_success 'status (status.showUntrackedFiles no)' '
 	test_i18ncmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#	new file:   dir2/added
-#
-# Changes not staged for commit:
-#	modified:   dir1/modified
-#
-# Untracked files not listed
-EOF
 test_expect_success 'status -uno (advice.statusHints false)' '
+	cat >expect <<EOF &&
+On branch master
+Changes to be committed:
+	new file:   dir2/added
+
+Changes not staged for commit:
+	modified:   dir1/modified
+
+Untracked files not listed
+EOF
 	test_config advice.statusHints false &&
 	git status -uno >output &&
 	test_i18ncmp expect output
@@ -410,31 +406,31 @@ test_expect_success 'status -s (status.showUntrackedFiles no)' '
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	dir3/
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'status -unormal' '
+	cat >expect <<EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	dir3/
+	expect
+	output
+	untracked
+EOF
 	git status -unormal >output &&
 	test_i18ncmp expect output
 '
@@ -467,32 +463,32 @@ test_expect_success 'status -s (status.showUntrackedFiles normal)' '
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	dir3/untracked1
-#	dir3/untracked2
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'status -uall' '
+	cat >expect <<EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	dir3/untracked1
+	dir3/untracked2
+	expect
+	output
+	untracked
+EOF
 	git status -uall >output &&
 	test_i18ncmp expect output
 '
@@ -529,31 +525,30 @@ test_expect_success 'status -s (status.showUntrackedFiles all)' '
 	test_cmp expect output
 '
 
-cat >expect <<\EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   ../dir2/added
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	untracked
-#	../dir2/modified
-#	../dir2/untracked
-#	../expect
-#	../output
-#	../untracked
-EOF
-
 test_expect_success 'status with relative paths' '
+	cat >expect <<\EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   ../dir2/added
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	untracked
+	../dir2/modified
+	../dir2/untracked
+	../expect
+	../output
+	../untracked
+EOF
 	(cd dir1 && git status) >output &&
 	test_i18ncmp expect output
 '
@@ -600,31 +595,30 @@ test_expect_success 'setup unique colors' '
 
 '
 
-cat >expect <<\EOF
-# On branch <GREEN>master<RESET>
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	<GREEN>new file:   dir2/added<RESET>
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	<RED>modified:   dir1/modified<RESET>
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	<BLUE>dir1/untracked<RESET>
-#	<BLUE>dir2/modified<RESET>
-#	<BLUE>dir2/untracked<RESET>
-#	<BLUE>expect<RESET>
-#	<BLUE>output<RESET>
-#	<BLUE>untracked<RESET>
-EOF
-
 test_expect_success 'status with color.ui' '
+	cat >expect <<\EOF &&
+On branch <GREEN>master<RESET>
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	<GREEN>new file:   dir2/added<RESET>
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	<RED>modified:   dir1/modified<RESET>
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	<BLUE>dir1/untracked<RESET>
+	<BLUE>dir2/modified<RESET>
+	<BLUE>dir2/untracked<RESET>
+	<BLUE>expect<RESET>
+	<BLUE>output<RESET>
+	<BLUE>untracked<RESET>
+EOF
 	test_config color.ui always &&
 	git status | test_decode_color >output &&
 	test_i18ncmp expect output
@@ -728,33 +722,32 @@ test_expect_success 'status --porcelain respects -b' '
 
 '
 
-cat >expect <<\EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
 
 
 test_expect_success 'status without relative paths' '
+	cat >expect <<\EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
 
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	test_config status.relativePaths false &&
 	(cd dir1 && git status) >output &&
 	test_i18ncmp expect output
@@ -780,23 +773,23 @@ test_expect_success 'status -s without relative paths' '
 
 '
 
-cat <<EOF >expect
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'dry-run of partial commit excluding new file in index' '
+	cat >expect <<EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/
+	expect
+	output
+	untracked
+EOF
 	git commit --dry-run dir1/modified >output &&
 	test_i18ncmp expect output
 '
@@ -821,31 +814,31 @@ test_expect_success 'setup status submodule summary' '
 	git add sm
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#	new file:   sm
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'status submodule summary is disabled by default' '
+	cat >expect <<EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+	new file:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	git status >output &&
 	test_i18ncmp expect output
 '
@@ -880,36 +873,36 @@ test_expect_success 'status -s --untracked-files=all does not show submodule' '
 
 head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#	new file:   sm
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Submodule changes to be committed:
-#
-# * sm 0000000...$head (1):
-#   > Add foo
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'status submodule summary' '
+	cat >expect <<EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+	new file:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Submodule changes to be committed:
+
+* sm 0000000...$head (1):
+  > Add foo
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	git config status.submodulesummary 10 &&
 	git status >output &&
 	test_i18ncmp expect output
@@ -941,26 +934,26 @@ test_expect_success 'status -s submodule summary' '
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
+test_expect_success 'status submodule summary (clean submodule): commit' '
+	cat >expect <<EOF &&
+On branch master
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
-test_expect_success 'status submodule summary (clean submodule): commit' '
 	git commit -m "commit submodule" &&
 	git config status.submodulesummary 10 &&
 	test_must_fail git commit --dry-run >output &&
@@ -990,36 +983,36 @@ test_expect_success 'status -z implies porcelain' '
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD^1 <file>..." to unstage)
-#
-#	new file:   dir2/added
-#	new file:   sm
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Submodule changes to be committed:
-#
-# * sm 0000000...$head (1):
-#   > Add foo
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'commit --dry-run submodule summary (--amend)' '
+	cat >expect <<EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD^1 <file>..." to unstage)
+
+	new file:   dir2/added
+	new file:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Submodule changes to be committed:
+
+* sm 0000000...$head (1):
+  > Add foo
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	git config status.submodulesummary 10 &&
 	git commit --dry-run --amend >output &&
 	test_i18ncmp expect output
@@ -1044,37 +1037,36 @@ test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository'
 new_head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 touch .gitmodules
 
-cat > expect << EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	modified:   sm
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Submodule changes to be committed:
-#
-# * sm $head...$new_head (1):
-#   > Add bar
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	.gitmodules
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
-
 test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
+	cat > expect << EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Submodule changes to be committed:
+
+* sm $head...$new_head (1):
+  > Add bar
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	.gitmodules
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	echo modified  sm/untracked &&
 	git status --ignore-submodules=untracked >output &&
 	test_i18ncmp expect output
@@ -1154,39 +1146,38 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with modifie
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
-cat > expect << EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	modified:   sm
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#   (commit or discard the untracked or modified content in submodules)
-#
-#	modified:   dir1/modified
-#	modified:   sm (modified content)
-#
-# Submodule changes to be committed:
-#
-# * sm $head...$new_head (1):
-#   > Add bar
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	.gitmodules
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
-
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
+	cat > expect << EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+  (commit or discard the untracked or modified content in submodules)
+
+	modified:   dir1/modified
+	modified:   sm (modified content)
+
+Submodule changes to be committed:
+
+* sm $head...$new_head (1):
+  > Add bar
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	.gitmodules
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	git status --ignore-submodules=untracked > output &&
 	test_i18ncmp expect output
 '
@@ -1212,43 +1203,42 @@ test_expect_success ".git/config ignore=untracked doesn't suppress submodules wi
 
 head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --verify HEAD)
 
-cat > expect << EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	modified:   sm
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#	modified:   sm (new commits)
-#
-# Submodule changes to be committed:
-#
-# * sm $head...$new_head (1):
-#   > Add bar
-#
-# Submodules changed but not updated:
-#
-# * sm $new_head...$head2 (1):
-#   > 2nd commit
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	.gitmodules
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
-
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
+	cat > expect << EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+	modified:   sm (new commits)
+
+Submodule changes to be committed:
+
+* sm $head...$new_head (1):
+  > Add bar
+
+Submodules changed but not updated:
+
+* sm $new_head...$head2 (1):
+  > 2nd commit
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	.gitmodules
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+EOF
 	git status --ignore-submodules=untracked > output &&
 	test_i18ncmp expect output
 '
@@ -1333,38 +1323,37 @@ EOF
 
 test_expect_success "status (core.commentchar with submodule summary)" '
 	test_config core.commentchar ";" &&
-	git status >output &&
+	git -c status.oldStyle=true status >output &&
 	test_i18ncmp expect output
 '
 
 test_expect_success "status (core.commentchar with two chars with submodule summary)" '
 	test_config core.commentchar ";;" &&
-	git status >output &&
+	git -c status.oldStyle=true status >output &&
 	test_i18ncmp expect output
 '
 
-cat > expect << EOF
-# On branch master
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	.gitmodules
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
+test_expect_success "--ignore-submodules=all suppresses submodule summary" '
+	cat > expect << EOF &&
+On branch master
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	.gitmodules
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
-
-test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	git status --ignore-submodules=all > output &&
 	test_i18ncmp expect output
 '
-- 
1.8.4.4.g70bf5e8.dirty
