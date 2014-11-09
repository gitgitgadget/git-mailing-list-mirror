From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 6/9] builtin/notes: Split create_note() to clarify add vs. remove logic
Date: Sun,  9 Nov 2014 13:30:52 +0100
Message-ID: <1415536255-19961-7-git-send-email-johan@herland.net>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnReY-00085I-Rm
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbaKIMbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:18 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59283 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbaKIMbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:14 -0500
Received: by mail-lb0-f179.google.com with SMTP id l4so4661161lbv.10
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NAJJK26va2DkLFuESGbmIE+lUcxKKS1frOY23sxi07E=;
        b=Xvd7wIPeX7rfyO8DTyNqQydEdbvazPbXk7sNgE8aDWDno9jtN6AAVrGzQLWC2/YzZ+
         IhExvEVciXV47i+XmzbMs7O7qNy+w2D0CtJag7g9EsnSbeJkhTv5wzC5V0JphOFkywwC
         ihKw/PjnzL/hyFTPxMQQleg9dMk7tDAaMWONMqIIFxBz9Qnt6KkyTxLx74T7fCiGCeoi
         a2nsd32TK41UHc3SrTEOpf5VxTpcqnTp0vGUzFnnbBGXgyYolFfMyF+OvkriBtY37Wu+
         DELCuuQ/vd1kPzQTZx7AuIOYN6ALFw997/4hFuYI2Xyomm95HsomqUKoOdYAxMoTO9LB
         q97Q==
X-Received: by 10.112.180.198 with SMTP id dq6mr22958614lbc.56.1415536272765;
        Sun, 09 Nov 2014 04:31:12 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.31.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:11 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1415536255-19961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

create_note() has a non-trivial interface, and comprises three loosely
related parts:

 1. launching the editor with the note contents, if needed
 2. appending to an existing note, if append_only was given
 3. adding or removing the resulting note, based on whether it's non-empty

Split it along those lines to make the logic clearer: The first part
goes into a new function - prepare_note_data(), with a simpler interface.
The second part is moved into append_edit(), which is the only user of
this code. Finally, the add vs. remove decision is moved into the callers
(add() and append_edit()), keeping the logic for writing the actual note
object in a separate function: write_note_data().

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c | 103 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index f1480cf..7017434 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -159,9 +159,8 @@ static void write_commented_object(int fd, const unsigned char *object)
 		    sha1_to_hex(object));
 }
 
-static void create_note(const unsigned char *object, struct note_data *d,
-			int append_only, const unsigned char *prev,
-			unsigned char *result)
+static void prepare_note_data(const unsigned char *object, struct note_data *d,
+		const unsigned char *old_note)
 {
 	if (d->use_editor || !d->given) {
 		int fd;
@@ -175,8 +174,8 @@ static void create_note(const unsigned char *object, struct note_data *d,
 
 		if (d->given)
 			write_or_die(fd, d->buf.buf, d->buf.len);
-		else if (prev && !append_only)
-			copy_obj_to_fd(fd, prev);
+		else if (old_note)
+			copy_obj_to_fd(fd, old_note);
 
 		strbuf_addch(&buf, '\n');
 		strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
@@ -194,33 +193,16 @@ static void create_note(const unsigned char *object, struct note_data *d,
 		}
 		stripspace(&d->buf, 1);
 	}
+}
 
-	if (prev && append_only) {
-		/* Append buf to previous note contents */
-		unsigned long size;
-		enum object_type type;
-		char *prev_buf = read_sha1_file(prev, &type, &size);
-
-		strbuf_grow(&d->buf, size + 1);
-		if (d->buf.len && prev_buf && size)
-			strbuf_insert(&d->buf, 0, "\n", 1);
-		if (prev_buf && size)
-			strbuf_insert(&d->buf, 0, prev_buf, size);
-		free(prev_buf);
-	}
-
-	if (!d->buf.len) {
-		fprintf(stderr, _("Removing note for object %s\n"),
-			sha1_to_hex(object));
-		hashclr(result);
-	} else {
-		if (write_sha1_file(d->buf.buf, d->buf.len, blob_type, result)) {
-			error(_("unable to write note object"));
-			if (d->edit_path)
-				error(_("The note contents have been left in %s"),
-				      d->edit_path);
-			exit(128);
-		}
+static void write_note_data(struct note_data *d, unsigned char *sha1)
+{
+	if (write_sha1_file(d->buf.buf, d->buf.len, blob_type, sha1)) {
+		error(_("unable to write note object"));
+		if (d->edit_path)
+			error(_("The note contents have been left in %s"),
+				d->edit_path);
+		exit(128);
 	}
 }
 
@@ -403,7 +385,6 @@ static int add(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
-	char logmsg[100];
 	const unsigned char *note;
 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
@@ -462,17 +443,20 @@ static int add(int argc, const char **argv, const char *prefix)
 			sha1_to_hex(object));
 	}
 
-	create_note(object, &d, 0, note, new_note);
-	free_note_data(&d);
-
-	if (is_null_sha1(new_note))
+	prepare_note_data(object, &d, note);
+	if (d.buf.len) {
+		write_note_data(&d, new_note);
+		if (add_note(t, object, new_note, combine_notes_overwrite))
+			die("BUG: combine_notes_overwrite failed");
+		commit_notes(t, "Notes added by 'git notes add'");
+	} else {
+		fprintf(stderr, _("Removing note for object %s\n"),
+			sha1_to_hex(object));
 		remove_note(t, object);
-	else if (add_note(t, object, new_note, combine_notes_overwrite))
-		die("BUG: combine_notes_overwrite failed");
+		commit_notes(t, "Notes removed by 'git notes add'");
+	}
 
-	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
-		 is_null_sha1(new_note) ? "removed" : "added", "add");
-	commit_notes(t, logmsg);
+	free_note_data(&d);
 	free_notes(t);
 	return 0;
 }
@@ -601,17 +585,38 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	t = init_notes_check(argv[0]);
 	note = get_note(t, object);
 
-	create_note(object, &d, !edit, note, new_note);
-	free_note_data(&d);
+	prepare_note_data(object, &d, edit ? note : NULL);
 
-	if (is_null_sha1(new_note))
-		remove_note(t, object);
-	else if (add_note(t, object, new_note, combine_notes_overwrite))
-		die("BUG: combine_notes_overwrite failed");
+	if (note && !edit) {
+		/* Append buf to previous note contents */
+		unsigned long size;
+		enum object_type type;
+		char *prev_buf = read_sha1_file(note, &type, &size);
+
+		strbuf_grow(&d.buf, size + 1);
+		if (d.buf.len && prev_buf && size)
+			strbuf_insert(&d.buf, 0, "\n", 1);
+		if (prev_buf && size)
+			strbuf_insert(&d.buf, 0, prev_buf, size);
+		free(prev_buf);
+	}
 
-	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
-		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
+	if (d.buf.len) {
+		write_note_data(&d, new_note);
+		if (add_note(t, object, new_note, combine_notes_overwrite))
+			die("BUG: combine_notes_overwrite failed");
+		snprintf(logmsg, sizeof(logmsg), "Notes added by 'git notes %s'",
+			argv[0]);
+	} else {
+		fprintf(stderr, _("Removing note for object %s\n"),
+			sha1_to_hex(object));
+		remove_note(t, object);
+		snprintf(logmsg, sizeof(logmsg), "Notes removed by 'git notes %s'",
+			argv[0]);
+	}
 	commit_notes(t, logmsg);
+
+	free_note_data(&d);
 	free_notes(t);
 	return 0;
 }
-- 
2.1.1.392.g062cc5d
