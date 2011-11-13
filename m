From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/7] sequencer: teach '--continue' how to commit
Date: Sun, 13 Nov 2011 16:16:20 +0530
Message-ID: <1321181181-23923-7-git-send-email-artagnon@gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXc1-0000WR-4L
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab1KMKs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 05:48:28 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50926 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab1KMKsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:48:25 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so9315254pzk.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/+56JOxrySJT9CqoaU6HXAwT7tpogZ/g4z5tUUzZ/a8=;
        b=qUturtLLr3sylWzf1CqwT/UOYknQRkJj9wVp4OfjyZfgY3fb/0dbGbw83Y9Yj7E94u
         rXUwr4P0Br1QfEoIoOTwuWzVv4bFOL6LweS3vUCZ82fnFfufbEh+HUHQtsLXRxiMSgXz
         +d9/b7r1eMNXUPRcKk1nYpeSemmAWZgDObNAs=
Received: by 10.68.28.133 with SMTP id b5mr40280236pbh.28.1321181304987;
        Sun, 13 Nov 2011 02:48:24 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id g8sm28723464pbe.11.2011.11.13.02.48.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:48:23 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185335>

As discussed earlier in the series, the commit-before-continue
convention has caused a lot of workflow inconsistencies.  Teach
'--continue' how to commit so that you can now do:

  $ git cherry-pick foo..bar
  ... conflict occured in bar~1 ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git sequencer --continue

Modify existing tests in 't3510-sequencer.sh' to exclude the 'git
commit' step, and port relevant tests from
't3511-cherry-pick-sequence.sh' after removing the 'git commit' step.
Note that the tests in 't3511-cherry-pick-sequence.sh' (with the 'git
commit' step) still need to respect backward compatibility.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c          |   10 +++++++-
 t/t3510-sequencer.sh |   51 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 012d531..7b10b7b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -269,7 +269,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 	args[i++] = "-n";
 	if (opts->signoff)
 		args[i++] = "-s";
-	if (!opts->edit) {
+	if (!opts->edit && defmsg) {
 		args[i++] = "-F";
 		args[i++] = defmsg;
 	}
@@ -776,6 +776,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 {
 	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
+	int res;
 
 	if (opts->subcommand == REPLAY_NONE)
 		assert(opts->revs);
@@ -796,9 +797,14 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		read_populate_opts(&opts);
 		read_populate_todo(&todo_list);
 
-		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
 			todo_list = todo_list->next;
+		else if (!opts->no_commit && !read_cache_unmerged()) {
+			res = run_git_commit(NULL, opts);
+			if (res)
+				return res;
+			todo_list = todo_list->next;
+		}
 	} else {
 		/*
 		 * Start a new cherry-pick/ revert sequence; but
diff --git a/t/t3510-sequencer.sh b/t/t3510-sequencer.sh
index 6b2e712..65f2724 100755
--- a/t/t3510-sequencer.sh
+++ b/t/t3510-sequencer.sh
@@ -45,12 +45,54 @@ test_expect_success '--continue complains when there are unresolved conflicts' '
 	test_must_fail git sequencer --continue
 '
 
+test_expect_success '--continue continues after conflicts are resolved' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git sequencer --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--continue respects opts' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -x base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git sequencer --continue &&
+	test_path_is_missing .git/sequencer &&
+	git cat-file commit HEAD >anotherpick_msg &&
+	git cat-file commit HEAD~1 >picked_msg &&
+	git cat-file commit HEAD~2 >unrelatedpick_msg &&
+	git cat-file commit HEAD~3 >initial_msg &&
+	test_must_fail grep "cherry picked from" initial_msg &&
+	grep "cherry picked from" unrelatedpick_msg &&
+	grep "cherry picked from" picked_msg &&
+	grep "cherry picked from" anotherpick_msg
+'
+
 test_expect_success 'malformed instruction sheet 1' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
 	git add foo &&
-	git commit &&
 	sed "s/pick /pick/" .git/sequencer/todo >new_sheet &&
 	cp new_sheet .git/sequencer/todo &&
 	test_must_fail git sequencer --continue
@@ -61,7 +103,6 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_must_fail git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
 	git add foo &&
-	git commit &&
 	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
 	cp new_sheet .git/sequencer/todo &&
 	test_must_fail git sequencer --continue
@@ -72,7 +113,6 @@ test_expect_success 'malformed instruction sheet 3' '
 	test_must_fail git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
 	git add foo &&
-	git commit &&
 	sed "s/pick \([0-9a-f]*\)/pick $_r10/" .git/sequencer/todo >new_sheet &&
 	cp new_sheet .git/sequencer/todo &&
 	test_must_fail git sequencer --continue
@@ -83,7 +123,6 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_must_fail git cherry-pick base..anotherpick &&
 	echo "c" >foo &&
 	git add foo &&
-	git commit &&
 	cut -d" " -f1,2 .git/sequencer/todo >new_sheet &&
 	cp new_sheet .git/sequencer/todo &&
 	git sequencer --continue &&
@@ -97,7 +136,6 @@ test_expect_success 'revert --continue continues after cherry-pick' '
 	test_must_fail git cherry-pick base..anotherpick &&
 	echo "c" >foo &&
 	git add foo &&
-	git commit &&
 	git revert --continue &&
 	test_path_is_missing .git/sequencer &&
 	{
@@ -120,12 +158,11 @@ test_expect_success 'revert --continue continues after cherry-pick' '
 '
 
 test_expect_success 'mixed pick and revert instructions' '
+	oldsha=`git rev-parse --short HEAD~2` &&
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
 	echo "c" >foo &&
 	git add foo &&
-	git commit &&
-	oldsha=`git rev-parse --short HEAD~1` &&
 	echo "revert $oldsha unrelatedpick" >>.git/sequencer/todo &&
 	git sequencer --continue &&
 	test_path_is_missing .git/sequencer &&
-- 
1.7.6.351.gb35ac.dirty
