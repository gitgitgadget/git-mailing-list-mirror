From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 07/31] am: extract patch, message and authorship with git-mailinfo
Date: Thu, 18 Jun 2015 19:25:19 +0800
Message-ID: <1434626743-8552-8-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xy2-0004ot-BU
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbbFRL0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:40 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35113 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbbFRL0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:31 -0400
Received: by pdbci14 with SMTP id ci14so6227918pdb.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kS4CFLOWPY3Iu6J4z4XKoAPJdETBme+xNZLOM//bmFA=;
        b=VSiXVSZN26qsj0/SJpd3WyZ1is+4qfuIwPWY3fftI0bbl1VB0oZ2Jkv/kjIlm6rWUR
         OEYJwoO99KxQG3OOVUQgwwQA1nEEiX0/wNlHWRy6fSdyVupy1XIKRdEx2D9Y/ur0YuzE
         9Z9OaGge5zFXpz/x3dSDhB2YblBYPIO01WgyfT8zXnjPP5QLe52nhb0FjbUG8cVbvMUb
         78ojx6/RKfvKuRuPvL9t180QgkdVuDaAxVu6Gtbh76Oa+/GRP00FyM9dYIrIYGvRQHG7
         zcHCHbCwF8jGpemhMQgZoejcvChLGpA36P/6xkcpLNqbvHvoJyPiXLphNvxzVFLD2IMo
         YssQ==
X-Received: by 10.68.65.43 with SMTP id u11mr20592292pbs.118.1434626790971;
        Thu, 18 Jun 2015 04:26:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271973>

For the purpose of applying the patch and committing the results,
implement extracting the patch data, commit message and authorship from
an e-mail message using git-mailinfo.

git-mailinfo is run as a separate process, but ideally in the future,
we should be be able to access its functionality directly without
spawning a new process.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
Notes:
    v3
    
    * Style fixes

 builtin/am.c | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7b97ea8..d6434e4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -9,6 +9,23 @@
 #include "parse-options.h"
 #include "dir.h"
 #include "run-command.h"
+#include "quote.h"
+
+/**
+ * Returns 1 if the file is empty or does not exist, 0 otherwise.
+ */
+static int is_empty_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno == ENOENT)
+			return 1;
+		die_errno(_("could not stat %s"), filename);
+	}
+
+	return !st.st_size;
+}
 
 enum patch_format {
 	PATCH_FORMAT_UNKNOWN = 0,
@@ -23,6 +40,12 @@ struct am_state {
 	int cur;
 	int last;
 
+	/* commit message and metadata */
+	struct strbuf author_name;
+	struct strbuf author_email;
+	struct strbuf author_date;
+	struct strbuf msg;
+
 	/* number of digits in patch filename */
 	int prec;
 };
@@ -36,6 +59,11 @@ static void am_state_init(struct am_state *state)
 
 	strbuf_init(&state->dir, 0);
 
+	strbuf_init(&state->author_name, 0);
+	strbuf_init(&state->author_email, 0);
+	strbuf_init(&state->author_date, 0);
+	strbuf_init(&state->msg, 0);
+
 	state->prec = 4;
 }
 
@@ -45,6 +73,10 @@ static void am_state_init(struct am_state *state)
 static void am_state_release(struct am_state *state)
 {
 	strbuf_release(&state->dir);
+	strbuf_release(&state->author_name);
+	strbuf_release(&state->author_email);
+	strbuf_release(&state->author_date);
+	strbuf_release(&state->msg);
 }
 
 /**
@@ -94,6 +126,105 @@ static int read_state_file(struct strbuf *sb, const char *file, size_t hint, int
 }
 
 /**
+ * Reads a KEY=VALUE shell variable assignment from fp, and returns the VALUE
+ * in `value`. VALUE must be a quoted string, and the KEY must match `key`.
+ * Returns 0 on success, -1 on failure.
+ *
+ * This is used by read_author_script() to read the GIT_AUTHOR_* variables from
+ * the author-script.
+ */
+static int read_shell_var(struct strbuf *value, FILE *fp, const char *key)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char *str;
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		return -1;
+
+	if (!skip_prefix(sb.buf, key, (const char **)&str))
+		return -1;
+
+	if (!skip_prefix(str, "=", (const char **)&str))
+		return -1;
+
+	str = sq_dequote(str);
+	if (!str)
+		return -1;
+
+	strbuf_reset(value);
+	strbuf_addstr(value, str);
+
+	strbuf_release(&sb);
+
+	return 0;
+}
+
+/**
+ * Parses the "author script" `filename`, and sets state->author_name,
+ * state->author_email and state->author_date accordingly. We are strict with
+ * our parsing, as the author script is supposed to be eval'd, and loosely
+ * parsing it may not give the results the user expects.
+ *
+ * The author script is of the format:
+ *
+ *	GIT_AUTHOR_NAME='$author_name'
+ *	GIT_AUTHOR_EMAIL='$author_email'
+ *	GIT_AUTHOR_DATE='$author_date'
+ *
+ * where $author_name, $author_email and $author_date are quoted.
+ */
+static int read_author_script(struct am_state *state)
+{
+	const char *filename = am_path(state, "author-script");
+	FILE *fp = fopen(filename, "r");
+	if (!fp) {
+		if (errno == ENOENT)
+			return 0;
+		die_errno(_("could not open '%s' for reading"), filename);
+	}
+
+	if (read_shell_var(&state->author_name, fp, "GIT_AUTHOR_NAME"))
+		return -1;
+
+	if (read_shell_var(&state->author_email, fp, "GIT_AUTHOR_EMAIL"))
+		return -1;
+
+	if (read_shell_var(&state->author_date, fp, "GIT_AUTHOR_DATE"))
+		return -1;
+
+	if (fgetc(fp) != EOF)
+		return -1;
+
+	fclose(fp);
+	return 0;
+}
+
+/**
+ * Saves state->author_name, state->author_email and state->author_date in
+ * `filename` as an "author script", which is the format used by git-am.sh.
+ */
+static void write_author_script(const struct am_state *state)
+{
+	static const char fmt[] = "GIT_AUTHOR_NAME=%s\n"
+		"GIT_AUTHOR_EMAIL=%s\n"
+		"GIT_AUTHOR_DATE=%s\n";
+	struct strbuf author_name = STRBUF_INIT;
+	struct strbuf author_email = STRBUF_INIT;
+	struct strbuf author_date = STRBUF_INIT;
+
+	sq_quote_buf(&author_name, state->author_name.buf);
+	sq_quote_buf(&author_email, state->author_email.buf);
+	sq_quote_buf(&author_date, state->author_date.buf);
+
+	write_file(am_path(state, "author-script"), 1, fmt,
+			author_name.buf, author_email.buf, author_date.buf);
+
+	strbuf_release(&author_name);
+	strbuf_release(&author_email);
+	strbuf_release(&author_date);
+}
+
+/**
  * Loads state from disk.
  */
 static void am_load(struct am_state *state)
