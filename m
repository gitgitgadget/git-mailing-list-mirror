From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3] Teach merge the '[-e|--edit]' option
Date: Sat,  8 Oct 2011 14:39:52 -0400
Message-ID: <1318099192-60860-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 20:40:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCboZ-0001Fr-62
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 20:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab1JHSj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 14:39:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50723 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1JHSj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 14:39:56 -0400
Received: by ywb5 with SMTP id 5so4459343ywb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vw25pXFiIa0GmJwpQVLbupYIsK7DI8ccGZcYMxbo8Mg=;
        b=oB7pIhDyXXYOK6iVr3Y+vR4cruERkXH+hvVQjfADk7JL4wbXu3V0JBqIMKE4jJDZHe
         zrWXrV4eGF5bSmCBEoWs37vZnzsg2t6ihpCW1VEj/X2pr+Upana04i6QbHcV0s2Dw5e9
         C3YrrCXinYKhKtNkc8PlCive4XQDk7VcCngKQ=
Received: by 10.236.76.38 with SMTP id a26mr16768997yhe.53.1318099195671;
        Sat, 08 Oct 2011 11:39:55 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id u21sm13958765yhe.1.2011.10.08.11.39.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 11:39:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.147.g4f6dc9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183173>

Implemented internally instead of as "git merge --no-commit && git commit"
so that "merge --edit" is otherwise consistent (hooks, etc) with "merge".

Note: the edit message does not include the status information that one
gets with "commit --status" and it is cleaned up after editing like one
gets with "commit --cleanup=default". A later patch could add the status
information if desired.

Note: previously we were not calling stripspace() after running the
prepare-commit-msg hook. Now we are, stripping comments and
leading/trailing whitespace lines if --edit is given, otherwise only
stripping leading/trailing whitespace lines if not given --edit.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I probably can't spend more time on this patch any time soon. Hopefully
this iteration is close enough. If not, maybe Todd can help.

 Documentation/merge-options.txt |    6 ++
 builtin/merge.c                 |  109 +++++++++++++++++++++++++--------------
 t/t7600-merge.sh                |   15 +++++
 3 files changed, 91 insertions(+), 39 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index b613d4ed08..6bd0b041c3 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -7,6 +7,12 @@ With --no-commit perform the merge but pretend the merge
 failed and do not autocommit, to give the user a chance to
 inspect and further tweak the merge result before committing.
 
+--edit::
+-e::
++
+	Invoke editor before committing successful merge to further
+	edit the default merge message.
+
 --ff::
 --no-ff::
 	Do not generate a merge commit if the merge resolved as
diff --git a/builtin/merge.c b/builtin/merge.c
index ee56974371..fcb7a60bfa 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -46,7 +46,7 @@ static const char * const builtin_merge_usage[] = {
 
 static int show_diffstat = 1, shortlog_len, squash;
 static int option_commit = 1, allow_fast_forward = 1;
-static int fast_forward_only;
+static int fast_forward_only, option_edit;
 static int allow_trivial = 1, have_message;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
@@ -190,6 +190,8 @@ static struct option builtin_merge_options[] = {
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
 		"perform a commit if the merge succeeds (default)"),
+	OPT_BOOLEAN('e', "edit", &option_edit,
+		"edit message before committing"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast-forward (default)"),
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
@@ -842,30 +844,54 @@ static void add_strategies(const char *string, unsigned attr)
 
 }
 
-static void write_merge_msg(void)
+static void write_merge_msg(struct strbuf *msg)
 {
 	int fd = open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"),
 			  git_path("MERGE_MSG"));
-	if (write_in_full(fd, merge_msg.buf, merge_msg.len) != merge_msg.len)
+	if (write_in_full(fd, msg->buf, msg->len) != msg->len)
 		die_errno(_("Could not write to '%s'"), git_path("MERGE_MSG"));
 	close(fd);
 }
 
-static void read_merge_msg(void)
+static void read_merge_msg(struct strbuf *msg)
 {
-	strbuf_reset(&merge_msg);
-	if (strbuf_read_file(&merge_msg, git_path("MERGE_MSG"), 0) < 0)
+	strbuf_reset(msg);
+	if (strbuf_read_file(msg, git_path("MERGE_MSG"), 0) < 0)
 		die_errno(_("Could not read from '%s'"), git_path("MERGE_MSG"));
 }
 
