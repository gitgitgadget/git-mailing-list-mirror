From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 4/7] status: do not depend on rebase reflog messages
Date: Wed, 19 Jun 2013 00:25:34 +0530
Message-ID: <1371581737-10013-5-git-send-email-artagnon@gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:59:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up17X-0002gV-8h
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933699Ab3FRS64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:58:56 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:38782 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933697Ab3FRS6z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:58:55 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so4323381pad.30
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eAxbmgrIpwx2ficbpua85TaT1tnCS5Kun9oLMsp1ZnU=;
        b=fYaKUoiC8EY87gSgvkVzgVdNKzGSJKIBCWHc3AsEoCjv/vg14UJQcSTAzIsmjH7X9g
         eLvHrWTBlHV9bxtRRyPVj7BeP4pZA3RXJyFMC2PQy5dofW7kfZT18gKnoFT9hPd0iSVd
         zsCa6iaBZl3NkEQo2yPDexxfJEBtEkNweaFRYffV1s9Y+wzNDKgAq6gJrkIH1WI8IWyS
         Q9EfkEfGfErGX3M6hy9Ky5mYxKEVujO/bMR3NIJzYYNkS06CA/WXBuBauGuvCIhAYedB
         SB5XFdhKARhSgkzGxl+VuxvO0tBE2CqytMp7CeKAdZ4Hj1Snog/IagUr74iNxrWBUsh4
         trzg==
X-Received: by 10.68.203.103 with SMTP id kp7mr10367597pbc.165.1371581935011;
        Tue, 18 Jun 2013 11:58:55 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ag4sm19432751pbc.20.2013.06.18.11.58.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:58:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
In-Reply-To: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228301>

b397ea4 (status: show more info than "currently not on any branch",
2013-03-13) attempted to make the output of 'git status' richer in
the case of a detached HEAD.  Before this patch, with a detached
HEAD, we saw:

  $ git status
  # Not currently on any branch.

But after the patch, we see:

  $ git checkout v1.8.2
  $ git status
  # HEAD detached at v1.8.2

It works by digging the reflog for the most recent message of the
form "checkout: moving from xxxx to yyyy".  It then asserts that
HEAD and "yyyy" are the same, and displays this message.  When they
aren't equal, it displays:

  $ git status
  # HEAD detached from fe11db

so that the user can see where the HEAD was first detached.

In case of a rebase [-i] operation in progress, this message depends on
the implementation of rebase writing "checkout: " messages to the
reflog, but that is an implementation detail of "rebase".  To remove
this dependency so that rebase can be updated to write better reflog
messages, replace this "HEAD detached from" message with:

  # rebase in progress; onto $ONTO

Changes to the commit object name in the expected output for some of the
tests shows that what the test expected "status" to show during "rebase
-i" was not consistent with the output during a vanilla "rebase", which
showed on top of what commit the series is being replayed.  Now we
consistently show something meaningful to the end user.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7512-status-help.sh | 37 +++++++++++++++++--------------------
 wt-status.c            |  5 ++++-
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index bafa5e7..d6c66d7 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -77,7 +77,7 @@ test_expect_success 'status when rebase in progress before resolving conflicts'
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
@@ -104,7 +104,7 @@ test_expect_success 'status when rebase in progress before rebase --continue' '
 	echo three >main.txt &&
 	git add main.txt &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
@@ -136,7 +136,7 @@ test_expect_success 'status during rebase -i when conflicts unresolved' '
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
@@ -162,7 +162,7 @@ test_expect_success 'status during rebase -i after resolving conflicts' '
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
@@ -188,10 +188,9 @@ test_expect_success 'status when rebasing -i in edit mode' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~2) &&
-	TGT=$(git rev-parse --short two_rebase_i) &&
 	git rebase -i HEAD~2 &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $TGT
+	# rebase in progress; onto $ONTO
 	# You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -216,9 +215,8 @@ test_expect_success 'status when splitting a commit' '
 	ONTO=$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
-	TGT=$(git rev-parse --short HEAD) &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $TGT
+	# rebase in progress; onto $ONTO
 	# You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
@@ -246,11 +244,10 @@ test_expect_success 'status after editing the last commit with --amend during a
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
-	TGT=$(git rev-parse --short three_amend) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $TGT
+	# rebase in progress; onto $ONTO
 	# You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -280,7 +277,7 @@ test_expect_success 'status: (continue first edit) second edit' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -302,7 +299,7 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
@@ -329,7 +326,7 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -351,7 +348,7 @@ test_expect_success 'status: (amend first edit) second edit' '
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -374,7 +371,7 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
@@ -402,7 +399,7 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "d" &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -426,7 +423,7 @@ test_expect_success 'status: (split first edit) second edit' '
 	git commit -m "e" &&
 	git rebase --continue &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -451,7 +448,7 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
@@ -481,7 +478,7 @@ test_expect_success 'status: (split first edit) second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "h" &&
 	cat >expected <<-EOF &&
-	# HEAD detached from $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your changes)
@@ -601,7 +598,7 @@ test_expect_success 'status when rebase conflicts with statushints disabled' '
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-EOF &&
-	# HEAD detached at $ONTO
+	# rebase in progress; onto $ONTO
 	# You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
 	#
 	# Unmerged paths:
diff --git a/wt-status.c b/wt-status.c
index 2511270..85a00f1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1174,7 +1174,10 @@ void wt_status_print(struct wt_status *s)
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			if (state.detached_from) {
+			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
+				on_what = _("rebase in progress; onto ");
+				branch_name = state.onto;
+			} else if (state.detached_from) {
 				unsigned char sha1[20];
 				branch_name = state.detached_from;
 				if (!get_sha1("HEAD", sha1) &&
-- 
1.8.3.1.455.g5932b31
