From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] Allow custom "comment char"
Date: Tue, 15 Jan 2013 19:50:27 +0100
Message-ID: <1358275827-5244-1-git-send-email-ralf.thielow@gmail.com>
References: <7vk3rk25iw.fsf_-_@alter.siamese.dyndns.org>
Cc: jrnieder@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 15 19:51:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvBbG-0001NJ-E4
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 19:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374Ab3AOSuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 13:50:44 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49574 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab3AOSun (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 13:50:43 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so280281bkw.19
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uvJHmnzhFszqt2etdjaNY4q+DnGIh26/4XL6DdXLbHU=;
        b=0CZEDSxA3lUUS033EwknV/Qx/e4viW4HfvhhmzZHViFQq8OHgdOSfw6ncP1aBgt+YP
         0cmB1CUzq5cBcZcE71ebPEt1vMSrlL7nR31kzdlUtpuAcQ0x/hvrHNf2S1/+LK+Actz+
         KfjumK5Vyw9JeGVy5iMMdU65BXRxBNJCSwMEbVgF4EvhxphS7XQCGk/Wlg+SwEEr0nD/
         N4mVtbc+RnnNM6p1eycKBFusGw5cpqBLhkm+/v0qDj5QFjXcknt6pD/2Pu4S9sYEvoCt
         /4cSv+pmOfJCKt5GiFgfnh7y/+7hRa5ZfxfXQfySsZYFbhr8S3/Do8hO4vRXj8ebQnvg
         wzug==
X-Received: by 10.204.151.21 with SMTP id a21mr41751594bkw.124.1358275841913;
        Tue, 15 Jan 2013 10:50:41 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id e22sm13722092bke.14.2013.01.15.10.50.40
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 10:50:41 -0800 (PST)
X-Mailer: git-send-email 1.8.1.291.g185e8f6
In-Reply-To: <7vk3rk25iw.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213658>

From: Junio C Hamano <gitster@pobox.com>

Some users do want to write a line that begin with a pound sign, #,
in their commit log message.  Many tracking system recognise
a token of #<bugid> form, for example.

The support we offer these use cases is not very friendly to the end
users.  They have a choice between

 - Don't do it.  Avoid such a line by rewrapping or indenting; and

 - Use --cleanup=whitespace but remove all the hint lines we add.

Give them a way to set a custom comment char, e.g.

    $ git -c core.commentchar="%" commit

so that they do not have to do either of the two workarounds.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 Documentation/config.txt               |  6 ++++
 Documentation/technical/api-strbuf.txt | 10 +++++++
 builtin/branch.c                       | 10 +++----
 builtin/commit.c                       | 12 ++++----
 builtin/fmt-merge-msg.c                |  2 +-
 builtin/merge.c                        |  5 ++--
 builtin/notes.c                        | 34 ++++++++++-------------
 builtin/stripspace.c                   |  2 +-
 builtin/tag.c                          | 35 ++++++++++++------------
 cache.h                                |  6 ++++
 config.c                               |  8 ++++++
 environment.c                          |  6 ++++
 git-submodule.sh                       | 14 +++++++---
 strbuf.c                               | 38 ++++++++++++++++++++++++++
 strbuf.h                               |  4 +++
 t/t7502-commit.sh                      |  7 +++++
 t/t7508-status.sh                      | 50 ++++++++++++++++++++++++++++++++++
 wt-status.c                            | 10 ++++---
 18 files changed, 198 insertions(+), 61 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5809e0..e99b9f2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -528,6 +528,12 @@ core.editor::
 	variable when it is set, and the environment variable
 	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
 
+core.commentchar::
+	Commands such as `commit` and `tag` that lets you edit
+	messages consider a line that begins with this character
+	commented, and removes them after the editor returns
+	(default '#').
+
 sequence.editor::
 	Text editor used by `git rebase -i` for editing the rebase insn file.
 	The value is meant to be interpreted by the shell when it is used.
diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 84686b5..6767102 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -156,6 +156,11 @@ then they will free() it.
 	Remove the bytes between `pos..pos+len` and replace it with the given
 	data.
 
+`strbuf_commented_addstr`::
+
+	Add a NUL-terminated string prepended by a comment character and a blank
+	to the buffer.
+
 `strbuf_add`::
 
 	Add data of given length to the buffer.
@@ -229,6 +234,11 @@ which can be used by the programmer of the callback as she sees fit.
 
 	Add a formatted string to the buffer.
 
+`strbuf_commented_addf`::
+
+	Add a formatted string prepended by a comment character and a
+	blank to the buffer.
+
 `strbuf_fread`::
 
 	Read a given size of data from a FILE* pointer to the buffer.
diff --git a/builtin/branch.c b/builtin/branch.c
index 873f624..3548271 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -706,11 +706,11 @@ static int edit_branch_description(const char *branch_name)
 	read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
-	strbuf_addf(&buf,
-		    "# Please edit the description for the branch\n"
-		    "#   %s\n"
-		    "# Lines starting with '#' will be stripped.\n",
-		    branch_name);
+	strbuf_commented_addf(&buf,
+		    "Please edit the description for the branch\n"
+		    "  %s\n"
+		    "Lines starting with '%c' will be stripped.\n",
+		    branch_name, comment_line_char);
 	fp = fopen(git_path(edit_description), "w");
 	if ((fwrite(buf.buf, 1, buf.len, fp) < buf.len) || fclose(fp)) {
 		strbuf_release(&buf);
diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..f95f64a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -733,15 +733,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (cleanup_mode == CLEANUP_ALL)
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
-				" Lines starting\nwith '#' will be ignored, and an empty"
-				" message aborts the commit.\n"));
+				  " Lines starting\nwith '%c' will be ignored, and an empty"
+				  " message aborts the commit.\n"), comment_line_char);
 		else /* CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
-				" Lines starting\n"
-				"with '#' will be kept; you may remove them"
-				" yourself if you want to.\n"
-				"An empty message aborts the commit.\n"));
+				  " Lines starting\n"
+				  "with '%c' will be kept; you may remove them"
+				  " yourself if you want to.\n"
+				  "An empty message aborts the commit.\n"), comment_line_char);
 		if (only_include_assumed)
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					"%s", only_include_assumed);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index d9af43c..d0fcd34 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -470,7 +470,7 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	strbuf_complete_line(tagbuf);
 	if (sig->len) {
 		strbuf_addch(tagbuf, '\n');
-		strbuf_add_lines(tagbuf, "# ", sig->buf, sig->len);
+		strbuf_commented_addstr(tagbuf, sig->buf);
 	}
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 9307e9c..7c8922c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -788,17 +788,16 @@ static const char merge_editor_comment[] =
 N_("Please enter a commit message to explain why this merge is necessary,\n"
    "especially if it merges an updated upstream into a topic branch.\n"
    "\n"
-   "Lines starting with '#' will be ignored, and an empty message aborts\n"
+   "Lines starting with '%c' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
-	const char *comment = _(merge_editor_comment);
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
 	if (0 < option_edit)
-		strbuf_add_lines(&msg, "# ", comment, strlen(comment));
+		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	write_merge_msg(&msg);
 	if (run_hook(get_index_file(), "prepare-commit-msg",
 		     git_path("MERGE_MSG"), "merge", NULL, NULL))
diff --git a/builtin/notes.c b/builtin/notes.c
index 453457a..5e84e35 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -92,10 +92,7 @@ static const char * const git_notes_get_ref_usage[] = {
 };
 
 static const char note_template[] =
-	"\n"
-	"#\n"
-	"# Write/edit the notes for the following object:\n"
-	"#\n";
+	"Write/edit the notes for the following object:";
 
 struct msg_arg {
 	int given;
@@ -129,7 +126,7 @@ static void write_commented_object(int fd, const unsigned char *object)
 		{"show", "--stat", "--no-notes", sha1_to_hex(object), NULL};
 	struct child_process show;
 	struct strbuf buf = STRBUF_INIT;
-	FILE *show_out;
+	struct strbuf cbuf = STRBUF_INIT;
 
 	/* Invoke "git show --stat --no-notes $object" */
 	memset(&show, 0, sizeof(show));
