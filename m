Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C959E1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeKIRsF (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42902 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeKIRsF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so865162wru.9
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nb4AJRXGh2qNyydiwDl3R1Gk3/8v2N+Z3YmaNoiVVOU=;
        b=KbwmpThbfFmauYhzjdUABe4S2JQd1WJOKAJ6s6mpRUNB6bkQXQ50FFs5EoCuQxJxUW
         hOcdJ8kuqDaa5n6DjXG+OslFrbQ7NxM1mL8XMfCq8PjoZ+dXZEFR8a28YwZxq/SgtyiN
         BKpxIR8Go6/VqNdMW3TZR510CZnqiMTu2j037Xc0wxFJXyml8kkpW1rrgCMCJDMFAK2o
         RBN4ETYg+5g3BXm7BzodiUi5S1SKdL/j//UFCN0wNFEQ5qVp29jogJQn+5mo3uagpOhD
         LHOeJ+j4d2IxCnzw8oxtTnTFw5CX0H61fgdmLN0Oiz6K3rcMSOCnjMxXsZN/MdXf0IK3
         4A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nb4AJRXGh2qNyydiwDl3R1Gk3/8v2N+Z3YmaNoiVVOU=;
        b=lxJ+RXLLCYTo/X9jVSzfrZk9frPRjend4hGOfeT2jrtl8i/9aGKieF4WNSZbh9JOvx
         a1VKusR0rgVTp2QcSrQJtLCKutqMYZffqUQwFmoTANbaqECdP5BJjEyjd4M+AZK6qqSJ
         QQfN8yYvqEtgQvav+INTUFfpibCti+2kF54tqdNODfQXOj/Hm+JPid2Mgatc8imsK7Xe
         hLT/t96PRhZ1NyCZHQMNWpk0UNz7RHxbb9kyC3CZV1tRITEBfFAsnMT83oY35zfZCfDY
         Gsdk9eNdKP6TSQf4poW4jQ+c2vg2+9WUfEFdYe4CW7nPsjRZ91SWJ5bOkL4uQ5RAUPgo
         MdEA==
X-Gm-Message-State: AGRZ1gJ6E9HfFuab9ZBifVGoOYTUuApwQH/SuzAXoURvJQJnhb64qUBG
        Jkan3XCv6++WIy5itkUJbtuJgEB9
X-Google-Smtp-Source: AJdET5fFYRjHvi3rVK+nVHkwdhXR2OCuWX9ostU9ohclYLfBXJvAYm6vzmZ8DS9Sy4bhLlH8SweA2w==
X-Received: by 2002:a5d:4682:: with SMTP id u2-v6mr6816430wrq.39.1541750917615;
        Fri, 09 Nov 2018 00:08:37 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:37 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 06/16] sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
Date:   Fri,  9 Nov 2018 09:07:55 +0100
Message-Id: <20181109080805.6350-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors sequencer_add_exec_commands() to work on a todo_list to
avoid redundant reads and writes to the disk.

Instead of just inserting the `exec' command between the other commands,
and re-parsing the buffer at the end the exec command is appended to the
buffer once, and a new list of items is created.  Items from the old
list are copied across and new `exec' items are appended when
necessary.  This eliminates the need to reparse the buffer, but this
also means we have to use todo_list_write_to_disk() to write the file().

todo_list_add_exec_commands() and sequencer_add_exec_commands() are
modified to take a string list instead of a string -- one item for each
command.  This makes it easier to insert a new command to the todo list
for each command to execute.

sequencer_add_exec_commands() still reads the todo list from the disk,
as it is needed by rebase -p.

complete_action() still uses sequencer_add_exec_commands() for now.
This will be changed in a future commit.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c |  15 +++--
 sequencer.c                   | 111 +++++++++++++++++++++-------------
 sequencer.h                   |   4 +-
 3 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index c1d87c0fe6..1fb5a43c0d 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -65,7 +65,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 				 const char *onto, const char *onto_name,
 				 const char *squash_onto, const char *head_name,
 				 const char *restrict_revision, char *raw_strategies,
-				 const char *cmd, unsigned autosquash)
+				 struct string_list *commands, unsigned autosquash)
 {
 	int ret;
 	const char *head_hash = NULL;
@@ -115,7 +115,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	else {
 		discard_cache();
 		ret = complete_action(opts, flags, shortrevisions, onto_name, onto,
-				      head_hash, cmd, autosquash);
+				      head_hash, commands, autosquash);
 	}
 
 	free(revisions);
@@ -138,6 +138,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
 		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
 		*switch_to = NULL, *cmd = NULL;
+	struct string_list commands = STRING_LIST_INIT_DUP;
 	char *raw_strategies = NULL;
 	enum {
 		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
@@ -220,6 +221,12 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
+	if (cmd && *cmd) {
+		string_list_split(&commands, cmd, '\n', -1);
+		if (strlen(commands.items[commands.nr - 1].string) == 0)
+			--commands.nr;
+	}
+
 	switch (command) {
 	case NONE:
 		if (!onto && !upstream)
@@ -227,7 +234,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
 					    onto_name, squash_onto, head_name, restrict_revision,
-					    raw_strategies, cmd, autosquash);
+					    raw_strategies, &commands, autosquash);
 		break;
 	case SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
@@ -261,7 +268,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = rearrange_squash();
 		break;
 	case ADD_EXEC:
