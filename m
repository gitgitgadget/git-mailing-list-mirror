From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v5 5/6] tests: don't set status.displayCommentPrefix file-wide
Date: Fri,  6 Sep 2013 19:43:08 +0200
Message-ID: <1378489389-25802-6-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
 <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 19:44:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI04y-0001TI-QD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030Ab3IFRoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:44:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44264 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab3IFRoO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:44:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r86HhQJ9001294
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 19:43:26 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VI048-0000bG-Qb; Fri, 06 Sep 2013 19:43:28 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VI048-0006ja-FY; Fri, 06 Sep 2013 19:43:28 +0200
X-Mailer: git-send-email 1.8.4.5.g8688bea
In-Reply-To: <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Sep 2013 19:43:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86HhQJ9001294
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379094209.02685@6iNjy0O8I0WHnczUSjW0Yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234076>

The previous commit set status.displayCommentPrefix file-wide in
t7060-wtstatus.sh, t7508-status.sh and t/t7512-status-help.sh to make the
patch small. However, now that status.displayCommentPrefix is not the
default, it is better to disable it in tests so that the most common
situation is also the most tested.

While we're there, move the "cat > expect << EOF" blocks inside the
tests.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7060-wtstatus.sh    | 113 +++----
 t/t7508-status.sh      | 889 ++++++++++++++++++++++++-------------------------
 t/t7512-status-help.sh | 604 +++++++++++++++++----------------
 3 files changed, 793 insertions(+), 813 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 5ecafac..7d467c0 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -4,10 +4,6 @@ test_description='basic work tree status reporting'
 
 . ./test-lib.sh
 
-test_expect_success 'use status.displayCommentPrefix by default ' '
-	git config --global status.displayCommentPrefix true
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
index 8d28280..d0444d3 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -7,10 +7,6 @@ test_description='git status'
 
 . ./test-lib.sh
 
-test_expect_success 'use status.displayCommentPrefix by default ' '
-	git config --global status.displayCommentPrefix true
-'
-
 test_expect_success 'status -h in broken repository' '
 	git config --global advice.statusuoption false &&
 	mkdir broken &&
@@ -157,20 +153,20 @@ test_expect_success 'commit ignores status.displayCommentPrefix=false in COMMIT_
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
+	git -c status.displayCommentPrefix=true status >output &&
 	test_i18ncmp expect output
 '
 
 test_expect_success "status (core.commentchar with two chars with submodule summary)" '
 	test_config core.commentchar ";;" &&
-	git status >output &&
+	git -c status.displayCommentPrefix=true status >output &&
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
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 312f417..0688d58 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -13,10 +13,6 @@ test_description='git status advice'
 
 set_fake_editor
 
-test_expect_success 'use status.displayCommentPrefix by default ' '
-	git config --global status.displayCommentPrefix true
-'
-
 test_expect_success 'prepare for conflicts' '
 	git config --global advice.statusuoption false &&
 	test_commit init main.txt init &&
@@ -29,18 +25,18 @@ test_expect_success 'prepare for conflicts' '
 
 test_expect_success 'status when conflicts unresolved' '
 	test_must_fail git merge master &&
-	cat >expected <<-\EOF &&
-	# On branch conflicts
-	# You have unmerged paths.
-	#   (fix conflicts and run "git commit")
-	#
-	# Unmerged paths:
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<\EOF &&
+On branch conflicts
+You have unmerged paths.
+  (fix conflicts and run "git commit")
+
+Unmerged paths:
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -51,17 +47,17 @@ test_expect_success 'status when conflicts resolved before commit' '
 	test_must_fail git merge master &&
 	echo one >main.txt &&
 	git add main.txt &&
-	cat >expected <<-\EOF &&
-	# On branch conflicts
-	# All conflicts fixed but you are still merging.
-	#   (use "git commit" to conclude merge)
-	#
-	# Changes to be committed:
-	#
-	#	modified:   main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch conflicts
+All conflicts fixed but you are still merging.
+  (use "git commit" to conclude merge)
+
+Changes to be committed:
+
+	modified:   main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -80,21 +76,21 @@ test_expect_success 'status when rebase in progress before resolving conflicts'
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
-	#   (fix conflicts and then run "git rebase --continue")
-	#   (use "git rebase --skip" to skip this patch)
-	#   (use "git rebase --abort" to check out the original branch)
-	#
-	# Unmerged paths:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
+  (fix conflicts and then run "git rebase --continue")
+  (use "git rebase --skip" to skip this patch)
+  (use "git rebase --abort" to check out the original branch)
+
+Unmerged paths:
+  (use "git reset HEAD <file>..." to unstage)
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -107,18 +103,18 @@ test_expect_success 'status when rebase in progress before rebase --continue' '
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	echo three >main.txt &&
 	git add main.txt &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
