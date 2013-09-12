From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/3] wt-status: turn advice_status_hints into a field of wt_status
Date: Thu, 12 Sep 2013 12:50:05 +0200
Message-ID: <1378983006-3980-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1378983006-3980-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: javierdo1@gmail.com, jrnieder@gmail.com, judge.packham@gmail.com,
	peff@peff.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 12 12:50:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK4Ti-00043X-TE
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805Ab3ILKuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 06:50:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53735 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab3ILKuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:50:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8CAo7iH003329
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Sep 2013 12:50:07 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VK4TR-0002AJ-5Y; Thu, 12 Sep 2013 12:50:09 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VK4TQ-00013I-RT; Thu, 12 Sep 2013 12:50:08 +0200
X-Mailer: git-send-email 1.8.4.8.g834017f
In-Reply-To: <1378983006-3980-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 12 Sep 2013 12:50:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8CAo7iH003329
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379587809.62436@JQOlmcq0VmPUCUw/sLh9PQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234645>

No behavior change in this patch, but this makes the display of status
hints more flexible as they can be enabled or disabled for individual
calls to commit.c:run_status().

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
No real change since v1, just a slight adaptation after the PATCH 1.

 builtin/commit.c |  1 +
 wt-status.c      | 38 +++++++++++++++++++-------------------
 wt-status.h      |  1 +
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index dc957a9..7bfce94 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -169,6 +169,7 @@ static void status_init_config(struct wt_status *s, config_fn_t fn)
 	gitmodules_config();
 	git_config(fn, s);
 	determine_whence(s);
+	s->hints = advice_status_hints; /* must come after git_config() */
 }
 
 static void rollback_index_files(void)
diff --git a/wt-status.c b/wt-status.c
index cb24f1f..885ee66 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -160,7 +160,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 		}
 	}
 
-	if (!advice_status_hints)
+	if (!s->hints)
 		return;
 	if (s->whence != FROM_COMMIT)
 		;
@@ -187,7 +187,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 	const char *c = color(WT_STATUS_HEADER, s);
 
 	status_printf_ln(s, c, _("Changes to be committed:"));
-	if (!advice_status_hints)
+	if (!s->hints)
 		return;
 	if (s->whence != FROM_COMMIT)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
@@ -205,7 +205,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	const char *c = color(WT_STATUS_HEADER, s);
 
 	status_printf_ln(s, c, _("Changes not staged for commit:"));
-	if (!advice_status_hints)
+	if (!s->hints)
 		return;
 	if (!has_deleted)
 		status_printf_ln(s, c, _("  (use \"git add <file>...\" to update what will be committed)"));
@@ -223,7 +223,7 @@ static void wt_status_print_other_header(struct wt_status *s,
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	status_printf_ln(s, c, "%s:", what);
-	if (!advice_status_hints)
+	if (!s->hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
 	status_printf_ln(s, c, "");
@@ -801,13 +801,13 @@ static void show_merge_in_progress(struct wt_status *s,
 {
 	if (has_unmerged(s)) {
 		status_printf_ln(s, color, _("You have unmerged paths."));
-		if (advice_status_hints)
+		if (s->hints)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git commit\")"));
 	} else {
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
-		if (advice_status_hints)
+		if (s->hints)
 			status_printf_ln(s, color,
 				_("  (use \"git commit\" to conclude merge)"));
 	}
@@ -823,7 +823,7 @@ static void show_am_in_progress(struct wt_status *s,
 	if (state->am_empty_patch)
 		status_printf_ln(s, color,
 			_("The current patch is empty."));
-	if (advice_status_hints) {
+	if (s->hints) {
 		if (!state->am_empty_patch)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git am --continue\")"));
@@ -896,7 +896,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 		else
 			status_printf_ln(s, color,
 					 _("You are currently rebasing."));
-		if (advice_status_hints) {
+		if (s->hints) {
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git rebase --continue\")"));
 			status_printf_ln(s, color,
@@ -913,7 +913,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 		else
 			status_printf_ln(s, color,
 					 _("You are currently rebasing."));
-		if (advice_status_hints)
+		if (s->hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
 	} else if (split_commit_in_progress(s)) {
@@ -925,7 +925,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 		else
 			status_printf_ln(s, color,
 					 _("You are currently splitting a commit during a rebase."));
-		if (advice_status_hints)
+		if (s->hints)
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
 	} else {
@@ -937,7 +937,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 		else
 			status_printf_ln(s, color,
 					 _("You are currently editing a commit during a rebase."));
-		if (advice_status_hints && !s->amend) {
+		if (s->hints && !s->amend) {
 			status_printf_ln(s, color,
 				_("  (use \"git commit --amend\" to amend the current commit)"));
 			status_printf_ln(s, color,
@@ -952,7 +952,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking."));
-	if (advice_status_hints) {
+	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git cherry-pick --continue\")"));
@@ -971,7 +971,7 @@ static void show_revert_in_progress(struct wt_status *s,
 {
 	status_printf_ln(s, color, _("You are currently reverting commit %s."),
 			 find_unique_abbrev(state->revert_head_sha1, DEFAULT_ABBREV));
-	if (advice_status_hints) {
+	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git revert --continue\")"));
@@ -995,7 +995,7 @@ static void show_bisect_in_progress(struct wt_status *s,
 	else
 		status_printf_ln(s, color,
 				 _("You are currently bisecting."));
-	if (advice_status_hints)
+	if (s->hints)
 		status_printf_ln(s, color,
 			_("  (use \"git bisect reset\" to get back to the original branch)"));
 	wt_status_print_trailer(s);
@@ -1233,7 +1233,7 @@ void wt_status_print(struct wt_status *s)
 		}
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
-			advice_status_hints
+			s->hints
 			? _(" (use -u option to show untracked files)") : "");
 
 	if (s->verbose)
@@ -1244,25 +1244,25 @@ void wt_status_print(struct wt_status *s)
 		else if (s->nowarn)
 			; /* nothing */
 		else if (s->workdir_dirty) {
-			if (advice_status_hints)
+			if (s->hints)
 				printf(_("no changes added to commit "
 					 "(use \"git add\" and/or \"git commit -a\")\n"));
 			else
 				printf(_("no changes added to commit\n"));
 		} else if (s->untracked.nr) {
-			if (advice_status_hints)
+			if (s->hints)
 				printf(_("nothing added to commit but untracked files "
 					 "present (use \"git add\" to track)\n"));
 			else
 				printf(_("nothing added to commit but untracked files present\n"));
 		} else if (s->is_initial) {
-			if (advice_status_hints)
+			if (s->hints)
 				printf(_("nothing to commit (create/copy files "
 					 "and use \"git add\" to track)\n"));
 			else
 				printf(_("nothing to commit\n"));
 		} else if (!s->show_untracked_files) {
-			if (advice_status_hints)
+			if (s->hints)
 				printf(_("nothing to commit (use -u to show untracked files)\n"));
 			else
 				printf(_("nothing to commit\n"));
diff --git a/wt-status.h b/wt-status.h
index fb7152e..b4c9cb4 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -59,6 +59,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int show_branch;
+	int hints;
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
-- 
1.8.4.8.g834017f
