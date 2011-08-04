From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/18] revert: Save data for continuing after conflict resolution
Date: Thu,  4 Aug 2011 16:09:08 +0530
Message-ID: <1312454356-3070-11-git-send-email-artagnon@gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:43:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovOa-0007Db-2h
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab1HDKnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:43:12 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63604 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab1HDKnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:43:11 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1836868pzk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JE71GkP8CGnE1ilLMumVrEOHIzDlH3TID8TUCwxPIOo=;
        b=ZF51fupV5wgGwCDucLfCeqSncoi4XIv97S6i5wGeckpevvXHCWnERgyGiI6wysW+Fm
         Zam9pzRSuJfatRHxmEKBcIDY/Q+RtE+Ch8G5YZtUNX+ggVQKS9RckQx7CVSMz9OayVU7
         JLpJBR4BfUyCIiGp7YA47oCqFUlGsNdWD3L9w=
Received: by 10.142.120.9 with SMTP id s9mr586237wfc.431.1312454590659;
        Thu, 04 Aug 2011 03:43:10 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.43.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:43:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178727>

Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
one commit, 2010-06-02), a single invocation of "git cherry-pick" or
"git revert" can perform picks of several individual commits.  To
implement features like "--continue" to continue the whole operation,
we will need to store some information about the state and the plan at
the beginning.  Introduce a ".git/sequencer/head" file to store this
state, and ".git/sequencer/todo" file to store the plan.  The head
file contains the SHA-1 of the HEAD before the start of the operation,
and the todo file contains an instruction sheet whose format is
inspired by the format of the "rebase -i" instruction sheet.  As a
result, a typical todo file looks like:

  pick 8537f0e submodule add: test failure when url is not configured
  pick 4d68932 submodule add: allow relative repository path
  pick f22a17e submodule add: clean up duplicated code
  pick 59a5775 make copy_ref globally available

Since SHA-1 hex is abbreviated using an find_unique_abbrev(), it is
unambiguous.  This does not guarantee that there will be no ambiguity
when more objects are added to the repository.

These two files alone are not enough to implement a "--continue" that
remembers the command-line options specified; later patches in the
series save them too.

These new files are unrelated to the existing .git/CHERRY_PICK_HEAD,
which will still be useful while committing after a conflict
resolution.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |  134 +++++++++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh |   48 ++++++++++++++
 2 files changed, 178 insertions(+), 4 deletions(-)
 create mode 100755 t/t3510-cherry-pick-sequence.sh