-	#   (all conflicts fixed: run "git rebase --continue")
-	#
-	# Changes to be committed:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#
-	#	modified:   main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
+  (all conflicts fixed: run "git rebase --continue")
+
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -139,21 +135,21 @@ test_expect_success 'status during rebase -i when conflicts unresolved' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
-	#   (fix conflicts and then run "git rebase --continue")
-	#   (use "git rebase --skip" to skip this patch)
-	#   (use "git rebase --abort" to check out the original branch)
-	#
-	# Unmerged paths:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
+  (fix conflicts and then run "git rebase --continue")
+  (use "git rebase --skip" to skip this patch)
+  (use "git rebase --abort" to check out the original branch)
+
+Unmerged paths:
+  (use "git reset HEAD <file>..." to unstage)
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -165,18 +161,18 @@ test_expect_success 'status during rebase -i after resolving conflicts' '
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
-	#   (all conflicts fixed: run "git rebase --continue")
-	#
-	# Changes to be committed:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#
-	#	modified:   main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
+  (all conflicts fixed: run "git rebase --continue")
+
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -193,14 +189,14 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~2) &&
 	git rebase -i HEAD~2 &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -219,19 +215,19 @@ test_expect_success 'status when splitting a commit' '
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
-	#   (Once your working directory is clean, run "git rebase --continue")
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
+  (Once your working directory is clean, run "git rebase --continue")
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -250,14 +246,14 @@ test_expect_success 'status after editing the last commit with --amend during a
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -280,14 +276,14 @@ test_expect_success 'status: (continue first edit) second edit' '
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -302,19 +298,19 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (Once your working directory is clean, run "git rebase --continue")
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (Once your working directory is clean, run "git rebase --continue")
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -329,14 +325,14 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -351,14 +347,14 @@ test_expect_success 'status: (amend first edit) second edit' '
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "a" &&
 	git rebase --continue &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -374,19 +370,19 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	git commit --amend -m "b" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (Once your working directory is clean, run "git rebase --continue")
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (Once your working directory is clean, run "git rebase --continue")
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -402,14 +398,14 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	git commit --amend -m "c" &&
 	git rebase --continue &&
 	git commit --amend -m "d" &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -426,14 +422,14 @@ test_expect_success 'status: (split first edit) second edit' '
 	git add main.txt &&
 	git commit -m "e" &&
 	git rebase --continue &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -451,19 +447,19 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	git commit --amend -m "f" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (Once your working directory is clean, run "git rebase --continue")
-	#
-	# Changes not staged for commit:
-	#   (use "git add <file>..." to update what will be committed)
-	#   (use "git checkout -- <file>..." to discard changes in working directory)
-	#
-	#	modified:   main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (Once your working directory is clean, run "git rebase --continue")
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -481,14 +477,14 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	git commit --amend -m "g" &&
 	git rebase --continue &&
 	git commit --amend -m "h" &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
