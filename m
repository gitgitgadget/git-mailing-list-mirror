From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/17] revert: Save data for continuing after conflict resolution
Date: Mon, 11 Jul 2011 14:54:02 +0000
Message-ID: <1310396048-24925-12-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:54:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHsg-0005F4-NA
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873Ab1GKOyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:35 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55920 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab1GKOya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:30 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so2716880vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=X8Sob97BmzZpybyyxx7HeL43pRRyAwHqenl4Vf/hSSw=;
        b=w24Z40jjxYlZMLz+vmXGWZ2FIU2sS9ZPkV9WwmvFz6tDmZ449Hisfe7wDVB4UKAc9z
         o3ioNGDOkv6cEaUChAwzoFIT8jlT02K/teD/Yif2ypXLFJYAYvJlJ1V8YxNwezhlM6/W
         LSII2kHUpUjeQuRK1iyZeyY7rS747EhQCfYL0=
Received: by 10.52.108.71 with SMTP id hi7mr2347201vdb.324.1310396070188;
        Mon, 11 Jul 2011 07:54:30 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176849>

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

It is imperative to note that these two files alone are not enough to
implement "--continue"; we will also need to persist the options that
were specified on the command-line, and this is done later in the
series.

These new files are unrelated to the existing .git/CHERRY_PICK_HEAD,
which will still be useful while committing after a conflict
resolution.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  202 ++++++++++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh |   48 +++++++++
 2 files changed, 246 insertions(+), 4 deletions(-)
 create mode 100755 t/t3510-cherry-pick-sequence.sh

diff --git a/builtin/revert.c b/builtin/revert.c
index ef5b097..856ee97 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -13,6 +13,8 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "dir.h"
+#include "sequencer.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -569,10 +571,192 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
-static int pick_commits(struct replay_opts *opts)
+/* Insert into todo_list in same order; commit_list_insert reverses
+ * the order
+ *
+ * Usage example:
+ *
+ *     struct commit_list *list;
+ *     struct commit_list **next = &list;
+ *
+ *     next = commit_list_append(c1, next);
+ *     next = commit_list_append(c2, next);
+ *     *next = NULL;
+ *     assert(commit_list_count(list) == 2);
+ *     return list;
+ *
+ * Don't forget to NULL-terminate!
+ */
+struct commit_list **commit_list_append(struct commit *commit,
+					struct commit_list **next)
+{
+	struct commit_list *new = xmalloc(sizeof(struct commit_list));
+	new->item = commit;
+	*next = new;
+	return &new->next;
+}
+
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
+static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+{
+	unsigned char commit_sha1[20];
+	char sha1_abbrev[40];
+	struct commit *commit;
+	enum replay_action action;
+	int insn_len = 0;
+	char *p;
+
+	p = start;
+	if (!(p = strchr(p, ' ')))
+		return NULL;
+	insn_len = p - start;
+	if (!(p = strchr(p + 1, ' ')))
+		return NULL;
+	p += 1;
+	strlcpy(sha1_abbrev, start + insn_len + 1,
+		p - (start + insn_len + 1));
+
+	if (!strncmp(start, "pick", insn_len))
+		action = CHERRY_PICK;
+	else if (!strncmp(start, "revert", insn_len))
+		action = REVERT;
+	else
+		return NULL;
+
+	/*
+	 * Verify that the action matches up with the one in
+	 * opts; we don't support arbitrary instructions
+	 */
+	if (action != opts->action)
+		return NULL;
+
+	if ((get_sha1(sha1_abbrev, commit_sha1) < 0)
+		|| !(commit = lookup_commit_reference(commit_sha1)))
+		return NULL;
+
+	return commit;
+}
+
+static void read_populate_todo(struct commit_list **todo_list,
+			struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct commit_list *new;
+	struct commit_list **next;
+	struct commit *commit;
+	char *p;
+	int fd;
+
+	fd = open(git_path(SEQ_TODO_FILE), O_RDONLY);
+	if (fd < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not open %s."), git_path(SEQ_TODO_FILE));
+	}
+	if (strbuf_read(&buf, fd, 0) < buf.len) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), git_path(SEQ_TODO_FILE));
+	}
+	close(fd);
+
+	next = todo_list;
+	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
+		if (!(commit = parse_insn_line(p, opts)))
+			goto error;
+		new = xmalloc(sizeof(struct commit_list));
+		new->item = commit;
+		*next = new;
+		next = &new->next;
+	}
+	*next = NULL;
+	if (!*todo_list)
+		goto error;
+	strbuf_release(&buf);
+	return;
+error:
+	strbuf_release(&buf);
+	die(_("Malformed instruction sheet: %s"), git_path(SEQ_TODO_FILE));
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
+static int pick_commits(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+	unsigned char sha1[20];
+	struct commit_list *cur;
+	int res;
 
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	if (opts->allow_ff)
@@ -580,14 +764,24 @@ static int pick_commits(struct replay_opts *opts)
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
 
+	/*
+	 * Sequence of picks finished successfully; cleanup by
+	 * removing the .git/sequencer directory
+	 */
+	remove_sequencer_state();
 	return 0;
 }
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
new file mode 100755
index 0000000..64eaa20
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
+	test_path_is_file .git/sequencer/todo &&
+	rm -rf .git/sequencer
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
1.7.5.GIT
