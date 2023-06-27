Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C2EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 22:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjF0Wmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 18:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0Wmi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 18:42:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD01FD5
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687905757; x=1719441757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a2n7UonGv71TtwIgNypoX3dt7Nw/EpLmBfm3wFTyiFg=;
  b=O8tLvieIjf44xVzQ4xWeThs/0NDhXuxhYRCpfIay8wh+hxrmHTB/7CAv
   FAcOaaV3lVaCWX0SeGOxSW/7I9ZywC9JuApzTEJFUNMJNi9SYxQE8YvsG
   oCvoioaX9y2TeRvda+u4S4msbPyOh/O9hm4fbB66jCE7RSPQ87reiQvfh
   lA57sGueZniBBk+stllq03zOc++jEqRYXE37dts/AU2Ge6Bt9CuHVbRsY
   5MQN1TIXFV6qQogJOuVDfb0/OKshqWB2l8LdbQNdV0ck2leKFveqZVaCe
   J1pPWLyfHYY+na1wiHMxOLC0Z43taQWBrkOr7+E+YjvL7CDHJWmX+icZp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448082650"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="448082650"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 15:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="840847652"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="840847652"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 15:42:36 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2] fix cherry-pick/revert status when doing multiple commits
Date:   Tue, 27 Jun 2023 15:41:50 -0700
Message-ID: <20230627224230.1951135-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0.1.g9857a21e0017.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

The status report for an in-progress cherry-pick does not show the
current commit if the cherry-pick happens as part of a series of
multiple commits:

 $ git cherry-pick <commit1> <commit2>
 < one of the cherry-picks fails to merge clean >
 Cherry-pick currently in progress.
  (run "git cherry-pick --continue" to continue)
  (use "git cherry-pick --skip" to skip this patch)
  (use "git cherry-pick --abort" to cancel the cherry-pick operation)

 $ git status
 On branch <branch>
 Your branch is ahead of '<upstream>' by 1 commit.
   (use "git push" to publish your local commits)

 Cherry-pick currently in progress.
   (run "git cherry-pick --continue" to continue)
   (use "git cherry-pick --skip" to skip this patch)
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)

The show_cherry_pick_in_progress() function prints "Cherry-pick
currently in progress". That function does have a more verbose print
based on whether the cherry_pick_head_oid is null or not. If it is not
null, then a more helpful message including which commit is actually
being picked is displayed.

The introduction of the "Cherry-pick currently in progress" message
comes from 4a72486de97b ("fix cherry-pick/revert status after commit",
2019-04-17). This commit modified wt_status_get_state() in order to
detect that a cherry-pick was in progress even if the user has used `git
commit` in the middle of the sequence.

The check used to detect this is the call to sequencer_get_last_command.
If the sequencer indicates that the lass command was a REPLAY_PICK, then
the state->cherry_pick_in_progress is set to 1 and the
cherry_pick_head_oid is initialized to the null_oid. Similar behavior is
done for the case of REPLAY_REVERT.

It happens that this call of sequencer_get_last_command will always
report the action even if the user hasn't interrupted anything. Thus,
during a range of cherry-picks or reverts, the cherry_pick_head_oid and
revert_head_oid will always be overwritten and initialized to the null
oid.

This results in status always displaying the terse message which does
not include commit information.

Fix this by adding an additional check so that we do not re-initialize
the cherry_pick_head_oid or revert_head_oid if we have already set the
cherry_pick_in_progress or revert_in_progress bits. This ensures that
git status will display the more helpful information when its available.
Add a test case covering this behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Changes since v1:
* add the missing test case that I had locally but forgot to squash in
* use else if as suggested by Phillip

 t/t7512-status-help.sh | 22 ++++++++++++++++++++++
 wt-status.c            |  4 ++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 2f16d5787edf..c2ab8a444a83 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -774,6 +774,28 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'status when cherry-picking multiple commits' '
+	git reset --hard cherry_branch &&
+	test_when_finished "git cherry-pick --abort" &&
+	test_must_fail git cherry-pick cherry_branch_second one_cherry &&
+	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
+	cat >expected <<EOF &&
+On branch cherry_branch
+You are currently cherry-picking commit $TO_CHERRY_PICK.
+  (fix conflicts and run "git cherry-pick --continue")
+  (use "git cherry-pick --skip" to skip this patch)
+  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
+
+Unmerged paths:
+  (use "git add <file>..." to mark resolution)
+	both modified:   main.txt
+
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'status when cherry-picking after committing conflict resolution' '
 	git reset --hard cherry_branch &&
 	test_when_finished "git cherry-pick --abort" &&
diff --git a/wt-status.c b/wt-status.c
index 068b76ef6d96..8d23ff8ced23 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1790,10 +1790,10 @@ void wt_status_get_state(struct repository *r,
 		oidcpy(&state->revert_head_oid, &oid);
 	}
 	if (!sequencer_get_last_command(r, &action)) {
-		if (action == REPLAY_PICK) {
+		if (action == REPLAY_PICK && !state->cherry_pick_in_progress) {
 			state->cherry_pick_in_progress = 1;
 			oidcpy(&state->cherry_pick_head_oid, null_oid());
-		} else {
+		} else if (action == REPLAY_REVERT && !state->revert_in_progress) {
 			state->revert_in_progress = 1;
 			oidcpy(&state->revert_head_oid, null_oid());
 		}
-- 
2.41.0.1.g9857a21e0017.dirty

