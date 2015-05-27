From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 6/8] am: extract patch, message and authorship with git-mailinfo
Date: Wed, 27 May 2015 21:33:36 +0800
Message-ID: <1432733618-25629-7-git-send-email-pyokagan@gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbUM-0006UN-LX
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbbE0Nen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:43 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36112 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbbE0Nek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:40 -0400
Received: by pdfh10 with SMTP id h10so15309918pdf.3
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tH//fniyoq1qz6ij0OgDDHx6V63yegroXhfGJsjFU4Y=;
        b=w2I94ReCMnSGTrAUFP6nD81r4oGq0vt0OClzcl6KvufXqTiKXRcYfK9pOgt0DHmk9K
         PEDqCBbL6yzKamVXD/njFT28S60+MS/TJWPO1LkX/Jn0FBFUFi2i2sCBqXV69yK/JC1K
         8zZ5hj0brOfHKcmmwK++MfKIYQNqmUZWhPfPFDwPpQ5DiCm67WIm4texFw6Knpn4NB3x
         HP16tUNFOkSPjxgK/5O34KPd7OQuAvFhbGXhGh8QSQeJiFTnL9K9Zip1DtlgH6sqbkLY
         JZmCzwH7y01Gt/XXkX5SQdIchiEJ4hwjSvQeve4E+wsgdtkFt41kz4BrGLPWYPv9UlUB
         6egA==
X-Received: by 10.68.224.35 with SMTP id qz3mr58215045pbc.165.1432733679914;
        Wed, 27 May 2015 06:34:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.34.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:34:38 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270055>

For the purpose of applying the patch and committing the results,
implement extracting the patch data, commit message and authorship from
an e-mail message using git-mailinfo.

git-mailinfo is run as a separate process, but ideally in the future,
we should be be able to access its functionality directly without
spawning a new process.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index d589ec5..0b8a42d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -7,6 +7,23 @@
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
@@ -17,6 +34,10 @@ struct am_state {
 	struct strbuf dir;            /* state directory path */
 	int cur;                      /* current patch number */
 	int last;                     /* last patch number */
+	struct strbuf msg;            /* commit message */
+	struct strbuf author_name;    /* commit author's name */
+	struct strbuf author_email;   /* commit author's email */
+	struct strbuf author_date;    /* commit author's date */
 	int prec;                     /* number of digits in patch filename */
 };
 
@@ -28,6 +49,10 @@ static void am_state_init(struct am_state *state)
 	memset(state, 0, sizeof(*state));
 
 	strbuf_init(&state->dir, 0);
+	strbuf_init(&state->msg, 0);
+	strbuf_init(&state->author_name, 0);
+	strbuf_init(&state->author_email, 0);
+	strbuf_init(&state->author_date, 0);
 	state->prec = 4;
 }
 
