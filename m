From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv5 2/3] t7512-status-help.sh: better advices for git status
Date: Thu, 31 May 2012 17:15:43 +0200
Message-ID: <1338477344-15940-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 17:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa76y-0008EY-Ub
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 17:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab2EaPQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 11:16:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49073 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932349Ab2EaPPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 11:15:47 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4VF7NJs032369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 17:07:23 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4VFFiww030281;
	Thu, 31 May 2012 17:15:44 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4VFFivq016443;
	Thu, 31 May 2012 17:15:44 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4VFFisp016442;
	Thu, 31 May 2012 17:15:44 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 17:07:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4VF7NJs032369
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339081644.27449@2E4hRQa0AHpp3svkaFSuYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198920>

The following tests include several cases in which the user needs to
run 'git status' to know his current situation, whether there're
conflicts or he's in rebase/bisect/am/ cherry-pick progress.

One of the test is about the set of the advice.statushints config key
to 'false' in .git/config.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Nguyen Huynh Khoi Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
---
 t/t7512-status-help.sh |  347 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 347 insertions(+), 0 deletions(-)
 create mode 100755 t/t7512-status-help.sh

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
new file mode 100755
index 0000000..af1d130
--- /dev/null
+++ b/t/t7512-status-help.sh
@@ -0,0 +1,347 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Valentin Duperray, Lucien Kong, Franck Jonas,
+#		     Thomas Nguy, Khoi Nguyen
+#		     Grenoble INP Ensimag
+#
+
+test_description='git status advices'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+test_expect_success 'status when conflicts unresolved' '
+	git init git &&
+	cd git &&
+	test_commit init main.txt init &&
+	git branch second_branch &&
+	test_commit on_master main.txt on_master &&
+	git checkout second_branch &&
+	test_commit on_second_branch main.txt on_second_branch &&
+	test_must_fail git merge master &&
+	cat >expect <<-\EOF &&
+	# On branch second_branch
+	# You have unmerged paths; fix conflicts and run "git commit".
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both modified:      main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when conflicts resolved before commit' '
+	echo one >main.txt &&
+	git add main.txt &&
+	cat >expect <<-\EOF &&
+	# On branch second_branch
+	# You are still merging, run "git commit" to conclude merge.
+	#
+	# Changes to be committed:
+	#
+	#	modified:   main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when rebase in progress before resolving conflicts' '
+	git commit -m "one" &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing: fix conflicts and then run "git rebase --continue".
+	#   If you would prefer to skip this patch, instead run "git rebase --skip".
+	#   To check out  the original branch and stop rebasing run "git rebase --abort".
+	#
+	# Unmerged paths:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both modified:      main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when rebase in progress before rebase --continue' '
+	test_when_finished "cd ../ && rm -rf git" &&
+	echo three >main.txt &&
+	git add main.txt &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing: all conflicts fixed: run "git rebase --continue".
+	#
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	modified:   main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when rebasing -i in edit mode' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git fake-editor.sh" &&
+	test_commit one main.txt one &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	git rebase -i HEAD~2 &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently editing a commit during a rebase.
+	#   You can amend the commit with
+	#	git commit --amend
+	#   Once you are satisfied with your changes, run
+	#	git rebase --continue
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output &&
+	git rebase --abort
+'
+
+
+test_expect_success 'status in an am session: file already exists' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit one main.txt "one  " &&
+	git format-patch -1 -oMaildir &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# You are in the middle of an am session:
+	#   When you have resolved this problem run "git am --resolved".
+	#   If you would prefer to skip this patch, instead run "git am --skip".
+	#   To restore the original branch and stop patching run "git am --abort".
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	Maildir/
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status in an am session: file does not exist' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit one main.txt "one" &&
+	git rm main.txt &&
+	git commit -m "delete main.txt" &&
+	git format-patch -1 -oMaildir &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# You are in the middle of an am session:
+	#   When you have resolved this problem run "git am --resolved".
+	#   If you would prefer to skip this patch, instead run "git am --skip".
+	#   To restore the original branch and stop patching run "git am --abort".
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	Maildir/
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status in an am session: wrong format' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit one one.txt "one" &&
+	test_commit two two.txt "two" &&
+	test_commit three three.txt "three" &&
+	git format-patch -3 -oMaildir &&
+	git rm one.txt two.txt three.txt &&
+	git commit -m "delete all" &&
+	echo error >Maildir/0002-two.patch &&
+	test_must_fail git am Maildir/*.patch &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# You are in the middle of an am session:
+	# The current patch is empty!
+	#   When you have resolved this problem run "git am --resolved".
+	#   If you would prefer to skip this patch, instead run "git am --skip".
+	#   To restore the original branch and stop patching run "git am --abort".
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	Maildir/
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when bisecting' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit one main.txt one &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	git bisect start &&
+	git bisect bad &&
+	git bisect good one &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently bisecting.
+	#   To get back to the original branch run "git bisect reset"
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when rebase conflicts with statushints disabled' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	git config --local advice.statushints false &&
+	test_commit one main.txt one &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing.
+	#
+	# Unmerged paths:
+	#	both modified:      main.txt
+	#
+	# Untracked files:
+	#	expect
+	#	output
+	no changes added to commit
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_expect_success 'status when cherry-picking before resolving conflicts' '
+	git init git &&
+	cd git &&
+	test_commit init main.txt init &&
+	git checkout -b second_branch &&
+	test_commit one main.txt one &&
+	test_commit two main.txt two &&
+	test_commit three main.txt three &&
+	git checkout master &&
+	test_must_fail git cherry-pick two &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# You are currently cherry-picking: fix conflicts and run "git commit".
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both modified:      main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'status when cherry-picking after resolving conflicts' '
+	test_when_finished "cd ../ && rm -rf git"
+	echo end >main.txt &&
+	git add main.txt &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# You are currently cherry-picking: all conflicts fixed: run "git commit".
+	#
+	# Changes to be committed:
+	#
+	#	modified:   main.txt
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	expect
+	#	output
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+
+test_done
-- 
1.7.8
