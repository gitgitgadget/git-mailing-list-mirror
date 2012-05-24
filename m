From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCH/RFC] t7512-status-warnings.sh : better advices for git status
Date: Thu, 24 May 2012 11:37:43 +0200
Message-ID: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 11:54:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXUkX-00079k-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 11:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab2EXJyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 05:54:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51410 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab2EXJyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 05:54:23 -0400
X-Greylist: delayed 984 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 05:54:23 EDT
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4O9Tidr027099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2012 11:29:44 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4O9bkTl025277;
	Thu, 24 May 2012 11:37:46 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4O9bkKw000508;
	Thu, 24 May 2012 11:37:46 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4O9bk4Q000507;
	Thu, 24 May 2012 11:37:46 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 May 2012 11:29:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4O9Tidr027099
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1338456588.02427@KiA1YTMIwbZmSiCs0nDAmg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198363>

Tests for the display of 'git status' before and after a conflict
resolved, and after a conflict warning during a rebase.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
---
The three following tests are supposed to be successful
but are not currently as we are not sure about the implementation.
For example, should the warning messages be in the top header of 'git status' or after that ?
If the warning messages are put as in the following tests,
we will have to code the messages in remote.c, and not in wt-status.c.

We are also working on the same kind of messages for git am and bisect.

 git/t/t7512-status-warnings.sh |   96 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100755 git/t/t7512-status-warnings.sh

diff --git a/git/t/t7512-status-warnings.sh b/git/t/t7512-status-warnings.sh
new file mode 100755
index 0000000..0214348
--- /dev/null
+++ b/git/t/t7512-status-warnings.sh
@@ -0,0 +1,96 @@
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
+test_expect_success 'status when conflicts unresolved' '
+	git init --shared --bare conflict_test.git &&
+	git clone conflict_test.git test1 &&
+	git clone conflict_test.git test2 &&
+	cd ./test1 &&
+	test_commit A main.txt toto &&
+	cd ../test2 &&
+	test_commit B main.txt tata &&
+	git push --all &&
+	cd ../test1 &&
+	test_must_fail git pull &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Your branch and '\''origin/master'\'' have diverged,
+	# and have 1 and 1 different commit each, respectively.
+	# You have unmerged paths : fix conflicts and then commit the result.
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both added:         main.txt
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
+	echo toto > main.txt &&
+	git add main.txt &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Your branch and '\''origin/master'\'' have diverged,
+	# and have 1 and 1 different commit each, respectively.
+	# You are still merging, commit to end merge.
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
+
+
+test_expect_success 'status when rebase in progress' '
+	git commit -m "one" &&
+	test_commit two main.txt tata &&
+	test_commit three main.txt titi &&
+	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	cat >expect <<-\EOF &&
+	# Not currently on any branch.
+	# You are currently rebasing : fix conflicts and then run "git rebase -- continue".
+	# If you would prefer to skip this patch, instead run "git rebase --skip".
+	# To check out  the original branch and stop rebasing run "git rebase --abort".
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
+test_done
-- 
1.7.8
