Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59816EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 22:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjFUWIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFUWIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 18:08:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E9119A8
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687385283; x=1718921283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yeu7Jm4Z7yLWd24nVlVrojaZfZ6VA4UEN9Jq38yMhRY=;
  b=b5p5e8xv/Tiq4lXLjz2P9TZ9nPKhPv4pfeymCRGxZYmImEDfuY4rxz9J
   EuHF7rA1nXAcwfZaG6OxTa4RVZJ5uECLOJOSAHYCJbwdZqO928bJHTjHi
   i7nXcFy5F7t1yOlzMLVTP8z9lbBdPzRAp1N3vCF6KS3xBToZu/2u2XnSj
   vb2PBYl4CRqSKbKYDS3wPgIgiCwtr0WiXybosifD9RRk2zzSGvK2vMmZJ
   vIuxARHA0p4Ou6qToDOHE0Cbf1VEoNqeAlHRCu468P1RS27BedzOTnBQn
   G6qGJ/t+8MeObmtOWjxMO46I4DsTgmZMC76WbtxG0sU0mmdrUckJteWOv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="340661272"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="340661272"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="961358496"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="961358496"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:08:02 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] fix cherry-pick/revert status when doing multiple commits
Date:   Wed, 21 Jun 2023 15:07:54 -0700
Message-ID: <20230621220754.126704-1-jacob.e.keller@intel.com>
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
 wt-status.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 068b76ef6d96..1e2daca73024 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1790,10 +1790,11 @@ void wt_status_get_state(struct repository *r,
 		oidcpy(&state->revert_head_oid, &oid);
 	}
 	if (!sequencer_get_last_command(r, &action)) {
-		if (action == REPLAY_PICK) {
+		if (action == REPLAY_PICK && !state->cherry_pick_in_progress) {
 			state->cherry_pick_in_progress = 1;
 			oidcpy(&state->cherry_pick_head_oid, null_oid());
-		} else {
+		}
+		if (action == REPLAY_REVERT && !state->revert_in_progress) {
 			state->revert_in_progress = 1;
 			oidcpy(&state->revert_head_oid, null_oid());
 		}
-- 
2.41.0.1.g9857a21e0017.dirty

