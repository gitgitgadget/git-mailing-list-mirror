From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 3/9] builtin/notes: Improve naming
Date: Sun,  9 Nov 2014 13:30:49 +0100
Message-ID: <1415536255-19961-4-git-send-email-johan@herland.net>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnReI-0007k1-Af
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbaKIMbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:11 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:43783 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaKIMbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:08 -0500
Received: by mail-lb0-f169.google.com with SMTP id 10so4631925lbg.14
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CXbiD3afXnHXQdfcIYV3Gx0O6BtlzaGbm+NMTkgewwE=;
        b=Jra2q3aao10GacqDlkkFRtWOIPNms2OOPQD/3pj0tzfBnnCj1pocHKU9zQQe2UhSrQ
         IFrs4Ac5IUiUD0YK0WFgODBjcgbHAbC2AJY9BO9wlz82FP+uR0DVTRetnVrop8wSxnvr
         xa3KQiz1vLbsgamW8vKy28httjnB/Bd7kLOTUr4Si+ePAAvwBPOxTeQVkvnskvC0ovUc
         FKozf9B/u2HY5FvBZYTrkwhPzgSvGrjoepx1NtjrHxzUKOjsyAiH/s6BACZGq8s30GPB
         MtNvAdrpWZbxjWU7eHJKwbmNa0Vqc7C+sY5jIIWPZb6BYoc5DLGFJu7OYDRBH/zjM7IJ
         p96w==
X-Received: by 10.152.20.199 with SMTP id p7mr23438765lae.49.1415536267037;
        Sun, 09 Nov 2014 04:31:07 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.31.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:06 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1415536255-19961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for some needed refactoring, rename struct msg_arg to
struct note_data, and rename its instances from "msg" to "d" (also
removing some unnecessary parentheses). The 'msg_arg' name was
inherited from tag.c, but is not really a good name for the contents
of a note.