@@ -142,21 +139,14 @@ static void write_commented_object(int fd, const unsigned char *object)
 		die(_("unable to start 'show' for object '%s'"),
 		    sha1_to_hex(object));
 
-	/* Open the output as FILE* so strbuf_getline() can be used. */
-	show_out = xfdopen(show.out, "r");
-	if (show_out == NULL)
-		die_errno(_("can't fdopen 'show' output fd"));
+	if (strbuf_read(&buf, show.out, 0) < 0)
+		die_errno(_("could not read 'show' output"));
+	strbuf_commented_addstr(&cbuf, buf.buf);
+	write_or_die(fd, cbuf.buf, cbuf.len);
 
-	/* Prepend "# " to each output line and write result to 'fd' */
-	while (strbuf_getline(&buf, show_out, '\n') != EOF) {
-		write_or_die(fd, "# ", 2);
-		write_or_die(fd, buf.buf, buf.len);
-		write_or_die(fd, "\n", 1);
-	}
+	strbuf_release(&cbuf);
 	strbuf_release(&buf);
-	if (fclose(show_out))
-		die_errno(_("failed to close pipe to 'show' for object '%s'"),
-			  sha1_to_hex(object));
+
 	if (finish_command(&show))
 		die(_("failed to finish 'show' for object '%s'"),
 		    sha1_to_hex(object));