@@ -106,6 +237,11 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, am_path(state, "last"), 8, 1);
 	state->last = strtol(sb.buf, NULL, 10);
 
+	if (read_author_script(state) < 0)
+		die(_("could not parse author script"));
+
+	read_state_file(&state->msg, am_path(state, "final-commit"), 0, 0);
+
 	strbuf_release(&sb);
 }
 
@@ -296,6 +432,91 @@ static void am_next(struct am_state *state)
 {
 	state->cur++;
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
+
+	strbuf_reset(&state->author_name);
+	strbuf_reset(&state->author_email);
+	strbuf_reset(&state->author_date);
+	unlink(am_path(state, "author-script"));
+
+	strbuf_reset(&state->msg);
+	unlink(am_path(state, "final-commit"));
+}
+
+/**
+ * Returns the filename of the current patch.
+ */
+static const char *msgnum(const struct am_state *state)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%0*d", state->prec, state->cur);
+
+	return sb.buf;
+}
+
+/**
+ * Parses `patch` using git-mailinfo. state->msg will be set to the patch
+ * message. state->author_name, state->author_email, state->author_date will be
+ * set to the patch author's name, email and date respectively. The patch's
+ * body will be written to "$state_dir/patch", where $state_dir is the state
+ * directory.
+ *
+ * Returns 1 if the patch should be skipped, 0 otherwise.
+ */
+static int parse_patch(struct am_state *state, const char *patch)
+{
+	FILE *fp;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+
+	cp.git_cmd = 1;
+	cp.in = xopen(patch, O_RDONLY, 0);
+	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT, 0777);
+
+	argv_array_push(&cp.args, "mailinfo");
+	argv_array_push(&cp.args, am_path(state, "msg"));
+	argv_array_push(&cp.args, am_path(state, "patch"));
+
+	if (run_command(&cp) < 0)
+		die("could not parse patch");
+
+	close(cp.in);
+	close(cp.out);
+
+	/* Extract message and author information */
+	fp = xfopen(am_path(state, "info"), "r");
+	while (!strbuf_getline(&sb, fp, '\n')) {
+		const char *x;
+
+		if (skip_prefix(sb.buf, "Subject: ", &x)) {
+			if (state->msg.len)
+				strbuf_addch(&state->msg, '\n');
+			strbuf_addstr(&state->msg, x);
+		} else if (skip_prefix(sb.buf, "Author: ", &x))
+			strbuf_addstr(&state->author_name, x);
+		else if (skip_prefix(sb.buf, "Email: ", &x))
+			strbuf_addstr(&state->author_email, x);
+		else if (skip_prefix(sb.buf, "Date: ", &x))
+			strbuf_addstr(&state->author_date, x);
+	}
+	fclose(fp);
+
+	/* Skip pine's internal folder data */
+	if (!strcmp(state->author_name.buf, "Mail System Internal Data"))
+		return 1;
+
+	if (is_empty_file(am_path(state, "patch")))
+		die(_("Patch is empty. Was it split wrong?\n"
+		"If you would prefer to skip this patch, instead run \"git am --skip\".\n"
+		"To restore the original branch and stop patching run \"git am --abort\"."));
+
+	strbuf_addstr(&state->msg, "\n\n");
+	if (strbuf_read_file(&state->msg, am_path(state, "msg"), 0) < 0)
+		die_errno(_("could not read '%s'"), am_path(state, "msg"));
+	stripspace(&state->msg, 0);
+
+	return 0;
 }
 
 /**
@@ -304,9 +525,20 @@ static void am_next(struct am_state *state)
 static void am_run(struct am_state *state)
 {
 	while (state->cur <= state->last) {
+		const char *patch = am_path(state, msgnum(state));
+
+		if (!file_exists(patch))
+			goto next;
+
+		if (parse_patch(state, patch))
+			goto next; /* patch should be skipped */
+
+		write_author_script(state);
+		write_file(am_path(state, "final-commit"), 1, "%s", state->msg.buf);
 
 		/* TODO: Patch application not implemented yet */
 
+next:
 		am_next(state);
 	}
 
-- 
2.1.4