Also rename write_note_data() to copy_obj_to_fd(), which more aptly
describes what it actually does: Copying the contents of a git object
(given by its SHA1) into a given file descriptor.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c | 109 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 54 insertions(+), 55 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9ee6816..3cf22cb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -92,7 +92,7 @@ static const char * const git_notes_get_ref_usage[] = {
 static const char note_template[] =
 	"\nWrite/edit the notes for the following object:\n";
 
-struct msg_arg {
+struct note_data {
 	int given;
 	int use_editor;
 	struct strbuf buf;
@@ -106,7 +106,7 @@ static int list_each_note(const unsigned char *object_sha1,
 	return 0;
 }
 
-static void write_note_data(int fd, const unsigned char *sha1)
+static void copy_obj_to_fd(int fd, const unsigned char *sha1)
 {
 	unsigned long size;
 	enum object_type type;
@@ -149,13 +149,13 @@ static void write_commented_object(int fd, const unsigned char *object)
 		    sha1_to_hex(object));
 }
 
-static void create_note(const unsigned char *object, struct msg_arg *msg,
+static void create_note(const unsigned char *object, struct note_data *d,
 			int append_only, const unsigned char *prev,
 			unsigned char *result)
 {
 	char *path = NULL;
 
-	if (msg->use_editor || !msg->given) {
+	if (d->use_editor || !d->given) {
 		int fd;
 		struct strbuf buf = STRBUF_INIT;
 
@@ -165,10 +165,10 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 		if (fd < 0)
 			die_errno(_("could not create file '%s'"), path);
 
-		if (msg->given)
-			write_or_die(fd, msg->buf.buf, msg->buf.len);
+		if (d->given)
+			write_or_die(fd, d->buf.buf, d->buf.len);
 		else if (prev && !append_only)
-			write_note_data(fd, prev);
+			copy_obj_to_fd(fd, prev);
 
 		strbuf_addch(&buf, '\n');
 		strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
@@ -179,13 +179,12 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 
 		close(fd);
 		strbuf_release(&buf);
-		strbuf_reset(&(msg->buf));
+		strbuf_reset(&d->buf);
 
-		if (launch_editor(path, &(msg->buf), NULL)) {
-			die(_("Please supply the note contents using either -m" \
-			    " or -F option"));
+		if (launch_editor(path, &d->buf, NULL)) {
+			die(_("Please supply the note contents using either -m or -F option"));
 		}
-		stripspace(&(msg->buf), 1);
+		stripspace(&d->buf, 1);
 	}
 
 	if (prev && append_only) {
@@ -194,20 +193,20 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 		enum object_type type;
 		char *prev_buf = read_sha1_file(prev, &type, &size);
 
-		strbuf_grow(&(msg->buf), size + 1);
-		if (msg->buf.len && prev_buf && size)
-			strbuf_insert(&(msg->buf), 0, "\n", 1);
+		strbuf_grow(&d->buf, size + 1);
+		if (d->buf.len && prev_buf && size)
+			strbuf_insert(&d->buf, 0, "\n", 1);
 		if (prev_buf && size)
-			strbuf_insert(&(msg->buf), 0, prev_buf, size);
+			strbuf_insert(&d->buf, 0, prev_buf, size);
 		free(prev_buf);
 	}
 
-	if (!msg->buf.len) {
+	if (!d->buf.len) {
 		fprintf(stderr, _("Removing note for object %s\n"),
 			sha1_to_hex(object));
 		hashclr(result);
 	} else {
-		if (write_sha1_file(msg->buf.buf, msg->buf.len, blob_type, result)) {
+		if (write_sha1_file(d->buf.buf, d->buf.len, blob_type, result)) {
 			error(_("unable to write note object"));
 			if (path)
 				error(_("The note contents have been left in %s"),
@@ -224,45 +223,45 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
-	struct msg_arg *msg = opt->value;
+	struct note_data *d = opt->value;
 
-	strbuf_grow(&(msg->buf), strlen(arg) + 2);
-	if (msg->buf.len)
-		strbuf_addch(&(msg->buf), '\n');
-	strbuf_addstr(&(msg->buf), arg);
-	stripspace(&(msg->buf), 0);
+	strbuf_grow(&d->buf, strlen(arg) + 2);
+	if (d->buf.len)
+		strbuf_addch(&d->buf, '\n');
+	strbuf_addstr(&d->buf, arg);
+	stripspace(&d->buf, 0);
 
-	msg->given = 1;
+	d->given = 1;
 	return 0;
 }
 
 static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 {
-	struct msg_arg *msg = opt->value;
+	struct note_data *d = opt->value;
 
-	if (msg->buf.len)
-		strbuf_addch(&(msg->buf), '\n');
+	if (d->buf.len)
+		strbuf_addch(&d->buf, '\n');
 	if (!strcmp(arg, "-")) {
-		if (strbuf_read(&(msg->buf), 0, 1024) < 0)
+		if (strbuf_read(&d->buf, 0, 1024) < 0)
 			die_errno(_("cannot read '%s'"), arg);
-	} else if (strbuf_read_file(&(msg->buf), arg, 1024) < 0)
+	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
 		die_errno(_("could not open or read '%s'"), arg);
-	stripspace(&(msg->buf), 0);
+	stripspace(&d->buf, 0);
 
-	msg->given = 1;
+	d->given = 1;
 	return 0;
 }
 
 static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 {
-	struct msg_arg *msg = opt->value;
+	struct note_data *d = opt->value;
 	char *buf;
 	unsigned char object[20];
 	enum object_type type;
 	unsigned long len;
 
-	if (msg->buf.len)
-		strbuf_addch(&(msg->buf), '\n');
+	if (d->buf.len)
+		strbuf_addch(&d->buf, '\n');
 
 	if (get_sha1(arg, object))
 		die(_("Failed to resolve '%s' as a valid ref."), arg);
@@ -274,17 +273,17 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 		free(buf);
 		die(_("Cannot read note data from non-blob object '%s'."), arg);
 	}
-	strbuf_add(&(msg->buf), buf, len);
+	strbuf_add(&d->buf, buf, len);
 	free(buf);
 
-	msg->given = 1;
+	d->given = 1;
 	return 0;
 }
 
 static int parse_reedit_arg(const struct option *opt, const char *arg, int unset)
 {
-	struct msg_arg *msg = opt->value;
-	msg->use_editor = 1;
+	struct note_data *d = opt->value;
+	d->use_editor = 1;
 	return parse_reuse_arg(opt, arg, unset);
 }
 
@@ -403,18 +402,18 @@ static int add(int argc, const char **argv, const char *prefix)
 	unsigned char object[20], new_note[20];
 	char logmsg[100];
 	const unsigned char *note;
-	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	struct note_data d = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
-		{ OPTION_CALLBACK, 'm', "message", &msg, N_("message"),
+		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
 			parse_msg_arg},
-		{ OPTION_CALLBACK, 'F', "file", &msg, N_("file"),
+		{ OPTION_CALLBACK, 'F', "file", &d, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg},
-		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, N_("object"),
+		{ OPTION_CALLBACK, 'c', "reedit-message", &d, N_("object"),
 			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
 			parse_reedit_arg},
-		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, N_("object"),
+		{ OPTION_CALLBACK, 'C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
 		OPT__FORCE(&force, N_("replace existing notes")),
@@ -439,7 +438,7 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	if (note) {
 		if (!force) {
-			if (!msg.given) {
+			if (!d.given) {
 				/*
 				 * Redirect to "edit" subcommand.
 				 *
@@ -460,7 +459,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			sha1_to_hex(object));
 	}
 
-	create_note(object, &msg, 0, note, new_note);
+	create_note(object, &d, 0, note, new_note);
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
@@ -472,7 +471,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	commit_notes(t, logmsg);
 out:
 	free_notes(t);
-	strbuf_release(&(msg.buf));
+	strbuf_release(&d.buf);
 	return retval;
 }
 
@@ -560,18 +559,18 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const unsigned char *note;
 	char logmsg[100];
 	const char * const *usage;
-	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	struct note_data d = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
-		{ OPTION_CALLBACK, 'm', "message", &msg, N_("message"),
+		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
 			parse_msg_arg},
-		{ OPTION_CALLBACK, 'F', "file", &msg, N_("file"),
+		{ OPTION_CALLBACK, 'F', "file", &d, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg},
-		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, N_("object"),
+		{ OPTION_CALLBACK, 'c', "reedit-message", &d, N_("object"),
 			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
 			parse_reedit_arg},
-		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, N_("object"),
+		{ OPTION_CALLBACK, 'C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
 		OPT_END()
@@ -587,7 +586,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	}
 
-	if (msg.given && edit)
+	if (d.given && edit)
 		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
 			"for the 'edit' subcommand.\n"
 			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n"));
@@ -600,7 +599,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	t = init_notes_check(argv[0]);
 	note = get_note(t, object);
 
-	create_note(object, &msg, !edit, note, new_note);
+	create_note(object, &d, !edit, note, new_note);
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
@@ -611,7 +610,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
 	commit_notes(t, logmsg);
 	free_notes(t);
-	strbuf_release(&(msg.buf));
+	strbuf_release(&d.buf);
 	return 0;
 }
 
-- 
2.1.1.392.g062cc5d
