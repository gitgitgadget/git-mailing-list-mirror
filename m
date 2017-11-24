Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4B9F20954
	for <e@80x24.org>; Fri, 24 Nov 2017 11:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbdKXLIW (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 06:08:22 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57722 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbdKXLIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 06:08:14 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id IBq0eNps6Ap17IBq9eb1Bm; Fri, 24 Nov 2017 11:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511521694;
        bh=2gqtdoLx9XRJm6Ys6mVtL69Tz675mZv7tYrU0mENt0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=hwS3GsdQ69KqwU6WqTUlOkfgvuUaNYowtqOeXEj9sy6IPMSDh2X0pIkGj01WtAbQG
         VFs0VS26YgRMvPiKzFA59WEtM2ZCSN8W/j0kg2cxJOvK7Wn04+q1LxFIsKLR2JqwXs
         d0PM+XUDQ8U4sUm9l/rIzqjF9cNhsN2TrfeaWIa0=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=swPmyTYr8vmIW86sC0sA:9
 a=eF08Hd-Nvrz8L7cY:21 a=DzFob3GGma4QAaSY:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 4/9] commit: move post-rewrite code to libgit
Date:   Fri, 24 Nov 2017 11:07:53 +0000
Message-Id: <20171124110758.9406-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171124110758.9406-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBj3TdXhunxW0QXDBVl7YlczUaNPgOyRaQUkQbxjn3hCoJWH8OifG2xqb91BLGibrkLGW1ceE/h8OC7ETND24df/lRwMGHJoIAWtL0k8yEvkr3vK69t5
 IpltUwnqXaz+lPOogw6w1zagfW67ftTwmgYYHBcts2uccqP+B7w0q1vYTC6FQamBZgE4tsgqjLh80EAUBBYkLffiNztbnQ7P9SbnPUGO2jpoJWN9XBbnlV7c
 Y3PjdSrRBQWrc8J1nBRLRM9CfyKIUqgstfTYcRxlVXh6ikzqofBCAISFmv9wEtjh78lgvPsJwfTaVRdbZGpV1G72no7ZKPWhIC2kzRItGAyU5NiDMmiHXQsI
 ejYGafWO+JrVEijU/dPtkl2jKFDSB09HlcWaquu2Vg8ioxwjLns=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move run_rewrite_hook() from bulitin/commit.c to sequencer.c so it can
be shared with other commands and add a new function
commit_post_rewrite() based on the code in builtin/commit.c that
encapsulates rewriting notes and running the post-rewrite hook. Once
the sequencer learns how to create commits without forking 'git
commit' these functions will be used when squashing commits.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v1:
     - reword commit message to explain why the code is being moved

 builtin/commit.c | 42 +-----------------------------------------
 sequencer.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |  2 ++
 3 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eb144556bf37b7bf357bd976b94305171b4fd159..d251cfcebad3476c365492d83803e7821fdfdf2b 100644
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
@@ -1497,37 +1495,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
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
@@ -1758,14 +1725,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
index ef262980c5255d90ee023c0b29c6c1c628b3c7d2..6bc8346d42bb3cb1d2dc6a2238dd1b38e4308914 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -21,6 +21,8 @@
 #include "log-tree.h"
 #include "wt-status.h"
 #include "hashmap.h"
+#include "notes-utils.h"
+#include "sigchain.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -789,6 +791,51 @@ int update_head_with_reflog(const struct commit *old_head,
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
index 81a2098e900f0aca30e45ed7f19ae4bf3ce682f0..ec13b679c40dc4012a84a761ea856d6e75953490 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -73,4 +73,6 @@ int update_head_with_reflog(const struct commit *old_head,
 			    const struct object_id *new_head,
 			    const char *action, const struct strbuf *msg,
 			    struct strbuf *err);
+void commit_post_rewrite(const struct commit *current_head,
+			 const struct object_id *new_head);
 #endif
-- 
2.15.0

