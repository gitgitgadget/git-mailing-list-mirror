Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8C7A20958
	for <e@80x24.org>; Thu, 23 Mar 2017 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965561AbdCWQH0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:07:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:59684 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965540AbdCWQHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:07:20 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mam2Q-1cb4aQ25gQ-00KRgY; Thu, 23
 Mar 2017 17:07:12 +0100
Date:   Thu, 23 Mar 2017 17:07:11 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 2/3] sequencer: make commit options more extensible
In-Reply-To: <cover.1490285210.git.johannes.schindelin@gmx.de>
Message-ID: <75e2c4fe839602af19811ed3e251eb583ff6c8ad.1490285210.git.johannes.schindelin@gmx.de>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <cover.1490285210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IkLcxBdPo4uZFsuMH51Lu296egl4NF6CR2DZlYqns4pcq4jhr4B
 GOMeQel1+p0eMSvHP+h09uFTuHIHbQEJE9LoOw2oR1JzDh0tKf92ARnn1YOq/uxuKA3fLF7
 5+fguaErw9DlIbCIPYt0veLuCHnpY4e8fEJ/dzdwku3ohti7KCdvp/lTqFgC5zT5FBgsAe4
 24+eSVMLv44IJajkUtIbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qaon7lKm+dg=:+Rn2OGZbhYywXvQd77mtGp
 zqFfmJNmN+qkeNWK6L2KrFC0x4PBrU4EJnrPiuW2iMkUHxrI2sZXzuLh9905lbW1fAXQHn3sN
 TOrQlofr8Iql0fBw0FIPkEDbcdmOIkDtMm81JDTB8XZ7FEHEdKfStkauGQvIRJgt/N9d+xv9i
 dxzcQo6fw8G8g2fN/Ox7eykD83fQzzpBVJoHRovGazYWgVrpMwXGT5vSNfg/fkL1SPtkrNESw
 JPwqFj5XGqckS0AtAumbce6kyQ8nXs6hd8lpMFSOJ+TGgkNbASBh4cLyhfEPxxX1SAp8ND6gJ
 KA3OjPebTNW/+Iaq911qYvqw13chQtW2piZBEKd63/1Sv41jusWRV2P9fDVLlRT7ggnCi0ohE
 gObyqAsOzC3yz6Ni6As5lyXp0F3JtVMAWHEf38Y0Mc81lskKiNTb71lGRIBpKm8M1OW8g9wKY
 1X+34FOw7VjCXrSRNKuOk5WwvBlb1hwK07mktJXuoHBWq0laDgfuWEEYx0+6mRtKH/8vm+ikT
 JhrVyn0aoe/rNJplXcsoyObZQv8ZZcSym7y/WpwW/S5DLfDOtmPNUehPPrHmoD+OEBkRUAIhu
 I2xrJZthdp6x56wDMrTqXk2Lv8aQEG5SfTf333HcuchG+p5YztTq6VsgymbKLQ2rpv/plKs5o
 QSApCnH+hDt+wd3w+aOlMz0m9ci4gS44i/VlXn401VMO3w5CnjRENjccr8cdN7DsDm8A1Fcvi
 t9gCMKxH/ISpVIgyVriY/Hqr8J0G9d+ni/Hov2HjHG9YFvYjCuiQXPhx3zmY+QmFj9paSW0tx
 tyQ4NlR97XF8GrsDk20FRftMlOCFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was pointed out during review of the sequencer-i patch series (which
taught the sequencer to execute an interactive rebase) that it may be
cumbersome to keep extending the signature of the run_git_commit()
function whenever a new commit option is needed.

While that concern had merit, back then I was reluctant to change even
more than was already asked for (which typically introduces regressions,
this late in the review process, which is no fun for nobody).

Now, with fresh eyes, and with an actual need, is a good time to change
the strategy from adding individual flag parameters to coalescing them
into a single flags parameter.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8183a83c1fa..ce05d61a2ae 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -602,6 +602,11 @@ N_("you have staged changes in your working tree\n"
 "\n"
 "  git rebase --continue\n");
 