@@ -170,6 +160,7 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 
 	if (msg->use_editor || !msg->given) {
 		int fd;
+		struct strbuf buf = STRBUF_INIT;
 
 		/* write the template message before editing: */
 		path = git_pathdup("NOTES_EDITMSG");
@@ -181,11 +172,16 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 			write_or_die(fd, msg->buf.buf, msg->buf.len);
 		else if (prev && !append_only)
 			write_note_data(fd, prev);
-		write_or_die(fd, note_template, strlen(note_template));
+
+		strbuf_addf(&buf, "\n%c\n", comment_line_char);
+		strbuf_commented_addstr(&buf, note_template);
+		strbuf_addf(&buf, "\n%c\n", comment_line_char);
+		write_or_die(fd, buf.buf, buf.len);
 
 		write_commented_object(fd, object);
 
 		close(fd);
+		strbuf_release(&buf);
 		strbuf_reset(&(msg->buf));
 
 		if (launch_editor(path, &(msg->buf), NULL)) {
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index f16986c..600ca66 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -45,7 +45,7 @@ void stripspace(struct strbuf *sb, int skip_comments)
 		eol = memchr(sb->buf + i, '\n', sb->len - i);
 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
 
-		if (skip_comments && len && sb->buf[i] == '#') {
+		if (skip_comments && len && sb->buf[i] == comment_line_char) {
 			newlen = 0;
 			continue;
 		}
diff --git a/builtin/tag.c b/builtin/tag.c
index 9c3e067..e1b72be 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -246,19 +246,13 @@ static int do_sign(struct strbuf *buffer)
 }
 
 static const char tag_template[] =
-	N_("\n"
-	"#\n"
-	"# Write a tag message\n"
-	"# Lines starting with '#' will be ignored.\n"
-	"#\n");
+	N_("Write a tag message\n"
+	"Lines starting with '%c' will be ignored.");
 
 static const char tag_template_nocleanup[] =
-	N_("\n"
-	"#\n"
-	"# Write a tag message\n"
-	"# Lines starting with '#' will be kept; you may remove them"
-	" yourself if you want to.\n"
-	"#\n");
+	N_("Write a tag message\n"
+	"Lines starting with '%c' will be kept; you may remove them"
+	" yourself if you want to.");
 
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
@@ -346,14 +340,19 @@ static void create_tag(const unsigned char *object, const char *tag,
 		if (fd < 0)
 			die_errno(_("could not create file '%s'"), path);
 
-		if (!is_null_sha1(prev))
+		if (!is_null_sha1(prev)) {
 			write_tag_body(fd, prev);
-		else if (opt->cleanup_mode == CLEANUP_ALL)
-			write_or_die(fd, _(tag_template),
-					strlen(_(tag_template)));
-		else
-			write_or_die(fd, _(tag_template_nocleanup),
-					strlen(_(tag_template_nocleanup)));
+		} else {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "\n%c\n", comment_line_char);
+			if (opt->cleanup_mode == CLEANUP_ALL)
+				strbuf_commented_addf(&buf, _(tag_template), comment_line_char);
+			else
+				strbuf_commented_addf(&buf, _(tag_template_nocleanup), comment_line_char);
+			strbuf_addf(&buf, "\n%c\n", comment_line_char);
+			write_or_die(fd, buf.buf, buf.len);
+			strbuf_release(&buf);
+		}
 		close(fd);
 
 		if (launch_editor(path, buf, NULL)) {
diff --git a/cache.h b/cache.h
index c257953..0b435a4 100644
--- a/cache.h
+++ b/cache.h
@@ -562,6 +562,12 @@ extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 
+/*
+ * The character that begins a commented line in user-editable file
+ * that is subject to stripspace.
+ */
+extern char comment_line_char;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/config.c b/config.c
index 7b444b6..d873c59 100644
--- a/config.c
+++ b/config.c
@@ -717,6 +717,14 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
+	if (!strcmp(var, "core.commentchar")) {
+		const char *comment;
+		int ret = git_config_string(&comment, var, value);
+		if (!ret)
+			comment_line_char = comment[0];
+		return ret;
+	}
+
 	if (!strcmp(var, "core.askpass"))
 		return git_config_string(&askpass_program, var, value);
 
diff --git a/environment.c b/environment.c
index 85edd7f..a40c38b 100644
--- a/environment.c
+++ b/environment.c
@@ -62,6 +62,12 @@ int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
 
+/*
+ * The character that begins a commented line in user-editable file
+ * that is subject to stripspace.
+ */
+char comment_line_char = '#';
+
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 22ec5b6..1b8d95f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -975,13 +975,19 @@ cmd_summary() {
 		echo
 	done |
 	if test -n "$for_status"; then
+		comment_char=`git config core.commentchar`
+		if [ ! -n "$comment_char" ]; then
+			comment_char='#'
+		elif [ ${#comment_char} -gt 1 ]; then
+			comment_char=`expr substr $comment_char 1 1`
+		fi
 		if [ -n "$files" ]; then
-			gettextln "# Submodules changed but not updated:"
+			eval_gettextln "\$comment_char Submodules changed but not updated:"
 		else
-			gettextln "# Submodule changes to be committed:"
+			eval_gettextln "\$comment_char Submodule changes to be committed:"
 		fi
-		echo "#"
-		sed -e 's|^|# |' -e 's|^# $|#|'
+		echo "$comment_char"
+		sed -e "s|^|$comment_char |" -e "s|^$comment_char $|$comment_char|"
 	else
 		cat
 	fi
diff --git a/strbuf.c b/strbuf.c
index 9a373be..8af4b4f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -204,6 +204,44 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	va_end(ap);
 }
 
+void strbuf_commented_addstr(struct strbuf *sb, const char *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf prefix = STRBUF_INIT;
+
+	strbuf_addf(&prefix, "%c ", comment_line_char);
+	strbuf_addstr(&buf, s);
+	strbuf_add_lines(sb, prefix.buf, buf.buf, buf.len);
+
+	// remove additional '\n' added by strbuf_add_lines()
+	if (sb->len && sb->buf[sb->len - 1] != buf.buf[buf.len - 1])
+		strbuf_remove(sb, sb->len - 1, 1);
+
+	strbuf_release(&prefix);
+	strbuf_release(&buf);
+}
+
+void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list params;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf prefix = STRBUF_INIT;
+
+	va_start(params, fmt);
+	strbuf_vaddf(&buf, fmt, params);
+	va_end(params);
+
+	strbuf_addf(&prefix, "%c ", comment_line_char);
+	strbuf_add_lines(sb, prefix.buf, buf.buf, buf.len);
+
+	// remove additional '\n' added by strbuf_add_lines()
+	if (sb->len && sb->buf[sb->len - 1] != buf.buf[buf.len - 1])
+		strbuf_remove(sb, sb->len - 1, 1);
+
+	strbuf_release(&prefix);
+	strbuf_release(&buf);
+}
+
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 {
 	int len;
diff --git a/strbuf.h b/strbuf.h
index ecae4e2..8d5afd5 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -110,6 +110,8 @@ extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
 extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
                           const void *, size_t);
 
+extern void strbuf_commented_addstr(struct strbuf *sb, const char *s);
+
 extern void strbuf_add(struct strbuf *, const void *, size_t);
 static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
 	strbuf_add(sb, s, strlen(s));
@@ -131,6 +133,8 @@ extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format (printf, 2, 3)))
+extern void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
 __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 1a5cb69..6a2c67c 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -447,4 +447,11 @@ use_template="-t template"
 
 try_commit_status_combo
 
+test_expect_success 'commit --status with custom comment character' '
+	test_when_finished "git config --unset core.commentchar" &&
+	git config core.commentchar ";" &&
+	try_commit --status &&
+	test_i18ngrep "^; Changes to be committed:" .git/COMMIT_EDITMSG
+'
+
 test_done
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e313ef1..a79c032 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1254,6 +1254,56 @@ test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary
 '
 
 cat > expect << EOF
+; On branch master
+; Changes to be committed:
+;   (use "git reset HEAD <file>..." to unstage)
+;
+;	modified:   sm
+;
+; Changes not staged for commit:
+;   (use "git add <file>..." to update what will be committed)
+;   (use "git checkout -- <file>..." to discard changes in working directory)
+;
+;	modified:   dir1/modified
+;	modified:   sm (new commits)
+;
+; Submodule changes to be committed:
+;
+; * sm $head...$new_head (1):
+;   > Add bar
+;
+; Submodules changed but not updated:
+;
+; * sm $new_head...$head2 (1):
+;   > 2nd commit
+;
+; Untracked files:
+;   (use "git add <file>..." to include in what will be committed)
+;
+;	.gitmodules
+;	dir1/untracked
+;	dir2/modified
+;	dir2/untracked
+;	expect
+;	output
+;	untracked
+EOF
+
+test_expect_success "status (core.commentchar with submodule summary)" '
+	test_when_finished "git config --unset core.commentchar" &&
+	git config core.commentchar ";" &&
+	git status >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success "status (core.commentchar with two chars with submodule summary)" '
+	test_when_finished "git config --unset core.commentchar" &&
+	git config core.commentchar ";;" &&
+	git status >output &&
+	test_i18ncmp expect output
+'
+
+cat > expect << EOF
 # On branch master
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..f6f197e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -45,7 +45,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
 	strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
-		strbuf_addch(&sb, '#');
+		strbuf_addch(&sb, comment_line_char);
 		if (!trail)
 			strbuf_addch(&sb, ' ');
 		color_print_strbuf(s->fp, color, &sb);
@@ -59,7 +59,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
 		strbuf_reset(&linebuf);
 		if (at_bol) {
-			strbuf_addch(&linebuf, '#');
+			strbuf_addch(&linebuf, comment_line_char);
 			if (*line != '\n' && *line != '\t')
 				strbuf_addch(&linebuf, ' ');
 		}
@@ -760,8 +760,10 @@ static void wt_status_print_tracking(struct wt_status *s)
 
 	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s),
-				 "# %.*s", (int)(ep - cp), cp);
-	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
+				 "%c %.*s", comment_line_char,
+				 (int)(ep - cp), cp);
+	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
+			 comment_line_char);
 }
 
 static int has_unmerged(struct wt_status *s)
-- 
1.8.1.291.g185e8f6
