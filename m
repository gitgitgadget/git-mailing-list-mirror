From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 07/45] builtin-am: extract patch and commit info with git-mailinfo
Date: Tue,  4 Aug 2015 21:51:28 +0800
Message-ID: <1438696326-19590-8-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:53:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMces-0002IR-W3
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934244AbbHDNxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:18 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36063 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933627AbbHDNxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:16 -0400
Received: by pacgq8 with SMTP id gq8so9163689pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tHP9t56Fdp+4x800kUkUem1U56muPG8R6tjwmienLZ0=;
        b=zd9jW7DZV1u9You/1G7cZIIkP3AD5tD520sx1o7/52wg0Uq6GAkKtXX7gUoE/nEgaQ
         eGqMJmVVw3KndaWTbv4cQgpCiZPcKKuLahsvRk2ZEoL7h+KWxnBByrykTAoCirC7WDHu
         LwB4fzejIZQl7+ZrEXQtcVT4eNZ4j4CcJhI1lloITaVFIInNmICoEK6G6OJt2bEU3mFr
         2+AUICpVp/j2LOKnlel5V9x1rzXwMuRbtGO7oCEcBaoGj6078YNOdlHrk8T9bJrIhjpl
         F+jIHhgnWAaOftw7DJGUOzZNeTEcHObNqQPszMZmIy2RcuIWKo2y6ZrVyHtb6L84C1nI
         8yrA==
X-Received: by 10.66.62.194 with SMTP id a2mr8243763pas.67.1438696395666;
        Tue, 04 Aug 2015 06:53:15 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275282>

For the purpose of applying the patch and committing the results,
implement extracting the patch data, commit message and authorship from
an e-mail message using git-mailinfo.

git-mailinfo is run as a separate process, but ideally in the future,
we should be be able to access its functionality directly without
spawning a new process.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 317 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 317 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index c12566a..63f0fa4 100644
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
 
 /**
  * Like strbuf_getline(), but treats both '\n' and "\r\n" as line terminators.
@@ -38,6 +55,13 @@ struct am_state {
 	int cur;
 	int last;
 
+	/* commit metadata and message */
+	char *author_name;
+	char *author_email;
+	char *author_date;
+	char *msg;
+	size_t msg_len;
+
 	/* number of digits in patch filename */
 	int prec;
 };
@@ -62,6 +86,10 @@ static void am_state_init(struct am_state *state, const char *dir)
 static void am_state_release(struct am_state *state)
 {
 	free(state->dir);
+	free(state->author_name);
+	free(state->author_email);
+	free(state->author_date);
+	free(state->msg);
 }
 
 /**
@@ -112,6 +140,161 @@ static int read_state_file(struct strbuf *sb, const struct am_state *state,
 }
 
 /**
+ * Reads a KEY=VALUE shell variable assignment from `fp`, returning the VALUE
+ * as a newly-allocated string. VALUE must be a quoted string, and the KEY must
+ * match `key`. Returns NULL on failure.
+ *
+ * This is used by read_author_script() to read the GIT_AUTHOR_* variables from
+ * the author-script.
+ */
+static char *read_shell_var(FILE *fp, const char *key)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *str;
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		goto fail;
+
+	if (!skip_prefix(sb.buf, key, &str))
+		goto fail;
+
+	if (!skip_prefix(str, "=", &str))
+		goto fail;
+
+	strbuf_remove(&sb, 0, str - sb.buf);
+
+	str = sq_dequote(sb.buf);
+	if (!str)
+		goto fail;
+
+	return strbuf_detach(&sb, NULL);
+
+fail:
+	strbuf_release(&sb);
+	return NULL;
+}
+
+/**
+ * Reads and parses the state directory's "author-script" file, and sets
+ * state->author_name, state->author_email and state->author_date accordingly.
+ * Returns 0 on success, -1 if the file could not be parsed.
+ *
+ * The author script is of the format:
+ *
+ *	GIT_AUTHOR_NAME='$author_name'
+ *	GIT_AUTHOR_EMAIL='$author_email'
+ *	GIT_AUTHOR_DATE='$author_date'
+ *
+ * where $author_name, $author_email and $author_date are quoted. We are strict
+ * with our parsing, as the file was meant to be eval'd in the old git-am.sh
+ * script, and thus if the file differs from what this function expects, it is
+ * better to bail out than to do something that the user does not expect.
+ */
+static int read_author_script(struct am_state *state)
+{
+	const char *filename = am_path(state, "author-script");
+	FILE *fp;
+
+	assert(!state->author_name);
+	assert(!state->author_email);
+	assert(!state->author_date);
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		if (errno == ENOENT)
+			return 0;
+		die_errno(_("could not open '%s' for reading"), filename);
+	}
+
+	state->author_name = read_shell_var(fp, "GIT_AUTHOR_NAME");
+	if (!state->author_name) {
+		fclose(fp);
+		return -1;
+	}
+
+	state->author_email = read_shell_var(fp, "GIT_AUTHOR_EMAIL");
+	if (!state->author_email) {
+		fclose(fp);
+		return -1;
+	}
+
+	state->author_date = read_shell_var(fp, "GIT_AUTHOR_DATE");
+	if (!state->author_date) {
+		fclose(fp);
+		return -1;
+	}
+
+	if (fgetc(fp) != EOF) {
+		fclose(fp);
+		return -1;
+	}
+
+	fclose(fp);
+	return 0;
+}
+
+/**
+ * Saves state->author_name, state->author_email and state->author_date in the
+ * state directory's "author-script" file.
+ */
+static void write_author_script(const struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, "GIT_AUTHOR_NAME=");
+	sq_quote_buf(&sb, state->author_name);
+	strbuf_addch(&sb, '\n');
+
+	strbuf_addstr(&sb, "GIT_AUTHOR_EMAIL=");
+	sq_quote_buf(&sb, state->author_email);
+	strbuf_addch(&sb, '\n');
+
+	strbuf_addstr(&sb, "GIT_AUTHOR_DATE=");
+	sq_quote_buf(&sb, state->author_date);
+	strbuf_addch(&sb, '\n');
+
+	write_file(am_path(state, "author-script"), 1, "%s", sb.buf);
+
+	strbuf_release(&sb);
+}
+
+/**
+ * Reads the commit message from the state directory's "final-commit" file,
+ * setting state->msg to its contents and state->msg_len to the length of its
+ * contents in bytes.
+ *
+ * Returns 0 on success, -1 if the file does not exist.
+ */
+static int read_commit_msg(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	assert(!state->msg);
+
+	if (read_state_file(&sb, state, "final-commit", 0) < 0) {
+		strbuf_release(&sb);
+		return -1;
+	}
+
+	state->msg = strbuf_detach(&sb, &state->msg_len);
+	return 0;
+}
+
+/**
+ * Saves state->msg in the state directory's "final-commit" file.
+ */
+static void write_commit_msg(const struct am_state *state)
+{
+	int fd;
+	const char *filename = am_path(state, "final-commit");
+
+	fd = xopen(filename, O_WRONLY | O_CREAT, 0666);
+	if (write_in_full(fd, state->msg, state->msg_len) < 0)
+		die_errno(_("could not write to %s"), filename);
+	close(fd);
+}
+
+/**
  * Loads state from disk.
  */
 static void am_load(struct am_state *state)
