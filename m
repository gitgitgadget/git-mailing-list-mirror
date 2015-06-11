From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 07/19] am: extract patch, message and authorship with git-mailinfo
Date: Thu, 11 Jun 2015 18:21:53 +0800
Message-ID: <1434018125-31804-8-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdF-0007ox-7z
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbbFKKWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:40 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34624 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbFKKWh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:37 -0400
Received: by payr10 with SMTP id r10so1871692pay.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fr9rwB7GzCkJ/+Fo7N24tV8mK4QVeSrqW0oj0HZo+EA=;
        b=MTz3+87vp3iFwQQq88yGJjUBgtwDlSXoiMUgbd3TY950tHhwkg2H6F3pkxVxmnD0aG
         s/xUmEUWGiWTqfNyel2PnO4APFla3S4sC76vSN4NdtkL+5qPIc5Ci320tXiRA8rA2FKg
         CEQjWWo5vwoRI8wNRkO3sKuMa3wD8L4PwH7BrREX9h6VKVM4MQdZBmI8B7aSNiuEa0dI
         6Xnh8JFTGAH+Yxgr24fwVmSbIVscSD6Y0bpnxhVdpYLMkEBF1IFB3gwKgy0J2wtvPV9Z
         xFqsZrHa6KDQXewzTE52+r/W1uCaTGnkxKahycP5MIPtcl8m2h/lChVulCIn8CZvMYMz
         Z9+g==
X-Received: by 10.70.135.106 with SMTP id pr10mr13528052pdb.156.1434018156618;
        Thu, 11 Jun 2015 03:22:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:35 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271390>

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
    v2
    
    * use die_errno()
    
    * use '%*d' as the format specifier for msgnum()

 builtin/am.c | 228 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7379b97..a1db474 100644
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
@@ -35,6 +58,10 @@ static void am_state_init(struct am_state *state)
 	memset(state, 0, sizeof(*state));
 
 	strbuf_init(&state->dir, 0);
+	strbuf_init(&state->author_name, 0);
+	strbuf_init(&state->author_email, 0);
+	strbuf_init(&state->author_date, 0);
+	strbuf_init(&state->msg, 0);
 	state->prec = 4;
 }
 
@@ -44,6 +71,10 @@ static void am_state_init(struct am_state *state)
 static void am_state_release(struct am_state *state)
 {
 	strbuf_release(&state->dir);
+	strbuf_release(&state->author_name);
+	strbuf_release(&state->author_email);
+	strbuf_release(&state->author_date);
+	strbuf_release(&state->msg);
 }
 
 /**
@@ -93,6 +124,95 @@ static int read_state_file(struct strbuf *sb, const char *file, size_t hint, int
 }
 
 /**
+ * Parses the "author script" `filename`, and sets state->author_name,
+ * state->author_email and state->author_date accordingly. We are strict with
+ * our parsing, as the author script is supposed to be eval'd, and loosely
+ * parsing it may not give the results the user expects.
+ *
+ * The author script is of the format:
+ *
+ * 	GIT_AUTHOR_NAME='$author_name'
+ * 	GIT_AUTHOR_EMAIL='$author_email'
+ * 	GIT_AUTHOR_DATE='$author_date'
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
+		die_errno(_("could not open '%s' for reading"), filename);
+	}
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		return -1;
+	if (!skip_prefix(sb.buf, "GIT_AUTHOR_NAME=", (const char**) &value))
+		return -1;
+	value = sq_dequote(value);
+	if (!value)
+		return -1;
+	strbuf_reset(&state->author_name);
+	strbuf_addstr(&state->author_name, value);
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		return -1;
+	if (!skip_prefix(sb.buf, "GIT_AUTHOR_EMAIL=", (const char**) &value))
+		return -1;
+	value = sq_dequote(value);
+	if (!value)
+		return -1;
+	strbuf_reset(&state->author_email);
+	strbuf_addstr(&state->author_email, value);
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		return -1;
+	if (!skip_prefix(sb.buf, "GIT_AUTHOR_DATE=", (const char**) &value))
+		return -1;
+	value = sq_dequote(value);
+	if (!value)
+		return -1;
+	strbuf_reset(&state->author_date);
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
@@ -105,6 +225,11 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, am_path(state, "last"), 8, 1);
 	state->last = strtol(sb.buf, NULL, 10);
 
+	if (read_author_script(state) < 0)
+		die(_("could not parse author script"));
+
+	read_state_file(&state->msg, am_path(state, "final-commit"), 0, 0);
+
 	strbuf_release(&sb);
 }
 
@@ -293,6 +418,98 @@ static void am_next(struct am_state *state)
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
@@ -301,9 +518,20 @@ static void am_next(struct am_state *state)
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
