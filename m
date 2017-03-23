Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9B120958
	for <e@80x24.org>; Thu, 23 Mar 2017 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965571AbdCWQHj (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:07:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:62566 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965540AbdCWQHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:07:37 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIzGn-1ct1DA3Gen-002U9Z; Thu, 23
 Mar 2017 17:07:17 +0100
Date:   Thu, 23 Mar 2017 17:07:17 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 3/3] sequencer: allow the commit-msg hooks to run during
 a `reword`
In-Reply-To: <cover.1490285210.git.johannes.schindelin@gmx.de>
Message-ID: <315c237eb50572f8e109ea547a2010d9f81c3aff.1490285210.git.johannes.schindelin@gmx.de>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <cover.1490285210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sHcXDnlzyNkMOCGoDyJbv3pDsC2CWOand4KcaOnIxfKBvFA6YDW
 b0SJYjRQiRcVRaqurB9vxxgmGi7oQix7+Z4v/eFIScWCad8kycYkFE/LqnTtpdcTYWjqed0
 rqnHNeQqnS1LHAecsyYGjx1MUuOvYG7mK2XUWyvdJnECZ5ETpI3Ueb5vD0glX7SdWPejpOv
 nakpMzfp5S5n8nr+I8fIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pcbTzYvPns8=:7WpGVhZ6gZhUT2mrN5saZ5
 T1ptpy2Bo4gN1l/CRVFmuN5lEEd8n8sOiMJuQQYwqhfTs7WJvYzIbmxOmKL3nUB+9zPuy+bPY
 /Awr5vtq5UXxu9ER71wcBciqUeJ3X/VY2P4QYiMTMfJqTNKtegLfswIW6UipaQjIvkHnTLKBX
 6cp08LlSmRxhuY4J3Ho0w29oBSAj+J008uvUCcjS5AFTQiIE5WNVe/uxxuKmnOzJ+RAENuljk
 7TYIV0zcnsi0iLWOczRlpw6hL3lr2XRNmSVJ5JFj7PRoHcZnRmRH2Og7BVogY8BiRW2//rMbc
 sxKHGMbPMIs8DBDJ1a3KLC6nk+4SEo6tijl3N7m54UTPMwvwyEerWDK0lcfS721vzOgWBofWR
 zUdUwLUZ78ioOO1UZAm7+rAgdPbmRnU6QaxPMdTmijN3j6kjnOtKThEJN8u1uEcbFpatDuq4O
 //0nylMM3iLfxrtPpbYR1CrFgBhsZl4GwuGhPEhPnfMTl2ZLyFdyrpzMKT479zBX5eVo7iv1D
 69soo7ni/yLr0ZEg6eGyVGlKtzuL5mQ/IhZFhc/s6rxRXTIms7l3gjaPXXoIgmNGDgBpRcwwo
 oBY1FiqdaQBXc4Lv6AM7zgFKmwzpH1JV+rgYCnnuZ52aEqn2Mu4YpQ8kzIKe80gSn4VRGy7Gv
 tm+VbKdqSo9W1is0DtZ7mgdzTSiG6PeuizBsc9GHEvBAJPO/6zTt973xLEBB96/PD/IBIV1Ay
 ZUOxxfA9aJRgOxIOfYbTBFwkyn+6mPiIW78iqFxUhCYXlbV5G7fFM8XyPWT/t8igChZmo17Et
 sy3zj+W38XXxyqVGx5GlhPadm3QhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `reword` command used to call `git commit` in a manner that asks for
the prepare-commit-msg and commit-msg hooks to do their thing.

Converting that part of the interactive rebase to C code introduced the
regression where those hooks were no longer run.

Let's fix this.

Note: the flag is called `VERIFY_MSG` instead of the more intuitive
`RUN_COMMIT_MSG_HOOKS` to indicate that the flag suppresses the
`--no-verify` flag (which may do other things in the future in addition
to suppressing the commit message hooks, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                | 8 ++++++--
 t/t7504-commit-msg-hook.sh | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ce05d61a2ae..bc2fe48e65c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -606,6 +606,7 @@ N_("you have staged changes in your working tree\n"
 #define EDIT_MSG    (1<<1)
 #define AMEND_MSG   (1<<2)
 #define CLEANUP_MSG (1<<3)
+#define VERIFY_MSG  (1<<4)
 
 /*
  * If we are cherry-pick, and if the merge did not result in
@@ -642,8 +643,9 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	}
 
 	argv_array_push(&cmd.args, "commit");
-	argv_array_push(&cmd.args, "-n");
 
+	if (!(flags & VERIFY_MSG))
+		argv_array_push(&cmd.args, "-n");
 	if ((flags & AMEND_MSG))
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
@@ -996,6 +998,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		if (res || command != TODO_REWORD)
 			goto leave;
 		flags |= EDIT_MSG | AMEND_MSG;
+		if (command == TODO_REWORD)
+			flags |= VERIFY_MSG;
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
@@ -1050,7 +1054,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 
 	if (command == TODO_REWORD)
-		flags |= EDIT_MSG;
+		flags |= EDIT_MSG | VERIFY_MSG;
 	else if (is_fixup(command)) {
 		if (update_squash_messages(command, commit, opts))
 			return -1;
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index c3d9ab02a3b..88d4cda2992 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -230,7 +230,7 @@ chmod +x reword-editor
 REWORD_EDITOR="$(pwd)/reword-editor"
 export REWORD_EDITOR
 
-test_expect_failure 'hook is called for reword during `rebase -i`' '
+test_expect_success 'hook is called for reword during `rebase -i`' '
 
 	GIT_SEQUENCE_EDITOR="\"$REWORD_EDITOR\"" git rebase -i HEAD^ &&
 	commit_msg_is "new message"
-- 
2.12.1.windows.1
