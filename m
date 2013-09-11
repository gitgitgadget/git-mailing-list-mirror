From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] wt-status: turn advice_status_hints into a field of wt_status
Date: Wed, 11 Sep 2013 11:08:58 +0200
Message-ID: <1378890539-1966-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: javierdo1@gmail.com, jrnieder@gmail.com, judge.packham@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 11 11:09:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJgQU-00039P-2q
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 11:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab3IKJJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 05:09:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47977 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab3IKJJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 05:09:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8B996tD007004
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Sep 2013 11:09:06 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VJgQ7-0005Gv-JJ; Wed, 11 Sep 2013 11:09:07 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VJgQ7-0000Wd-8s; Wed, 11 Sep 2013 11:09:07 +0200
X-Mailer: git-send-email 1.8.4.8.g834017f
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 11 Sep 2013 11:09:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8B996tD007004
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379495348.59876@eo7ULFKQtsB5EYo0x96FZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234553>

No behavior change in this patch, but this makes the display of status
hints more flexible as they can be enabled or disabled for individual
calls to commit.c:run_status().

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/commit.c | 10 ++++++++--
 wt-status.c      | 38 +++++++++++++++++++-------------------
 wt-status.h      |  1 +
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 60812b5..388acde 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -163,6 +163,12 @@ static void determine_whence(struct wt_status *s)
 		s->whence = whence;
 }
 
+static void status_finalize(struct wt_status *s)
+{
+	determine_whence(s);
+	s->hints = advice_status_hints;
+}
+
 static void rollback_index_files(void)
 {
 	switch (commit_style) {
@@ -1249,7 +1255,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 	gitmodules_config();
 	git_config(git_status_config, &s);
-	determine_whence(&s);
+	status_finalize(&s);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
@@ -1494,7 +1500,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(git_commit_config, &s);
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
-	determine_whence(&s);
+	status_finalize(&s);
 	s.colopts = 0;
 
 	if (get_sha1("HEAD", sha1))
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
