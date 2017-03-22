Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB4820323
	for <e@80x24.org>; Wed, 22 Mar 2017 15:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760683AbdCVPCC (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 11:02:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:58175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760655AbdCVPCA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 11:02:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MexaL-1cXEwy3lZx-00Oanc; Wed, 22
 Mar 2017 16:01:54 +0100
Date:   Wed, 22 Mar 2017 16:01:53 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/3] sequencer: make commit options more extensible
In-Reply-To: <cover.1490194846.git.johannes.schindelin@gmx.de>
Message-ID: <c0c836e1f1739af25ad875419ee6125b53ac6a1a.1490194846.git.johannes.schindelin@gmx.de>
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TO5xFclI6FjjSE/1vZa7xAZkUkAIJ8FhRw5uU8s+CK5lkXTk+54
 wBHetFM0HYV1mjBDFF00bbifNojNQhYZJi2wzd20AzGL8hya6kVKPEJM4+2af4cZxOanUBS
 bXs6bwhbU48pNe/Xc+/cPxHwV27yiLQbeDz4mYrE6Y4/DchpWX3QNJsZ/E++49GTAGQIrPy
 HixWKcjBgJjzN4Pl0wQnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Br4qvA4LzMY=:qxQ1IQTMU7SxoRxNA93c1u
 ugQS5q51FkXdKqn/Iuglkh0rTG1m13ZX2YaB3MLiSRy/Wu4KbHU+jfcS+/Tn2IYdQI6y0J7jZ
 YizLtNNE82Jwe0XD4V+CR0ulb8rqDdNuYL/wpNHAqTIkAI1z3/+l05YlhpHU2+RPP0G/mmT1c
 pjfSHjskBIPHNdFVtbM3P2ctp5K4RDy8udlL+WbSEiIKcP6RK7vUTQy+DORz6XxDznQj7gIf+
 XZzlzDmgApD9POAgOe4+Spq95rYBWv7B82CSdsEveu6pzaxVE9rlr7gkSA4GzfIWDf/8gdili
 0X4k3SybehkteHfchriO7Pl2qJ+FLJfb6jim5ZhLOQYMJ45vE7Yiu7znEDt2SvOheBZwIoSAR
 PI9cOXLS8gyecMWgcOhxf9T26TBdFseEbpunFEJgaxSHoBG7TjHyLwCrUNy8YtWYzG8F7a8qO
 /o3Q5D8VAMacNzPizjGyEXBdJ9nvjf1oeQY0hfHEs1NL5xmAAWckKGyxoNjr3/6pTvhov8Vqp
 kwNdsuBipZEqj4VrZKztnTzgSy/ToLOTFy7vgemLFzLdSHwioiZahxgg3tHIsgjlASZvJ8MZA
 ++dv7wltm1OuSrwh0aDxHajI/2NGG0pIZ3ZuN90T36EHK7awdJ5mBUNfc81XF3/xlsqNV+/Eu
 npkN7AwMzUOHr3zHpXhdSRTHGTJwM7HnzFuFsiaLUfWxoa8qzFo+YGlFEraSKu52M8xurK4wN
 jioyx5wl5a1cGDtopJadN1H0slzn+6pHbzED7hLP5V/QXMlGvm4GRBBffGtso/mmq2XKAfMbL
 4f7PDPt33OR5tBuMYjrOOK6puN+EQ==
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
index 8183a83c1fa..1abe559fe86 100644
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
+			  int flags)
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
+	int flags = opts->edit ? EDIT_MSG : 0, allow = 0;
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
+	int flags = ALLOW_EMPTY | EDIT_MSG;
 
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


