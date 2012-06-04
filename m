From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv7 3/4] status: don't suggest "git rm" or "git add" if not appropriate
Date: Mon,  4 Jun 2012 19:19:58 +0200
Message-ID: <1338830399-31504-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 19:20:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbawu-0008Ia-J2
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106Ab2FDRUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:20:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45268 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab2FDRUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:20:04 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q54HBJGs016443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 19:11:19 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q54HK0NM014341;
	Mon, 4 Jun 2012 19:20:00 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q54HK00I031625;
	Mon, 4 Jun 2012 19:20:00 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q54HK04J031624;
	Mon, 4 Jun 2012 19:20:00 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jun 2012 19:11:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54HBJGs016443
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339434681.63281@fH5hH0OhLPNjA9vSqo34mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199151>

The display of the advice '(use git add/rm [...])' (when there are
unmerged files) after running 'git status' is now depending of the
mark, whether it's 'both deleted', 'deleted by us/them' or others. For
instance, when there is just one file that's marked as 'both deleted',
'git status' shows '(use git rm [...])' and if there are two files,
one as 'both deleted' and the other as 'added by them', the advice is
'(use git add/rm [...])'.

The previous tests in t7512-status-help.sh are updated.

Test about the case of only 'both deleted' is added in
t7060-wtstatus.sh

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 t/t7060-wtstatus.sh    |   26 ++++++++++++++++++++++++++
 t/t7512-status-help.sh |    8 ++++----
 wt-status.c            |   37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 4326df7..1e6ec37 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -182,4 +182,30 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
 '
 
 
+test_expect_success 'status when conflicts with only rm advice (both deleted)' '
+	git add sub_master.txt &&
+	git add sub_second.txt &&
+	cat >expected <<-\EOF &&
+	# On branch conflict_second
+	# You have unmerged paths.
+	#   (fix conflicts and run "git commit")
+	#
+	# Changes to be committed:
+	#
+	#	new file:   sub_master.txt
+	#
+	# Unmerged paths:
+	#   (use "git rm <file>..." to mark resolution)
+	#
+	#	both deleted:       main.txt
+	#
+	# Untracked files not listed (use -u option to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual &&
+	git reset --hard &&
+	git checkout master
+'
+
+
 test_done
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 53d0e05..e52a05a 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -26,7 +26,7 @@ test_expect_success 'status when conflicts unresolved' '
 	#   (fix conflicts and run "git commit")
 	#
 	# Unmerged paths:
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -76,7 +76,7 @@ test_expect_success 'status when rebase in progress before resolving conflicts'
 	#
 	# Unmerged paths:
 	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -124,7 +124,7 @@ test_expect_success 'status during rebase -i when conflicts unresolved' '
 	#
 	# Unmerged paths:
 	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -310,7 +310,7 @@ test_expect_success 'status when cherry-picking before resolving conflicts' '
 	#   (fix conflicts and run "git commit")
 	#
 	# Unmerged paths:
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
diff --git a/wt-status.c b/wt-status.c
index 2b19fe3..3a2b787 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -131,9 +131,34 @@ void wt_status_prepare(struct wt_status *s)
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
 {
+	int i;
+	int del_mod_conflict = 0;
+	int both_deleted = 0;
+	int not_deleted = 0;
 	const char *c = color(WT_STATUS_HEADER, s);
 
 	status_printf_ln(s, c, _("Unmerged paths:"));
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct string_list_item *it = &(s->change.items[i]);
+		struct wt_status_change_data *d = it->util;
+
+		switch (d->stagemask) {
+		case 0:
+			break;
+		case 1:
+			both_deleted = 1;
+			break;
+		case 3:
+		case 5:
+			del_mod_conflict = 1;
+			break;
+		default:
+			not_deleted = 1;
+			break;
+		}
+	}
+
 	if (!advice_status_hints)
 		return;
 	if (s->whence != FROM_COMMIT)
@@ -142,7 +167,17 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
-	status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
+
+	if (!both_deleted) {
+		if (!del_mod_conflict)
+			status_printf_ln(s, c, _("  (use \"git add <file>...\" to mark resolution)"));
+		else
+			status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
+	} else if (!del_mod_conflict && !not_deleted) {
+		status_printf_ln(s, c, _("  (use \"git rm <file>...\" to mark resolution)"));
+	} else {
+		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
+	}
 	status_printf_ln(s, c, "");
 }
 
-- 
1.7.8
