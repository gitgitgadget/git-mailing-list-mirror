Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496DC2021B
	for <e@80x24.org>; Fri, 10 Nov 2017 11:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdKJLKM (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 06:10:12 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:46249 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbdKJLKG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 06:10:06 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id D7C7etmv6mITaD7CHeDJl9; Fri, 10 Nov 2017 11:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510312205;
        bh=SoVtLVNJfeZQLsd4XYAhnSokGmWG2Vn01i3lSCtrUyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=aFWST7+MCZhpHNQUPDoHqdRuJlLnBykK3uJrfuR2r4dfFefFfj8ofblja6KeTU+1U
         6ee7zosCX9uAb/Oh2Ybtoy9Iz4HkWHR/XpO40dqPNu4i/c9Cy+s4Pj+48N9woR18H7
         3HPp7DKJAWxiJrYCZr5to/r9rmYauAjpZgSQ88RI=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=2KFHKmnFOLNn0y6cwGoA:9
 a=X0cjHmx7Z1TIIcT3:21 a=PaGmMcDjFQlOUU4Q:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/9] Add a function to update HEAD after creating a commit
Date:   Fri, 10 Nov 2017 11:09:43 +0000
Message-Id: <20171110110949.328-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171110110949.328-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfC7HBmRWvkUeHbcT6KjewOYTLBXEFPfqk8uESRrhpaAvj7kpw/CAn+wngYGUx/uG9EZrOaI/jYM/23wg8b4aFPo0w5LDNMDhyZDrs4fEcTnPlJTNJ1WH
 391NYMYUE1q4esN2a7hTPvnEBmRVVKxhVHwMr8uMXJ7oTZikN5/tYnk+XUSj9Y5sOiwozTOXplr6nJFmj1/iwhJzXVE3gkIDYdSvyXNcTgFLVouQLz4y4/Vc
 zoWlHpjpVkbNKum/d0yADhHRqnaX4MGeBlm3zT6msbccRh+/iQmfcyAQaiZs4n1V
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

Notes:
    changes since v1:
     - rename update_head() to update_head_with_reflog()

 builtin/commit.c | 20 ++------------------
 sequencer.c      | 39 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h      |  4 ++++
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index dbc160c525e7a9249b7c7df2180495a4c7102296..7c28144446644a665f7b7d8f4b6c0a5855aef01b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1591,13 +1591,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1720,25 +1718,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
+	if (update_head_with_reflog(current_head, &oid, reflog_msg, &sb,
+				    &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
 	}
-	ref_transaction_free(transaction);
 
 	unlink(git_path_cherry_pick_head());
 	unlink(git_path_revert_head());
diff --git a/sequencer.c b/sequencer.c
index 23c250f16cfb7620215bb9c99b8e12d726dc9191..fcd8e92531a3fb1f0bc1294925e87b3624ada909 100644
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
@@ -752,6 +752,43 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 	return rest_is_empty(sb, start - sb->buf);
 }
 
+int update_head_with_reflog(const struct commit *old_head,
+			    const struct object_id *new_head,
+			    const char *action, const struct strbuf *msg,
+			    struct strbuf *err)
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
index 82e57713a2940c5d65ccac013c3f42c55cc12baf..82035ced129d35ff8ba64710477531a9a713b631 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -69,4 +69,8 @@ int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
 		       enum commit_msg_cleanup_mode cleanup_mode);
+int update_head_with_reflog(const struct commit *old_head,
+			    const struct object_id *new_head,
+			    const char* action, const struct strbuf *msg,
+			    struct strbuf *err);
 #endif
-- 
2.15.0