@@ -37,6 +62,10 @@ static void am_state_init(struct am_state *state)
 static void am_state_release(struct am_state *state)
 {
 	strbuf_release(&state->dir);
+	strbuf_release(&state->msg);
+	strbuf_release(&state->author_name);
+	strbuf_release(&state->author_email);
+	strbuf_release(&state->author_date);
 }
 
 /**
@@ -81,6 +110,92 @@ static int read_state_file(struct strbuf *sb, const char *file, size_t hint) {
 }
 
 /**
+ * Parses the "author script" `filename`, and sets state->author_name,
+ * state->author_email and state->author_date accordingly. We are strict with
+ * our parsing, as the author script is supposed to be eval'd, and loosely
+ * parsing it may not give the results the user expects.
+ *
+ * The author script is of the format:
+ *
+ *         GIT_AUTHOR_NAME='$author_name'
+ *         GIT_AUTHOR_EMAIL='$author_email'
+ *	   GIT_AUTHOR_DATE='$author_date'
+ *
+ * where $author_name, $author_email and $author_date are quoted.
+ */
+static int read_author_script(struct am_state *state)
+{
+	char *value;
+	struct strbuf sb = STRBUF_INIT;
+	const char *filename = am_path(state, "author-script");
+	FILE *fp = fopen(filename, "r");
+	if (!fp) {
+		if (errno == ENOENT)
+			return 0;
+		die(_("could not open '%s' for reading"), filename);
+	}
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		return -1;
+	if (!skip_prefix(sb.buf, "GIT_AUTHOR_NAME=", (const char**) &value))
+		return -1;
+	value = sq_dequote(value);
+	if (!value)
+		return -1;
+	strbuf_addstr(&state->author_name, value);
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		return -1;
+	if (!skip_prefix(sb.buf, "GIT_AUTHOR_EMAIL=", (const char**) &value))
+		return -1;
+	value = sq_dequote(value);
+	if (!value)
+		return -1;
+	strbuf_addstr(&state->author_email, value);
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		return -1;
+	if (!skip_prefix(sb.buf, "GIT_AUTHOR_DATE=", (const char**) &value))
+		return -1;
+	value = sq_dequote(value);
+	if (!value)
+		return -1;
+	strbuf_addstr(&state->author_date, value);
+
+	if (fgetc(fp) != EOF)
+		return -1;
+
+	fclose(fp);
+	strbuf_release(&sb);
+	return 0;
+}
+
+/**
+ * Saves state->author_name, state->author_email and state->author_date in
+ * `filename` as an "author script", which is the format used by git-am.sh.
+ */
+static void write_author_script(const struct am_state *state)
+{
+	static const char fmt[] = "GIT_AUTHOR_NAME='%s'\n"
+		"GIT_AUTHOR_EMAIL='%s'\n"
+		"GIT_AUTHOR_DATE='%s'\n";
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
 static void am_state_load(struct am_state *state)
@@ -93,6 +208,14 @@ static void am_state_load(struct am_state *state)
 	read_state_file(&sb, am_path(state, "last"), 8);
 	state->last = strtol(sb.buf, NULL, 10);
 
+	read_state_file(&state->msg, am_path(state, "final-commit"), 0);
+
+	strbuf_reset(&state->author_name);
+	strbuf_reset(&state->author_email);
+	strbuf_reset(&state->author_date);
+	if (read_author_script(state) < 0)
+		die(_("could not parse author script"));
+
 	strbuf_release(&sb);
 }
 
@@ -282,6 +405,102 @@ static void am_next(struct am_state *state)
 {
 	state->cur++;
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
+
+	strbuf_reset(&state->msg);
+	unlink(am_path(state, "final-commit"));
+
+	strbuf_reset(&state->author_name);
+	strbuf_reset(&state->author_email);
+	strbuf_reset(&state->author_date);
+	unlink(am_path(state, "author-script"));
+}
+
+/**
+ * Returns the filename of the current patch.
+ */
+static const char *msgnum(const struct am_state *state)
+{
+	static struct strbuf fmt = STRBUF_INIT;
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&fmt);
+	strbuf_addf(&fmt, "%%0%dd", state->prec);
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, fmt.buf, state->cur);
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
+		} else if (skip_prefix(sb.buf, "Author: ", &x)) {
+			if (state->author_name.len)
+				strbuf_addch(&state->author_name, '\n');
+			strbuf_addstr(&state->author_name, x);
+		} else if (skip_prefix(sb.buf, "Email: ", &x)) {
+			if (state->author_email.len)
+				strbuf_addch(&state->author_email, '\n');
+			strbuf_addstr(&state->author_email, x);
+		} else if (skip_prefix(sb.buf, "Date: ", &x)) {
+			if (state->author_date.len)
+				strbuf_addch(&state->author_date, '\n');
+			strbuf_addstr(&state->author_date, x);
+		}
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
@@ -290,8 +509,20 @@ static void am_next(struct am_state *state)
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
+		write_file(am_path(state, "final-commit"), 1, "%s", state->msg.buf);
+		write_author_script(state);
+
 		/* patch application not implemented yet */
 
+next:
 		am_next(state);
 	}
 
-- 
2.1.4
