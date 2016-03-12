From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 17/17] rebase-interactive: introduce interactive backend for builtin rebase
Date: Sat, 12 Mar 2016 18:46:37 +0800
Message-ID: <1457779597-6918-18-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh5S-0006JB-Bx
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbcCLKry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:54 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35262 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbcCLKrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:49 -0500
Received: by mail-pa0-f41.google.com with SMTP id td3so92373481pab.2
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HdK98ECL/hEagI+DT0AyrGoMwRiGiH6SSw6DrfoQ7I4=;
        b=sF94+M5d09qVX3TiV+NY63JXZN3otjQZDiKXUX4XIqw9FEjj4ghF+rgv32FglJa5k0
         V9KgarSH88DiGpxZak3wZ0J+QjeVRikzUzMQC1HDSf5A3tDuuycRIpP7DdrN46lUJxhu
         bCZeV0zWdiqN8d/DQErEaQGrTY778CzzeRh1Mni4ssWmXjDMubjYMXC6CEqI4tDetlIA
         IErBeKfR1zf+8m76cW1N5Y5UL+gToDDcH9SISQ+qjHYevhwUI6hS+NHJwDlxUH5h7F6i
         MAEr1lMQn+HlVVcJ2O70hxRqBu+n5o+dI0TcLgzuuMbb787X7Xpsv42v24qgfv20ymd7
         XGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HdK98ECL/hEagI+DT0AyrGoMwRiGiH6SSw6DrfoQ7I4=;
        b=AzE8RcKLvzrwyv6a+wIUKpsQTpwZFuG82l825ckNP6g4T9AxODW2E1ltmqAzAVJa7K
         KVePk06epq6HgvhcKPcCRyv9647SUgbVo2SILybYkV6SBlXYRolQNt7P5ZWnd2l7xBPb
         Owk/sguOqsPgt61eYaHhs12A+rA21fKIPyvUiw7+Z4XkpENBvVJRKuAjME8HdNLUqFWe
         tjGg3qCQqqup6sVGhaIbFjLdkyzPVQb4LrPr3WThP1uNcdl6og2Ob8pJS2J73VCbRI+2
         oad2o1WeAUIpJrlchJ5/SHfuZUgGGPsXuANfl9wEO9KobXHjN7nH/ePR+Ur7zbgjrYh+
         T59A==
X-Gm-Message-State: AD7BkJJSbV51PK4VE/fh+5qjxbHRKuLCWltStG7yDYxtYVyakfYtAy/wSgbskEvN9T3Fjg==
X-Received: by 10.66.119.71 with SMTP id ks7mr23013455pab.151.1457779668239;
        Sat, 12 Mar 2016 02:47:48 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:46 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288747>

Since 1b1dce4 (Teach rebase an interactive mode, 2007-06-25), git-rebase
supports an interactive mode when passed the -i switch.

In interactive mode, git-rebase allows users to edit the list of patches
(using the user's GIT_SEQUENCE_EDITOR), so that the user can reorder,
edit and delete patches.

Re-implement a skeletal version of the above feature by introducing a
rebase-interactive backend for our builtin-rebase. This skeletal
implementation is only able to pick and re-order commits.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile             |   1 +
 builtin/rebase.c     |  17 ++-
 rebase-interactive.c | 375 +++++++++++++++++++++++++++++++++++++++++++++++++++
 rebase-interactive.h |  33 +++++
 4 files changed, 424 insertions(+), 2 deletions(-)
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

diff --git a/Makefile b/Makefile
index 8b928e4..3bd3127 100644
--- a/Makefile
+++ b/Makefile
@@ -781,6 +781,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += rebase-am.o
 LIB_OBJS += rebase-common.o
+LIB_OBJS += rebase-interactive.o
 LIB_OBJS += rebase-merge.o
 LIB_OBJS += rebase-todo.o
 LIB_OBJS += reflog-walk.o
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6d42115..d811a44 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -10,11 +10,13 @@
 #include "refs.h"
 #include "rebase-am.h"
 #include "rebase-merge.h"
+#include "rebase-interactive.h"
 
 enum rebase_type {
 	REBASE_TYPE_NONE = 0,
 	REBASE_TYPE_AM,
-	REBASE_TYPE_MERGE
+	REBASE_TYPE_MERGE,
+	REBASE_TYPE_INTERACTIVE
 };
 
 static const char *rebase_dir(enum rebase_type type)
@@ -24,6 +26,8 @@ static const char *rebase_dir(enum rebase_type type)
 		return git_path_rebase_am_dir();
 	case REBASE_TYPE_MERGE:
 		return git_path_rebase_merge_dir();
+	case REBASE_TYPE_INTERACTIVE:
+		return git_path_rebase_interactive_dir();
 	default:
 		die("BUG: invalid rebase_type %d", type);
 	}
