Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910211F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeJHDIh (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53356 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJHDIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so3213296wma.3
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z52qn2XW4l4R0Et9jJAQuBrEcJQUH2VRy/azWvb8+iE=;
        b=pSgDR9rdadWzNVaOZyPFLwSEPSQ2gowix3WHiKSYmDe4VpLOK+F5QygH1ytr3c5EiT
         ITLzPbH04G1O5HCUCFXgEjwRmEJX/9x43sp5afDM9VmFD82eiQFg4IEUmJE5ZjOwJS21
         fLRZtOv3r7rwmoBTleRv98uhFECgMEJzlI0xf1SeggY5wSSY7o25GrWQ+COXDzB1kSSj
         /pGEZcCrMSl4Lhx4k6dtMM2hFHyGtttoBcWWJwXxRlkucRjrDT1jyVFzP3tnq3d2AlYC
         z8thIVbT+SC965m2u9xx0OUabGMOtEybFCy2oEseFsATp4Zc8pK32S1UQdM+OsAvjUPQ
         KFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z52qn2XW4l4R0Et9jJAQuBrEcJQUH2VRy/azWvb8+iE=;
        b=Eudxm0FxylRzHjVRe39fxlUoCvzbgKMRUlaMJSfIclSk7dqlFlx9M6NN+qSEnUGTyg
         Pl4WN6aL+ENAAfXFep4Zq2+d1cWyOAw64jJumwV5QDSFAjF05Mn3OGf6sSCFR8+Bk2Iu
         Ya+IF1ChYKFmNgfTXmKtQsGfSDimCY4K5NLAi6SlRFxAfdGHMIBmp8LUpGjGIXQJU/X9
         PIrmVPv60z2p+JGjnRZEU3BbPoYLzX3pM908NyV+Wl4U/56+FBkQrT5pbroDoYQAMoDs
         ZyJ+ofjUkR4Alucb2AUBkWFQhSx+m3cuPQLtaPGtlF/BKiToq/TObE5OF3IYisQkUWRp
         nmgQ==
X-Gm-Message-State: ABuFfogXb8z5qCNBJQk1MVBqUU35mSgi4XKQGDGgg+J8y8vsIPTwPtmB
        npf4FEwvEDCPsk+JXPVNs8qHqcsO
X-Google-Smtp-Source: ACcGV6367S29xmw3TOW3t2TJeIWieVZslAftB2nwG4+UXOyurF0vWEPWO/mNQvV6DEwzSsKPjFxPUQ==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr13840068wme.33.1538942412205;
        Sun, 07 Oct 2018 13:00:12 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:11 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 04/15] sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
Date:   Sun,  7 Oct 2018 21:54:07 +0200
Message-Id: <20181007195418.25752-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors sequencer_add_exec_commands() to work on a todo_list to
avoid redundant reads and writes to the disk.

sequencer_add_exec_commands() still reads the todo list from the disk,
as it is needed by rebase -p.  todo_list_add_exec_commands() works on a
todo_list structure, and reparses it at the end.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 56 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8dda61927c..6d998f21a4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4370,34 +4370,21 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	return 0;
 }
 
-/*
- * Add commands after pick and (series of) squash/fixup commands
- * in the todo list.
- */
-int sequencer_add_exec_commands(const char *commands)
+static void todo_list_add_exec_commands(struct todo_list *todo_list,
+					const char *commands)
 {
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	struct strbuf *buf = &todo_list.buf;
+	struct strbuf *buf = &todo_list->buf;
 	size_t offset = 0, commands_len = strlen(commands);
 	int i, insert;
 
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
 	/*
 	 * Insert <commands> after every pick. Here, fixup/squash chains
 	 * are considered part of the pick, so we insert the commands *after*
 	 * those chains if there are any.
 	 */
 	insert = -1;
-	for (i = 0; i < todo_list.nr; i++) {
-		enum todo_command command = todo_list.items[i].command;
+	for (i = 0; i < todo_list->nr; i++) {
+		enum todo_command command = todo_list->items[i].command;
 
 		if (insert >= 0) {
 			/* skip fixup/squash chains */
@@ -4408,7 +4395,7 @@ int sequencer_add_exec_commands(const char *commands)
 				continue;
 			}
 			strbuf_insert(buf,
-				      todo_list.items[insert].offset_in_buf +
+				      todo_list->items[insert].offset_in_buf +
 				      offset, commands, commands_len);
 			offset += commands_len;
 			insert = -1;
@@ -4419,15 +4406,38 @@ int sequencer_add_exec_commands(const char *commands)
 	}
 
 	/* insert or append final <commands> */
-	if (insert >= 0 && insert < todo_list.nr)
-		strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
+	if (insert >= 0 && insert < todo_list->nr)
+		strbuf_insert(buf, todo_list->items[insert].offset_in_buf +
 			      offset, commands, commands_len);
 	else if (insert >= 0 || !offset)
 		strbuf_add(buf, commands, commands_len);
 
-	i = write_message(buf->buf, buf->len, todo_file, 0);
+	if (todo_list_parse_insn_buffer(buf->buf, todo_list))
+		BUG("unusable todo list");}
+
+/*
+ * Add commands after pick and (series of) squash/fixup commands
+ * in the todo list.
+ */
+int sequencer_add_exec_commands(const char *commands)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	todo_list_add_exec_commands(&todo_list, commands);
+	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
 	todo_list_release(&todo_list);
-	return i;
+
+	return res;
 }
 
 int transform_todos(unsigned flags)
-- 
2.19.1

