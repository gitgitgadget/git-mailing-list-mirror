Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57111F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 10:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfDVKGT (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 06:06:19 -0400
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:41520 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDVKGT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 06:06:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 56088A0042;
        Mon, 22 Apr 2019 12:06:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UgVpPtPQ0PXu; Mon, 22 Apr 2019 12:06:12 +0200 (CEST)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id CF04BA0027;
        Mon, 22 Apr 2019 12:06:12 +0200 (CEST)
Received: from Corentin-Linux.lan (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Mon, 22 Apr 2019 12:06:11 +0200
From:   Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
To:     <gitster@pobox.com>
CC:     <Matthieu.Moy@grenoble-inp.fr>, <eda@waniasset.com>,
        <git@vger.kernel.org>,
        Corentin Bompard <corentin.bompard@etu.univ-lyon1.fr>,
        Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>,
        Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>,
        Matthieu MOY <matthieu.moy@univ-lyon1.fr>
Subject: [PATCH] allow commentChars in commit messages
Date:   Mon, 22 Apr 2019 12:05:39 +0200
Message-ID: <20190422100539.2446-1-corentin.bompard@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.21.0-rc0
In-Reply-To: <xmqqtwsodsw0.fsf@gitster.dls.corp.google.com>
References: <xmqqtwsodsw0.fsf@gitster.dls.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: JPMBX2013-02.univ-lyon1.fr (134.214.201.246) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Corentin Bompard <corentin.bompard@etu.univ-lyon1.fr>

Add new argument which permits stripspace to escape backslashes
in order to have commit messages which begins with commentChars
and backslashes.

Add new function strbuf_addbackslash which adds a backslash before
commentChars and other backslashes used by git commit --amend
which prevents escaping the commit message lines which starts with
a commentChar.

Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
Signed-off-by: Matthieu MOY <matthieu.moy@univ-lyon1.fr>
---
 
 builtin/am.c                       |  2 +-
 builtin/branch.c                   |  2 +-
 builtin/commit.c                   |  8 ++-
 builtin/merge.c                    |  2 +-
 builtin/notes.c                    |  6 +-
 builtin/stripspace.c               |  2 +-
 builtin/tag.c                      |  2 +-
 rebase-interactive.c               |  2 +-
 sequencer.c                        |  6 +-
 strbuf.c                           | 64 +++++++++++++++++++-
 strbuf.h                           |  8 ++-
 t/t7526-commit-message-comments.sh | 93 ++++++++++++++++++++++++++++++
 12 files changed, 180 insertions(+), 17 deletions(-)
 create mode 100755 t/t7526-commit-message-comments.sh

diff --git a/builtin/am.c b/builtin/am.c
index 58a2aef28..58817ab90 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1212,7 +1212,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	strbuf_addstr(&msg, "\n\n");
 	strbuf_addbuf(&msg, &mi.log_message);
-	strbuf_stripspace(&msg, 0);
+	strbuf_stripspace(&msg, 0, 0);
 
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
diff --git a/builtin/branch.c b/builtin/branch.c
index 1be727209..0bfb17fc3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -568,7 +568,7 @@ static int edit_branch_description(const char *branch_name)
 		strbuf_release(&buf);
 		return -1;
 	}
-	strbuf_stripspace(&buf, 1);
+	strbuf_stripspace(&buf, 1, 0);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	git_config_set(name.buf, buf.len ? buf.buf : NULL);
diff --git a/builtin/commit.c b/builtin/commit.c
index 2986553d5..49075a7ac 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -710,8 +710,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	} else if (use_message) {
 		char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
-		if (buffer)
+		if (buffer) {
 			strbuf_addstr(&sb, skip_blank_lines(buffer + 2));
+			strbuf_addbackslash(&sb);
+		}
 		hook_arg1 = "commit";
 		hook_arg2 = use_message;
 	} else if (fixup_message) {
@@ -786,7 +788,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	s->hints = 0;
 
 	if (clean_message_contents)
-		strbuf_stripspace(&sb, 0);
+		strbuf_stripspace(&sb, 0, 0);
 
 	if (signoff)
 		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
@@ -1621,7 +1623,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
 		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
 	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL, 1);
 
 	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
diff --git a/builtin/merge.c b/builtin/merge.c
index e47d77bae..d0c3cb033 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -829,7 +829,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		abort_commit(remoteheads, NULL);
 
 	read_merge_msg(&msg);
-	strbuf_stripspace(&msg, 0 < option_edit);
+	strbuf_stripspace(&msg, 0 < option_edit, 0);
 	if (!msg.len)
 		abort_commit(remoteheads, _("Empty commit message."));
 	strbuf_release(&merge_msg);
