From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Thu, 13 Jun 2013 19:02:28 +0530
Message-ID: <1371130349-30651-6-git-send-email-artagnon@gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:31:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7cB-0003x5-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578Ab3FMNaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:30:52 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:45321 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab3FMNar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:30:47 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so6889955pad.14
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XuXV5m8iZRHlcZp1T8WymsJqff2QLsnG53VA4qdqgbE=;
        b=mrzs2V/6fi0FaOv/0V3BTc1HisAMYpPZ8cqamlqnJE6AqlmH3n43i2dv5b5E15jcLs
         NEPiCWEqyvIkmnWi08RNNN3WTPgI0mf3SNRPBm/lsuI9ldQIvCE/F6P5lX0fdIiyf2+1
         CSmpn40FuuMS+ODufXzH44/DVJ470oZRK9fbs7npea9Kf64hxvO2lGurxvlayGXvZTCw
         VRwpKu6Y7AuM2G5jPFndxF/o6XcqONoQ/vJRPvLS8+2JAv3dnKPF6s8LjEb5RENug6y+
         16rXNmnVpmoWRs2xya49CNKDRycGPzxHkFaTuQaFSSAVitUnzQsxIc8MUXlhsPS2dRFp
         6IaA==
X-Received: by 10.66.135.139 with SMTP id ps11mr2899135pab.51.1371130246640;
        Thu, 13 Jun 2013 06:30:46 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id re16sm4581222pac.16.2013.06.13.06.30.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 06:30:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.384.g7cec0b4
In-Reply-To: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227730>

b397ea4 (status: show more info than "currently not on any branch",
2013-03-13) made the output of 'git status' richer in the case of a
detached HEAD.  Before this patch, with a detached HEAD:

  $ git status
  # Not currently on any branch.

After the patch:

  $ git checkout v1.8.2
  # HEAD is now detached
  $ git status
  # HEAD detached at v1.8.2.

It works by digging the reflog for the most recent message of the form
"checkout: moving from xxxx to yyyy".  It then asserts that HEAD and
"yyyy" are the same, and displays this message.  When they aren't equal,
it displays:

  $ git status
  # HEAD detached from fe11db.

At this point, the utility of such a message is in question.  Moreover,
there are several tests in t/status-help that explicitly rely on rebase
writing "checkout: " messages to the reflog.  As evidenced by the
failing tests in t/checkout-last, these messages are completely
unintended and flaky.  Relying on them only makes it harder to improve
the reflog messages written by scripts.  As a reasonable compromise,
remove the logic to display the "HEAD detached from ..." message, and
fallback to "Not currently on any branch." in this case.  Update the
tests, giving scripts some breathing space.

This issue is not isolated to rebase at all.  Several other scripts like
bisect write (confusing) "checkout: " messages to the reflog.  Fixing
them is left as an exercise to other contributors.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t7512-status-help.sh | 24 +++++++++++-------------
 wt-status.c            | 11 ++++-------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index bf08d4e..ed9d57c 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -188,10 +188,9 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~2) &&
-	TGT=$(git rev-parse --short two_rebase_i) &&
 	git rebase -i HEAD~2 &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $TGT
+	# Not currently on any branch.
 	# You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -246,11 +245,10 @@ test_expect_success 'status after editing the last commit with --amend during a
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
-	TGT=$(git rev-parse --short three_amend) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $TGT
+	# Not currently on any branch.
 	# You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -280,7 +278,7 @@ test_expect_success 'status: (continue first edit) second edit' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -302,7 +300,7 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
@@ -329,7 +327,7 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -351,7 +349,7 @@ test_expect_success 'status: (amend first edit) second edit' '
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -374,7 +372,7 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
@@ -402,7 +400,7 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "d" &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -426,7 +424,7 @@ test_expect_success 'status: (split first edit) second edit' '
 	git commit -m "e" &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -451,7 +449,7 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
@@ -481,7 +479,7 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "h" &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# Not currently on any branch.
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
diff --git a/wt-status.c b/wt-status.c
index 2511270..f7d46a1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1173,15 +1173,12 @@ void wt_status_print(struct wt_status *s)
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
+			unsigned char sha1[20];
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			if (state.detached_from) {
-				unsigned char sha1[20];
+			if (state.detached_from && !get_sha1("HEAD", sha1) &&
+				!hashcmp(sha1, state.detached_sha1)) {
 				branch_name = state.detached_from;
-				if (!get_sha1("HEAD", sha1) &&
-				    !hashcmp(sha1, state.detached_sha1))
-					on_what = _("HEAD detached at ");
-				else
-					on_what = _("HEAD detached from ");
+				on_what = _("HEAD detached at ");
 			} else {
 				branch_name = "";
 				on_what = _("Not currently on any branch.");
-- 
1.8.3.1.384.g7cec0b4
