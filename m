Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF99C2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934010AbcLMPbw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:31:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:63952 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932778AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLOMM-1cHMzH1qTq-000ZEH; Tue, 13
 Dec 2016 16:29:41 +0100
Date:   Tue, 13 Dec 2016 16:29:40 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 03/34] sequencer (rebase -i): implement the 'edit'
 command
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <a1361151ad1dad8f4dc3c412c7ed30f625d67ba0.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6ZWrZ3bN0IlTT/7xzrTfdjqR77aDosYbGGgQxhhSAya7KPcCB1D
 UTqKa3iLVm+Li1P2l8q2WPhnk2USNA9OK4iera5/UNoIK3FlebvfbyRQ0YH7Y1cP+yyXWct
 JNKGYPtiZjMJwhOkphHGCXj2wIHt47KXAJGLZh8Z/a1XBcJOoiNo1ybJOK5wW++aMJzgufs
 7dN5w5Fx7Zv63d1g/r46A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ER7Fj5Pdyho=:RwqlEkMdTlho6/A7sMubZ7
 AiC9ueyYpAsF1Qr+GjLqYbJM1hGZTkxNTDqnNYAdQa49KycGphy0XWvtmy63uudIgyxLrov4r
 QqUOB0DT3GxG7SwLznHCwk5lUxgytBUogm3pw+hWu/xr98deo0stH+0nXzIGV4d9HcgPRpsC9
 13uf6MtZK7x+q/4Q+Pz09OA4J3ekRya9M9E5TGbK7GCPnoZdktn5T7aoiv8iWAEjKSvoX4roN
 18hlx+KM//knAQDXcGzbY9b5ZepsavxaQXvrgpGt+jHnPEG6Y+gTSzWzxZyB9qHWGqkCW+PGR
 gaTzOdirIfQdwCNgaxdXDpahjs/Dva2p+q7dWSJ9frHb2BPod7esZobRaKlI9QrY//q2nRkNw
 uAnzxZTMVa7rra9FzwUr+k10YLNnwn6Vl8IdRdcIZ1ujP8iGfDnQdd/7KcMKjILn2AnJ/Kn6O
 Gv6KrIMcKPyeb42mR62m7BCU5UFUgZ0afZw/1l+Ut7JjcVKxuHY/K+PC/zgIllBNqTpEjNB0/
 If6Yqb+gfHLxzPbLpKZvBHEPpVbjZ83X/BC0sjLkFSUFdcX2IhiH3DtIFKiB81gOf1k6AHQeN
 IKw7L8LsWrAYoz+G4EFi1fFclRj/aV7iLUm9qjqTwEfepmbUh+KdgNVLE/AORxpvEkXiEtqgN
 wSevCL1fwbNaVuRvmIW0cAmHhm8+TyrU89fq7+EfZJdeNnR/b9msDKmKalBLpX9KwDh2b8MmK
 4fTRHyNtogF7NJxkhld1LFZNynhO33bWLo57DXgwUBgVmEsKN4+Cbc5fszqBqbipoPBL3uXwd
 yw22F/6
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
 sequencer.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1224799286..68e2c84803 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -16,6 +16,7 @@
 #include "refs.h"
 #include "argv-array.h"
 #include "quote.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -43,6 +44,20 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
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
+ * the long commit name of the corresponding patch.
+ */
+static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
+/*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
  */
@@ -648,6 +663,7 @@ enum todo_command {
 	/* commands that handle commits */
 	TODO_PICK = 0,
 	TODO_REVERT,
+	TODO_EDIT,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP
 };
@@ -655,6 +671,7 @@ enum todo_command {
 static const char *todo_command_strings[] = {
 	"pick",
 	"revert",
+	"edit",
 	"noop"
 };
 
@@ -1301,9 +1318,87 @@ static int save_opts(struct replay_opts *opts)
 	return res;
 }
 
+static int make_patch(struct commit *commit, struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct rev_info log_tree_opt;
+	const char *commit_buffer = get_commit_buffer(commit, NULL), *subject, *p;
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
+	}
+	else if (exit_code)
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
@@ -1316,9 +1411,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		struct todo_item *item = todo_list->items + todo_list->current;
 		if (save_todo(todo_list, opts))
 			return -1;
-		if (item->command <= TODO_REVERT)
+		if (item->command <= TODO_EDIT) {
 			res = do_pick_commit(item->command, item->commit,
 					opts);
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
+		}
 		else if (item->command != TODO_NOOP)
 			return error(_("unknown command %d"), item->command);
 
@@ -1327,6 +1433,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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