@@ -126,6 +309,11 @@ static void am_load(struct am_state *state)
 		die("BUG: state file 'last' does not exist");
 	state->last = strtol(sb.buf, NULL, 10);
 
+	if (read_author_script(state) < 0)
+		die(_("could not parse author script"));
+
+	read_commit_msg(state);
+
 	strbuf_release(&sb);
 }
 
@@ -318,19 +506,148 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
  */
 static void am_next(struct am_state *state)
 {
+	free(state->author_name);
+	state->author_name = NULL;
+
+	free(state->author_email);
+	state->author_email = NULL;
+
+	free(state->author_date);
+	state->author_date = NULL;
+
+	free(state->msg);
+	state->msg = NULL;
+	state->msg_len = 0;
+
+	unlink(am_path(state, "author-script"));
+	unlink(am_path(state, "final-commit"));
+
 	state->cur++;
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 }
 
 /**
+ * Returns the filename of the current patch email.
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
+ * Parses `mail` using git-mailinfo, extracting its patch and authorship info.
+ * state->msg will be set to the patch message. state->author_name,
+ * state->author_email and state->author_date will be set to the patch author's
+ * name, email and date respectively. The patch body will be written to the
+ * state directory's "patch" file.
+ *
+ * Returns 1 if the patch should be skipped, 0 otherwise.
+ */
+static int parse_mail(struct am_state *state, const char *mail)
+{
+	FILE *fp;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf author_name = STRBUF_INIT;
+	struct strbuf author_date = STRBUF_INIT;
+	struct strbuf author_email = STRBUF_INIT;
+	int ret = 0;
+
+	cp.git_cmd = 1;
+	cp.in = xopen(mail, O_RDONLY, 0);
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
+			if (msg.len)
+				strbuf_addch(&msg, '\n');
+			strbuf_addstr(&msg, x);
+		} else if (skip_prefix(sb.buf, "Author: ", &x))
+			strbuf_addstr(&author_name, x);
+		else if (skip_prefix(sb.buf, "Email: ", &x))
+			strbuf_addstr(&author_email, x);
+		else if (skip_prefix(sb.buf, "Date: ", &x))
+			strbuf_addstr(&author_date, x);
+	}
+	fclose(fp);
+
+	/* Skip pine's internal folder data */
+	if (!strcmp(author_name.buf, "Mail System Internal Data")) {
+		ret = 1;
+		goto finish;
+	}
+
+	if (is_empty_file(am_path(state, "patch"))) {
+		printf_ln(_("Patch is empty. Was it split wrong?"));
+		exit(128);
+	}
+
+	strbuf_addstr(&msg, "\n\n");
+	if (strbuf_read_file(&msg, am_path(state, "msg"), 0) < 0)
+		die_errno(_("could not read '%s'"), am_path(state, "msg"));
+	stripspace(&msg, 0);
+
+	assert(!state->author_name);
+	state->author_name = strbuf_detach(&author_name, NULL);
+
+	assert(!state->author_email);
+	state->author_email = strbuf_detach(&author_email, NULL);
+
+	assert(!state->author_date);
+	state->author_date = strbuf_detach(&author_date, NULL);
+
+	assert(!state->msg);
+	state->msg = strbuf_detach(&msg, &state->msg_len);
+
+finish:
+	strbuf_release(&msg);
+	strbuf_release(&author_date);
+	strbuf_release(&author_email);
+	strbuf_release(&author_name);
+	strbuf_release(&sb);
+	return ret;
+}
+
+/**
  * Applies all queued mail.
  */
 static void am_run(struct am_state *state)
 {
 	while (state->cur <= state->last) {
+		const char *mail = am_path(state, msgnum(state));
+
+		if (!file_exists(mail))
+			goto next;
+
+		if (parse_mail(state, mail))
+			goto next; /* mail should be skipped */
+
+		write_author_script(state);
+		write_commit_msg(state);
 
 		/* NEEDSWORK: Patch application not implemented yet */
 
+next:
 		am_next(state);
 	}
 
-- 
2.5.0.280.gd88bd6e
