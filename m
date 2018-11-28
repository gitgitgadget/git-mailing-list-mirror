Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659281F609
	for <e@80x24.org>; Wed, 28 Nov 2018 13:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeK2Aj0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 19:39:26 -0500
Received: from bumblebee.htkc.org ([212.129.41.47]:52679 "EHLO
        bumblebee.htkc.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Aj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 19:39:26 -0500
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 19:39:25 EST
Received: by bumblebee.htkc.org (Postfix, from userid 65534)
        id 12FBD900; Wed, 28 Nov 2018 14:28:52 +0100 (CET)
Received: from [192.168.1.33] (unknown [109.132.211.228])
        by bumblebee.htkc.org (Postfix) with ESMTPSA id 608C688D
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 14:28:51 +0100 (CET)
From:   Paul Morelle <paul.morelle@gmail.com>
Subject: [PATCH] rebase -i: introduce the 'test' command
To:     Git Users <git@vger.kernel.org>
Message-ID: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
Date:   Wed, 28 Nov 2018 14:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'exec' command can be used to run tests on a set of commits,
interrupting on failing commits to let the user fix the tests.

However, the 'exec' line has been consumed, so it won't be ran again by
'git rebase --continue' is ran, even if the tests weren't fixed.

This commit introduces a new command 'test' equivalent to 'exec', except
that it is automatically rescheduled in the todo list if it fails.

Signed-off-by: Paul Morelle <paul.morelle@gmail.com>
---
 Documentation/git-rebase.txt  |  9 ++++++---
 rebase-interactive.c          |  1 +
 sequencer.c                   | 23 +++++++++++++++--------
 t/lib-rebase.sh               |  4 +++-
 t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
 5 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 80793bad8..c8f565637 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -693,8 +693,8 @@ $ git rebase -i -p --onto Q O
 Reordering and editing commits usually creates untested intermediate
 steps.  You may want to check that your history editing did not break
 anything by running a test, or at least recompiling at intermediate
-points in history by using the "exec" command (shortcut "x").  You may
-do so by creating a todo list like this one:
+points in history by using the "exec" command (shortcut "x") or the
+"test" command.  You may do so by creating a todo list like this one:
  -------------------------------------------
 pick deadbee Implement feature XXX
@@ -702,7 +702,7 @@ fixup f1a5c00 Fix to feature XXX
 exec make
 pick c0ffeee The oneline of the next commit
 edit deadbab The oneline of the commit after
-exec cd subdir; make test
+test cd subdir; make test
 ...
 -------------------------------------------
 @@ -715,6 +715,9 @@ in `$SHELL`, or the default shell if `$SHELL` is
not set), so you can
 use shell features (like "cd", ">", ";" ...). The command is run from
 the root of the working tree.
 +The "test" command does the same, but will remain in the todo list as
+the next command, until it succeeds.
+
 ----------------------------------
 $ git rebase -i --exec "make test"
 ----------------------------------
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 78f3263fc..4a408661d 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -14,6 +14,7 @@ void append_todo_help(unsigned edit_todo, unsigned
keep_empty,
 "s, squash <commit> = use commit, but meld into previous commit\n"
 "f, fixup <commit> = like \"squash\", but discard this commit's log
message\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
+"   test <command> = same as exec command, but keep it in TODO if it
fails\n"
 "b, break = stop here (continue rebase later with 'git rebase
--continue')\n"
 "d, drop <commit> = remove commit\n"
 "l, label <label> = label current HEAD with a name\n"
diff --git a/sequencer.c b/sequencer.c
index e1a4dd15f..c3dde6910 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1508,6 +1508,7 @@ enum todo_command {
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
+	TODO_TEST,
 	TODO_BREAK,
 	TODO_LABEL,
 	TODO_RESET,
@@ -1530,6 +1531,7 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
+	{ 0,   "test" },
 	{ 'b', "break" },
 	{ 'l', "label" },
 	{ 't', "reset" },
@@ -2072,7 +2074,7 @@ static int parse_insn_line(struct todo_item *item,
const char *bol, char *eol)
 			     command_to_string(item->command));
  	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
-	    item->command == TODO_RESET) {
+	    item->command == TODO_RESET || item->command == TODO_TEST) {
 		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = (int)(eol - bol);
@@ -3576,7 +3578,7 @@ static int pick_commits(struct todo_list
*todo_list, struct replay_opts *opts)
 						item->arg, item->arg_len, opts,
 						res, to_amend);
 			}
-		} else if (item->command == TODO_EXEC) {
+		} else if (item->command == TODO_EXEC || item->command == TODO_TEST) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
 			int saved = *end_of_arg;
 			struct stat st;
@@ -3586,9 +3588,12 @@ static int pick_commits(struct todo_list
*todo_list, struct replay_opts *opts)
 			*end_of_arg = saved;
  			/* Reread the todo file if it has changed. */
-			if (res)
+			if (res) {
 				; /* fall through */
-			else if (stat(get_todo_path(opts), &st))
+				if (item->command == TODO_TEST) {
+					reschedule = 1;
+				}
+			} else if (stat(get_todo_path(opts), &st))
 				res = error_errno(_("could not stat '%s'"),
 						  get_todo_path(opts));
 			else if (match_stat_data(&todo_list->stat, &st)) {
@@ -3622,10 +3627,12 @@ static int pick_commits(struct todo_list
*todo_list, struct replay_opts *opts)
 			return error(_("unknown command %d"), item->command);
  		if (reschedule) {
-			advise(_(rescheduled_advice),
-			       get_item_line_length(todo_list,
-						    todo_list->current),
-			       get_item_line(todo_list, todo_list->current));
+			if (item->command != TODO_TEST) {
+				advise(_(rescheduled_advice),
+				       get_item_line_length(todo_list,
+							    todo_list->current),
+				       get_item_line(todo_list, todo_list->current));
+			}
 			todo_list->current--;
 			if (save_todo(todo_list, opts))
 				return -1;
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 7ea30e500..7d36f00bd 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -19,6 +19,8 @@
 #
 #   "exec_cmd_with_args" -- add an "exec cmd with args" line.
 #
+#   "test_cmd_with_args" -- add a "test cmd with args" line.
+#
 #   "#" -- Add a comment line.
 #
 #   ">" -- Add a blank line.
@@ -49,7 +51,7 @@ set_fake_editor () {
 		case $line in
 		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
 			action="$line";;
-		exec_*|x_*|break|b)
+		exec_*|x_*|break|b|test_*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
 		"#")
 			echo '# comment' >> "$1";;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7a440e08d..14c60b14d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1453,4 +1453,20 @@ test_expect_success 'valid author header when
author contains single quote' '
 	test_cmp expected actual
 '
 +test_expect_success 'rebase -i keeps test until it passes' '
+	git checkout master &&
+	(
+	set_fake_editor &&
+	FAKE_LINES="1 test_false 2 3 4 5" &&
+	export FAKE_LINES &&
+	test_must_fail git rebase -i A &&
+	test_cmp_rev B HEAD &&
+	test_must_fail git rebase --continue &&
+	test_cmp_rev B HEAD &&
+	FAKE_LINES="test_true 2 3 4" git rebase --edit-todo &&
+	git rebase --continue
+	) &&
+	test_cmp_rev master HEAD
+'
+
 test_done
-- 
2.19.1