+#define ALLOW_EMPTY (1<<0)
+#define EDIT_MSG    (1<<1)
+#define AMEND_MSG   (1<<2)
+#define CLEANUP_MSG (1<<3)
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -615,8 +620,7 @@ N_("you have staged changes in your working tree\n"
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit, int amend,
-			  int cleanup_commit_message)
+			  unsigned int flags)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	const char *value;
@@ -624,7 +628,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts)) {
-		if (!edit) {
+		if (!(flags & EDIT_MSG)) {
 			cmd.stdout_to_stderr = 1;
 			cmd.err = -1;
 		}
@@ -640,7 +644,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_push(&cmd.args, "commit");
 	argv_array_push(&cmd.args, "-n");
 
-	if (amend)
+	if ((flags & AMEND_MSG))
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
@@ -648,16 +652,16 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&cmd.args, "-s");
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
-	if (cleanup_commit_message)
+	if ((flags & CLEANUP_MSG))
 		argv_array_push(&cmd.args, "--cleanup=strip");
-	if (edit)
+	if ((flags & EDIT_MSG))
 		argv_array_push(&cmd.args, "-e");
-	else if (!cleanup_commit_message &&
+	else if (!(flags & CLEANUP_MSG) &&
 		 !opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
 		argv_array_push(&cmd.args, "--cleanup=verbatim");
 
-	if (allow_empty)
+	if ((flags & ALLOW_EMPTY))
 		argv_array_push(&cmd.args, "--allow-empty");
 
 	if (opts->allow_empty_message)
@@ -926,14 +930,14 @@ static void record_in_rewritten(struct object_id *oid,
 static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct replay_opts *opts, int final_fixup)
 {
-	int edit = opts->edit, cleanup_commit_message = 0;
-	const char *msg_file = edit ? NULL : git_path_merge_msg();
+	unsigned int flags = opts->edit ? EDIT_MSG : 0, allow = 0;
+	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, amend = 0, allow = 0;
+	int res, unborn = 0;
 
 	if (opts->no_commit) {
 		/*
@@ -991,7 +995,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			opts);
 		if (res || command != TODO_REWORD)
 			goto leave;
-		edit = amend = 1;
+		flags |= EDIT_MSG | AMEND_MSG;
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
@@ -1046,15 +1050,15 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 
 	if (command == TODO_REWORD)
-		edit = 1;
+		flags |= EDIT_MSG;
 	else if (is_fixup(command)) {
 		if (update_squash_messages(command, commit, opts))
 			return -1;
-		amend = 1;
+		flags |= AMEND_MSG;
 		if (!final_fixup)
 			msg_file = rebase_path_squash_msg();
 		else if (file_exists(rebase_path_fixup_msg())) {
-			cleanup_commit_message = 1;
+			flags |= CLEANUP_MSG;
 			msg_file = rebase_path_fixup_msg();
 		} else {
 			const char *dest = git_path("SQUASH_MSG");
@@ -1064,7 +1068,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 					     rebase_path_squash_msg(), dest);
 			unlink(git_path("MERGE_MSG"));
 			msg_file = dest;
-			edit = 1;
+			flags |= EDIT_MSG;
 		}
 	}
 
@@ -1123,11 +1127,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	if (allow < 0) {
 		res = allow;
 		goto leave;
-	}
+	} else if (allow)
+		flags |= ALLOW_EMPTY;
 	if (!opts->no_commit)
 fast_forward_edit:
-		res = run_git_commit(msg_file, opts, allow, edit, amend,
-				     cleanup_commit_message);
+		res = run_git_commit(msg_file, opts, flags);
 
 	if (!res && final_fixup) {
 		unlink(rebase_path_fixup_msg());
@@ -2154,7 +2158,7 @@ static int continue_single_pick(void)
 
 static int commit_staged_changes(struct replay_opts *opts)
 {
-	int amend = 0;
+	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
 
 	if (has_unstaged_changes(1))
 		return error(_("cannot rebase: You have unstaged changes."));
@@ -2184,10 +2188,10 @@ static int commit_staged_changes(struct replay_opts *opts)
 				       "--continue' again."));
 
 		strbuf_release(&rev);
-		amend = 1;
+		flags |= AMEND_MSG;
 	}
 
-	if (run_git_commit(rebase_path_message(), opts, 1, 1, amend, 0))
+	if (run_git_commit(rebase_path_message(), opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
 	return 0;
-- 
2.12.1.windows.1


