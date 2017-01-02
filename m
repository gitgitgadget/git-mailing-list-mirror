Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB32205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 15:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756148AbdABP0v (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:26:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:61031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752820AbdABP0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:26:50 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYwyp-1c1g9v0N4V-00Vj9C; Mon, 02
 Jan 2017 16:26:44 +0100
Date:   Mon, 2 Jan 2017 16:26:43 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 06/38] sequencer (rebase -i): implement the 'edit'
 command
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <736f100f4c219ee5c81e1e7b664128785df80521.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9q+d9jwmcaiJVSqx6jfvur8tKI/qQ8O29/lSNKnFKYDkt7+Fx74
 eoY8Z4wyW62KbW4bytVhEeepIY8E0jUyL1T/c7YORIlBVq0SnoJ8KQ5BvEEvnKQoIPclkYG
 eSNgjeOMRXlo4/buF+2VxqT9s8Bybyo+idPU6TbMujI8dCGmUnnQMMWbsBEfxyROSr1I3yW
 382VnhQF7W4aVElY/BUBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m7U9402kwYo=:NkiU0PAHYTUyGSu7pjMoX+
 wrhEzk3sAaIrNBQEIAX0BKFju+xlNE8MgANYtWqV1jCTyLLcbhNlXqJp3AjVxO9gDDEBcdm92
 T8swrrWsNxiR28rtE4Wf90CcPKgrk9bZRV0hngeZci+7bMeCLo+N0QCK6wWtzaONEjXJbZpg0
 8iImJ3yf8RFYVZx5V0RozbVuJre8/lVHawkdT5xt5j3tJlYZbmQGrS/ucFh0FcH6t6LBOMCx/
 YCXBNHp/Yn7ZtpVol45mUS65YD2sZevpywUwFen5MRtxzCund3Svc7uLEEvVRoy0JoD+TzIwR
 sSyz2AgbdnEwFqnsfL6JmkGZvoiUoB9U7eSUr1fhoSFjMAyUCP6seKiM5pQBlXLYw0TzXFByQ
 RGfEKwkahDU7CD1sthggkj8Mwbmqmx+FR+SDXqkG35runMjXOOKnFfTQUbUYuyHf+WB6ibG8a
 oZG7+OeRS67NtNatrn4Icg641tiP3Ph9kHBgmRbutj/ZtWcMNHEn4p5hpeB91WlJV2dEm3Naz
 sjtDYTfyrKWUFWd2E2PeSf4FFQrbwVIQOTHjYUlJVYHtKP5yZ/VCXl4vI7JzJx5mv5KO6ihsA
 06qAm4z6KaVj6pYeNQSz0TAnlA6LZ4iC2dbE6e648/hhn6iMyQF9DAR4MBOYtFjWv8IhDoOb6
 tIFRKhu+JSAw0dYEpN1q0DdmsGH4VMkDwHPspJ2tOl0e338Ho9dkD2ZJlW93jmI5rUTwMGqTM
 xwvEbzAVvaDA0fmOnCgiGWL6f9c6HOvx12WFNriEKoOqIWLVvlhk97szwbMxNWg394JtYiA19
 S5H+oNH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is a straight-forward reimplementation of the `edit`
operation of the interactive rebase command.

Well, not *quite* straight-forward: when stopping, the `edit`
command wants to write the `patch` file (which is not only the
patch, but includes the commit message and author information). To
that end, this patch requires the earlier work that taught the
log-tree machinery to respect the `file` setting of
rev_info->diffopt to write to a file stream different than stdout.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 84f18e64e9..b138a3906c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -17,6 +17,7 @@
 #include "argv-array.h"
 #include "quote.h"
 #include "trailer.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -45,6 +46,20 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
  */
 static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
 /*
+ * When an "edit" rebase command is being processed, the SHA1 of the
+ * commit to be edited is recorded in this file.  When "git rebase
+ * --continue" is executed, if there are any staged changes then they
+ * will be amended to the HEAD commit, but only provided the HEAD
+ * commit is still the commit to be edited.  When any other rebase
+ * command is processed, this file is deleted.
+ */
+static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
+/*
+ * When we stop at a given patch via the "edit" command, this file contains
+ * the abbreviated commit name of the corresponding patch.
+ */
+static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
+/*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
  */
