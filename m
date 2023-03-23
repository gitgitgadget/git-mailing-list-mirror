Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685FBC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjCWQsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjCWQrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:06 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED0EFF1E
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:34 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id D5BDF2423F
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B0D-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 3/8] sequencer: pass around rebase action explicitly
Date:   Thu, 23 Mar 2023 17:22:30 +0100
Message-Id: <20230323162235.995574-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... instead of deriving it from other arguments. This is a lot cleaner
and more extensible.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 builtin/rebase.c     | 25 ++++++++++---------------
 rebase-interactive.c | 21 +++++++++++----------
 rebase-interactive.h | 16 ++++++++++++++--
 sequencer.c          | 16 +++++++++-------
 sequencer.h          |  8 +++++---
 5 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 491759db19..a309addd50 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -58,16 +58,6 @@ enum empty_type {
 	EMPTY_ASK
 };
 
-enum action {
-	ACTION_NONE = 0,
-	ACTION_CONTINUE,
-	ACTION_SKIP,
-	ACTION_ABORT,
-	ACTION_QUIT,
-	ACTION_EDIT_TODO,
-	ACTION_SHOW_CURRENT_PATCH
-};
-
 static const char *action_names[] = {
 	"undefined",
 	"continue",
@@ -104,7 +94,7 @@ struct rebase_options {
 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
 	struct strvec git_am_opts;
-	enum action action;
+	enum rebase_action action;
 	char *reflog_action;
 	int signoff;
 	int allow_rerere_autoupdate;
@@ -198,9 +188,11 @@ static int edit_todo_file(unsigned flags)
 		return error_errno(_("could not read '%s'."), todo_file);
 
 	strbuf_stripspace(&todo_list.buf, 1);
-	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
+	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags,
+			     ACTION_EDIT_TODO);
 	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
-					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
+					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS),
+					    ACTION_EDIT_TODO))
 		res = error_errno(_("could not write '%s'"), todo_file);
 
 	todo_list_release(&todo_list);
@@ -294,7 +286,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		ret = complete_action(the_repository, &replay, flags,
 			shortrevisions, opts->onto_name, opts->onto,
 			&opts->orig_head->object.oid, &opts->exec,
-			opts->autosquash, opts->update_refs, &todo_list);
+			opts->autosquash, opts->update_refs, &todo_list,
+			opts->action);
 	}
 
 cleanup:
@@ -1246,7 +1239,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		else if (options.exec.nr)
 			trace2_cmd_mode("interactive-exec");
 		else
-			trace2_cmd_mode(action_names[options.action]);
+			trace2_cmd_mode(
+				(BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(action_names) == ACTION_LAST),
+				 action_names[options.action]));
 	}
 
 	options.reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 7407c59319..111a2071ae 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -35,7 +35,7 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
 	return MISSING_COMMIT_CHECK_IGNORE;
 }
 
