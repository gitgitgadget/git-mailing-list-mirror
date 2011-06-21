From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/13] revert: Persist data for continuation
Date: Tue, 21 Jun 2011 13:04:46 +0000
Message-ID: <1308661489-20080-11-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0e7-00065X-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673Ab1FUNFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:12 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51876 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475Ab1FUNFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:05:10 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so1679724vxb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BtzOM88nqmQlEZr2i1iD2T8g7CVtBEuFN99GfMcDLII=;
        b=xDYG3eop63QLLwPIJZQ5zKs1DTXM+zxx8dTn2wkKXj3wBS73/yc4QXrViSZOJxJDuu
         mZGYlsQsWjj5iVtgnf6qMVVhOvsEXb2j7k/A3ISLGF/uJrTs60vvO4Ortt/IiiriLSBY
         8LT2DVqao+bEIKX5Z71LGhoD5aIGjM+pnUUJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HN1IO7516Wmr2533Vii7LoBtDtpN+rOUONQr1brIKfKkLCZq9EQxj9rMkqNUphGTYp
         47Bl7/HhtGbONJPxBkyKZPFnwgOgn8W03NS153g1E3sSbyvPHX+AkDoqUEX4OiTxCHrw
         ZgJLfQLcDW3EAehChM6EHXLIIdpuu6vliM/7w=
Received: by 10.52.161.231 with SMTP id xv7mr532181vdb.254.1308661510371;
        Tue, 21 Jun 2011 06:05:10 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.05.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:05:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176150>

Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
one commit, 2010-06-02), a single invocation of "git cherry-pick" or
"git revert" can perform picks of several individual commits.  To
implement features like "--continue" to continue the whole operation,
we will need to store some information about the state and the plan at
the beginning.  Introduce a ".git/sequencer/head" file to store this
state, and ".git/sequencer/todo" file to store the plan.  Don't touch
CHERRY_PICK_HEAD -- it will still be useful when a conflict is
encountered.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  123 ++++++++++++++++++++++++++++++++++++--
 t/t3510-cherry-pick-sequence.sh |   37 ++++++++++++
 2 files changed, 153 insertions(+), 7 deletions(-)
 create mode 100644 t/t3510-cherry-pick-sequence.sh

diff --git a/builtin/revert.c b/builtin/revert.c
index cfa898f..ca5756b 100644
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
 
+#define SEQ_DIR		git_path("sequencer")
+#define HEAD_FILE	git_path("sequencer/head")
+#define TODO_FILE	git_path("sequencer/todo")
+
 static const char * const revert_usage[] = {
 	"git revert [options] <commit-ish>",
 	NULL
@@ -412,7 +417,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			return error(_("Your index file is unmerged."));
 	} else {
 		if (get_sha1("HEAD", head))
-			return error(_("You do not have a valid HEAD"));
+			return error(_("Can't %s on an unborn branch"), me);
 		if (index_differs_from("HEAD", 0))
 			return error_dirty_index(me);
 	}
@@ -574,23 +579,127 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
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
+	struct commit_list *new_item;
+	struct commit_list *cur = NULL;
+
+	/* Insert into todo_list in the same order */
+	prepare_revs(&revs, opts);
+	while ((commit = get_revision(&revs))) {
+		new_item = xmalloc(sizeof(struct commit_list));
+		new_item->item = commit;
+		if (cur)
+			cur->next = new_item;
+		else
+			*todo_list = new_item;
+		cur = new_item;
+	}
+	cur->next = NULL;
+}
+
+static void persist_head(const char *head)
+{
+	static struct lock_file head_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	if (file_exists(SEQ_DIR)) {
+		if (!is_directory(SEQ_DIR) && remove_path(SEQ_DIR) < 0) {
+			strbuf_release(&buf);
+			die(_("Could not remove %s"), SEQ_DIR);
+		}
+	} else {
+		if (mkdir(SEQ_DIR, 0777) < 0) {
+			strbuf_release(&buf);
+			die_errno(_("Could not create sequencer directory '%s'."), SEQ_DIR);
+		}
+	}
+	fd = hold_lock_file_for_update(&head_lock, HEAD_FILE, LOCK_DIE_ON_ERROR);
+	strbuf_addf(&buf, "%s\n", head);
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s."), HEAD_FILE);
+	if (commit_lock_file(&head_lock) < 0)
+		die(_("Error wrapping up %s"), HEAD_FILE);
+}
+
+static void persist_todo(struct commit_list *todo_list, struct replay_opts *opts)
+{
+	static struct lock_file todo_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&todo_lock, TODO_FILE, LOCK_DIE_ON_ERROR);
+	format_todo(&buf, todo_list, opts);
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not write to %s."), TODO_FILE);
+	}
+	if (commit_lock_file(&todo_lock) < 0) {
+		strbuf_release(&buf);
+		die(_("Error wrapping up %s"), TODO_FILE);
+	}
+	strbuf_release(&buf);
+}
+
+static int cleanup_sequencer_data(void)
+{
+	static struct strbuf seq_dir = STRBUF_INIT;
+
+	strbuf_addf(&seq_dir, "%s", SEQ_DIR);
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
 
-	setenv(GIT_REFLOG_ACTION, me, 0);
 	read_and_refresh_cache(me, opts);
+	setenv(GIT_REFLOG_ACTION, me, 0);
 
-	prepare_revs(&revs, opts);
+	walk_revs_populate_todo(&todo_list, opts);
+	if (!get_sha1("HEAD", sha1))
+		persist_head(sha1_to_hex(sha1));
+	persist_todo(todo_list, opts);
 
-	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(commit, opts);
+	for (cur = todo_list; cur; cur = cur->next) {
+		persist_todo(cur, opts);
+		res = do_pick_commit(cur->item, opts);
 		if (res)
 			return res;
 	}
 
-	return 0;
+	/* Sequence of picks finished successfully; cleanup by
+	   removing the .git/sequencer directory */
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
