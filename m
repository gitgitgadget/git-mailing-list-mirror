Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD511C76196
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjCWQrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjCWQrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:00 -0400
X-Greylist: delayed 1431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 09:46:27 PDT
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603710A
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:27 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 119F82424D
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:36 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B0w-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [RFC PATCH] rebase: implement --rewind
Date:   Thu, 23 Mar 2023 17:22:35 +0100
Message-Id: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is fundamentally --edit-todo, except that we first prepend the
already applied commits and reset back to `onto`. This is useful when
one finds that a prior change needs (further) modifications.

This patch implements "flat" rewind, that is, once the todo edit has
been committed, one can abort only the complete rebase. The pre-rewind
position is marked with a `break` command (these pile up when rewinding
multiple times; the user is expected to clean them up as necessary).

An alternative to that would be "nested" rewind, where one can return to
the pre-rewind state even after committing the todo edit. However, this:
- would add somewhat significant complexity due to having to maintain a
  stack of todos and HEADs
- would be mildly confusing to use due to needing to track the state of
  the stack. One could simplify this somewhat by hiding the rest of the
  previous todo before nesting, but this would be somewhat limiting in
  turn (one might want to defer a factored out hunk, and stashing it is
  not necessarily the most elegant way to do it).
- would be of somewhat limited usefulness, speaking from experience

This patch leaves transitive resolution of rewritten-list to the
consumer. This is probably a bad idea.
Somewhat related to that, --update-refs isn't properly handled yet.

Reference: <YhPiqlM81XCjNWpk@ugly>
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 Documentation/git-rebase.txt  |  14 ++++-
 builtin/rebase.c              |  98 ++++++++++++++++++++++++++++--
 rebase-interactive.c          |  34 ++++++++++-
 rebase-interactive.h          |   2 +
 sequencer.c                   |  37 +++++++++---
 sequencer.h                   |   3 +
 t/t3404-rebase-interactive.sh | 111 ++++++++++++++++++++++++++++++++++
 7 files changed, 281 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..f736131a6c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
+'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --rewind |
+	--show-current-patch)
 
 DESCRIPTION
 -----------
@@ -215,7 +216,8 @@ The options in this section cannot be used with any other option,
 including not with each other:
 
 --continue::
-	Restart the rebasing process after having resolved a merge conflict.
+	Restart the rebasing process after an interruption, e.g. having
+	resolved a merge conflict.
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
@@ -236,6 +238,10 @@ including not with each other:
 --edit-todo::
 	Edit the todo list during an interactive rebase.
 
+--rewind::
+	Edit the todo list during an interactive rebase, but first
+	prepend the commits on top of the new base and reset to it.
+
 --show-current-patch::
 	Show the current patch in an interactive rebase or when rebase
 	is stopped because of conflicts. This is the equivalent of
@@ -975,6 +981,10 @@ pick f4593f9 four
 exec make test
 --------------------
 
+If during editing a commit you notice that an ancestor commit should be
+actually edited first, you may use `git rebase --rewind` to restart the
+interactive rebase without starting from scratch.
+
 SPLITTING COMMITS
 -----------------
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 61e5363ac7..3a14ac1a4f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -36,7 +36,8 @@ static char const * const builtin_rebase_usage[] = {
 		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
-	"git rebase --continue | --abort | --skip | --edit-todo",
+	"git rebase --continue | --abort | --quit | --skip | --edit-todo | "
+		"--rewind",
 	NULL
 };
 
@@ -65,6 +66,8 @@ static const char *action_names[] = {
 	"abort",
 	"quit",
 	"edit_todo",
+	"rewind",
+	"resume_rewind",
 	"show_current_patch"
 };
 
@@ -183,17 +186,21 @@ static int edit_todo_file(unsigned flags)
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT,
 		new_todo = TODO_LIST_INIT;
+	enum rebase_action action = file_exists(rebase_path_todo_orig()) ?
+				ACTION_RESUME_REWIND : ACTION_EDIT_TODO;
 	int res = 0;
 
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
 	strbuf_stripspace(&todo_list.buf, 1);
 	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags,
