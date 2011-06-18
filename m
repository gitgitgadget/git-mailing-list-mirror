From: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 1/6] Bring notes.c template handling in line with commit.c.
Date: Sat, 18 Jun 2011 23:06:43 +0200
Message-ID: <1308431208-13353-2-git-send-email-ydirson@free.fr>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 23:07:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY2jr-0007jg-96
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 23:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab1FRVHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 17:07:03 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42408 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715Ab1FRVHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 17:07:00 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A7FD4D480F7;
	Sat, 18 Jun 2011 23:06:54 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QY2jF-0003Uy-Ds; Sat, 18 Jun 2011 23:06:53 +0200
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1308431208-13353-1-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175984>

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 builtin/notes.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437d..bd342ac 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -108,19 +108,19 @@ static int list_each_note(const unsigned char *object_sha1,
 	return 0;
 }
 
-static void write_note_data(int fd, const unsigned char *sha1)
+static void write_note_data(FILE *fp, const unsigned char *sha1)
 {
 	unsigned long size;
 	enum object_type type;
 	char *buf = read_sha1_file(sha1, &type, &size);
 	if (buf) {
 		if (size)
-			write_or_die(fd, buf, size);
+			fwrite(buf, 1, size, fp);
 		free(buf);
 	}
 }
 
-static void write_commented_object(int fd, const unsigned char *object)
+static void write_commented_object(FILE *fp, const unsigned char *object)
 {
 	const char *show_args[5] =
 		{"show", "--stat", "--no-notes", sha1_to_hex(object), NULL};
@@ -144,11 +144,11 @@ static void write_commented_object(int fd, const unsigned char *object)
 	if (show_out == NULL)
 		die_errno(_("can't fdopen 'show' output fd"));
 
-	/* Prepend "# " to each output line and write result to 'fd' */
+	/* Prepend "# " to each output line and write result to 'fp' */
 	while (strbuf_getline(&buf, show_out, '\n') != EOF) {
-		write_or_die(fd, "# ", 2);
-		write_or_die(fd, buf.buf, buf.len);
-		write_or_die(fd, "\n", 1);
+		fwrite("# ", 1, 2, fp);
+		fwrite(buf.buf, 1, buf.len, fp);
+		fwrite("\n", 1, 1, fp);
 	}
 	strbuf_release(&buf);
 	if (fclose(show_out))
@@ -166,23 +166,23 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 	char *path = NULL;
 
 	if (msg->use_editor || !msg->given) {
-		int fd;
+		FILE *fp;
 
 		/* write the template message before editing: */
 		path = git_pathdup("NOTES_EDITMSG");
-		fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-		if (fd < 0)
+		fp = fopen(path, "w");
+		if (fp == NULL)
 			die_errno(_("could not create file '%s'"), path);
 
 		if (msg->given)
-			write_or_die(fd, msg->buf.buf, msg->buf.len);
+			fwrite(msg->buf.buf, 1, msg->buf.len, fp);
 		else if (prev && !append_only)
-			write_note_data(fd, prev);
-		write_or_die(fd, note_template, strlen(note_template));
+			write_note_data(fp, prev);
+		fwrite(note_template, 1, strlen(note_template), fp);
 
-		write_commented_object(fd, object);
+		write_commented_object(fp, object);
 
-		close(fd);
+		fclose(fp);
 		strbuf_reset(&(msg->buf));
 
 		if (launch_editor(path, &(msg->buf), NULL)) {
-- 
1.7.5.3
