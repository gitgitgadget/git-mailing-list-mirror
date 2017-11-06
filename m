Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24ED0202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbdKFL2n (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:28:43 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:10561 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbdKFL2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:28:41 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id BfYqeiZ2C3CyHBfZhewtvg; Mon, 06 Nov 2017 11:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509967714; bh=hLO0Hsabg+JNKKp8vrYY4oLiPFSXa3pyq0diYKeq+Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=WWt4t5U6IXjTXgS3sF110JCbRBqMatGprC3rwzxo00BHJQ/mLxbx2wHrISIX3NNHS
         2uSM8XS3dy2r/PvcNzfBq8Q56+LfIA/N9L8V31S1SvRSXIAC+OVaqooQfjg7vZM0aW
         4BLBQ/yBF1LaVeVyRtvV8OgZDebdjGhEQOSHGgrE=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=SHjO67hjHJaZrGLTU5MA:9
 a=-Jliqa836x2W7NUv:21 a=GVKkjcRhWSG3-E9I:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 3/8] commit: move post-rewrite code to libgit
Date:   Mon,  6 Nov 2017 11:27:04 +0000
Message-Id: <20171106112709.2121-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171106112709.2121-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfE2xou7WNm6cqommGXVY21xAhBqDHXnWTivPZox5DgJ84o+l5FidktFi9joiewUR0MLrNWg4AGO3OxQ6hBOmy7bBFPn9emMD3t4Z1zhr4dEWbdlTM/Hj
 EFgbTOwAa1ABcofe8Z+DuD74lY2WYs1v95O6tQAG3TPidUfV89oGP49bgrJ80Tu/C/N38FA2JcQImrEXNU+5m7jYQeHbE6o9rHAkFMOvCcXYZGTxuawnMeP9
 7R6XPpuj1bfP/o2S+mo2oMIvHjlV7ls4c67qOSmBs7rb/kP/9VLMMoRfPim1u5Sj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move run_rewrite_hook() from bulitin/commit.c to sequencer.c so it can
be shared with other commands and add a new function
commit_post_rewrite() based on the code in builtin/commit.c that
encapsulates rewriting notes and running the post-rewrite hook.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 42 +-----------------------------------------
 sequencer.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |  2 ++
 3 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e82754f1fb9f80b8e5b83546d2b2b010daaba522..4f0092b91b9553855fe16864b16b7779b7d1f330 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -31,9 +31,7 @@
 #include "gpg-interface.h"
 #include "column.h"
 #include "sequencer.h"
-#include "notes-utils.h"
 #include "mailmap.h"
-#include "sigchain.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -1493,37 +1491,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	return git_status_config(k, v, s);
 }
 
-static int run_rewrite_hook(const struct object_id *oldoid,
-			    const struct object_id *newoid)
-{
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *argv[3];
-	int code;
-	struct strbuf sb = STRBUF_INIT;
-
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
-		return 0;
-
-	argv[1] = "amend";
-	argv[2] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-
-	code = start_command(&proc);
-	if (code)
-		return code;
-	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
-	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, sb.buf, sb.len);
-	close(proc.in);
-	strbuf_release(&sb);
-	sigchain_pop(SIGPIPE);
-	return finish_command(&proc);
-}
-
 int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
 {
 	struct argv_array hook_env = ARGV_ARRAY_INIT;
@@ -1753,14 +1720,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	rerere(0);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
-		struct notes_rewrite_cfg *cfg;
-		cfg = init_copy_notes_for_rewrite("amend");
-		if (cfg) {
-			/* we are amending, so current_head is not NULL */
-			copy_note_for_rewrite(cfg, &current_head->object.oid, &oid);
-			finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
-		}
-		run_rewrite_hook(&current_head->object.oid, &oid);
+		commit_post_rewrite(current_head, &oid);
 	}
 	if (!quiet)
 		print_summary(prefix, &oid, !current_head);
diff --git a/sequencer.c b/sequencer.c
index a85ad659114248b9b5215641cd2911bc4d02e4df..6d9e393f8368ac03d92019189f9fccd6a3ba1d77 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -21,6 +21,8 @@
 #include "log-tree.h"
 #include "wt-status.h"
 #include "hashmap.h"
+#include "notes-utils.h"
+#include "sigchain.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -787,6 +789,51 @@ int update_head(const struct commit *old_head, const struct object_id *new_head,
 	return ret;
 }
 
+static int run_rewrite_hook(const struct object_id *oldoid,
+			    const struct object_id *newoid)
+{
+	struct child_process proc = CHILD_PROCESS_INIT;
+	const char *argv[3];
+	int code;
+	struct strbuf sb = STRBUF_INIT;
+
+	argv[0] = find_hook("post-rewrite");
+	if (!argv[0])
+		return 0;
+
+	argv[1] = "amend";
+	argv[2] = NULL;
+
+	proc.argv = argv;
+	proc.in = -1;
+	proc.stdout_to_stderr = 1;
+
+	code = start_command(&proc);
+	if (code)
+		return code;
+	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
+	sigchain_push(SIGPIPE, SIG_IGN);
+	write_in_full(proc.in, sb.buf, sb.len);
+	close(proc.in);
+	strbuf_release(&sb);
+	sigchain_pop(SIGPIPE);
+	return finish_command(&proc);
+}
+
+void commit_post_rewrite(const struct commit *old_head,
+			 const struct object_id *new_head)
+{
+	struct notes_rewrite_cfg *cfg;
+
+	cfg = init_copy_notes_for_rewrite("amend");
+	if (cfg) {
+		/* we are amending, so old_head is not NULL */
+		copy_note_for_rewrite(cfg, &old_head->object.oid, new_head);
+		finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
+	}
+	run_rewrite_hook(&old_head->object.oid, new_head);
+}
+
 static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
diff --git a/sequencer.h b/sequencer.h
index 1db06caea35bed556dfaabca1c6be8a80857ed5e..5734c8a3d869564354e5193c52bf45c119a8b840 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -71,4 +71,6 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 int update_head(const struct commit *old_head, const struct object_id *new_head,
 		const char* action, const struct strbuf *msg,
 		struct strbuf *err);
+void commit_post_rewrite(const struct commit *current_head,
+			 const struct object_id *new_head);
 #endif
-- 
2.14.3

