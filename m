Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C369201C8
	for <e@80x24.org>; Fri, 17 Nov 2017 11:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbdKQLgV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 06:36:21 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:23070 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754480AbdKQLgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 06:36:11 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id FevAeP1Zopb8rFewMexNEo; Fri, 17 Nov 2017 11:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510918570;
        bh=VoCKEU9FF/ayhKEEwRnsD/DNSrtW87zZvA6Jf/ugte0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=OyVHSQg7jaG2HPu3oDF4oooYpTI1BC5OTI0zr3zJXk3s7llB6sNWkbAJLFJcW0RVz
         1Elb4356ZPDH+23PJzjCDkHcFAQQNFzg0d7snjaZnU0K4ifmw5QJfvHqig//hrLtGU
         RMNuMaRGP0O/g20UhI6SxZ8EAl5dKJ2xC64e6DSk=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=lwQX8hbtY5LG0p_dRqUA:9
 a=YtLniJEHI1pBiEd6:21 a=YqjHFiUZr1EcQFKv:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 3/8] Add a function to update HEAD after creating a commit
Date:   Fri, 17 Nov 2017 11:34:47 +0000
Message-Id: <20171117113452.26597-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171117113452.26597-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171117113452.26597-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfAoRElqU1k/UCRN4D7X9gbMvIvg+3RWweJ+c12CXNLvN40SPoKSxQuB/WJz8MVrGNRaW3FKyPGuq+GMOILA3P0F7wr2xZRrJqAgG2uqHGTJK9qNMRNuS
 l+blHUipchWK3QqKwYpdlqe+fTRCfw9W394tC8WrMYNSi+KVAYJOh/6Ja+iY8D0n9xrxr0BoPMBEeZIBv7mR2o9sirKuCVT9nDzZYbqq57o2w5XWVbjQ8RDm
 LxXK6FFDqD2xzuE1RV2wX8SwWEvrUEZby0gVXsdldm5aVndZEWRGbJyzAC5agsb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add update_head_with_reflog() based on the code that updates HEAD
after committing in builtin/commit.c that can be called by 'git
commit' and other commands.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - updated commit message to reflect the change in function name
     - style fixes
    
    changes since v1:
     - rename update_head() to update_head_with_reflog()

 builtin/commit.c | 20 ++------------------
 sequencer.c      | 39 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h      |  4 ++++
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d958c2eb2adc9a29dab29340ce9b56daea41fecd..eb144556bf37b7bf357bd976b94305171b4fd159 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1610,13 +1610,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1739,25 +1737,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
index 36e03d041f32bcc0fdd1fddebb33b23c7e4d8a70..ef262980c5255d90ee023c0b29c6c1c628b3c7d2 100644
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
index 82e57713a2940c5d65ccac013c3f42c55cc12baf..81a2098e900f0aca30e45ed7f19ae4bf3ce682f0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -69,4 +69,8 @@ int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
 		       enum commit_msg_cleanup_mode cleanup_mode);
+int update_head_with_reflog(const struct commit *old_head,
+			    const struct object_id *new_head,
+			    const char *action, const struct strbuf *msg,
+			    struct strbuf *err);
 #endif
-- 
2.15.0

