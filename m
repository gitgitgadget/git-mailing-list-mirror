Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B458320281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934563AbdIYKL2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:28 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:2445 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932970AbdIYKLM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:12 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQM2dIVIP; Mon, 25 Sep 2017 11:11:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334270; bh=1Th/4lEbzyIVSaTqYH2+VxI5EQ//yQn25Lmyxe9wu8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=LJmgDixxGWjNTPTw3KEo0gMP2qRTTP98BHthGWbXhDbUa3PMMk4V6KYRWvLCZ7PR9
         /qbcOFfz1E1ciMZHFvgefhMicTgRMO00lQIf3ZSZi+rW/aelP+m1DavAqKrQDMEVEl
         a/ZnGuQjCENWb9fTflu5fvUSJ1HhrRah6oCRSvcs=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=WJQUUi1JHkI1yd6wmi0A:9
 a=Pl4ugNyaaASI1V1C:21 a=0Tnc_NT5WfMmt1Bo:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 2/8] commit: move code to update HEAD to libgit
Date:   Mon, 25 Sep 2017 11:10:35 +0100
Message-Id: <20170925101041.18344-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfE4kNZ+VLz2VccYsBojBh3ZlTm418I8E/NjMUXL/sr4xCJBtnV7kTwTNfRAuUU9NS3ASbIzIsTaini4obo+MmRgzlNLS4E9CnMLTGEh0yhuYuHy1XCDF
 X/lKFHjvW5h3jvr7xE7wBWb/NbzOYnhj3RoT149zc7mi+iwJHux2xip3KABKU9QoCr+NcwmVNkwzo2OFGUF5f5uyIcENXmg0ynJ+k+pGtWpX7hbZn5Hdzij+
 lCr8/wM3JnM4QcWmRaeJEsZ88m7q9YUsT1xRvjenQfI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 31 +++++++------------------------
 sequencer.c      | 39 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h      |  2 ++
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0b8c1ef6f57cfed328d12255e6834adb4bda4137..497778ba2c02afdd4a337969a27ca781e8389040 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1578,13 +1578,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
-	char *nl;
 	struct object_id oid;
 	struct commit_list *parents = NULL;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
-	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -1625,10 +1623,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!current_head) {
 		if (!reflog_msg)
-			reflog_msg = "commit (initial)";
+			setenv ("GIT_REFLOG_ACTION", "commit (initial)", 1);
 	} else if (amend) {
 		if (!reflog_msg)
-			reflog_msg = "commit (amend)";
+			setenv("GIT_REFLOG_ACTION", "commit (amend)", 1);
 		parents = copy_commit_list(current_head->parents);
 	} else if (whence == FROM_MERGE) {
 		struct strbuf m = STRBUF_INIT;
@@ -1637,7 +1635,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		struct commit_list **pptr = &parents;
 
 		if (!reflog_msg)
-			reflog_msg = "commit (merge)";
+			setenv("GIT_REFLOG_ACTION", "commit (merge)", 1);
 		pptr = commit_list_append(current_head, pptr);
 		fp = xfopen(git_path_merge_head(), "r");
 		while (strbuf_getline_lf(&m, fp) != EOF) {
@@ -1660,9 +1658,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			parents = reduce_heads(parents);
 	} else {
 		if (!reflog_msg)
-			reflog_msg = (whence == FROM_CHERRY_PICK)
-					? "commit (cherry-pick)"
-					: "commit";
+			setenv("GIT_REFLOG_ACTION", (whence == FROM_CHERRY_PICK)
+						? "commit (cherry-pick)"
+						: "commit", 1);
 		commit_list_insert(current_head, &parents);
 	}
 
@@ -1707,25 +1705,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	nl = strchr(sb.buf, '\n');
-	if (nl)
-		strbuf_setlen(&sb, nl + 1 - sb.buf);
-	else
-		strbuf_addch(&sb, '\n');
-	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
-	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
-
-	transaction = ref_transaction_begin(&err);
-	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", oid.hash,
-				   current_head
-				   ? current_head->object.oid.hash : null_sha1,
-				   0, sb.buf, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	if (update_head (current_head, &oid, &sb, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
 	}
-	ref_transaction_free(transaction);
 
 	unlink(git_path_cherry_pick_head());
 	unlink(git_path_revert_head());
diff --git a/sequencer.c b/sequencer.c
index 319208afb3de36c97b6c62d4ecf6e641245e7a54..917ad4a16216b30adb2c2c9650217926d8db8ba7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,10 +1,10 @@
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
-#include "sequencer.h"
 #include "dir.h"
 #include "object.h"
 #include "commit.h"
+#include "sequencer.h"
 #include "tag.h"
 #include "run-command.h"
 #include "exec_cmd.h"
@@ -750,6 +750,43 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 	return rest_is_empty(sb, start - sb->buf);
 }
 
+int update_head(const struct commit *old_head, const struct object_id *new_head,
+		const struct strbuf *msg, struct strbuf *err)
+{
+	struct ref_transaction *transaction;
+	struct strbuf sb = STRBUF_INIT;
+	const char *nl, *reflog_msg;
+	int ret = 0;
+
+	reflog_msg = getenv("GIT_REFLOG_ACTION");
+	if (!reflog_msg)
+		reflog_msg="";
+
+	nl = strchr(msg->buf, '\n');
+	if (nl) {
+		strbuf_add(&sb, msg->buf, nl + 1 - msg->buf);
+	} else {
+		strbuf_addbuf(&sb, msg);
+		strbuf_addch(&sb, '\n');
+	}
+	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
+	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
+
+	transaction = ref_transaction_begin(err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", new_head->hash,
+				   old_head
+				   ? old_head->object.oid.hash : null_sha1,
+				   0, sb.buf, err) ||
+	    ref_transaction_commit(transaction, err)) {
+		ret = -1;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&sb);
+
+	return ret;
+}
+
 static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
diff --git a/sequencer.h b/sequencer.h
index dd071cfcd82d165bd23726814b74cbf3384e1a17..87edf40e5274d59f48d5af57678100ea220d2c8a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -60,4 +60,6 @@ enum cleanup_mode {
 int message_is_empty(const struct strbuf *sb, enum cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
 		       enum cleanup_mode cleanup_mode);
+int update_head(const struct commit *old_head, const struct object_id *new_head,
+		const struct strbuf *msg, struct strbuf *err);
 #endif
-- 
2.14.1