diff --git a/builtin/notes.c b/builtin/notes.c
index 02e97f55c..fd304ed9c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -196,7 +196,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 		if (launch_editor(d->edit_path, &d->buf, NULL)) {
 			die(_("please supply the note contents using either -m or -F option"));
 		}
-		strbuf_stripspace(&d->buf, 1);
+		strbuf_stripspace(&d->buf, 1, 0);
 	}
 }
 
@@ -221,7 +221,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 	strbuf_addstr(&d->buf, arg);
-	strbuf_stripspace(&d->buf, 0);
+	strbuf_stripspace(&d->buf, 0, 0);
 
 	d->given = 1;
 	return 0;
@@ -240,7 +240,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 			die_errno(_("cannot read '%s'"), arg);
 	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
 		die_errno(_("could not open or read '%s'"), arg);
-	strbuf_stripspace(&d->buf, 0);
+	strbuf_stripspace(&d->buf, 0, 0);
 
 	d->given = 1;
 	return 0;
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index be33eb83c..c5d449b5e 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -55,7 +55,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		die_errno("could not read the input");
 
 	if (mode == STRIP_DEFAULT || mode == STRIP_COMMENTS)
-		strbuf_stripspace(&buf, mode == STRIP_COMMENTS);
+		strbuf_stripspace(&buf, mode == STRIP_COMMENTS, 0);
 	else
 		comment_lines(&buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd127..cb9422c17 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -261,7 +261,7 @@ static void create_tag(const struct object_id *object, const char *tag,
 	}
 
 	if (opt->cleanup_mode != CLEANUP_NONE)
-		strbuf_stripspace(buf, opt->cleanup_mode == CLEANUP_ALL);
+		strbuf_stripspace(buf, opt->cleanup_mode == CLEANUP_ALL, 0);
 
 	if (!opt->message_given && !buf->len)
 		die(_("no tag message?"));
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 68aff1dac..6e6e45c45 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -61,7 +61,7 @@ int edit_todo_list(struct repository *r, unsigned flags)
 	if (strbuf_read_file(&buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	strbuf_stripspace(&buf, 1);
+	strbuf_stripspace(&buf, 1, 0);
 	if (write_message(buf.buf, buf.len, todo_file, 0)) {
 		strbuf_release(&buf);
 		return -1;
diff --git a/sequencer.c b/sequencer.c
index 0db410d59..231682632 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1041,7 +1041,7 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
 		return 0;
 
-	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL, 0);
 	if (!skip_prefix(sb->buf, tmpl.buf, &start))
 		start = sb->buf;
 	strbuf_release(&tmpl);
@@ -1386,7 +1386,7 @@ static int try_to_commit(struct repository *r,
 					  opts->default_msg_cleanup;
 
 	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
+		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL, 0);
 	if ((flags & EDIT_MSG) && message_is_empty(msg, cleanup)) {
 		res = 1; /* run 'git commit' to display error message */
 		goto out;
@@ -4941,7 +4941,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
-	strbuf_stripspace(buf, 1);
+	strbuf_stripspace(buf, 1, 0);
 	if (buf->len == 0) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
diff --git a/strbuf.c b/strbuf.c
index f6a6cf78b..148ba2815 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -966,8 +966,12 @@ static size_t cleanup(char *line, size_t len)
  *
  * Enable skip_comments to skip every line starting with comment
  * character.
+ *
+ * Enable escape_backslash to remove backslash in beginning of
+ * lines.
  */
-void strbuf_stripspace(struct strbuf *sb, int skip_comments)
+void strbuf_stripspace(struct strbuf *sb, int skip_comments,
+		int escape_backslash)
 {
 	size_t empties = 0;
 	size_t i, j, len, newlen;
@@ -999,8 +1003,66 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 	}
 
 	strbuf_setlen(sb, j);
+
+	if (escape_backslash) {
+		strbuf_escape_backslash(sb);
+	}
+}
+
+/*
+ * Add a backslash in front of commentChar and other backslash.
+ */
+void strbuf_addbackslash(struct strbuf *sb)
+{
+	size_t i, len = 0, total = 0;
+	char *eol;
+
+	for (i = 0; i < sb->len; i += len) {
+		eol = memchr(sb->buf + i, '\n', sb->len -i);
+		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
+
+		if (len > 0 && sb->buf[i] == comment_line_char) {
+			memmove(sb->buf + i + 1, sb->buf + i, sb->len - i);
+			sb->buf[i] = '\\';
+			total += (len + 1);
+		} else if (len > 0 && sb->buf[i] == '\\') {
+			memmove(sb->buf + i + 1, sb->buf + i, sb->len - i);
+			sb->buf[i] = '\\';
+			total += len;
+		} else {
+			total += len;
+		}
+	}
+	strbuf_grow(sb, total-len);
+	strbuf_setlen(sb, total);
 }
 
+/*
+ * Escape backslash in beginning of lines.
+ */
+void strbuf_escape_backslash(struct strbuf *sb)
+{
+	size_t i, len, total = sb->len;
+	char *eol;
+
+	for (i = 0; i < sb->len; i += len) {
+		eol = memchr(sb->buf + i, '\n', sb->len - i);
+		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
+
+		if (sb->buf[i] == '\\') {
+			memmove(sb->buf + i, sb->buf + i + 1, total - 1 - i);
+			total --;
+			len --;
+			i++;
+		}
+		/* Avoid initite loop if len=0 */
+		if (len <= 0) len = 1;
+	}
+	strbuf_setlen(sb, sb->len - (sb->len - total));
+}
+
+
+
 int strbuf_normalize_path(struct strbuf *src)
 {
 	struct strbuf dst = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index fc40873b6..6ee958498 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -499,8 +499,14 @@ int strbuf_normalize_path(struct strbuf *sb);
 /**
  * Strip whitespace from a buffer. The second parameter controls if
  * comments are considered contents to be removed or not.
+ * The third parameter controls if backslashes are escaped.
  */
-void strbuf_stripspace(struct strbuf *buf, int skip_comments);
+void strbuf_stripspace(struct strbuf *buf, int skip_comments,
+		int escape_backslash);
+
+void strbuf_escape_backslash(struct strbuf *sb);
+
+void strbuf_addbackslash(struct strbuf *sb);
 
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
diff --git a/t/t7526-commit-message-comments.sh b/t/t7526-commit-message-comments.sh
new file mode 100755
index 000000000..e4b04eb7a
--- /dev/null
+++ b/t/t7526-commit-message-comments.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+
+test_description='"git commit" allows # in the start of a line in commit message.
+
+'
+. ./test-lib.sh
+
+
+# set up fake editor for interactive editing
+cat >fake-editor <<'EOF'
+#!/bin/sh
+cp FAKE_MSG "$1"
+exit 0
+EOF
+chmod +x fake-editor
+
+FAKE_EDITOR="$(pwd)/fake-editor"
+export FAKE_EDITOR
+
+commit_msg_is () {
+	test "$(git log --pretty=format:%s%b -1)" = "$1"
+}
+
+ensure_fresh_upstream () {
+	rm -rf parent && git init --bare parent
+}
+
+test_expect_success 'setup bare parent' '
+	ensure_fresh_upstream &&
+	git remote add upstream parent
+'
+
+test_expect_success 'git commit "\#text" keeps "#text" as a commit message' '
+	echo test1 >file &&
+	git add file &&
+	printf "%s\n" "\\#text" >FAKE_MSG &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit &&
+	commit_msg_is "#text"
+'
+
+test_expect_success 'git commit "\text" keeps "text" as a commit message' '
+	echo test2 >file &&
+	git add file &&
+	printf "%s\n" "\\text" >FAKE_MSG &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit &&
+	commit_msg_is "text"
+'
+
+test_expect_success 'git commit "\\text" keeps "\text" as a commit message' '
+	echo test5 >file &&
+	git add file &&
+	printf "%s\n" "\\\\text" >FAKE_MSG &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit &&
+	commit_msg_is "\\text"
+'
+
+test_expect_success 'git commit -m "\#text" keeps "#text" as a commit message' '
+	echo test1 >file &&
+	git add file &&
+	git commit -m "\\#text" &&
+	commit_msg_is "#text"
+'
+
+test_expect_success 'git commit -m "\text" keeps "text" as a commit message' '
+	echo test2 >file &&
+	git add file &&
+	git commit -m "\\text" &&
+	commit_msg_is "text"
+'
+
+test_expect_success 'git commit -m "\\text" keeps "\text" as a commit message' '
+	echo test3 >file &&
+	git add file &&
+	git commit -m "\\\\text" &&
+	commit_msg_is "\\text"
+'
+
+test_expect_success 'git commit --amend add backslash in front of comment
+and other backslash' '
+	echo "\\#Include something" > msg &&
+	echo "" >> msg &&
+	echo "Some content" >> msg &&
+	echo "\\\\\\Backslash example" >> msg &&
+	echo "test amend" > file &&
+	git add file &&
+	git commit -F msg &&
+	cat .git/COMMIT_EDITMSG > expect &&
+	git commit --amend &&
+	sed "/^#/d" .git/COMMIT_EDITMSG > actual &&
+	sed -i -e "$ d" actual &&
+	test_cmp expect actual
+'
+test_done
-- 
2.21.0-rc0

