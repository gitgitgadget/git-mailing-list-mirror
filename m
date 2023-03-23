Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84713C76196
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjCWQr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjCWQrB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:01 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F19ABDC3
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:30 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E14162424B
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B0h-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 8/8] rebase: improve resumption from incorrect initial todo list
Date:   Thu, 23 Mar 2023 17:22:35 +0100
Message-Id: <20230323162235.995574-9-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user butchers the todo file during rebase -i setup, the
--continue which would follow --edit-todo would have skipped the last
steps of the setup. Notably, this would bypass the fast-forward over
untouched picks (though the actual picking loop would still fast-forward
the commits, one by one).

Fix this by splitting off the tail of complete_action() to a new
start_rebase() function and call that from sequencer_continue() when no
commands have been executed yet.

More or less as a side effect, we no longer checkout `onto` before exiting
when the todo file is bad. This makes aborting cheaper and will simplify
things in a later change.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 builtin/rebase.c              |  4 +-
 builtin/revert.c              |  3 +-
 sequencer.c                   | 89 ++++++++++++++++++++---------------
 sequencer.h                   |  4 +-
 t/t3404-rebase-interactive.sh | 31 ++++++++++++
 5 files changed, 91 insertions(+), 40 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e703b29835..61e5363ac7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -333,7 +333,9 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 	case ACTION_CONTINUE: {
 		struct replay_opts replay_opts = get_replay_opts(opts);
 
-		ret = sequencer_continue(the_repository, &replay_opts);
+		ret = sequencer_continue(the_repository, &replay_opts, flags,
+					 opts->onto_name, &opts->onto->object.oid,
+					 &opts->orig_head->object.oid);
 		replay_opts_release(&replay_opts);
 		break;
 	}
diff --git a/builtin/revert.c b/builtin/revert.c
index 62986a7b1b..00d3e19c62 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -231,7 +231,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		return ret;
 	}
 	if (cmd == 'c')
-		return sequencer_continue(the_repository, opts);
+		return sequencer_continue(the_repository, opts,
+					  0, NULL, NULL, NULL);
 	if (cmd == 'a')
 		return sequencer_rollback(the_repository, opts);
 	if (cmd == 's')
diff --git a/sequencer.c b/sequencer.c
index aef42122f1..0b4d16b8e8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3369,7 +3369,7 @@ int sequencer_skip(struct repository *r, struct replay_opts *opts)
 	if (!is_directory(git_path_seq_dir()))
 		return 0;
 
-	return sequencer_continue(r, opts);
+	return sequencer_continue(r, opts, 0, NULL, NULL, NULL);
 
 give_advice:
 	error(_("there is nothing to skip"));
@@ -5096,7 +5096,13 @@ static int commit_staged_changes(struct repository *r,
 	return 0;
 }
 
-int sequencer_continue(struct repository *r, struct replay_opts *opts)
+static int start_rebase(struct repository *r, struct replay_opts *opts, unsigned flags,
+			const char *onto_name, const struct object_id *onto,
+			const struct object_id *orig_head, struct todo_list *todo_list);
+
+int sequencer_continue(struct repository *r, struct replay_opts *opts, unsigned flags,
+		       const char *onto_name, const struct object_id *onto,
+		       const struct object_id *orig_head)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
 	int res;
@@ -5117,6 +5123,13 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			unlink(rebase_path_dropped());
 		}
 
+		if (!todo_list.done_nr) {
+			res = start_rebase(r, opts, flags,
+					   onto_name, onto,
+					   orig_head, &todo_list);
+			goto release_todo_list;
+		}
+
 		opts->reflog_message = reflog_message(opts, "continue", NULL);
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
@@ -6096,9 +6109,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    enum rebase_action action)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
-	const char *todo_file = rebase_path_todo();
 	struct todo_list new_todo = TODO_LIST_INIT;
-	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
+	struct strbuf *buf = &todo_list->buf;
 	int res;
 
 	find_unique_abbrev_r(shortonto, onto, DEFAULT_ABBREV);
@@ -6142,49 +6154,52 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 		return error(_("nothing to do"));
 	} else if (res == EDIT_TODO_INCORRECT) {
-		checkout_onto(r, opts, onto_name, onto, orig_head);
 		todo_list_release(&new_todo);
 
 		return -1;
 	}
 
