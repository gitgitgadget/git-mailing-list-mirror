Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22DC761AF
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjCWQrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCWQrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:06 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3562DEB66
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id D82B324245
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B0J-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 4/8] sequencer: create enum for edit_todo_list() return value
Date:   Thu, 23 Mar 2023 17:22:31 +0100
Message-Id: <20230323162235.995574-5-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a lot cleaner than open-coding magic numbers.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 rebase-interactive.c | 15 ++++++++-------
 rebase-interactive.h | 11 ++++++++++-
 sequencer.c          |  8 ++++----
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 111a2071ae..a3d8925b06 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -94,7 +94,8 @@ void append_todo_help(int command_count, enum rebase_action action,
 	strbuf_add_commented_lines(buf, msg, strlen(msg));
 }
 
-int edit_todo_list(struct repository *r, struct todo_list *todo_list,
+enum edit_todo_result edit_todo_list(
+		   struct repository *r, struct todo_list *todo_list,
 		   struct todo_list *new_todo, const char *shortrevisions,
 		   const char *shortonto, unsigned flags,
 		   enum rebase_action action)
@@ -123,37 +124,37 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 		return error(_("could not write '%s'."), rebase_path_todo_backup());
 
 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
-		return -2;
+		return EDIT_TODO_FAILED;
 
 	strbuf_stripspace(&new_todo->buf, 1);
 	if (action != ACTION_EDIT_TODO && new_todo->buf.len == 0)
-		return -3;
+		return EDIT_TODO_ABORT;
 
 	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
 		fprintf(stderr, _(edit_todo_list_advice));
-		return -4;
+		return EDIT_TODO_INCORRECT;
 	}
 
 	if (incorrect) {
 		if (todo_list_check_against_backup(r, new_todo)) {
 			write_file(rebase_path_dropped(), "%s", "");
-			return -4;
+			return EDIT_TODO_INCORRECT;
 		}
 
 		if (incorrect > 0)
 			unlink(rebase_path_dropped());
 	} else if (todo_list_check(todo_list, new_todo)) {
 		write_file(rebase_path_dropped(), "%s", "");
-		return -4;
+		return EDIT_TODO_INCORRECT;
 	}
 
 	/*
 	 * See if branches need to be added or removed from the update-refs
 	 * file based on the new todo list.
 	 */
 	todo_list_filter_update_refs(r, new_todo);
 
-	return 0;
+	return EDIT_TODO_OK;
 }
 
 define_commit_slab(commit_seen, unsigned char);
diff --git a/rebase-interactive.h b/rebase-interactive.h
index d9873d3497..5aa4111b4f 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -16,10 +16,19 @@ enum rebase_action {
 	ACTION_LAST
 };
 
+enum edit_todo_result {
+	EDIT_TODO_OK = 0,         // must be 0
+	EDIT_TODO_IOERROR = -1,   // generic i/o error; must be -1
+	EDIT_TODO_FAILED = -2,    // editing failed
+	EDIT_TODO_ABORT = -3,     // user requested abort
+	EDIT_TODO_INCORRECT = -4  // file violates syntax or constraints
+};
+
 void append_todo_help(int command_count, enum rebase_action action,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
-int edit_todo_list(struct repository *r, struct todo_list *todo_list,
+enum edit_todo_result edit_todo_list(
+		   struct repository *r, struct todo_list *todo_list,
 		   struct todo_list *new_todo, const char *shortrevisions,
 		   const char *shortonto, unsigned flags,
 		   enum rebase_action action);
diff --git a/sequencer.c b/sequencer.c
index f05174d151..b1c29c8802 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6125,20 +6125,20 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
 			     shortonto, flags, action);
-	if (res == -1)
+	if (res == EDIT_TODO_IOERROR)
 		return -1;
-	else if (res == -2) {
+	else if (res == EDIT_TODO_FAILED) {
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return -1;
-	} else if (res == -3) {
+	} else if (res == EDIT_TODO_ABORT) {
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
 
 		return error(_("nothing to do"));
-	} else if (res == -4) {
+	} else if (res == EDIT_TODO_INCORRECT) {
 		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
 		todo_list_release(&new_todo);
 
-- 
2.40.0.152.g15d061e6df