-		ret = sequencer_add_exec_commands(cmd);
+		ret = sequencer_add_exec_commands(&commands);
 		break;
 	default:
 		BUG("invalid command '%d'", command);
diff --git a/sequencer.c b/sequencer.c
index 900899ef20..11692d0b98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4394,24 +4394,29 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	return 0;
 }
 
-/*
- * Add commands after pick and (series of) squash/fixup commands
- * in the todo list.
- */
-int sequencer_add_exec_commands(const char *commands)
+static void todo_list_add_exec_commands(struct todo_list *todo_list,
+					struct string_list *commands)
 {
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	struct strbuf *buf = &todo_list.buf;
-	size_t offset = 0, commands_len = strlen(commands);
-	int i, insert;
+	struct strbuf *buf = &todo_list->buf;
+	const char *old_buf = buf->buf;
+	size_t base_length = buf->len;
+	int i, insert, nr = 0, alloc = 0;
+	struct todo_item *items = NULL, *base_items = NULL;
 
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
+	for (i = 0; i < commands->nr; ++i) {
+		strbuf_addstr(buf, commands->items[i].string);
+		strbuf_addch(buf, '\n');
+	}
 
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
+	base_items = xcalloc(commands->nr, sizeof(struct todo_item));
+	for (i = 0; i < commands->nr; ++i) {
+		size_t command_len = strlen(commands->items[i].string) - strlen("exec ");
+
+		base_items[i].command = TODO_EXEC;
+		base_items[i].offset_in_buf = base_length + strlen("exec ");
+		base_items[i].arg = buf->buf + base_items[i].offset_in_buf;
+		base_items[i].arg_len = command_len;
+		base_length = base_items[i].offset_in_buf + base_items[i].arg_len + 1;
 	}
 
 	/*
@@ -4420,38 +4425,62 @@ int sequencer_add_exec_commands(const char *commands)
 	 * those chains if there are any.
 	 */
 	insert = -1;
-	for (i = 0; i < todo_list.nr; i++) {
-		enum todo_command command = todo_list.items[i].command;
-
-		if (insert >= 0) {
-			/* skip fixup/squash chains */
-			if (command == TODO_COMMENT)
-				continue;
-			else if (is_fixup(command)) {
-				insert = i + 1;
-				continue;
-			}
-			strbuf_insert(buf,
-				      todo_list.items[insert].offset_in_buf +
-				      offset, commands, commands_len);
-			offset += commands_len;
+	for (i = 0; i < todo_list->nr; i++) {
+		enum todo_command command = todo_list->items[i].command;
+		if (todo_list->items[i].arg)
+			todo_list->items[i].arg = todo_list->items[i].arg - old_buf + buf->buf;
+
+		if (insert >= 0 && command != TODO_COMMENT && !is_fixup(command)) {
+			ALLOC_GROW(items, nr + commands->nr, alloc);
+			COPY_ARRAY(items + nr, base_items, commands->nr);
+			nr += commands->nr;
 			insert = -1;
 		}
 
-		if (command == TODO_PICK || command == TODO_MERGE)
+		ALLOC_GROW(items, nr + 1, alloc);
+		items[nr++] = todo_list->items[i];
+
+		if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))
 			insert = i + 1;
 	}
 
 	/* insert or append final <commands> */
-	if (insert >= 0 && insert < todo_list.nr)
-		strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
-			      offset, commands, commands_len);
-	else if (insert >= 0 || !offset)
-		strbuf_add(buf, commands, commands_len);
+	if (insert >= 0 || nr == todo_list->nr) {
+		ALLOC_GROW(items, nr + commands->nr, alloc);
+		COPY_ARRAY(items + nr, base_items, commands->nr);
+		nr += commands->nr;
+	}
+
+	free(base_items);
+	FREE_AND_NULL(todo_list->items);
+	todo_list->items = items;
+	todo_list->nr = nr;
+	todo_list->alloc = alloc;
+}
+
+/*
+ * Add commands after pick and (series of) squash/fixup commands
+ * in the todo list.
+ */
+int sequencer_add_exec_commands(struct string_list *commands)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
 
-	i = write_message(buf->buf, buf->len, todo_file, 0);
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	todo_list_add_exec_commands(&todo_list, commands);
+	res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, -1, 0);
 	todo_list_release(&todo_list);
-	return i;
+
+	return res;
 }
 
 static void todo_list_to_strbuf(struct todo_list *todo_list, struct strbuf *buf,
@@ -4677,7 +4706,7 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    const char *onto, const char *orig_head, const char *cmd,
+		    const char *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash)
 {
 	const char *shortonto, *todo_file = rebase_path_todo();
@@ -4696,8 +4725,8 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	if (autosquash && rearrange_squash())
 		return -1;
 
-	if (cmd && *cmd)
-		sequencer_add_exec_commands(cmd);
+	if (commands->nr)
+		sequencer_add_exec_commands(commands);
 
 	if (strbuf_read_file(buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
diff --git a/sequencer.h b/sequencer.h
index c78f00aadd..d7b52044bd 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -140,12 +140,12 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
-int sequencer_add_exec_commands(const char *command);
+int sequencer_add_exec_commands(struct string_list *commands);
 int transform_todo_file(unsigned flags);
 int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    const char *onto, const char *orig_head, const char *cmd,
+		    const char *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash);
 int rearrange_squash(void);
 
-- 
2.19.1.872.ga867da739e

