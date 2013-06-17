From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] wt-status: give better advice when cherry-pick is in progress
Date: Mon, 17 Jun 2013 06:28:26 +0200
Message-ID: <1371443306-3073-1-git-send-email-ralf.thielow@gmail.com>
Cc: Lucien.Kong@ensimag.imag.fr, gitster@pobox.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 17 06:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoR3W-0007T3-6c
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 06:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab3FQE2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 00:28:34 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:49172 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3FQE2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 00:28:33 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so1516799eei.13
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 21:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vVMlPAJB3nm0E/egRz9TAdNTWbTSOlHaDfxoeyfqtWY=;
        b=gLzQPtLm8uBY+BZ80pilw8zgeFW+khnQb0tL771WCOpv43Vx/8kOKp9JoK4bEk/mnE
         r+AQ4DwoLT2ZaHQJ11eP0Ziyka4/ckRZMilPMxUJRoWLbpztrhZu7GQqP3nyIM9WmGl8
         tQ9LawDs48N5wXmLkrz+BermKsXEbkwVPoCKhYze0juALwh/HFR758/l/CDgct/SrCUj
         gu1DiALG4nxjgPWuldlPKDk7xvGCquGd8VkrjFytvwEAbS1sMD/7Z0vXwB3KErmkP0sE
         vpyNx0qYoBJDTCQmhVmsjcPreSnNT5dymaQYSnzwimvWZ58HafpQafBeRak/3wJLoPFL
         VfXg==
X-Received: by 10.14.251.202 with SMTP id b50mr14587266ees.85.1371443312208;
        Sun, 16 Jun 2013 21:28:32 -0700 (PDT)
Received: from localhost (dslb-178-005-125-192.pools.arcor-ip.net. [178.5.125.192])
        by mx.google.com with ESMTPSA id y2sm20883478eeu.2.2013.06.16.21.28.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 21:28:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.3.gf2b4626.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228039>

When cherry-pick is in progress, 'git status' gives the advice to
run "git commit" to finish the cherry-pick. However, this won't continue
the sequencer.
"git status" should give the advice of running "git cherry-pick --continue"
or "git cherry-pick --abort".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 t/t7512-status-help.sh | 6 ++++--
 wt-status.c            | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index bf08d4e..4f09bec 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -632,7 +632,8 @@ test_expect_success 'status when cherry-picking before resolving conflicts' '
 	cat >expected <<-\EOF &&
 	# On branch cherry_branch
 	# You are currently cherry-picking.
-	#   (fix conflicts and run "git commit")
+	#   (fix conflicts and run "git cherry-pick --continue")
+	#   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
 	#
 	# Unmerged paths:
 	#   (use "git add <file>..." to mark resolution)
@@ -655,7 +656,8 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 	cat >expected <<-\EOF &&
 	# On branch cherry_branch
 	# You are currently cherry-picking.
-	#   (all conflicts fixed: run "git commit")
+	#   (all conflicts fixed: run "git cherry-pick --continue")
+	#   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
 	#
 	# Changes to be committed:
 	#
diff --git a/wt-status.c b/wt-status.c
index bf84a86..438a40d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -955,10 +955,12 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 	if (advice_status_hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
-				_("  (fix conflicts and run \"git commit\")"));
+				_("  (fix conflicts and run \"git cherry-pick --continue\")"));
 		else
 			status_printf_ln(s, color,
-				_("  (all conflicts fixed: run \"git commit\")"));
+				_("  (all conflicts fixed: run \"git cherry-pick --continue\")"));
+		status_printf_ln(s, color,
+			_("  (use \"git cherry-pick --abort\" to cancel the cherry-pick operation)"));
 	}
 	wt_status_print_trailer(s);
 }
-- 
1.8.3.1.3.gf2b4626.dirty
