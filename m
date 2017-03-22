Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2F420323
	for <e@80x24.org>; Wed, 22 Mar 2017 15:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934827AbdCVPC0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 11:02:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:51434 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934687AbdCVPCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 11:02:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1Mt-1ccDI51KKl-00Lr1t; Wed, 22
 Mar 2017 16:02:02 +0100
Date:   Wed, 22 Mar 2017 16:02:01 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 3/3] sequencer: allow the commit-msg hooks to run during a
 `reword`
In-Reply-To: <cover.1490194846.git.johannes.schindelin@gmx.de>
Message-ID: <9b83b6f7012368e970ec2b310f63b4daf66602e5.1490194846.git.johannes.schindelin@gmx.de>
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4huU0B1HjGkXLdm1qBw84DRvqNFlOolUV31wTHqfCxabBpaLzNT
 4BTkkHP8YW2EtVZRa6C2hDTYBvj/o0V1OtyTNNnFwMtslgkeREG5ouCSrE2ehFkYVilFCHY
 hV7Ih1vMv9LSsYQk2INCKQfTE7jIcqT6+03qImLFDSq6tyh28h/jv6fvh11BkuEayIxIhEx
 tK6t/y04VTO5fyiman4Jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2jXk8Rmheok=:FYz89pfxBY7sBznprPWqyi
 /dg39VYrH4BQmCo+oRC7ZKid8Ve4MaNTWL55h+vrE0uinf5vNyD9LezEMaBN0zbyBi1ZlW2aD
 2cuQCOP8v63Dm4Zh7pIq6r2FHQKtsPFJts3588enhTMDhB5Fcus5bAsjk25UWicXpiOGJpH/B
 FjVNEtgmjJjdKS2B2SFEXuyQNCFU/rRh8ieIhBadkZn21dTWRWISdI425we4JPlyjXplXusYt
 cN6wQqdUwx0wWE+Kbcl2Ic/schIRtoKbeTgGWbp/5l4tlpQLSABaZd9zAh3CTEB0Qteqnpddt
 utor6C3sN0+ndiQlNVy7kByGvOUtVslVSzppEVILdMgXW7uho5A/nw4SE6hBnJboD6SFSQUEh
 PAfNGQ3jVcwefdBmF8R6DJtHGMZhVPoQ8adevXIkZlyrVdMi0RJegf2MAtg7vdairSBc7iJS/
 TVRCWjbbTW1NrsMIrcWTTN7d1iNzK8yU++RILJcWC56XGUBgnj3aejx05S0VNCNP7n29sSxEI
 yGKCIcru2G/24A8Zl0ka/RhnRnNzdCcUl6j3Z3lGngFrrZP8YbNXrIIeHytRUQsiH2xDn7A9X
 Myy/5t0mJk8KSl+dPv9fHg+CSjJjCElj4ISQG6SZPAWlqaa11tV6X6C7IfoQmQ5mGToPejThq
 a8zQB1yoF15pieg7YAI4mVGtsc0DaHk29/4qQX0oy6RyAoUvr+ov7ZBo4piZveoclM5ahNriw
 q1uqEMnRi1d1/CvE+Kay5p1pNtcYKC3TIYog6bI+usC8L9cg4DimyhBiRv7jhpCRBs6Ha4fKi
 P/jvFUxkZ+Pn2K7NzIkhsdBuLcZrA==
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
 sequencer.c                | 12 +++++++++---
 t/t7504-commit-msg-hook.sh |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1abe559fe86..377af91c475 100644
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
@@ -993,7 +995,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			write_author_script(msg.message);
 		res = fast_forward_to(commit->object.oid.hash, head, unborn,
 			opts);
-		if (res || command != TODO_REWORD)
+		if (res)
+			goto leave;
+		else if (command == TODO_REWORD)
+			flags |= VERIFY_MSG;
+		else
 			goto leave;
 		flags |= EDIT_MSG | AMEND_MSG;
 		msg_file = NULL;
@@ -1050,7 +1056,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
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
