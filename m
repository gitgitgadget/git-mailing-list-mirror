From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv2 1/2] wt-status: better advices for git status
Date: Sat, 26 May 2012 14:38:24 +0200
Message-ID: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 14:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYGGR-0001fL-CE
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 14:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab2EZMib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 08:38:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54072 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839Ab2EZMia (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 08:38:30 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4QCUKcI006726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 May 2012 14:30:20 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4QCcQw3023904;
	Sat, 26 May 2012 14:38:26 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4QCcQI0024354;
	Sat, 26 May 2012 14:38:26 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4QCcQhm024353;
	Sat, 26 May 2012 14:38:26 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 26 May 2012 14:30:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4QCUKcI006726
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1338640222.70821@9wBUbLe3ZFYNNB9wGuo4kw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198558>

This patch provides more information about your current state after a git status command (in the cases of conflicts, before and after they are resolved, a rebase or a bisect process).
This would help users to know what they are currently doing, in a more accurate way.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Nguyen Huynh Khoi Nguyen Lucien <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
---
 wt-status.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h |    1 +
 2 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index dd6d8c4..9839280 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,6 +15,7 @@
 
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
+	GIT_COLOR_NORMAL, /* WT_STATUS_IN_PROGRESS */
 	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
 	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
 	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
@@ -728,6 +729,92 @@ static void wt_status_print_tracking(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
 
+static void wt_status_print_in_progress(struct wt_status *s)
+{
+	int i;
+	const char *c = color(WT_STATUS_IN_PROGRESS, s);
+	const char *git_dir = getenv(GIT_DIR_ENVIRONMENT);
+	const char* path;
+	int unmerged_state = 0;
+	int rebase_state = 0;
+	int rebase_interactive_state = 0;
+	int am_state = 0;
+	int bisect_state = 0;
+	int conflict = 0;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (d->stagemask) {
+			conflict = 1;
+			continue;
+		}
+	}
+
+	path = mkpath("%s/MERGE_HEAD", git_dir);
+	if (!access(path, R_OK))
+		unmerged_state = 1;
+
+	path = mkpath("%s/rebase-apply", git_dir);
+	if (!access(path, R_OK)) {
+		path = mkpath("%s/rebase-apply/applying", git_dir);
+		if (!access(path, R_OK))
+			am_state = 1;
+		else
+			rebase_state = 1;
+	}
+	else {
+		path = mkpath("%s/rebase-merge", git_dir);
+		if (!access(path, R_OK)) {
+			path = mkpath("%s/rebase-merge/interactive", git_dir);
+			if (!access(path, R_OK))
+				rebase_interactive_state = 1;
+			else
+				rebase_state = 1;
+		}
+	}
+
+	path = mkpath("%s/BISECT_LOG", git_dir);
+	if (!access(path, R_OK))
+		bisect_state = 1;
+
+	if(bisect_state) {
+		status_printf_ln(s, c, _("You are currently bisecting."));
+		status_printf_ln(s, c, _("To get back to the original branch run \"git bisect reset\""));
+		wt_status_print_trailer(s);
+	}
+
+	if(unmerged_state) {
+		if (conflict)
+			status_printf_ln(s, c, _("You have unmerged paths: fix conflicts and then commit the result."));
+		else
+			status_printf_ln(s, c, _("You are still merging, run \"git commit\" to conclude merge."));
+		wt_status_print_trailer(s);
+	}
+
+	if(rebase_state || rebase_interactive_state) {
+		if (conflict) {
+			status_printf_ln(s, c, _("You are currently rebasing: fix conflicts and then run \"git rebase -- continue\"."));
+			status_printf_ln(s, c, _("If you would prefer to skip this patch, instead run \"git rebase --skip\"."));
+			status_printf_ln(s, c, _("To check out  the original branch and stop rebasing run \"git rebase --abort\"."));
+		}
+		else {
+			if (rebase_state)
+				status_printf_ln(s, c, _("You are currently rebasing: all conflicts fixed; run \"git rebase --continue\"."));
+			else {
+				status_printf_ln(s, c, _("You are currently editing in a rebase progress."));
+				status_printf_ln(s, c, _("You can amend the commit with"));
+				status_printf_ln(s, c, _("	git commit --amend"));
+				status_printf_ln(s, c, _("Once you are satisfied with your changes, run"));
+				status_printf_ln(s, c, _("	git rebase --continue"));
+			}
+		}
+		wt_status_print_trailer(s);
+	}
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
@@ -750,6 +837,8 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
+	wt_status_print_in_progress(s);
+
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
diff --git a/wt-status.h b/wt-status.h
index 14aa9f7..3d86801 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -7,6 +7,7 @@
 
 enum color_wt_status {
 	WT_STATUS_HEADER = 0,
+	WT_STATUS_IN_PROGRESS,
 	WT_STATUS_UPDATED,
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
-- 
1.7.8
