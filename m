Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD82202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdKFLeU (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:34:20 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:15362 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdKFL2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:28:24 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id BfYqeiZ2C3CyHBfZNewtu3; Mon, 06 Nov 2017 11:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509967695; bh=PjQduyRwWvCydPd0uCd9kznO9gCWizoFlJB4asAFB24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=SgjfQ6y4YyHgj6tKatdYoYHwJxCbi+xaAy4UO1ABZLj1sSbehKclCWJKL01lpwkNO
         pUC+f1V3/rLYBWufRuVzUyZRr1s80j2KrXEg14LIO986mHq7mC1AP/X3Pj55wWQfRU
         cIpuynhAP/pmzzth3N42BumxcREdHFT6oBX2wcy0=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=LFz8oBjQBYW4GBmViakA:9
 a=TQzbyl2_1OAoftqt:21 a=PZPXzO-53nP0oUW2:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 2/8] Add a function to update HEAD after creating a commit
Date:   Mon,  6 Nov 2017 11:27:03 +0000
Message-Id: <20171106112709.2121-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171106112709.2121-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKegmSxjB6uVgqPtnKz2kNO1sAuV5uNJ50IEyU0zhr9KXsqzN8v3DXnYtv3uandb3Y4DjXqbz+JaQahXv0Sn863Uh6IwK//WTrPwf3ajBhju2DXQOlVa
 eldnEBnco2QOZ5sfc+Jb8JobMBaHFz5Jhbx08tjbBA8DxCGWKxCT7486EwycLaOoG1NYwKTZci4PfHtRWguipgyzmK5jrcx0EgOebjcEHYrnos4Loca2xO9r
 6i8LUaFM+9jt/eRvlYVKgUkmdYxqnUnobOAP2hZ1tW+NkkQKNtStkGduQvqFUCt6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add update_head() based on the code that updates HEAD after committing
in builtin/commit.c that can be called by 'git commit' and other
commands.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 19 +------------------
 sequencer.c      | 38 +++++++++++++++++++++++++++++++++++++-
 sequencer.h      |  3 +++
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fab512b668af07a1fa927f713eca71c9f783b422..e82754f1fb9f80b8e5b83546d2b2b010daaba522 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1606,13 +1606,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1735,25 +1733,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
-	    ref_transaction_update(transaction, "HEAD", &oid,
-				   current_head
-				   ? &current_head->object.oid : &null_oid,
-				   0, sb.buf, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	if (update_head(current_head, &oid, reflog_msg, &sb, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
 	}
-	ref_transaction_free(transaction);
 
 	unlink(git_path_cherry_pick_head());
 	unlink(git_path_revert_head());
diff --git a/sequencer.c b/sequencer.c
index f4a04c913c0d60adbf78d68ca87db739c8e3a280..a85ad659114248b9b5215641cd2911bc4d02e4df 100644
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
@@ -751,6 +751,42 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 	return rest_is_empty(sb, start - sb->buf);
 }
 
+int update_head(const struct commit *old_head, const struct object_id *new_head,
+		const char *action, const struct strbuf *msg,
+		struct strbuf *err)
+{
+	struct ref_transaction *transaction;
+	struct strbuf sb = STRBUF_INIT;
+	const char *nl;
+	int ret = 0;
+
+	if (action) {
+		strbuf_addstr(&sb, action);
+		strbuf_addstr(&sb, ": ");
+	}
+
+	nl = strchr(msg->buf, '\n');
+	if (nl) {
+		strbuf_add(&sb, msg->buf, nl + 1 - msg->buf);
+	} else {
+		strbuf_addbuf(&sb, msg);
+		strbuf_addch(&sb, '\n');
+	}
+
+	transaction = ref_transaction_begin(err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", new_head,
+				   old_head ? &old_head->object.oid : &null_oid,
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
index 65a4b0c25185d7ad5115035abb766d1b95df9a62..1db06caea35bed556dfaabca1c6be8a80857ed5e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -68,4 +68,7 @@ enum cleanup_mode {
 int message_is_empty(const struct strbuf *sb, enum cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
 		       enum cleanup_mode cleanup_mode);
+int update_head(const struct commit *old_head, const struct object_id *new_head,
+		const char* action, const struct strbuf *msg,
+		struct strbuf *err);
 #endif
-- 
2.14.3