@@ -142,6 +146,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *onto_name = NULL;
 	const char *branch_name;
 	int do_merge = 0;
+	int interactive = 0;
 
 	const char * const usage[] = {
 		N_("git rebase [options] [--onto <newbase>] [<upstream>] [<branch>]"),
@@ -153,6 +158,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("rebase onto given branch instead of upstream")),
 		OPT_BOOL('m', "merge", &do_merge,
 			N_("use merging strategies to rebase")),
+		OPT_BOOL('i', "interactive", &interactive,
+			N_("let the user edit the list of commits to rebase")),
 		OPT_END()
 	};
 
@@ -232,7 +239,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Run the appropriate rebase backend */
-	if (do_merge) {
+	if (interactive) {
+		struct rebase_interactive state;
+		rebase_interactive_init(&state, rebase_dir(REBASE_TYPE_INTERACTIVE));
+		rebase_options_swap(&state.opts, &rebase_opts);
+		rebase_interactive_run(&state);
+		rebase_interactive_release(&state);
+	} else if (do_merge) {
 		struct rebase_merge state;
 		rebase_merge_init(&state, rebase_dir(REBASE_TYPE_MERGE));
 		rebase_options_swap(&state.opts, &rebase_opts);
diff --git a/rebase-interactive.c b/rebase-interactive.c
new file mode 100644
index 0000000..342a6fe
--- /dev/null
+++ b/rebase-interactive.c
@@ -0,0 +1,375 @@
+#include "cache.h"
+#include "rebase-interactive.h"
+#include "argv-array.h"
+#include "revision.h"
+#include "dir.h"
+#include "run-command.h"
+
+static int is_empty_commit(struct commit *commit)
+{
+	if (commit->parents)
+		return !oidcmp(&commit->object.oid, &commit->parents->item->object.oid);
+	else
+		return !hashcmp(commit->object.oid.hash, EMPTY_TREE_SHA1_BIN);
+}
+
+GIT_PATH_FUNC(git_path_rebase_interactive_dir, "rebase-merge")
+
+void rebase_interactive_init(struct rebase_interactive *state, const char *dir)
+{
+	rebase_options_init(&state->opts);
+	if (!dir)
+		dir = git_path_rebase_interactive_dir();
+	state->dir = xstrdup(dir);
+
+	state->todo_file = mkpathdup("%s/git-rebase-todo", state->dir);
+	rebase_todo_list_init(&state->todo);
+	state->todo_offset = 0;
+	state->todo_count = 0;
+
+	state->done_file = mkpathdup("%s/done", state->dir);
+	state->done_count = 0;
+
+	state->instruction_format = NULL;
+	git_config_get_value("rebase.instructionFormat", &state->instruction_format);
+}
+
+void rebase_interactive_release(struct rebase_interactive *state)
+{
+	rebase_options_release(&state->opts);
+	free(state->dir);
+
+	free(state->todo_file);
+	rebase_todo_list_clear(&state->todo);
+
+	free(state->done_file);
+}
+
+int rebase_interactive_in_progress(const struct rebase_interactive *state)
+{
+	const char *dir = state ? state->dir : git_path_rebase_interactive_dir();
+	struct stat st;
+
+	if (lstat(dir, &st) || !S_ISDIR(st.st_mode))
+		return 0;
+
+	if (lstat(mkpath("%s/interactive", dir), &st) || !S_ISREG(st.st_mode))
+		return 0;
+
+	return 1;
+}
+
+int rebase_interactive_load(struct rebase_interactive *state)
+{
+	struct rebase_todo_list done;
+
+	/* common rebase options */
+	if (rebase_options_load(&state->opts, state->dir) < 0)
+		return -1;
+
+	/* todo list */
+	rebase_todo_list_clear(&state->todo);
+	if (rebase_todo_list_load(&state->todo, state->todo_file, 0) < 0)
+		return -1;
+	state->todo_offset = 0;
+	state->todo_count = rebase_todo_list_count(&state->todo);
+
+	/* done list */
+	rebase_todo_list_init(&done);
+	if (file_exists(state->done_file) && rebase_todo_list_load(&done, state->done_file, 0) < 0)
+		return -1;
+	state->done_count = rebase_todo_list_count(&done);
+	rebase_todo_list_clear(&done);
+
+	return 0;
+}
+
+static int run_command_without_output(const struct rebase_interactive *state,
+				      struct child_process *cp)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int status;
+
+	cp->stdout_to_stderr = 1;
+	cp->err = -1;
+	if (start_command(cp) < 0)
+		return -1;
+
+	if (strbuf_read(&sb, cp->err, 0) < 0) {
+		strbuf_release(&sb);
+		close(cp->err);
+		finish_command(cp);
+		return -1;
+	}
+
+	close(cp->err);
+	status = finish_command(cp);
+	if (status)
+		fputs(sb.buf, stderr);
+	strbuf_release(&sb);
+	return status;
+}
+
+static int detach_head(const struct rebase_interactive *state, const struct object_id *onto, const char *onto_name)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *reflog_action = getenv("GIT_REFLOG_ACTION");
+
+	if (!reflog_action)
+		reflog_action = "";
+	if (!onto_name)
+		onto_name = oid_to_hex(onto);
+	cp.git_cmd = 1;
+	argv_array_pushf(&cp.env_array, "GIT_REFLOG_ACTION=%s: checkout %s",
+			reflog_action, onto_name);
+	argv_array_push(&cp.args, "checkout");
+	argv_array_push(&cp.args, oid_to_hex(onto));
+
+	if (run_command_without_output(state, &cp))
+		return -1;
+
+	discard_cache();
+	read_cache();
+
+	return 0;
+}
+
+static int gen_todo_list(struct rebase_interactive *state,
+			 const struct object_id *left,
+			 const struct object_id *right)
+{
+	struct rev_info revs;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct pretty_print_context pretty_ctx = {};
+	struct commit *commit;
+	const char *instruction_format;
+
+	init_revisions(&revs, NULL);
+	argv_array_push(&args, "rev-list");
+	argv_array_pushl(&args, "--no-merges", "--cherry-pick", NULL);
+	argv_array_pushl(&args, "--reverse", "--right-only", "--topo-order", NULL);
+	argv_array_pushf(&args, "%s...%s", oid_to_hex(left), oid_to_hex(right));
+	setup_revisions(args.argc, args.argv, &revs, NULL);
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	pretty_ctx.fmt = CMIT_FMT_USERFORMAT;
+	pretty_ctx.abbrev = revs.abbrev;
+	pretty_ctx.output_encoding = get_commit_output_encoding();
+	pretty_ctx.color = 0;
+	instruction_format = state->instruction_format;
+	if (!instruction_format)
+		instruction_format = "%s";
+
+	while ((commit = get_revision(&revs))) {
+		struct rebase_todo_item *item;
+		struct strbuf sb = STRBUF_INIT;
+
+		item = rebase_todo_list_push_empty(&state->todo);
+		item->action = REBASE_TODO_PICK;
+		oidcpy(&item->oid, &commit->object.oid);
+
+		if (is_empty_commit(commit) && single_parent(commit))
+			item->action = REBASE_TODO_NONE;
+
+		format_commit_message(commit, instruction_format, &sb, &pretty_ctx);
+		strbuf_setlen(&sb, strcspn(sb.buf, "\n"));
+		if (item->action == REBASE_TODO_PICK)
+			item->rest = strbuf_detach(&sb, NULL);
+		else
+			item->rest = xstrfmt("%c pick %s %s", comment_line_char,
+					     oid_to_hex(&item->oid), sb.buf);
+		strbuf_release(&sb);
+	}
+
+	if (!state->todo.nr)
+		rebase_todo_list_push_noop(&state->todo);
+
+	reset_revision_walk();
+	argv_array_clear(&args);
+	return 0;
+}
+
+/**
+ * Mark the current action as done.
+ */
+static void mark_action_done(struct rebase_interactive *state)
+{
+	const struct rebase_todo_item *done_item = &state->todo.items[state->todo_offset++];
+	struct strbuf sb = STRBUF_INIT;
+
+	/* update todo file */
+	rebase_todo_list_save(&state->todo, state->todo_file, state->todo_offset, 0);
+
+	/* update done file */
+	strbuf_add_rebase_todo_item(&sb, done_item, 0);
+	append_file(state->done_file, "%s", sb.buf);
+	strbuf_release(&sb);
+
+	/* update todo and done counts if item is not none */
+	if (done_item->action != REBASE_TODO_NONE) {
+		unsigned int total = state->todo_count + state->done_count;
+
+		state->todo_count--;
+		state->done_count++;
+
+		printf(_("Rebasing (%u/%u)\r"), state->done_count, total);
+	}
+}
+
+/**
+ * Put the last action marked done at the beginning of the todo list again. If
+ * there has not been an action marked done yet, leave the list of items on the
+ * todo list unchanged.
+ */
+static void reschedule_last_action(struct rebase_interactive *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *last_line;
+
+	if (!state->todo_offset)
+		return; /* no action marked done yet */
+
+	/* update todo file */
+	rebase_todo_list_save(&state->todo, state->todo_file, --state->todo_offset, 0);
+
+	/* remove the last line from the done file */
+	if (strbuf_read_file(&sb, state->done_file, 0) < 0)
+		die_errno(_("failed to read %s"), state->done_file);
+	last_line = sb.buf + sb.len;
+	if (*last_line == '\n')
+		last_line--;
+	last_line = strrchr(last_line, '\n');
+	if (last_line)
+		strbuf_setlen(&sb, last_line - sb.buf);
+	else
+		strbuf_reset(&sb);
+	write_file(state->done_file, "%s", sb.buf);
+	strbuf_release(&sb);
+}
+
+/**
+ * Pick a non-merge commit.
+ */
+static int pick_one_non_merge(struct rebase_interactive *state,
+			      const struct object_id *oid, int no_commit)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int status;
+
+	cp.git_cmd = 1;
+	if (state->opts.resolvemsg)
+		argv_array_pushf(&cp.env_array, "GIT_CHERRY_PICK_HELP=%s", state->opts.resolvemsg);
+	argv_array_push(&cp.args, "cherry-pick");
+	argv_array_push(&cp.args, "--allow-empty");
+	if (no_commit)
+		argv_array_push(&cp.args, "-n");
+	else
+		argv_array_push(&cp.args, "--ff");
+	argv_array_push(&cp.args, oid_to_hex(oid));
+	status = run_command_without_output(state, &cp);
+
+	/* Reload index as cherry-pick will have modified it */
+	discard_cache();
+	read_cache();
+
+	return status;
+}
+
+/**
+ * Pick a commit.
+ */
+static int pick_one(struct rebase_interactive *state, const struct object_id *oid,
+		    int no_commit)
+{
+	return pick_one_non_merge(state, oid, no_commit);
+}
+
+static void do_pick(struct rebase_interactive *state,
+		    const struct rebase_todo_item *item)
+{
+	int ret;
+	struct object_id head;
+
+	if (get_oid("HEAD", &head))
+		die("invalid head");
+
+	mark_action_done(state);
+	ret = pick_one(state, &item->oid, 0);
+	if (ret != 0 && ret != 1)
+		reschedule_last_action(state);
+	if (ret)
+		die(_("Could not apply %s... %s"), oid_to_hex(&item->oid), item->rest);
+}
+
+static void do_item(struct rebase_interactive *state)
+{
+	const struct rebase_todo_item *item = &state->todo.items[state->todo_offset];
+
+	switch (item->action) {
+	case REBASE_TODO_NONE:
+	case REBASE_TODO_NOOP:
+		mark_action_done(state);
+		break;
+	case REBASE_TODO_PICK:
+		do_pick(state, item);
+		break;
+	default:
+		die("BUG: invalid action %d", item->action);
+	}
+}
+
+static void do_rest(struct rebase_interactive *state)
+{
+	while (state->todo_offset < state->todo.nr)
+		do_item(state);
+	rebase_common_finish(&state->opts, state->dir);
+}
+
+void rebase_interactive_run(struct rebase_interactive *state)
+{
+	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
+		die_errno(_("failed to create directory '%s'"), state->dir);
+
+	write_file(mkpath("%s/interactive", state->dir), "%s", "");
+	rebase_options_save(&state->opts, state->dir);
+
+	/* generate initial todo list contents */
+	if (gen_todo_list(state, &state->opts.upstream, &state->opts.orig_head) < 0) {
+		rebase_common_destroy(&state->opts, state->dir);
+		die("could not generate todo list");
+	}
+
+	/* open editor on todo list */
+	rebase_todo_list_save(&state->todo, state->todo_file, 0, 1);
+	if (launch_sequence_editor(state->todo_file, NULL, NULL) < 0) {
+		rebase_common_destroy(&state->opts, state->dir);
+		die("Could not execute editor");
+	}
+
+	/* re-read todo list (which will check the todo list format) */
+	rebase_todo_list_clear(&state->todo);
+	if (rebase_todo_list_load(&state->todo, state->todo_file, 1) < 0)
+		die(_("You can fix this with 'git rebase --edit-todo'"));
+
+	/* count the number of actions in todo list; exit if there are none */
+	state->todo_count = rebase_todo_list_count(&state->todo);
+	if (!state->todo_count) {
+		fprintf_ln(stderr, _("Nothing to do"));
+		rebase_common_destroy(&state->opts, state->dir);
+		exit(2);
+	}
+
+	/* expand todo ids */
+	state->todo_count = rebase_todo_list_count(&state->todo);
+	rebase_todo_list_save(&state->todo, state->todo_file, 0, 0);
+
+	/* checkout onto */
+	if (detach_head(state, &state->opts.onto, state->opts.onto_name) < 0) {
+		rebase_common_destroy(&state->opts, state->dir);
+		die(_("could not detach HEAD"));
+	}
+
+	do_rest(state);
+}
diff --git a/rebase-interactive.h b/rebase-interactive.h
new file mode 100644
index 0000000..bb64203
--- /dev/null
+++ b/rebase-interactive.h
@@ -0,0 +1,33 @@
+#ifndef REBASE_INTERACTIVE_H
+#define REBASE_INTERACTIVE_H
+#include "rebase-common.h"
+#include "rebase-todo.h"
+
+const char *git_path_rebase_interactive_dir(void);
+
+struct rebase_interactive {
+    struct rebase_options opts;
+    char *dir;
+
+    char *todo_file;
+    struct rebase_todo_list todo;
+    unsigned int todo_offset;
+    unsigned int todo_count;
+
+    char *done_file;
+    unsigned int done_count;
+
+    const char *instruction_format;
+};
+
+void rebase_interactive_init(struct rebase_interactive *, const char *);
+
+void rebase_interactive_release(struct rebase_interactive *);
+
+int rebase_interactive_in_progress(const struct rebase_interactive *);
+
+int rebase_interactive_load(struct rebase_interactive *);
+
+void rebase_interactive_run(struct rebase_interactive *);
+
+#endif /* REBASE_INTERACTIVE_H */
-- 
2.7.0