-			     ACTION_EDIT_TODO);
-	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
-					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS),
-					    ACTION_EDIT_TODO))
+			     action);
+	if (res == EDIT_TODO_ABORT)
+		res = error(_("rewind aborted; state restored"));
+	else if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
+						 NULL, NULL, -1,
+						 flags & ~(TODO_LIST_SHORTEN_IDS), action))
 		res = error_errno(_("could not write '%s'"), todo_file);
 
 	todo_list_release(&todo_list);
@@ -301,6 +308,64 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	return ret;
 }
 
+static int rewind_todo_file(struct rebase_options *opts,
+			    unsigned flags)
+{
+	int ret;
+	char *revisions;
+	const char *todo_file = rebase_path_todo();
+	struct strvec make_script_args = STRVEC_INIT;
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct replay_opts replay = get_replay_opts(opts);
+	struct string_list commands = STRING_LIST_INIT_DUP;
+
+	require_clean_work_tree(the_repository,
+		N_("rewind rebase"),
+		_("Please commit or stash them."), 1, 0);
+
+	if (file_exists(rebase_path_todo_orig()))
+		return error(_("you are already rewinding a rebase.\n"
+			       "Use rebase --edit-todo to continue."));
+
+	revisions = xstrfmt("%s..HEAD", oid_to_hex(&opts->onto->object.oid));
+	strvec_pushl(&make_script_args, "", revisions, NULL);
+	free(revisions);
+
+	ret = sequencer_make_script(the_repository, &todo_list.buf,
+				    make_script_args.nr, make_script_args.v,
+				    flags);
+	strvec_clear(&make_script_args);
+
+	if (ret)
+		error(_("could not generate todo list"));
+	else {
+		if (flags & TODO_LIST_ABBREVIATE_CMDS)
+			strbuf_addstr(&todo_list.buf, "b\n\n");
+		else
+			strbuf_addstr(&todo_list.buf, "break\n\n");
+
+		if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0) {
+			strbuf_release(&todo_list.buf);
+			return error_errno(_("could not read '%s'."), todo_file);
+		}
+
+		discard_index(&the_index);
+		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+						&todo_list))
+			BUG("unusable todo list");
+
+		ret = complete_action(the_repository, &replay, flags,
+			NULL, opts->onto_name, &opts->onto->object.oid,
+			&opts->orig_head->object.oid, &opts->exec,
+			opts->autosquash, opts->update_refs, &todo_list,
+			opts->action);
+	}
+
+	todo_list_release(&todo_list);
+
+	return ret;
+}
+
 static int run_sequencer_rebase(struct rebase_options *opts)
 {
 	unsigned flags = 0;
@@ -342,6 +407,9 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 	case ACTION_EDIT_TODO:
 		ret = edit_todo_file(flags);
 		break;
+	case ACTION_REWIND:
+		ret = rewind_todo_file(opts, flags);
+		break;
 	case ACTION_SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
@@ -1088,6 +1156,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    N_("abort but keep HEAD where it is"), ACTION_QUIT),
 		OPT_CMDMODE(0, "edit-todo", &options.action, N_("edit the todo list "
 			    "during an interactive rebase"), ACTION_EDIT_TODO),
+		OPT_CMDMODE(0, "rewind", &options.action, N_("rewind an interactive "
+			    "rebase"), ACTION_REWIND),
 		OPT_CMDMODE(0, "show-current-patch", &options.action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
@@ -1235,6 +1305,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.action == ACTION_EDIT_TODO && !is_merge(&options))
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
+	else if (options.action == ACTION_REWIND && !is_merge(&options))
+		die(_("The --rewind action can only be used during "
+		      "interactive rebase."));
 
 	if (trace2_is_enabled()) {
 		if (is_merge(&options))
@@ -1339,17 +1412,21 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	case ACTION_EDIT_TODO:
 		options.dont_finish_rebase = 1;
 		goto run_rebase;
+	case ACTION_REWIND:
+		if (read_basic_state(&options))
+			exit(1);
+		break;
 	case ACTION_SHOW_CURRENT_PATCH:
 		options.dont_finish_rebase = 1;
 		goto run_rebase;
 	case ACTION_NONE:
 		break;
 	default:
 		BUG("action: %d", options.action);
 	}
 
 	/* Make sure no rebase is in progress */