-void append_todo_help(int command_count,
+void append_todo_help(int command_count, enum rebase_action action,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf)
 {
@@ -62,9 +62,8 @@ void append_todo_help(int command_count,
 "                      updated at the end of the rebase\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
-	unsigned edit_todo = !(shortrevisions && shortonto);
 
-	if (!edit_todo) {
+	if (action == ACTION_NONE) {
 		strbuf_addch(buf, '\n');
 		strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
 					      "Rebase %s onto %s (%d commands)",
@@ -83,7 +82,7 @@ void append_todo_help(int command_count,
 
 	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
-	if (edit_todo)
+	if (action == ACTION_EDIT_TODO)
 		msg = _("\nYou are editing the todo file "
 			"of an ongoing interactive rebase.\n"
 			"To continue rebase after editing, run:\n"
@@ -97,35 +96,37 @@ void append_todo_help(int command_count,
 
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 		   struct todo_list *new_todo, const char *shortrevisions,
-		   const char *shortonto, unsigned flags)
+		   const char *shortonto, unsigned flags,
+		   enum rebase_action action)
 {
 	const char *todo_file = rebase_path_todo(),
 		*todo_backup = rebase_path_todo_backup();
-	unsigned initial = shortrevisions && shortonto;
 	int incorrect = 0;
 
 	/* If the user is editing the todo list, we first try to parse
 	 * it.  If there is an error, we do not return, because the user
 	 * might want to fix it in the first place. */
-	if (!initial)
+	if (action != ACTION_NONE)
 		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) |
 			file_exists(rebase_path_dropped());
 
 	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
-				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
+				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP,
+				    action))
 		return error_errno(_("could not write '%s'"), todo_file);
 
 	if (!incorrect &&
 	    todo_list_write_to_file(r, todo_list, todo_backup,
 				    shortrevisions, shortonto, -1,
-				    (flags | TODO_LIST_APPEND_TODO_HELP) & ~TODO_LIST_SHORTEN_IDS) < 0)
+				    (flags | TODO_LIST_APPEND_TODO_HELP) & ~TODO_LIST_SHORTEN_IDS,
+				    action) < 0)
 		return error(_("could not write '%s'."), rebase_path_todo_backup());
 
 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
 		return -2;
 
 	strbuf_stripspace(&new_todo->buf, 1);
-	if (initial && new_todo->buf.len == 0)
+	if (action != ACTION_EDIT_TODO && new_todo->buf.len == 0)
 		return -3;
 
 	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 7239c60f79..d9873d3497 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -5,12 +5,24 @@ struct strbuf;
 struct repository;
 struct todo_list;
 
-void append_todo_help(int command_count,
+enum rebase_action {
+	ACTION_NONE = 0,
+	ACTION_CONTINUE,
+	ACTION_SKIP,
+	ACTION_ABORT,
+	ACTION_QUIT,
+	ACTION_EDIT_TODO,
+	ACTION_SHOW_CURRENT_PATCH,
+	ACTION_LAST
+};
+
+void append_todo_help(int command_count, enum rebase_action action,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 		   struct todo_list *new_todo, const char *shortrevisions,
-		   const char *shortonto, unsigned flags);
+		   const char *shortonto, unsigned flags,
+		   enum rebase_action action);
 
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 int todo_list_check_against_backup(struct repository *r,
diff --git a/sequencer.c b/sequencer.c
index 7c275c9a65..f05174d151 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5894,14 +5894,15 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
 
 int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 			    const char *file, const char *shortrevisions,
-			    const char *shortonto, int num, unsigned flags)
+			    const char *shortonto, int num, unsigned flags,
+			    enum rebase_action action)
 {
 	int res;
 	struct strbuf buf = STRBUF_INIT;
 
 	todo_list_to_strbuf(r, todo_list, &buf, num, flags);
 	if (flags & TODO_LIST_APPEND_TODO_HELP)
-		append_todo_help(count_commands(todo_list),
+		append_todo_help(count_commands(todo_list), action,
 				 shortrevisions, shortonto, &buf);
 
 	res = write_message(buf.buf, buf.len, file, 0);
@@ -5941,7 +5942,8 @@ static int skip_unnecessary_picks(struct repository *r,
 	if (i > 0) {
 		const char *done_path = rebase_path_done();
 
-		if (todo_list_write_to_file(r, todo_list, done_path, NULL, NULL, i, 0)) {
+		if (todo_list_write_to_file(r, todo_list, done_path, NULL, NULL, i, 0,
+					    ACTION_NONE)) {
 			error_errno(_("could not write to '%s'"), done_path);
 			return -1;
 		}
@@ -6086,8 +6088,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
-		    unsigned update_refs,
-		    struct todo_list *todo_list)
+		    unsigned update_refs, struct todo_list *todo_list,
+		    enum rebase_action action)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
 	const char *todo_file = rebase_path_todo();
@@ -6122,7 +6124,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	}
 
 	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
-			     shortonto, flags);
+			     shortonto, flags, action);
 	if (res == -1)
 		return -1;
 	else if (res == -2) {
@@ -6158,7 +6160,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	}
 
 	if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
-				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
+				    flags & ~(TODO_LIST_SHORTEN_IDS), action)) {
 		todo_list_release(&new_todo);
 		return error_errno(_("could not write '%s'"), todo_file);
 	}
diff --git a/sequencer.h b/sequencer.h
index 33dbaf5b66..1a3e616af2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "wt-status.h"
 
+enum rebase_action;
 struct commit;
 struct index_state;
 struct repository;
@@ -134,7 +135,8 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 				struct todo_list *todo_list);
 int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 			    const char *file, const char *shortrevisions,
-			    const char *shortonto, int num, unsigned flags);
+			    const char *shortonto, int num, unsigned flags,
+			    enum rebase_action action);
 void todo_list_release(struct todo_list *todo_list);
 const char *todo_item_get_arg(struct todo_list *todo_list,
 			      struct todo_item *item);
@@ -187,8 +189,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
-		    unsigned update_refs,
-		    struct todo_list *todo_list);
+		    unsigned update_refs, struct todo_list *todo_list,
+		    enum rebase_action action);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
 /*
-- 
2.40.0.152.g15d061e6df

