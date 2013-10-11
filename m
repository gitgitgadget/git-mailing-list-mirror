From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] status: show commit sha1 in "You are currently cherry-picking" message
Date: Fri, 11 Oct 2013 17:58:37 +0200
Message-ID: <1381507117-11519-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, Matthieu.Moy@imag.fr,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 11 17:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUf73-0007Lh-H0
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 17:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076Ab3JKP6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 11:58:45 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:48149 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab3JKP6p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 11:58:45 -0400
Received: by mail-bk0-f41.google.com with SMTP id na10so1656668bkb.14
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SFQq78oJMDMJrVdOMYRBy9r56+r70Yr2OmONI5VeQ4g=;
        b=0o0AepB2Lrayeafi5idGV6CG9CCDy1lFp149gZ9m9tQ7taFy3hF7hjGbcTUF4aNwaV
         Y9SSseUA++H8mqABqQjB9WjPpo44+BYf4QnGYs6JjQQs6w7XrlHSbTD6ITYyBscCDMgg
         TGPGr3cTocTaYiImfNQCuEQROh0b193V6+l14zzdS3AZXPSPKxhvGYMqZIDhsl6iAKlo
         9QTwCJiz4cZEySL8YpjF7ULe61Q+Y8mgD1AUWbksfs4S5EYegOa0ZySFbpSiEzcqtRmF
         u4/AEC13vXxEPvkhvkhnOwkCS6e4ogvubHfN+oCAcdrPfmobl9oOCbgqSejulsexvDjf
         HRjA==
X-Received: by 10.204.63.7 with SMTP id z7mr18410432bkh.23.1381507121392;
        Fri, 11 Oct 2013 08:58:41 -0700 (PDT)
Received: from localhost (dslb-178-005-121-004.pools.arcor-ip.net. [178.5.121.4])
        by mx.google.com with ESMTPSA id no2sm30916962bkb.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 08:58:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.652.g0d6e0ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235910>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

Especially helpful when cherry-picking multiple commits.

 t/t7512-status-help.sh | 10 ++++++----
 wt-status.c            |  7 +++++--
 wt-status.h            |  1 +
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 0688d58..0a65db1 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -626,9 +626,10 @@ test_expect_success 'prepare for cherry-pick conflicts' '
 test_expect_success 'status when cherry-picking before resolving conflicts' '
 	test_when_finished "git cherry-pick --abort" &&
 	test_must_fail git cherry-pick cherry_branch_second &&
-	cat >expected <<\EOF &&
+	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
+	cat >expected <<EOF
 On branch cherry_branch
-You are currently cherry-picking.
+You are currently cherry-picking commit $TO_CHERRY_PICK.
   (fix conflicts and run "git cherry-pick --continue")
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
 
@@ -648,11 +649,12 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 	git reset --hard cherry_branch &&
 	test_when_finished "git cherry-pick --abort" &&
 	test_must_fail git cherry-pick cherry_branch_second &&
+	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
 	echo end >main.txt &&
 	git add main.txt &&
-	cat >expected <<\EOF &&
+	cat >expected <<EOF
 On branch cherry_branch
-You are currently cherry-picking.
+You are currently cherry-picking commit $TO_CHERRY_PICK.
   (all conflicts fixed: run "git cherry-pick --continue")
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
 
diff --git a/wt-status.c b/wt-status.c
index cbdce72..b4e44ba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -996,7 +996,8 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 					struct wt_status_state *state,
 					const char *color)
 {
-	status_printf_ln(s, color, _("You are currently cherry-picking."));
+	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
+			find_unique_abbrev(state->cherry_pick_head_sha1, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1169,8 +1170,10 @@ void wt_status_get_state(struct wt_status_state *state,
 			state->rebase_in_progress = 1;
 		state->branch = read_and_strip_branch("rebase-merge/head-name");
 		state->onto = read_and_strip_branch("rebase-merge/onto");
-	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
+	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st) &&
+			!get_sha1("CHERRY_PICK_HEAD", sha1)) {
 		state->cherry_pick_in_progress = 1;
+		hashcpy(state->cherry_pick_head_sha1, sha1);
 	}
 	if (!stat(git_path("BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
diff --git a/wt-status.h b/wt-status.h
index 9341c56..6c29e6f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -88,6 +88,7 @@ struct wt_status_state {
 	char *detached_from;
 	unsigned char detached_sha1[20];
 	unsigned char revert_head_sha1[20];
+	unsigned char cherry_pick_head_sha1[20];
 };
 
 void wt_status_prepare(struct wt_status *s);
-- 
1.8.4.652.g0d6e0ce
