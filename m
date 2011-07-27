From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/18] revert: Save data for continuing after conflict resolution
Date: Wed, 27 Jul 2011 08:49:08 +0530
Message-ID: <1311736755-24205-12-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QluiX-00068x-Lk
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab1G0DXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:23:13 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab1G0DXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:23:12 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lljSL4jAIqWBg+LWl0efnhHodUSDGSfks5CO17MGUT4=;
        b=fWf7xjyGG1dtxbWrrYjDfVCjsSui5rA1A8Mh5c3oMqlYn1yPCXZBLaLCfHhYoNEbF0
         j7cyw2GfuIX64YK+aizNTG2MVSNb1ijl/i8o1PRhMTzQKCm8O9iETD5KY1VLntNLjkqf
         MZbtZP49kEAjDwhaxPol9GmSvhetj4C2Om828=
Received: by 10.68.36.198 with SMTP id s6mr10797466pbj.51.1311736991747;
        Tue, 26 Jul 2011 20:23:11 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.23.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:23:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177913>

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

That these two files alone are not enough to implement a "--continue"
that remembers the command-line options specified; later patches in
the series save them too.

These new files are unrelated to the existing .git/CHERRY_PICK_HEAD,
which will still be useful while committing after a conflict
resolution.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  222 +++++++++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh |   48 +++++++++
 2 files changed, 264 insertions(+), 6 deletions(-)
 create mode 100755 t/t3510-cherry-pick-sequence.sh

diff --git a/builtin/revert.c b/builtin/revert.c
index 5e26a43..b3b1bf8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -13,6 +13,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "dir.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -59,6 +60,11 @@ struct replay_opts {
 };
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
+#define MAYBE_UNUSED __attribute__((__unused__))
+
+#define SEQ_DIR         "sequencer"
+#define SEQ_HEAD_FILE   "sequencer/head"
+#define SEQ_TODO_FILE   "sequencer/todo"
 
 static const char *action_name(const struct replay_opts *opts)
 {
@@ -269,7 +275,7 @@ static void write_message(struct strbuf *msgbuf, const char *filename)
 		die_errno(_("Could not write to %s."), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s"), filename);
+		die(_("Error wrapping up %s."), filename);
 }
 
 static struct tree *empty_tree(void)
@@ -582,10 +588,199 @@ static void read_and_refresh_cache(struct replay_opts *opts)
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
+static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+{
+	unsigned char commit_sha1[20];
+	char sha1_abbrev[40];
+	struct commit *commit;
+	enum replay_action action;
+	int insn_len = 0;
+	char *p, *q;
+
+	if (!prefixcmp(start, "pick ")) {
+		action = CHERRY_PICK;
+		insn_len = strlen("pick");
+		p = start + insn_len + 1;
+	}
+	else if (!prefixcmp(start, "revert ")) {
+		action = REVERT;
+		insn_len = strlen("revert");
+		p = start + insn_len + 1;
+	}
+	else
+		return NULL;
+
+	q = strchr(p, ' ');
+	if (!q)
+		return NULL;
+	q++;
+
+	strlcpy(sha1_abbrev, p, q - p);
+
+	/*
+	 * Verify that the action matches up with the one in
+	 * opts; we don't support arbitrary instructions
+	 */
+	if (action != opts->action) {
+		const char *action_str;
+		action_str = action == REVERT ? "revert" : "cherry-pick";
+		error(_("Cannot %s during a %s"), action_str, action_name(opts));
+		return NULL;
+	}
+
+	if ((get_sha1(sha1_abbrev, commit_sha1) < 0)
+		|| !(commit = lookup_commit_reference(commit_sha1)))
+		return NULL;
+
+	return commit;
+}
+
+static void MAYBE_UNUSED read_populate_todo(struct commit_list **todo_list,
+					struct replay_opts *opts)
+{
+	const char *todo_file = git_path(SEQ_TODO_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	struct commit_list **next;
+	struct commit *commit;
+	char *p;
+	int fd;
+
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not open %s."), todo_file);
+	}
+	if (strbuf_read(&buf, fd, 0) < buf.len) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), todo_file);
+	}
+	close(fd);
+
+	next = todo_list;
+	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
+		if (!(commit = parse_insn_line(p, opts)))
+			goto error;
+		next = commit_list_append(commit, next);
+	}
+	if (!*todo_list)
+		goto error;
+	strbuf_release(&buf);
+	return;
+error:
+	strbuf_release(&buf);
+	die(_("Unusable instruction sheet: %s"), todo_file);
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
+	if (!file_exists(seq_dir) && mkdir(seq_dir, 0777) < 0)
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
@@ -593,14 +788,29 @@ static int pick_commits(struct replay_opts *opts)
 				opts->record_origin || opts->edit));
 	read_and_refresh_cache(opts);
 
-	prepare_revs(&revs, opts);
-
-	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(commit, opts);
+	walk_revs_populate_todo(&todo_list, opts);
+	create_seq_dir();
+	if (get_sha1("HEAD", sha1)) {
+		if (opts->action == REVERT)
+			return error(_("Can't revert as initial commit"));
+		return error(_("Can't cherry-pick into empty head"));
+	} else
+		save_head(sha1_to_hex(sha1));
+	save_todo(todo_list, opts);
+
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
1.7.4.rc1.7.g2cf08.dirty