-	/* Expand the commit IDs */
-	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
-	strbuf_swap(&new_todo.buf, &buf2);
-	strbuf_release(&buf2);
-	new_todo.total_nr -= new_todo.nr;
-	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
-		BUG("invalid todo list after expanding IDs:\n%s",
-		    new_todo.buf.buf);
-
-	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &onto)) {
-		todo_list_release(&new_todo);
-		return error(_("could not skip unnecessary pick commands"));
-	}
-
-	if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
-				    flags & ~(TODO_LIST_SHORTEN_IDS), action)) {
-		todo_list_release(&new_todo);
-		return error_errno(_("could not write '%s'"), todo_file);
-	}
-
-	res = -1;
-
-	if (checkout_onto(r, opts, onto_name, onto, orig_head))
-		goto cleanup;
-
-	if (require_clean_work_tree(r, "rebase", NULL, 1, 1))
-		goto cleanup;
-
-	todo_list_write_total_nr(&new_todo);
-	res = pick_commits(r, &new_todo, opts);
-
-cleanup:
+	res = start_rebase(r, opts, flags, onto_name, onto, orig_head, &new_todo);
 	todo_list_release(&new_todo);
 
 	return res;
 }
 
+static int start_rebase(struct repository *r, struct replay_opts *opts, unsigned flags,
+			const char *onto_name, const struct object_id *onto,
+			const struct object_id *orig_head, struct todo_list *todo_list)
+{
+	const char *todo_file = rebase_path_todo();
+	struct strbuf buf2 = STRBUF_INIT;
+
+	/* Expand the commit IDs */
+	todo_list_to_strbuf(r, todo_list, &buf2, -1, 0);
+	strbuf_swap(&todo_list->buf, &buf2);
+	strbuf_release(&buf2);
+	todo_list->total_nr -= todo_list->nr;
+	if (todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) < 0)
+		BUG("invalid todo list after expanding IDs:\n%s",
+		    todo_list->buf.buf);
+
+	if (opts->allow_ff && skip_unnecessary_picks(r, todo_list, &onto))
+		return error(_("could not skip unnecessary pick commands"));
+
+	if (todo_list_write_to_file(r, todo_list, todo_file, NULL, NULL, -1,
+				    flags & ~(TODO_LIST_SHORTEN_IDS |
+					      TODO_LIST_APPEND_TODO_HELP),
+				    ACTION_CONTINUE))
+		return error_errno(_("could not write '%s'"), todo_file);
+
+	if (checkout_onto(r, opts, onto_name, onto, orig_head))
+		return -1;
+
+	if (require_clean_work_tree(r, "rebase", NULL, 1, 1))
+		return -1;
+
+	todo_list_write_total_nr(todo_list);
+	return pick_commits(r, todo_list, opts);
+}
+
 struct subject2item_entry {
 	struct hashmap_entry entry;
 	int i;
diff --git a/sequencer.h b/sequencer.h
index 24bf71d5db..33bcff89e0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -158,7 +158,9 @@ void todo_list_filter_update_refs(struct repository *r,
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct repository *repo,
 			     struct replay_opts *opts);
-int sequencer_continue(struct repository *repo, struct replay_opts *opts);
+int sequencer_continue(struct repository *repo, struct replay_opts *opts, unsigned flags,
+		       const char *onto_name, const struct object_id *onto,
+		       const struct object_id *orig_head);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
 void replay_opts_release(struct replay_opts *opts);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c625aad10a..dd47f0bbce 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1597,6 +1597,37 @@ test_expect_success 'static check of bad command' '
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+
+test_expect_success 'continue after bad first command' '
+	test_when_finished "git rebase --abort ||:" &&
+	git checkout primary^0 &&
+	git reflog expire --expire=all HEAD &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="bad 1 pick 1 pick 2 reword 3" \
+			git rebase -i HEAD~3 &&
+		test_cmp_rev HEAD primary &&
+		FAKE_LINES="pick 2 pick 3 reword 4" git rebase --edit-todo &&
+		FAKE_COMMIT_MESSAGE="E_reworded" git rebase --continue
+	) &&
+	git reflog > reflog &&
+	test $(grep -c fast-forward reflog) = 1 &&
+	test_cmp_rev HEAD~1 primary~1 &&
+	test "$(git log -1 --format=%B)" = "E_reworded"
+'
+
+test_expect_success 'abort after bad first command' '
+	test_when_finished "git rebase --abort ||:" &&
+	git checkout primary^0 &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="bad 1 pick 1 pick 2 reword 3" \
+			git rebase -i HEAD~3
+	) &&
+	git rebase --abort &&
+	test_cmp_rev HEAD primary
+'
+
 test_expect_success 'tabs and spaces are accepted in the todolist' '
 	rebase_setup_and_clean indented-comment &&
 	write_script add-indent.sh <<-\EOF &&
-- 
2.40.0.152.g15d061e6df