-	if (in_progress) {
+	if (in_progress && options.action != ACTION_REWIND) {
 		const char *last_slash = strrchr(options.state_dir, '/');
 		const char *state_dir_base =
 			last_slash ? last_slash + 1 : options.state_dir;
@@ -1570,6 +1647,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.flags |= REBASE_FORCE;
 	}
 
+	// We branch off after handling any option that could usefully
+	// affect the re-creation of the todo list.
+	// The omission of --onto from that is debatable.
+	// Options that will be overwritten by read_basic_state() are
+	// meaningless, so we can branch out before processing these;
+	// though arguably, it should be possible to change some of them.
+	if (options.action == ACTION_REWIND)
+		goto run_rebase;
+
 	if (!options.root) {
 		if (argc < 1) {
 			struct branch *branch;
diff --git a/rebase-interactive.c b/rebase-interactive.c
index a3d8925b06..d72ac7b8d1 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -87,6 +87,16 @@ void append_todo_help(int command_count, enum rebase_action action,
 			"of an ongoing interactive rebase.\n"
 			"To continue rebase after editing, run:\n"
 			"    git rebase --continue\n\n");
+	else if (action == ACTION_REWIND)
+		msg = _("\nYou are rewinding "
+			"an ongoing interactive rebase.\n"
+			"If you remove everything, "
+			"the todo file will be left unchanged.\n\n");
+	else if (action == ACTION_RESUME_REWIND)
+		msg = _("\nYou are correcting the rewind of "
+			"an ongoing interactive rebase.\n"
+			"If you remove everything, "
+			"the todo file will be restored.\n\n");
 	else
 		msg = _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
@@ -101,9 +111,18 @@ enum edit_todo_result edit_todo_list(
 		   enum rebase_action action)
 {
 	const char *todo_file = rebase_path_todo(),
-		*todo_backup = rebase_path_todo_backup();
+		*todo_backup = rebase_path_todo_backup(),
+		*todo_file_orig = rebase_path_todo_orig(),
+		*done_file = rebase_path_done(),
+		*done_file_orig = rebase_path_done_orig();
 	int incorrect = 0;
 
+	if (action == ACTION_REWIND) {
+		if (rename(todo_file, todo_file_orig) ||
+		    rename(done_file, done_file_orig))
+			return error_errno(_("cannot displace todo file"));
+	}
+
 	/* If the user is editing the todo list, we first try to parse
 	 * it.  If there is an error, we do not return, because the user
 	 * might want to fix it in the first place. */
@@ -127,8 +146,14 @@ enum edit_todo_result edit_todo_list(
 		return EDIT_TODO_FAILED;
 
 	strbuf_stripspace(&new_todo->buf, 1);
-	if (action != ACTION_EDIT_TODO && new_todo->buf.len == 0)
+	if (action != ACTION_EDIT_TODO && new_todo->buf.len == 0) {
+		if (action == ACTION_REWIND || action == ACTION_RESUME_REWIND) {
+			if (rename(todo_file_orig, todo_file) ||
+			    rename(done_file_orig, done_file))
+				return error_errno(_("cannot restore todo file"));
+		}
 		return EDIT_TODO_ABORT;
+	}
 
 	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
 		fprintf(stderr, _(edit_todo_list_advice));
@@ -148,6 +173,11 @@ enum edit_todo_result edit_todo_list(
 		return EDIT_TODO_INCORRECT;
 	}
 
+	if (action == ACTION_REWIND) {
+		unlink(todo_file_orig);
+		unlink(done_file_orig);
+	}
+
 	/*
 	 * See if branches need to be added or removed from the update-refs
 	 * file based on the new todo list.
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 5aa4111b4f..260dc7c53f 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -12,6 +12,8 @@ enum rebase_action {
 	ACTION_ABORT,
 	ACTION_QUIT,
 	ACTION_EDIT_TODO,
+	ACTION_REWIND,
+	ACTION_RESUME_REWIND,
 	ACTION_SHOW_CURRENT_PATCH,
 	ACTION_LAST
 };
diff --git a/sequencer.c b/sequencer.c
index 0b4d16b8e8..0e1d92b238 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -62,15 +62,17 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  */
 GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 GIT_PATH_FUNC(rebase_path_todo_backup, "rebase-merge/git-rebase-todo.backup")
+GIT_PATH_FUNC(rebase_path_todo_orig, "rebase-merge/git-rebase-todo.orig")
 
 GIT_PATH_FUNC(rebase_path_dropped, "rebase-merge/dropped")
 
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
  * actions.
  */
-static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
+GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
+GIT_PATH_FUNC(rebase_path_done_orig, "rebase-merge/done.orig")
 /*
  * The file to keep track of how many commands were already processed (e.g.
  * for the prompt).
@@ -6113,7 +6115,10 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	struct strbuf *buf = &todo_list->buf;
 	int res;
 
-	find_unique_abbrev_r(shortonto, onto, DEFAULT_ABBREV);
+	if (action == ACTION_NONE)
+		find_unique_abbrev_r(shortonto, onto, DEFAULT_ABBREV);
+	else if (read_populate_opts(opts))
+		return -1;
 
 	if (buf->len == 0) {
 		struct todo_item *item = append_new_todo(todo_list);
@@ -6143,11 +6148,20 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (res == EDIT_TODO_IOERROR)
 		return -1;
 	else if (res == EDIT_TODO_FAILED) {
+		if (action == ACTION_REWIND)
+			return -1;
+
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return -1;
 	} else if (res == EDIT_TODO_ABORT) {
+		if (action == ACTION_REWIND) {
+			todo_list_release(&new_todo);
+
+			return error(_("rewind aborted; state unchanged"));
+		}
+
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
@@ -6239,7 +6253,7 @@ static int skip_fixupish(const char *subject, const char **p) {
 int todo_list_rearrange_squash(struct todo_list *todo_list)
 {
 	struct hashmap subject2item;
-	int rearranged = 0, *next, *tail, i, nr = 0;
+	int rearranged = 0, *next, *tail, i, j, nr = 0;
 	char **subjects;
 	struct commit_todo_item commit_todo;
 	struct todo_item *items = NULL;
@@ -6266,6 +6280,10 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		int i2 = -1;
 		struct subject2item_entry *entry;
 
+		// When rewinding, process only up to the marker.
+		if (item->command == TODO_BREAK)
+			break;
+
 		next[i] = tail[i] = -1;
 		if (!item->commit || item->command == TODO_DROP) {
 			subjects[i] = NULL;
@@ -6350,9 +6368,9 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 	if (rearranged) {
 		items = ALLOC_ARRAY(items, todo_list->nr);
 
-		for (i = 0; i < todo_list->nr; i++) {
-			enum todo_command command = todo_list->items[i].command;
-			int cur = i;
+		for (j = 0; j < i; j++) {
+			enum todo_command command = todo_list->items[j].command;
+			int cur = j;
 
 			/*
 			 * Initially, all commands are 'pick's. If it is a
@@ -6367,16 +6385,19 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 			}
 		}
 
+		for (; j < todo_list->nr; j++)
+			items[nr++] = todo_list->items[j];
+
 		assert(nr == todo_list->nr);
 		todo_list->alloc = nr;
 		FREE_AND_NULL(todo_list->items);
 		todo_list->items = items;
 	}
 
 	free(next);
 	free(tail);
-	for (i = 0; i < todo_list->nr; i++)
-		free(subjects[i]);
+	for (j = 0; j < i; j++)
+		free(subjects[j]);
 	free(subjects);
 	hashmap_clear_and_free(&subject2item, struct subject2item_entry, entry);
 
diff --git a/sequencer.h b/sequencer.h
index 33bcff89e0..84d7c076c0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -12,7 +12,10 @@ struct repository;
 const char *git_path_commit_editmsg(void);
 const char *rebase_path_todo(void);
 const char *rebase_path_todo_backup(void);
+const char *rebase_path_todo_orig(void);
 const char *rebase_path_dropped(void);
+const char *rebase_path_done(void);
+const char *rebase_path_done_orig(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index dd47f0bbce..ef68f4470a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2180,6 +2180,117 @@ test_expect_success 'bad labels and refs rejected when parsing todo list' '
 	test_path_is_missing execed
 '
 
+test_expect_success 'rebase --rewind' '
+	git checkout primary^0 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 reword 2 3 break 4" \
+			FAKE_COMMIT_MESSAGE="C_reworded" \
+			git rebase -i HEAD~4 &&
+		FAKE_LINES="reword 1 2 3 6" \
+			FAKE_COMMIT_MESSAGE="B_reworded" \
+			git rebase --rewind >output 2>&1
+	) &&
+	grep -q "Rebasing (4/4)" output &&
+	test "$(git log -1 --format=%B HEAD~3)" = "B_reworded" &&
+	test "$(git log -1 --format=%B HEAD~2)" = "C_reworded"
+'
+
+test_expect_success 'rebase --rewind with initially botched todo' '
+	git checkout primary^0 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 reword 2 3 break 4" \
+			FAKE_COMMIT_MESSAGE="C_reworded" \
+			git rebase -i HEAD~4 &&
+		test_must_fail env FAKE_LINES="reword 1 bad 2 3 6" \
+			git rebase --rewind &&
+		grep -q "rewinding" < .git/rebase-merge/git-rebase-todo.backup &&
+		FAKE_LINES="reword 1 pick 2 3 4" \
+			git rebase --edit-todo &&
+		FAKE_COMMIT_MESSAGE="B_reworded" \
+			git rebase --continue
+	) &&
+	test "$(git log -1 --format=%B HEAD~3)" = "B_reworded" &&
+	test "$(git log -1 --format=%B HEAD~2)" = "C_reworded"
+'
+
+test_expect_success 'recursing rebase --rewind with initially botched todo' '
+	git checkout primary^0 &&
+	cat >expect <<-\EOF &&
+	error: you are already rewinding a rebase.
+	Use rebase --edit-todo to continue.
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 reword 2 3 break 4" \
+			FAKE_COMMIT_MESSAGE="C_reworded" \
+			git rebase -i HEAD~4 &&
+		test_must_fail env FAKE_LINES="reword 1 bad 2 3 6" \
+			git rebase --rewind &&
+		test_must_fail env FAKE_LINES="reword 1 pick 2 3 4" \
+			git rebase --rewind >actual 2>&1  &&
+		test_cmp expect actual &&
+		git rebase --abort
+	)
+'
+
+test_expect_success 'rebase --rewind being aborted' '
+	git checkout primary^0 &&
+	cat >expect <<-\EOF &&
+	error: rewind aborted; state unchanged
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 reword 2 3 break 4" \
+			FAKE_COMMIT_MESSAGE="C_reworded" \
+			git rebase -i HEAD~4 &&
+		test_must_fail env FAKE_LINES="#" \
+			git rebase --rewind >output 2>&1 &&
+		tail -n 1 output >actual &&  # Ignore output about changing todo list
+		test_cmp expect actual &&
+		git rebase --continue
+	) &&
+	test "$(git log -1 --format=%B HEAD~2)" = "C_reworded"
+'
+
+test_expect_success 'rebase --rewind being aborted after initially botched todo' '
+	git checkout primary^0 &&
+	cat >expect <<-\EOF &&
+	error: rewind aborted; state restored
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 reword 2 3 break 4" \
+			FAKE_COMMIT_MESSAGE="C_reworded" \
+			git rebase -i HEAD~4 &&
+		test_must_fail env FAKE_LINES="reword 1 bad 2 3 6" \
+			git rebase --rewind &&
+		test_must_fail env FAKE_LINES="#" \
+			git rebase --edit-todo >output 2>&1 &&
+		tail -n 1 output >actual &&  # Ignore output about changing todo list
+		test_cmp expect actual &&
+		git rebase --continue
+	) &&
+	test "$(git log -1 --format=%B HEAD~2)" = "C_reworded"
+'
+
+test_expect_failure 'rebase --rewind vs. --update-refs' '
+	git checkout primary^0 &&
+	git branch -f first HEAD~3 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 2 reword 4 5 break 6 7" \
+			FAKE_COMMIT_MESSAGE="C_reworded" \
+			git rebase -i --update-refs HEAD~4 &&
+		FAKE_LINES="reword 1 2 3 4 7 8" \
+			FAKE_COMMIT_MESSAGE="B_reworded" \
+			git rebase --rewind
+	) &&
+	test_cmp_rev HEAD~3 refs/heads/first &&
+	test_cmp_rev HEAD refs/heads/primary
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.40.0.152.g15d061e6df

