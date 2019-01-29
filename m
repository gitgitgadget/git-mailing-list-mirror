Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB9C1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfA2PDM (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46713 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfA2PDK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so22368302wrt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/uYUW+hYjKPMjKKYmlC6wwYCHRWeDMwiV1D3zunXZs=;
        b=QQycNZWRHTofupEvNpeNnCNWILyJoGxG74y89C7IZ/1LJnhoRK5L3xdeegxINvR3qO
         KTeQfdmmO8ltHpnQf4GJREwwBjND5QuCzBFclH1TGSSX7TA9MTp8hff90ni58rmO2Z/K
         erdyRRTZxEaKXiUy3L19A7tI8AwSxucVnajlvMLpOgyK8/lDuyw1ckHCuWbgyZGYOgg4
         8vg7YhkwDLi4N0ravLXtqlNUbjl8AWMfVdORT073C9n/VygTAWvyEPU7Y3NdKzKQtuoz
         ky7QbcQ8Sbd/Da8aPSTyeTkuzdko1juVCsoJNRH9tsgldHL61rHHTFz0ZhKQF7houErc
         ELog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/uYUW+hYjKPMjKKYmlC6wwYCHRWeDMwiV1D3zunXZs=;
        b=fWfNLTDE+9KG2zJsyhMYOYtSS1ywFpJC7R692RvnqdlnW+0Ba9OGuwBIdLGYo0mofP
         pjBidcAdaTEVXyAjRbI9F1/bHr16TvO8ddJNSeBwTC1GQNo5k2IsefDluH5XY1xdTold
         k7NwJ+hK3TYX/7/V/kFpw7IVf1Tr6vzYeWbvgNjZQrfo0i0XJrw9O8T4Xmqg9cdJPm0x
         PC7DC0aL/vBOqbe6GxtJSQzv2wtqVJgMrfPHcBvznap4+g5rNDsrgMSpvEvLAnMceceo
         gWZS/JtUMhcp8r7bJWHXVLwPP+H+Ltpa4vjgCVYvKwDJAQ/iP4a0xJl3dABq2rOycOpQ
         p7Iw==
X-Gm-Message-State: AJcUukdNsoecqSGUx6k0hxsWCJnRb8iqEI+m1XHYNWzP4FDbTJK1avhX
        vzuiZx7G17xdFFo8lOYnHRKiTO9z
X-Google-Smtp-Source: ALg8bN5tK9PP3kzUSyEijNt073Vrv1roUPMKuNz5ro1ZgD3jlj07N0yuzqW3i/R22nLOrKDZcbnRMw==
X-Received: by 2002:adf:be8b:: with SMTP id i11mr27670218wrh.235.1548774187560;
        Tue, 29 Jan 2019 07:03:07 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:07 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 07/16] sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
Date:   Tue, 29 Jan 2019 16:01:50 +0100
Message-Id: <20190129150159.10588-8-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors sequencer_add_exec_commands() to work on a todo_list to
avoid redundant reads and writes to the disk.

Instead of inserting the `exec' commands between the other commands and
re-parsing the buffer at the end, they are appended to the buffer once,
and a new list of items is created.  Items from the old list are copied
across and new `exec' items are appended when necessary.  This
eliminates the need to reparse the buffer, but this also means we have
to use todo_list_write_to_disk() to write the file.

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
 sequencer.c                   | 110 +++++++++++++++++++++-------------
 sequencer.h                   |   5 +-
 3 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index df19ccaeb9..53056ee713 100644
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
@@ -116,7 +116,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 		discard_cache();
 		ret = complete_action(the_repository, opts, flags,
 				      shortrevisions, onto_name, onto,
-				      head_hash, cmd, autosquash);
+				      head_hash, commands, autosquash);
 	}
 
 	free(revisions);
@@ -139,6 +139,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
 		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
 		*switch_to = NULL, *cmd = NULL;
