From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] status: show commit sha1 in "You are currently reverting" message
Date: Tue,  2 Apr 2013 16:20:22 +0200
Message-ID: <1364912422-29536-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1364689848-52647-1-git-send-email-robin.rosenberg@dewire.com>
 <1364912422-29536-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 02 16:21:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN25e-0006pu-Ch
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760750Ab3DBOVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:21:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36034 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759922Ab3DBOVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:21:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r32EKPmC006401
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Apr 2013 16:20:25 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UN24Y-0002Mg-Uh; Tue, 02 Apr 2013 16:20:26 +0200
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UN24Y-0007hB-Qj; Tue, 02 Apr 2013 16:20:26 +0200
X-Mailer: git-send-email 1.8.2.359.g6e2e2c6.dirty
In-Reply-To: <1364912422-29536-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Apr 2013 16:20:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r32EKPmC006401
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1365517227.85818@dMurO7xvDnf5KTOI8uopLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219771>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7512-status-help.sh | 7 ++++---
 wt-status.c            | 8 ++++++--
 wt-status.h            | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index d745cf4..bf08d4e 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -686,10 +686,11 @@ test_expect_success 'status while reverting commit (conflicts)' '
 	test_commit old to-revert.txt &&
 	echo new >to-revert.txt &&
 	test_commit new to-revert.txt &&
-	test_must_fail git revert HEAD^ &&
+	TO_REVERT=$(git rev-parse --short HEAD^) &&
+	test_must_fail git revert $TO_REVERT &&
 	cat >expected <<-EOF
 	# On branch master
-	# You are currently reverting a commit.
+	# You are currently reverting commit $TO_REVERT.
 	#   (fix conflicts and run "git revert --continue")
 	#   (use "git revert --abort" to cancel the revert operation)
 	#
@@ -710,7 +711,7 @@ test_expect_success 'status while reverting commit (conflicts resolved)' '
 	git add to-revert.txt &&
 	cat >expected <<-EOF
 	# On branch master
-	# You are currently reverting a commit.
+	# You are currently reverting commit $TO_REVERT.
 	#   (all conflicts fixed: run "git revert --continue")
 	#   (use "git revert --abort" to cancel the revert operation)
 	#
diff --git a/wt-status.c b/wt-status.c
index 5123c71..e956910 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -969,7 +969,8 @@ static void show_revert_in_progress(struct wt_status *s,
 					struct wt_status_state *state,
 					const char *color)
 {
-	status_printf_ln(s, color, _("You are currently reverting a commit."));
+	status_printf_ln(s, color, _("You are currently reverting commit %s."),
+			 find_unique_abbrev(state->revert_head_sha1, DEFAULT_ABBREV));
 	if (advice_status_hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1105,6 +1106,7 @@ void wt_status_get_state(struct wt_status_state *state,
 			 int get_detached_from)
 {
 	struct stat st;
+	unsigned char sha1[20];
 
 	if (!stat(git_path("MERGE_HEAD"), &st)) {
 		state->merge_in_progress = 1;
@@ -1132,8 +1134,10 @@ void wt_status_get_state(struct wt_status_state *state,
 		state->bisect_in_progress = 1;
 		state->branch = read_and_strip_branch("BISECT_START");
 	}
-	if (!stat(git_path("REVERT_HEAD"), &st)) {
+	if (!stat(git_path("REVERT_HEAD"), &st) &&
+	    !get_sha1("REVERT_HEAD", sha1)) {
 		state->revert_in_progress = 1;
+		hashcpy(state->revert_head_sha1, sha1);
 	}
 
 	if (get_detached_from)
diff --git a/wt-status.h b/wt-status.h
index 35cd6cb..4121bc2 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -85,6 +85,7 @@ struct wt_status_state {
 	char *onto;
 	char *detached_from;
 	unsigned char detached_sha1[20];
+	unsigned char revert_head_sha1[20];
 };
 
 void wt_status_prepare(struct wt_status *s);
-- 
1.8.2.359.g6e2e2c6.dirty
