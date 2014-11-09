From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 4/9] builtin/notes: Refactor note file path into struct note_data
Date: Sun,  9 Nov 2014 13:30:50 +0100
Message-ID: <1415536255-19961-5-git-send-email-johan@herland.net>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnReb-00085I-L2
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbaKIMbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:33 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:50642 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbaKIMbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:10 -0500
Received: by mail-la0-f49.google.com with SMTP id ge10so6476119lab.36
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GMdsnK370qqFEllgpOdXXKTv14P9zHoIUed9cmHj+Rs=;
        b=PzuorZmUVz7u+Uoo0AZa5Zuk7Dl09vV4ibeekeHmSiC+jkxq8xnKKtXf5X85NwXse3
         12hUAMj6mgcf1bZ+pUStPYEuBloszqeRme7AFMmI94nCvN/BaPPxxZN2uKenX45vw4qY
         lgk/EN339r7zdiEG1wpdEjKCAWrXgPvxJL6LVFqBKx7Fk5lmafcP954ONoVoGvmmAhYd
         qtvWsTID0hgNBLj9nmirAFOVi2Z9xhe9KO4aj4G4yefLSd+ZmykbxtLt2PvxK0N5qrJE
         +VAc9ZJl0orOZp+zHYeV/HlCcgFt+n7A8KTrYzKu7VsVoRovlaLuicnxsabmjDH+3DtC
         ZeDA==
X-Received: by 10.152.36.201 with SMTP id s9mr2729220laj.17.1415536268904;
        Sun, 09 Nov 2014 04:31:08 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.31.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:07 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1415536255-19961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the 'path' variable from create_note() and into the
note_data struct. Unify cleanup of note_data objects with
a free_note_data() function.

This might not make too much sense on its own, but it makes the
future refactoring of create_note() considerably cleaner.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3cf22cb..1017472 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -95,9 +95,19 @@ static const char note_template[] =
 struct note_data {
 	int given;
 	int use_editor;
+	char *edit_path;
 	struct strbuf buf;
 };
 
+static void free_note_data(struct note_data *d)
+{
+	if (d->edit_path) {
+		unlink_or_warn(d->edit_path);
+		free(d->edit_path);
+	}
+	strbuf_release(&d->buf);
+}
+
 static int list_each_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1, char *note_path,
 		void *cb_data)
@@ -153,17 +163,15 @@ static void create_note(const unsigned char *object, struct note_data *d,
 			int append_only, const unsigned char *prev,
 			unsigned char *result)
 {
-	char *path = NULL;
-
 	if (d->use_editor || !d->given) {
 		int fd;
 		struct strbuf buf = STRBUF_INIT;
 
 		/* write the template message before editing: */
-		path = git_pathdup("NOTES_EDITMSG");
-		fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		d->edit_path = git_pathdup("NOTES_EDITMSG");
+		fd = open(d->edit_path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 		if (fd < 0)
-			die_errno(_("could not create file '%s'"), path);
+			die_errno(_("could not create file '%s'"), d->edit_path);
 
 		if (d->given)
 			write_or_die(fd, d->buf.buf, d->buf.len);
@@ -181,7 +189,7 @@ static void create_note(const unsigned char *object, struct note_data *d,
 		strbuf_release(&buf);
 		strbuf_reset(&d->buf);
 
-		if (launch_editor(path, &d->buf, NULL)) {
+		if (launch_editor(d->edit_path, &d->buf, NULL)) {
 			die(_("Please supply the note contents using either -m or -F option"));
 		}
 		stripspace(&d->buf, 1);
@@ -208,17 +216,12 @@ static void create_note(const unsigned char *object, struct note_data *d,
 	} else {
 		if (write_sha1_file(d->buf.buf, d->buf.len, blob_type, result)) {
 			error(_("unable to write note object"));
-			if (path)
+			if (d->edit_path)
 				error(_("The note contents have been left in %s"),
-				      path);
+				      d->edit_path);
 			exit(128);
 		}
 	}
-
-	if (path) {
-		unlink_or_warn(path);
-		free(path);
-	}
 }
 
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
@@ -402,7 +405,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	unsigned char object[20], new_note[20];
 	char logmsg[100];
 	const unsigned char *note;
-	struct note_data d = { 0, 0, STRBUF_INIT };
+	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
 		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -447,6 +450,7 @@ static int add(int argc, const char **argv, const char *prefix)
 				 * therefore still in argv[0-1].
 				 */
 				argv[0] = "edit";
+				free_note_data(&d);
 				free_notes(t);
 				return append_edit(argc, argv, prefix);
 			}
@@ -460,6 +464,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	}
 
 	create_note(object, &d, 0, note, new_note);
+	free_note_data(&d);
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
@@ -471,7 +476,6 @@ static int add(int argc, const char **argv, const char *prefix)
 	commit_notes(t, logmsg);
 out:
 	free_notes(t);
-	strbuf_release(&d.buf);
 	return retval;
 }
 
@@ -559,7 +563,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const unsigned char *note;
 	char logmsg[100];
 	const char * const *usage;
-	struct note_data d = { 0, 0, STRBUF_INIT };
+	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
 		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -600,6 +604,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	note = get_note(t, object);
 
 	create_note(object, &d, !edit, note, new_note);
+	free_note_data(&d);
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
@@ -610,7 +615,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
 	commit_notes(t, logmsg);
 	free_notes(t);
-	strbuf_release(&d.buf);
 	return 0;
 }
 
-- 
2.1.1.392.g062cc5d