@@ -616,6 +631,7 @@ enum todo_command {
 	/* commands that handle commits */
 	TODO_PICK = 0,
 	TODO_REVERT,
+	TODO_EDIT,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP
 };
@@ -623,6 +639,7 @@ enum todo_command {
 static const char *todo_command_strings[] = {
 	"pick",
 	"revert",
+	"edit",
 	"noop"
 };
 
@@ -1302,9 +1319,87 @@ static int save_opts(struct replay_opts *opts)
 	return res;
 }
 
+static int make_patch(struct commit *commit, struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct rev_info log_tree_opt;
+	const char *subject, *p;
+	int res = 0;
+
+	p = short_commit_name(commit);
+	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
+		return -1;
+
+	strbuf_addf(&buf, "%s/patch", get_dir(opts));
+	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
+	init_revisions(&log_tree_opt, NULL);
+	log_tree_opt.abbrev = 0;
+	log_tree_opt.diff = 1;
+	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
+	log_tree_opt.disable_stdin = 1;
+	log_tree_opt.no_commit_id = 1;
+	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
+	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
+	if (!log_tree_opt.diffopt.file)
+		res |= error_errno(_("could not open '%s'"), buf.buf);
+	else {
+		res |= log_tree_commit(&log_tree_opt, commit);
+		fclose(log_tree_opt.diffopt.file);
+	}
+	strbuf_reset(&buf);
+
+	strbuf_addf(&buf, "%s/message", get_dir(opts));
+	if (!file_exists(buf.buf)) {
+		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		find_commit_subject(commit_buffer, &subject);
+		res |= write_message(subject, strlen(subject), buf.buf, 1);
+		unuse_commit_buffer(commit, commit_buffer);
+	}
+	strbuf_release(&buf);
+
+	return res;
+}
+
+static int intend_to_amend(void)
+{
+	unsigned char head[20];
+	char *p;
+
+	if (get_sha1("HEAD", head))
+		return error(_("cannot read HEAD"));
+
+	p = sha1_to_hex(head);
+	return write_message(p, strlen(p), rebase_path_amend(), 1);
+}
+
+static int error_with_patch(struct commit *commit,
+	const char *subject, int subject_len,
+	struct replay_opts *opts, int exit_code, int to_amend)
+{
+	if (make_patch(commit, opts))
+		return -1;
+
+	if (to_amend) {
+		if (intend_to_amend())
+			return -1;
+
+		fprintf(stderr, "You can amend the commit now, with\n"
+			"\n"
+			"  git commit --amend %s\n"
+			"\n"
+			"Once you are satisfied with your changes, run\n"
+			"\n"
+			"  git rebase --continue\n", gpg_sign_opt_quoted(opts));
+	} else if (exit_code)
+		fprintf(stderr, "Could not apply %s... %.*s\n",
+			short_commit_name(commit), subject_len, subject);
+
+	return exit_code;
+}
+
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
-	int res;
+	int res = 0;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
@@ -1317,10 +1412,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		struct todo_item *item = todo_list->items + todo_list->current;
 		if (save_todo(todo_list, opts))
 			return -1;
-		if (item->command <= TODO_REVERT)
+		if (item->command <= TODO_EDIT) {
 			res = do_pick_commit(item->command, item->commit,
 					opts);
-		else if (!is_noop(item->command))
+			if (item->command == TODO_EDIT) {
+				struct commit *commit = item->commit;
+				if (!res)
+					warning(_("stopped at %s... %.*s"),
+						short_commit_name(commit),
+						item->arg_len, item->arg);
+				return error_with_patch(commit,
+					item->arg, item->arg_len, opts, res,
+					!res);
+			}
+		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
@@ -1328,6 +1433,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			return res;
 	}
 
+	if (is_rebase_i(opts)) {
+		/* Stopped in the middle, as planned? */
+		if (todo_list->current < todo_list->nr)
+			return 0;
+	}
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
-- 
2.11.0.rc3.windows.1


