From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 4/9] builtin/notes: Refactor note file path into struct note_data
Date: Wed, 12 Nov 2014 01:40:11 +0100
Message-ID: <1415752816-22782-5-git-send-email-johan@herland.net>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, peff@peff.net, blume.mike@gmail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 01:40:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLzS-0005vi-9O
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 01:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbaKLAkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 19:40:39 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:45846 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbaKLAkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 19:40:37 -0500
Received: by mail-lb0-f171.google.com with SMTP id b6so8512861lbj.16
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 16:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vLt5J20FxAc0aKj1map1bCWRd0bZJW35i3l+pAunHDE=;
        b=mIaveaalnrgY8FEGjvTEkfgTJtAthVtvm9DdUoQd+6r4Vgep4zc1gxobaDIl639Zph
         GyMDLx+8QIXtvgZfBxTEXHzNLEQyzxeIXLLlGpJxm/2K9cH7MjYtYbP+UGromuFCXTBq
         beocWdW/JEbYZiPHrBBuqh2YoIHWVfC5GiQ9gRCtmm1D40J3tlRxZh4PYa3s1hS3x+3m
         lpUZqgaWxO2n6LQTAfNcGquY5cLUVUExXfh7mEjLBYKot9um+z2YycxkwqAa6YkPweIT
         i7hlmOPhhiQpYkvM8x2Lqv+ibDv96VRs7EwpeIZDFEnx+ZlXOayFI4IZbTL3P29bBVdD
         zQgg==
X-Received: by 10.112.148.130 with SMTP id ts2mr39403401lbb.43.1415752835788;
        Tue, 11 Nov 2014 16:40:35 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm6341174lav.15.2014.11.11.16.40.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Nov 2014 16:40:34 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415752816-22782-1-git-send-email-johan@herland.net>
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
2.0.0.rc4.501.gdaf83ca