-	#   (use "git commit --amend" to amend the current commit)
-	#   (use "git rebase --continue" once you are satisfied with your changes)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -508,15 +504,15 @@ test_expect_success 'status in an am session: file already exists' '
 	test_when_finished "rm Maildir/* && git am --abort" &&
 	git format-patch -1 -oMaildir &&
 	test_must_fail git am Maildir/*.patch &&
-	cat >expected <<-\EOF &&
-	# On branch am_already_exists
-	# You are in the middle of an am session.
-	#   (fix conflicts and then run "git am --continue")
-	#   (use "git am --skip" to skip this patch)
-	#   (use "git am --abort" to restore the original branch)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch am_already_exists
+You are in the middle of an am session.
+  (fix conflicts and then run "git am --continue")
+  (use "git am --skip" to skip this patch)
+  (use "git am --abort" to restore the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -530,15 +526,15 @@ test_expect_success 'status in an am session: file does not exist' '
 	test_when_finished "rm Maildir/* && git am --abort" &&
 	git format-patch -1 -oMaildir &&
 	test_must_fail git am Maildir/*.patch &&
-	cat >expected <<-\EOF &&
-	# On branch am_not_exists
-	# You are in the middle of an am session.
-	#   (fix conflicts and then run "git am --continue")
-	#   (use "git am --skip" to skip this patch)
-	#   (use "git am --abort" to restore the original branch)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch am_not_exists
+You are in the middle of an am session.
+  (fix conflicts and then run "git am --continue")
+  (use "git am --skip" to skip this patch)
+  (use "git am --abort" to restore the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -553,15 +549,15 @@ test_expect_success 'status in an am session: empty patch' '
 	git commit -m "delete all am_empty" &&
 	echo error >Maildir/0002-two_am.patch &&
 	test_must_fail git am Maildir/*.patch &&
-	cat >expected <<-\EOF &&
-	# On branch am_empty
-	# You are in the middle of an am session.
-	# The current patch is empty.
-	#   (use "git am --skip" to skip this patch)
-	#   (use "git am --abort" to restore the original branch)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch am_empty
+You are in the middle of an am session.
+The current patch is empty.
+  (use "git am --skip" to skip this patch)
+  (use "git am --abort" to restore the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -578,13 +574,13 @@ test_expect_success 'status when bisecting' '
 	git bisect bad &&
 	git bisect good one_bisect &&
 	TGT=$(git rev-parse --short two_bisect) &&
-	cat >expected <<-EOF &&
-	# HEAD detached at $TGT
-	# You are currently bisecting, started from branch '\''bisect'\''.
-	#   (use "git bisect reset" to get back to the original branch)
-	#
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<EOF &&
+HEAD detached at $TGT
+You are currently bisecting, started from branch '\''bisect'\''.
+  (use "git bisect reset" to get back to the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -601,15 +597,15 @@ test_expect_success 'status when rebase conflicts with statushints disabled' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
-	cat >expected <<-EOF &&
-	# rebase in progress; onto $ONTO
-	# You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
-	#
-	# Unmerged paths:
-	#	both modified:      main.txt
-	#
-	no changes added to commit
-	EOF
+	cat >expected <<EOF &&
+rebase in progress; onto $ONTO
+You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
+
+Unmerged paths:
+	both modified:      main.txt
+
+no changes added to commit
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -630,19 +626,19 @@ test_expect_success 'prepare for cherry-pick conflicts' '
 test_expect_success 'status when cherry-picking before resolving conflicts' '
 	test_when_finished "git cherry-pick --abort" &&
 	test_must_fail git cherry-pick cherry_branch_second &&
-	cat >expected <<-\EOF &&
-	# On branch cherry_branch
-	# You are currently cherry-picking.
-	#   (fix conflicts and run "git cherry-pick --continue")
-	#   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
-	#
-	# Unmerged paths:
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      main.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<\EOF &&
+On branch cherry_branch
+You are currently cherry-picking.
+  (fix conflicts and run "git cherry-pick --continue")
+  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
+
+Unmerged paths:
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -654,18 +650,18 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 	test_must_fail git cherry-pick cherry_branch_second &&
 	echo end >main.txt &&
 	git add main.txt &&
-	cat >expected <<-\EOF &&
-	# On branch cherry_branch
-	# You are currently cherry-picking.
-	#   (all conflicts fixed: run "git cherry-pick --continue")
-	#   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
-	#
-	# Changes to be committed:
-	#
-	#	modified:   main.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<\EOF &&
+On branch cherry_branch
+You are currently cherry-picking.
+  (all conflicts fixed: run "git cherry-pick --continue")
+  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
+
+Changes to be committed:
+
+	modified:   main.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -673,18 +669,18 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 test_expect_success 'status showing detached at and from a tag' '
 	test_commit atag tagging &&
 	git checkout atag &&
-	cat >expected <<-\EOF
-	# HEAD detached at atag
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF
+HEAD detached at atag
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual &&
 
 	git reset --hard HEAD^ &&
-	cat >expected <<-\EOF
-	# HEAD detached from atag
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF
+HEAD detached from atag
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -699,20 +695,20 @@ test_expect_success 'status while reverting commit (conflicts)' '
 	test_commit new to-revert.txt &&
 	TO_REVERT=$(git rev-parse --short HEAD^) &&
 	test_must_fail git revert $TO_REVERT &&
-	cat >expected <<-EOF
-	# On branch master
-	# You are currently reverting commit $TO_REVERT.
-	#   (fix conflicts and run "git revert --continue")
-	#   (use "git revert --abort" to cancel the revert operation)
-	#
-	# Unmerged paths:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add <file>..." to mark resolution)
-	#
-	#	both modified:      to-revert.txt
-	#
-	no changes added to commit (use "git add" and/or "git commit -a")
-	EOF
+	cat >expected <<EOF
+On branch master
+You are currently reverting commit $TO_REVERT.
+  (fix conflicts and run "git revert --continue")
+  (use "git revert --abort" to cancel the revert operation)
+
+Unmerged paths:
+  (use "git reset HEAD <file>..." to unstage)
+  (use "git add <file>..." to mark resolution)
+
+	both modified:      to-revert.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
@@ -720,29 +716,29 @@ test_expect_success 'status while reverting commit (conflicts)' '
 test_expect_success 'status while reverting commit (conflicts resolved)' '
 	echo reverted >to-revert.txt &&
 	git add to-revert.txt &&
-	cat >expected <<-EOF
-	# On branch master
-	# You are currently reverting commit $TO_REVERT.
-	#   (all conflicts fixed: run "git revert --continue")
-	#   (use "git revert --abort" to cancel the revert operation)
-	#
-	# Changes to be committed:
-	#   (use "git reset HEAD <file>..." to unstage)
-	#
-	#	modified:   to-revert.txt
-	#
-	# Untracked files not listed (use -u option to show untracked files)
-	EOF
+	cat >expected <<EOF
+On branch master
+You are currently reverting commit $TO_REVERT.
+  (all conflicts fixed: run "git revert --continue")
+  (use "git revert --abort" to cancel the revert operation)
+
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   to-revert.txt
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
 
 test_expect_success 'status after reverting commit' '
 	git revert --continue &&
-	cat >expected <<-\EOF
-	# On branch master
-	nothing to commit (use -u to show untracked files)
-	EOF
+	cat >expected <<\EOF
+On branch master
+nothing to commit (use -u to show untracked files)
+EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
-- 
1.8.4.5.g8688bea
