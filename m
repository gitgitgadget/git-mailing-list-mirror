From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/14] revert: Persist data for continuation
Date: Wed,  6 Jul 2011 07:54:24 +0000
Message-ID: <1309938868-2028-11-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwh-0005vT-9K
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab1GFHyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:49 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50598 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab1GFHyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:47 -0400
Received: by mail-qy0-f181.google.com with SMTP id 9so3905037qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=T6Kp58tvsoAOT/7+cFEKrQJQ+OqZwPRBF6ZoY8/+U/o=;
        b=rqtl7rZLea5rjJjwJd5zAGLUpTWJJeR/EYidotaVxHoVLp7p6nHqNO31xszte7s54e
         kpt+nb0+Z77EO1mzoUHNQlnuTuLc4s4S8BdxEz1F/ACDAi/KcozYcJpf9wVTsWl1gxHO
         SGMnxuJ+rGNIVhdvRjW9yHmFyRn7Je87mTACU=
Received: by 10.224.215.195 with SMTP id hf3mr4761266qab.68.1309938887078;
        Wed, 06 Jul 2011 00:54:47 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176654>

Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
one commit, 2010-06-02), a single invocation of "git cherry-pick" or
"git revert" can perform picks of several individual commits.  To
implement features like "--continue" to continue the whole operation,
we will need to store some information about the state and the plan at
the beginning.  Introduce a ".git/sequencer/head" file to store this
state, and ".git/sequencer/todo" file to store the plan.  These new
files are unrelated to the existing CHERRY_PICK_HEAD, which will still
be useful when a conflict is encountered.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  122 +++++++++++++++++++++++++++++++++++++--
 t/t3510-cherry-pick-sequence.sh |   37 ++++++++++++
 2 files changed, 153 insertions(+), 6 deletions(-)
 create mode 100644 t/t3510-cherry-pick-sequence.sh

diff --git a/builtin/revert.c b/builtin/revert.c
index 27dc538..7d76f92 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -13,6 +13,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "dir.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -25,6 +26,10 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 
+#define SEQ_DIR		"sequencer"
+#define SEQ_HEAD_FILE	"sequencer/head"
+#define SEQ_TODO_FILE	"sequencer/todo"
+
 static const char * const revert_usage[] = {
 	"git revert [options] <commit-ish>",
 	NULL
@@ -417,7 +422,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			return error(_("Your index file is unmerged."));
 	} else {
 		if (get_sha1("HEAD", head))
-			return error(_("You do not have a valid HEAD"));
+			return error(_("Can't %s on an unborn branch"), me);
 		if (index_differs_from("HEAD", 0))
 			return error_dirty_index(me, opts->action);
 	}
@@ -578,10 +583,106 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
-static int pick_commits(struct replay_opts *opts)
+static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
+			struct replay_opts *opts)
+{
+	struct commit_list *cur = NULL;
+	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+	const char *sha1_abbrev = NULL;
+	const char *action;
+
+	action = (opts->action == REVERT ? "revert" : "pick");
+	for (cur = todo_list; cur; cur = cur->next) {
+		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
+		if (get_message(cur->item, &msg))
+			die(_("Cannot get commit message for %s"), sha1_abbrev);
+		strbuf_addf(buf, "%s %s %s\n", action, sha1_abbrev, msg.subject);
+	}
+}
+
+static void walk_revs_populate_todo(struct commit_list **todo_list,
+				struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
+	struct commit_list *new;
+	struct commit_list **next;
+
+	prepare_revs(&revs, opts);
+
+	/* Insert into todo_list in the same order */
+	/* NEEDSWORK: Expose this as commit_list_append */
+	next = todo_list;
+	while ((commit = get_revision(&revs))) {
+		new = xmalloc(sizeof(struct commit_list));
+		new->item = commit;
+		*next = new;
+		next = &new->next;
+	}
+	*next = NULL;
+}
+
+static void create_seq_dir(void)
+{
+	if (file_exists(git_path(SEQ_DIR))) {
+		if (!is_directory(git_path(SEQ_DIR)) && remove_path(git_path(SEQ_DIR)) < 0)
+			die(_("Could not remove %s"), git_path(SEQ_DIR));
+	} else if (mkdir(git_path(SEQ_DIR), 0777) < 0)
+		die_errno(_("Could not create sequencer directory '%s'."), git_path(SEQ_DIR));
+}
+
+static void save_head(const char *head)
+{
+	static struct lock_file head_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&head_lock, git_path(SEQ_HEAD_FILE), LOCK_DIE_ON_ERROR);
+	strbuf_addf(&buf, "%s\n", head);
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s."), git_path(SEQ_HEAD_FILE));
+	if (commit_lock_file(&head_lock) < 0)
+		die(_("Error wrapping up %s"), git_path(SEQ_HEAD_FILE));
+}
+
+static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+{
+	static struct lock_file todo_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&todo_lock, git_path(SEQ_TODO_FILE), LOCK_DIE_ON_ERROR);
+	format_todo(&buf, todo_list, opts);
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not write to %s."), git_path(SEQ_TODO_FILE));
+	}
+	if (commit_lock_file(&todo_lock) < 0) {
+		strbuf_release(&buf);
+		die(_("Error wrapping up %s"), git_path(SEQ_TODO_FILE));
+	}
+	strbuf_release(&buf);
+}
+
+static int cleanup_sequencer_data(void)
+{
+	static struct strbuf seq_dir = STRBUF_INIT;
+
+	strbuf_addf(&seq_dir, "%s", git_path(SEQ_DIR));
+	if (remove_dir_recursively(&seq_dir, 0) < 0) {
+		strbuf_release(&seq_dir);
+		return error(_("Unable to clean up after successful %s"), me);
+	}
+	strbuf_release(&seq_dir);
+	return 0;
+}
+
+static int pick_commits(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+	unsigned char sha1[20];
+	struct commit_list *cur;
+	int res;
 
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	if (opts->allow_ff)
@@ -589,15 +690,24 @@ static int pick_commits(struct replay_opts *opts)
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(me, opts);
 
-	prepare_revs(&revs, opts);
+	walk_revs_populate_todo(&todo_list, opts);
+	create_seq_dir();
+	if (!get_sha1("HEAD", sha1))
+		save_head(sha1_to_hex(sha1));
+	save_todo(todo_list, opts);
 
-	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(commit, opts);
+	for (cur = todo_list; cur; cur = cur->next) {
+		save_todo(cur, opts);
+		res = do_pick_commit(cur->item, opts);
 		if (res)
 			return res;
 	}
 
-	return 0;
+	/*
+	 * Sequence of picks finished successfully; cleanup by
+	 * removing the .git/sequencer directory
+	 */
+	return cleanup_sequencer_data();
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
new file mode 100644
index 0000000..83e2722
--- /dev/null
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='Test cherry-pick continuation features
+
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
+	git config advice.detachedhead false
+
+'
+
+test_expect_success 'cherry-pick cleans up sequencer directory upon success' '
+	pristine_detach initial &&
+	git cherry-pick initial..picked &&
+	test_path_is_missing .git/sequencer
+'
+
+test_done
-- 
1.7.5.GIT
