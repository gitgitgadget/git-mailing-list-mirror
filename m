From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] status: show 'revert' state and status hint
Date: Tue,  2 Apr 2013 16:20:21 +0200
Message-ID: <1364912422-29536-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1364689848-52647-1-git-send-email-robin.rosenberg@dewire.com>
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 02 16:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN28x-0000hs-V9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761033Ab3DBOYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:24:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40560 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760231Ab3DBOYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:24:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r32EKOHJ023604
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Apr 2013 16:20:24 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UN24Y-0002Md-B5; Tue, 02 Apr 2013 16:20:26 +0200
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UN24Y-0007h8-4C; Tue, 02 Apr 2013 16:20:26 +0200
X-Mailer: git-send-email 1.8.2.359.g6e2e2c6.dirty
In-Reply-To: <1364689848-52647-1-git-send-email-robin.rosenberg@dewire.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Apr 2013 16:20:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r32EKOHJ023604
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1365517356.55408@B6f6J+kp/aPQs3XBJnuBeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219773>

This is the logical equivalent for "git status" of 3ee4452 (bash: teach
__git_ps1 about REVERT_HEAD).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -282,6 +282,8 @@ __git_ps1 ()
>  				r="|MERGING"
>  			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
>  				r="|CHERRY-PICKING"
> +			elif [ -f "$g/REVERT_HEAD" ]; then
> +				r="|REVERTING"

Good.

It makes sense to also teach "git status" about REVERT_HEAD.

 t/t7512-status-help.sh | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c            | 24 +++++++++++++++++++++
 wt-status.h            |  1 +
 3 files changed, 82 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 06749a6..d745cf4 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -678,4 +678,61 @@ test_expect_success 'status showing detached from a tag' '
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'status while reverting commit (conflicts)' '
+	git checkout master &&
+	echo before >to-revert.txt &&
+	test_commit before to-revert.txt &&
+	echo old >to-revert.txt &&
+	test_commit old to-revert.txt &&
+	echo new >to-revert.txt &&
+	test_commit new to-revert.txt &&
+	test_must_fail git revert HEAD^ &&
+	cat >expected <<-EOF
+	# On branch master
+	# You are currently reverting a commit.
+	#   (fix conflicts and run "git revert --continue")
+	#   (use "git revert --abort" to cancel the revert operation)
+	#
+	# Unmerged paths:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#   (use "git add <file>..." to mark resolution)
+	#
+	#	both modified:      to-revert.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'status while reverting commit (conflicts resolved)' '
+	echo reverted >to-revert.txt &&
+	git add to-revert.txt &&
+	cat >expected <<-EOF
+	# On branch master
+	# You are currently reverting a commit.
+	#   (all conflicts fixed: run "git revert --continue")
+	#   (use "git revert --abort" to cancel the revert operation)
+	#
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	modified:   to-revert.txt
+	#
+	# Untracked files not listed (use -u option to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'status after reverting commit' '
+	git revert --continue &&
+	cat >expected <<-\EOF
+	# On branch master
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index cea8e55..5123c71 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -965,6 +965,25 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 	wt_status_print_trailer(s);
 }
 
+static void show_revert_in_progress(struct wt_status *s,
+					struct wt_status_state *state,
+					const char *color)
+{
+	status_printf_ln(s, color, _("You are currently reverting a commit."));
+	if (advice_status_hints) {
+		if (has_unmerged(s))
+			status_printf_ln(s, color,
+				_("  (fix conflicts and run \"git revert --continue\")"));
+		else
+			status_printf_ln(s, color,
+				_("  (all conflicts fixed: run \"git revert --continue\")"));
+	}
+	if (advice_status_hints)
+		status_printf_ln(s, color,
+			_("  (use \"git revert --abort\" to cancel the revert operation)"));
+	wt_status_print_trailer(s);
+}
+
 static void show_bisect_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
@@ -1113,6 +1132,9 @@ void wt_status_get_state(struct wt_status_state *state,
 		state->bisect_in_progress = 1;
 		state->branch = read_and_strip_branch("BISECT_START");
 	}
+	if (!stat(git_path("REVERT_HEAD"), &st)) {
+		state->revert_in_progress = 1;
+	}
 
 	if (get_detached_from)
 		wt_status_get_detached_from(state);
@@ -1130,6 +1152,8 @@ static void wt_status_print_state(struct wt_status *s,
 		show_rebase_in_progress(s, state, state_color);
 	else if (state->cherry_pick_in_progress)
 		show_cherry_pick_in_progress(s, state, state_color);
+	else if (state->revert_in_progress)
+		show_revert_in_progress(s, state, state_color);
 	if (state->bisect_in_progress)
 		show_bisect_in_progress(s, state, state_color);
 }
diff --git a/wt-status.h b/wt-status.h
index be7a016..35cd6cb 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -80,6 +80,7 @@ struct wt_status_state {
 	int rebase_interactive_in_progress;
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
+	int revert_in_progress;
 	char *branch;
 	char *onto;
 	char *detached_from;
-- 
1.8.2.359.g6e2e2c6.dirty