-static void run_prepare_commit_msg(void)
+static void write_merge_state(void);
+static void abort_commit(const char *err_msg)
 {
-	write_merge_msg();
+	if (err_msg)
+		error("%s", err_msg);
+	fprintf(stderr,
+		_("Not committing merge; use 'git commit' to complete the merge.\n"));
+	write_merge_state();
+	exit(1);
+}
+
+static void prepare_to_commit(void)
+{
+	struct strbuf msg = STRBUF_INIT;
+	strbuf_addbuf(&msg, &merge_msg);
+	strbuf_addch(&msg, '\n');
+	write_merge_msg(&msg);
 	run_hook(get_index_file(), "prepare-commit-msg",
 		 git_path("MERGE_MSG"), "merge", NULL, NULL);
-	read_merge_msg();
+	if (option_edit) {
+		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
+			abort_commit(NULL);
+	}
+	read_merge_msg(&msg);
+	stripspace(&msg, option_edit);
+	if (!msg.len)
+		abort_commit(_("Empty commit message."));
+	strbuf_release(&merge_msg);
+	strbuf_addbuf(&merge_msg, &msg);
+	strbuf_release(&msg);
 }
 
 static int merge_trivial(void)
@@ -879,7 +905,7 @@ static int merge_trivial(void)
 	parent->next = xmalloc(sizeof(*parent->next));
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
-	run_prepare_commit_msg();
+	prepare_to_commit();
 	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
 	finish(result_commit, "In-index merge");
 	drop_save();
@@ -907,9 +933,9 @@ static int finish_automerge(struct commit_list *common,
 		for (j = remoteheads; j; j = j->next)
 			pptr = &commit_list_insert(j->item, pptr)->next;
 	}
-	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
-	run_prepare_commit_msg();
+	prepare_to_commit();
+	free_commit_list(remoteheads);
 	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL);
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(result_commit, buf.buf);
@@ -1015,6 +1041,36 @@ static int setup_with_upstream(const char ***argv)
 	return i;
 }
 
+static void write_merge_state(void)
+{
+	int fd;
+	struct commit_list *j;
+	struct strbuf buf = STRBUF_INIT;
+
+	for (j = remoteheads; j; j = j->next)
+		strbuf_addf(&buf, "%s\n",
+			sha1_to_hex(j->item->object.sha1));
+	fd = open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die_errno(_("Could not open '%s' for writing"),
+			  git_path("MERGE_HEAD"));
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+		die_errno(_("Could not write to '%s'"), git_path("MERGE_HEAD"));
+	close(fd);
+	strbuf_addch(&merge_msg, '\n');
+	write_merge_msg(&merge_msg);
+	fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0)
+		die_errno(_("Could not open '%s' for writing"),
+			  git_path("MERGE_MODE"));
+	strbuf_reset(&buf);
+	if (!allow_fast_forward)
+		strbuf_addf(&buf, "no-ff");
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+		die_errno(_("Could not write to '%s'"), git_path("MERGE_MODE"));
+	close(fd);
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1418,33 +1474,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (squash)
 		finish(NULL, NULL);
-	else {
-		int fd;
-		struct commit_list *j;
-
-		for (j = remoteheads; j; j = j->next)
-			strbuf_addf(&buf, "%s\n",
-				sha1_to_hex(j->item->object.sha1));
-		fd = open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
-		if (fd < 0)
-			die_errno(_("Could not open '%s' for writing"),
-				  git_path("MERGE_HEAD"));
-		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-			die_errno(_("Could not write to '%s'"), git_path("MERGE_HEAD"));
-		close(fd);
-		strbuf_addch(&merge_msg, '\n');
-		write_merge_msg();
-		fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 0666);
-		if (fd < 0)
-			die_errno(_("Could not open '%s' for writing"),
-				  git_path("MERGE_MODE"));
-		strbuf_reset(&buf);
-		if (!allow_fast_forward)
-			strbuf_addf(&buf, "no-ff");
-		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-			die_errno(_("Could not write to '%s'"), git_path("MERGE_MODE"));
-		close(fd);
-	}
+	else
+		write_merge_state();
 
 	if (merge_was_ok) {
 		fprintf(stderr, _("Automatic merge went well; "
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 87aac835a1..8c6b811718 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -643,4 +643,19 @@ test_expect_success 'amending no-ff merge commit' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+cat >editor <<\EOF
+#!/bin/sh
+# strip comments and blank lines from end of message
+sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > expected
+EOF
+chmod 755 editor
+
+test_expect_success 'merge --no-ff --edit' '
+	git reset --hard c0 &&
+	EDITOR=./editor git merge --no-ff --edit c1 &&
+	verify_parents $c0 $c1 &&
+	git cat-file commit HEAD | sed "1,/^$/d" > actual &&
+	test_cmp actual expected
+'
+
 test_done
-- 
1.7.7.147.g4f6dc9
