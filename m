From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv4 3/3] Advices about 'git rm' during conflicts (unmerged paths) more relevant
Date: Wed, 30 May 2012 15:23:36 +0200
Message-ID: <1338384216-18782-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 16:37:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZk1q-0007Bl-Pv
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 16:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab2E3OeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 10:34:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54825 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648Ab2E3Od7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 10:33:59 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4UDFKGs027846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 15:15:20 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4UDNbbR012292;
	Wed, 30 May 2012 15:23:37 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4UDNbOS019031;
	Wed, 30 May 2012 15:23:37 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4UDNbgx019030;
	Wed, 30 May 2012 15:23:37 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 May 2012 15:15:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4UDFKGs027846
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1338988520.95408@8fiAic+zHRo6e0eXBy/8Pg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198809>

The display of the advice '(use git add/rm [...])' (when
there are unmerged files) after running 'git status' is
now depending of the mark, whether it's 'both deleted',
'deleted by us/them' or others. For instance, when there is
just one file that's marked as 'both deleted', 'git status'
shows '(use git rm [...])' and if there are two files, one
as 'both deleted' and the other as 'added by them', the advice
is '(use git add/rm [...])'.

The previous tests in t7512-status-warnings.sh are updated and
5 tests are added about the different cases of unmerged paths.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Nguyen Huynh Khoi Nguyen Lucien <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
---
 t/t7512-status-warnings.sh |  165 ++++++++++++++++++++++++++++++++++++++++++-
 wt-status.c                |   29 ++++++++-
 2 files changed, 189 insertions(+), 5 deletions(-)

diff --git a/t/t7512-status-warnings.sh b/t/t7512-status-warnings.sh
index 2806fe8..01d614c 100755
--- a/t/t7512-status-warnings.sh
+++ b/t/t7512-status-warnings.sh
@@ -27,7 +27,7 @@ test_expect_success 'status when conflicts unresolved' '
 	# You have unmerged paths; fix conflicts and run "git commit".
 	#
 	# Unmerged paths:
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." as appropriate to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -78,7 +78,7 @@ test_expect_success 'status when rebase in progress before resolving conflicts'
 	#
 	# Unmerged paths:
 	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." as appropriate to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -280,7 +280,7 @@ test_expect_success 'status when rebase conflicts with statushelp disabled' '
 	#
 	# Unmerged paths:
 	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." as appropriate to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -311,7 +311,7 @@ test_expect_success 'status when cherry-picking before resolving conflicts' '
 	# You are currently cherry-picking: fix conflicts and run "git commit".
 	#
 	# Unmerged paths:
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." as appropriate to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -349,4 +349,161 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 '
 
 
+test_expect_success 'status when conflicts without rm advice (both modified)' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
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
+	#   (use "git add <file>..." as appropriate to mark resolution)
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
+test_expect_success 'status when conflicts with add and rm advice (deleted by us)' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit init main.txt init &&
+	git branch second_branch &&
+	test_commit on_master main.txt on_master &&
+	git checkout second_branch &&
+	git rm main.txt &&
+	git commit -m "main.txt deleted on second_branch" &&
+	test_must_fail git merge master &&
+	cat >expect <<-\EOF &&
+	# On branch second_branch
+	# You have unmerged paths; fix conflicts and run "git commit".
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	deleted by us:      main.txt
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
+test_expect_success 'status when conflicts with add and rm advice (deleted by them)' '
+	git init git &&
+	cd git &&
+	test_when_finished "cd ../ && rm -rf git" &&
+	test_commit init main.txt init &&
+	git branch second_branch &&
+	git rm main.txt &&
+	git commit -m "main.txt deleted on master" &&
+	git checkout second_branch &&
+	test_commit on_second main.txt on_second &&
+	test_must_fail git merge master &&
+	cat >expect <<-\EOF &&
+	# On branch second_branch
+	# You have unmerged paths; fix conflicts and run "git commit".
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	deleted by them:    main.txt
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
+test_expect_success 'status when conflicts with add and rm advice (both deleted)' '
+	git init git &&
+	cd git &&
+	test_commit init main.txt init &&
+	git branch second_branch &&
+	git mv main.txt sub_master.txt &&
+	git commit -m "main.txt renamed in sub_master.txt" &&
+	git checkout second_branch &&
+	git mv main.txt sub_second.txt &&
+	git commit -m "main.txt renamed in sub_second.txt" &&
+	test_must_fail git merge master &&
+	cat >expect <<-\EOF &&
+	# On branch second_branch
+	# You have unmerged paths; fix conflicts and run "git commit".
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both deleted:       main.txt
+	#	added by them:      sub_master.txt
+	#	added by us:        sub_second.txt
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
+test_expect_success 'status when conflicts with only rm advice (both deleted)' '
+	test_when_finished "cd ../ && rm -rf git" &&
+	git add sub_master.txt &&
+	git add sub_second.txt &&
+	cat >expect <<-\EOF &&
+	# On branch second_branch
+	# You have unmerged paths; fix conflicts and run "git commit".
+	#
+	# Changes to be committed:
+	#
+	#	new file:   sub_master.txt
+	#
+	# Unmerged paths:
+	#   (use "git rm <file>..." as appropriate to mark resolution)
+	#
+	#	both deleted:       main.txt
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
 test_done
diff --git a/wt-status.c b/wt-status.c
index 4dd294f..9d79f2b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -131,9 +131,27 @@ void wt_status_prepare(struct wt_status *s)
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
 {
+	int i;
+	int simple_deleted_flag = 0;
+	int both_deleted_flag = 0;
+	int not_deleted_flag = 0;
 	const char *c = color(WT_STATUS_HEADER, s);
 
 	status_printf_ln(s, c, _("Unmerged paths:"));
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct string_list_item *it = &(s->change.items[i]);
+		struct wt_status_change_data *d = it->util;
+
+		if (d->stagemask == 1 && !both_deleted_flag)
+			both_deleted_flag = 1;
+		else if ((d->stagemask == 3 || d->stagemask == 5) && !simple_deleted_flag)
+			simple_deleted_flag = 1;
+		else if ((d->stagemask == 2 || d->stagemask == 4 || d->stagemask == 6 ||
+				d->stagemask == 7) && !not_deleted_flag)
+			not_deleted_flag = 1;
+	}
+
 	if (!advice_status_hints)
 		return;
 	if (s->whence != FROM_COMMIT)
@@ -142,7 +160,16 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
-	status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
+
+	if (!both_deleted_flag)
+		if (!simple_deleted_flag)
+			status_printf_ln(s, c, _("  (use \"git add <file>...\" as appropriate to mark resolution)"));
+		else
+			status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
+	else if (!simple_deleted_flag && !not_deleted_flag)
+		status_printf_ln(s, c, _("  (use \"git rm <file>...\" as appropriate to mark resolution)"));
+	else
+		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	status_printf_ln(s, c, "");
 }
 
-- 
1.7.8