diff --git a/builtin/revert.c b/builtin/revert.c
index f75c9cb..54df8a2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -13,6 +13,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "dir.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -60,6 +61,10 @@ struct replay_opts {
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
+#define SEQ_DIR         "sequencer"
+#define SEQ_HEAD_FILE   "sequencer/head"
+#define SEQ_TODO_FILE   "sequencer/todo"
+
 static const char *action_name(const struct replay_opts *opts)
 {
 	return opts->action == REVERT ? "revert" : "cherry-pick";
@@ -587,10 +592,116 @@ static void read_and_refresh_cache(struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
-static int pick_commits(struct replay_opts *opts)
+/*
+ * Append a commit to the end of the commit_list.
+ *
+ * next starts by pointing to the variable that holds the head of an
+ * empty commit_list, and is updated to point to the "next" field of
+ * the last item on the list as new commits are appended.
+ *
+ * Usage example:
+ *
+ *     struct commit_list *list;
+ *     struct commit_list **next = &list;
+ *
+ *     next = commit_list_append(c1, next);
+ *     next = commit_list_append(c2, next);
+ *     assert(commit_list_count(list) == 2);
+ *     return list;
+ */
+struct commit_list **commit_list_append(struct commit *commit,
+					struct commit_list **next)
+{
+	struct commit_list *new = xmalloc(sizeof(struct commit_list));
+	new->item = commit;
+	*next = new;
+	new->next = NULL;
+	return &new->next;
+}
+
+static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
+		struct replay_opts *opts)
+{
+	struct commit_list *cur = NULL;
+	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+	const char *sha1_abbrev = NULL;
+	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+
+	for (cur = todo_list; cur; cur = cur->next) {
+		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
+		if (get_message(cur->item, &msg))
+			return error(_("Cannot get commit message for %s"), sha1_abbrev);
+		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
+	}
+	return 0;
+}
+
+static void walk_revs_populate_todo(struct commit_list **todo_list,
+				struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
+	struct commit_list **next;
+
+	prepare_revs(&revs, opts);
+
+	next = todo_list;
+	while ((commit = get_revision(&revs)))
+		next = commit_list_append(commit, next);
+}
+
+static void create_seq_dir(void)
+{
+	const char *seq_dir = git_path(SEQ_DIR);
+
+	if (!(file_exists(seq_dir) && is_directory(seq_dir))
+		&& mkdir(seq_dir, 0777) < 0)
+		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);
+}
+
+static void save_head(const char *head)
+{
+	const char *head_file = git_path(SEQ_HEAD_FILE);
+	static struct lock_file head_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
+	strbuf_addf(&buf, "%s\n", head);
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s."), head_file);
+	if (commit_lock_file(&head_lock) < 0)
+		die(_("Error wrapping up %s."), head_file);
+}
+
+static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+{
+	const char *todo_file = git_path(SEQ_TODO_FILE);
+	static struct lock_file todo_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
+	if (format_todo(&buf, todo_list, opts) < 0)
+		die(_("Could not format %s."), todo_file);
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not write to %s."), todo_file);
+	}
+	if (commit_lock_file(&todo_lock) < 0) {
+		strbuf_release(&buf);
+		die(_("Error wrapping up %s."), todo_file);
+	}
+	strbuf_release(&buf);
+}
+
+static int pick_commits(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+	struct commit_list *cur;
+	int res;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
@@ -598,14 +709,29 @@ static int pick_commits(struct replay_opts *opts)
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(opts);
 
-	prepare_revs(&revs, opts);
+	walk_revs_populate_todo(&todo_list, opts);
+	create_seq_dir();
+	if (get_sha1("HEAD", sha1)) {
+		if (opts->action == REVERT)
+			die(_("Can't revert as initial commit"));
+		die(_("Can't cherry-pick into empty head"));
+	}
+	save_head(sha1_to_hex(sha1));
 
-	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(commit, opts);
+	for (cur = todo_list; cur; cur = cur->next) {
+		save_todo(cur, opts);
+		res = do_pick_commit(cur->item, opts);
 		if (res)
 			return res;
 	}
 
+	/*
+	 * Sequence of picks finished successfully; cleanup by
+	 * removing the .git/sequencer directory
+	 */
+	strbuf_addf(&buf, "%s", git_path(SEQ_DIR));
+	remove_dir_recursively(&buf, 0);
+	strbuf_release(&buf);
 	return 0;
 }
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
new file mode 100755
index 0000000..a2c70ad
--- /dev/null
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='Test cherry-pick continuation features
+
+  + anotherpick: rewrites foo to d
+  + picked: rewrites foo to c
+  + unrelatedpick: rewrites unrelated to reallyunrelated
+  + base: rewrites foo to b
+  + initial: writes foo as a, unrelated as unrelated
+
+'
+
+. ./test-lib.sh
+
+pristine_detach () {
+	rm -rf .git/sequencer &&
+	git checkout -f "$1^0" &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x
+}
+
+test_expect_success setup '
+	echo unrelated >unrelated &&
+	git add unrelated &&
+	test_commit initial foo a &&
+	test_commit base foo b &&
+	test_commit unrelatedpick unrelated reallyunrelated &&
+	test_commit picked foo c &&
+	test_commit anotherpick foo d &&
+	git config advice.detachedhead false
+
+'
+
+test_expect_success 'cherry-pick persists data on failure' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	test_path_is_dir .git/sequencer &&
+	test_path_is_file .git/sequencer/head &&
+	test_path_is_file .git/sequencer/todo
+'
+
+test_expect_success 'cherry-pick cleans up sequencer state upon success' '
+	pristine_detach initial &&
+	git cherry-pick initial..picked &&
+	test_path_is_missing .git/sequencer
+'
+
+test_done
-- 
1.7.6.351.gb35ac.dirty
