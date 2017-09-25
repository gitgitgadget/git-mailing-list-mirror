Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A1B20281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934432AbdIYKLS (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:18 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:50345 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933589AbdIYKLO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:14 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQM3dIVIX; Mon, 25 Sep 2017 11:11:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334272; bh=ClThuZgEpK8GdGg5suIYysfX8oMkNgqi2Cc35C8kXrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ns8jw0xg6r2rudylW+8MHHERUxQ8dGY6tW/B5fnGwD7q9p/AcLPzWytCPs5ZhAFky
         fbkf6/63gpbUBeabAm0cexWdixjqpx9RvcxvvOBwyGYk2I1JVH/+5TnjLXu2z6SHNz
         zjmKNpn1ArAJw7o7Vpq9iE4x4YxydXjvmbeOVIXk=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=9idQjWVEHO6YU0NXrJwA:9
 a=pil_5PD80N1BJnI6:21 a=sIDBOgJs4394h0zz:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 4/8] commit: move post-rewrite code to libgit
Date:   Mon, 25 Sep 2017 11:10:37 +0100
Message-Id: <20170925101041.18344-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCXs7unc8cR8BzYLx0N/Un2m0tB9BQGYctr7s1J5P2peQLxhby96xQGtqX6VC14czhaYm8R2iNXy9Xqp14TYTGbO345gCDg1xFZ/W0oB1MxmKwi2Q8dd
 BYftiWAHn1JgRnlNeIsE7UgJmB5G5zeu8hiWddcQXFNXYk/DxmJiM7I/pHGPRSSIIVdHfHD/KLcuUz4sFL1PWI8ananlp8RGBQpHiucjaYHmMl57kW3fY2Tg
 Uh0Nq5HaOTxB87oxay6XAFeiGVn7dA9pmiW3NkltJFQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 42 +-----------------------------------------
 sequencer.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |  2 ++
 3 files changed, 49 insertions(+), 41 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 497778ba2c02afdd4a337969a27ca781e8389040..9d621098823d196643180226491e43c806154c13 100644
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
@@ -1465,37 +1463,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
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
@@ -1725,14 +1692,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
index 1795a4df2a0021b2419d941c6083e49cd6647314..81bd0810df6bcf2e078abc220bb8984345bf467f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -20,6 +20,8 @@
 #include "trailer.h"
 #include "log-tree.h"
 #include "wt-status.h"
+#include "notes-utils.h"
+#include "sigchain.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -786,6 +788,50 @@ int update_head(const struct commit *old_head, const struct object_id *new_head,
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
+	cfg = init_copy_notes_for_rewrite("amend");
+	if (cfg) {
+		/* we are amending, so current_head is not NULL */
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
index 87edf40e5274d59f48d5af57678100ea220d2c8a..45def684ad751d0b8dc62b6cfdfb819ddf183c89 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -62,4 +62,6 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 		       enum cleanup_mode cleanup_mode);
 int update_head(const struct commit *old_head, const struct object_id *new_head,
 		const struct strbuf *msg, struct strbuf *err);
+void commit_post_rewrite(const struct commit *current_head,
+			 const struct object_id *new_head);
 #endif
-- 
2.14.1