+	struct string_list commands = STRING_LIST_INIT_DUP;
 	char *raw_strategies = NULL;
 	enum {
 		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
@@ -221,6 +222,12 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
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
@@ -228,7 +235,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
 					    onto_name, squash_onto, head_name, restrict_revision,
-					    raw_strategies, cmd, autosquash);
+					    raw_strategies, &commands, autosquash);
 		break;
 	case SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
@@ -262,7 +269,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = rearrange_squash(the_repository);
 		break;
 	case ADD_EXEC:
-		ret = sequencer_add_exec_commands(the_repository, cmd);
+		ret = sequencer_add_exec_commands(the_repository, &commands);
 		break;
 	default:
 		BUG("invalid command '%d'", command);
diff --git a/sequencer.c b/sequencer.c
index 266f80d704..3a90b419d7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4446,25 +4446,27 @@ int sequencer_make_script(struct repository *r, FILE *out,
 	return 0;
 }
 
-/*
- * Add commands after pick and (series of) squash/fixup commands
- * in the todo list.
- */
-int sequencer_add_exec_commands(struct repository *r,
-				const char *commands)
+static void todo_list_add_exec_commands(struct todo_list *todo_list,
+					struct string_list *commands)
 {
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	struct strbuf *buf = &todo_list.buf;
-	size_t offset = 0, commands_len = strlen(commands);
-	int i, insert;
+	struct strbuf *buf = &todo_list->buf;
+	size_t base_offset = buf->len;
+	int i, insert, nr = 0, alloc = 0;
+	struct todo_item *items = NULL, *base_items = NULL;
 
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
+	base_items = xcalloc(commands->nr, sizeof(struct todo_item));
+	for (i = 0; i < commands->nr; ++i) {
+		size_t command_len = strlen(commands->items[i].string);
 
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
+		strbuf_addstr(buf, commands->items[i].string);
+		strbuf_addch(buf, '\n');
+
+		base_items[i].command = TODO_EXEC;
+		base_items[i].offset_in_buf = base_offset;
+		base_items[i].arg_offset = base_offset + strlen("exec ");
+		base_items[i].arg_len = command_len - strlen("exec ");
+
+		base_offset += command_len + 1;
 	}
 
 	/*
@@ -4473,38 +4475,62 @@ int sequencer_add_exec_commands(struct repository *r,
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
 
-	i = write_message(buf->buf, buf->len, todo_file, 0);
+/*
+ * Add commands after pick and (series of) squash/fixup commands
+ * in the todo list.
+ */
+int sequencer_add_exec_commands(struct repository *r,
+				struct string_list *commands)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	todo_list_add_exec_commands(&todo_list, commands);
+	res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
 	todo_list_release(&todo_list);
-	return i;
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
 }
 
 static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
@@ -4735,7 +4761,7 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    const char *onto, const char *orig_head, const char *cmd,
+		    const char *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash)
 {
 	const char *shortonto, *todo_file = rebase_path_todo();
@@ -4754,8 +4780,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (autosquash && rearrange_squash(r))
 		return -1;
 
-	if (cmd && *cmd)
-		sequencer_add_exec_commands(r, cmd);
+	if (commands->nr)
+		sequencer_add_exec_commands(r, commands);
 
 	if (strbuf_read_file(buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
diff --git a/sequencer.h b/sequencer.h
index 1de97f188d..e79f03e213 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -146,12 +146,13 @@ int sequencer_make_script(struct repository *r, FILE *out, int argc,
 			  const char **argv,
 			  unsigned flags);
 
-int sequencer_add_exec_commands(struct repository *r, const char *command);
+int sequencer_add_exec_commands(struct repository *r,
+				struct string_list *commands);
 int transform_todo_file(struct repository *r, unsigned flags);
 int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    const char *onto, const char *orig_head, const char *cmd,
+		    const char *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash);
 int rearrange_squash(struct repository *r);
 
-- 
2.20.1

