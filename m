From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 15/16] remote-svn: add marks-file regeneration.
Date: Tue, 14 Aug 2012 21:13:17 +0200
Message-ID: <1344971598-8213-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Mcg-0003zx-8t
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809Ab2HNTRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:46 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756761Ab2HNTRm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:42 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lziaXxcXt5n4xLN5V89QVUdQpXOK4nV5CeF/mPGvhQ8=;
        b=D8LniKx6n/6HyOESk/sFQ/+V2MKuQtv5R0RJJ+1iANZ4Y41K9Ei3hf+8dZuNYfZUQe
         Nk/i/BvE3byDl6DoyDcR4d23AKNjeL3jIUBz59qRwlPpbL7wXLezFZVev1LS2tBTcjgH
         JdnSiv6mm8bOfP3BHm678mfFU+oCrttny9d4EkeLS4rFafD2kAkULSqkB741xFmnBi9N
         GIUaREnUx2mK7yk/Kc0jQ2dvqDF/LrctsPtdF7o/qJs1iKzSYtu2bMWL5sl9nsW9k9js
         sHFk3B//iVHUjHBa3uGKkZIj3rPtzg9Ld+lBb9C8mNUY+hOXDJ8m0LaeQtlE5tFcmm+9
         4Arg==
Received: by 10.204.136.216 with SMTP id s24mr6903652bkt.137.1344971862162;
        Tue, 14 Aug 2012 12:17:42 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.39
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203436>

fast-import mark files are stored outside the object database and are therefore
not fetched and can be lost somehow else.
marks provide a svn revision --> git sha1 mapping, while the notes that are attached
to each commit when it is imported provide a git sha1 --> svn revision.

If the marks file is not available or not plausible, regenerate it by walking through
the notes tree.
, i.e.
The plausibility check tests if the highest revision in the marks file matches the
revision of the top ref. It doesn't ensure that the mark file is completely correct.
This could only be done with an effort equal to unconditional regeneration.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   69 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index d659a0e..94e5196 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
@@ -13,7 +13,7 @@ static const char *url;
 static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
-static const char *notes_ref;
+static const char *notes_ref, *marksfilename;
 struct rev_note { unsigned int rev_nr; };
 
 static int cmd_capabilities(const char *line);
@@ -87,6 +87,68 @@ static int parse_rev_note(const char *msg, struct rev_note *res) {
 	return 0;
 }
 
+static int note2mark_cb(const unsigned char *object_sha1,
+		const unsigned char *note_sha1, char *note_path,
+		void *cb_data) {
+	FILE *file = (FILE *)cb_data;
+	char *msg;
+	unsigned long msglen;
+	enum object_type type;
+	struct rev_note note;
+	if (!(msg = read_sha1_file(note_sha1, &type, &msglen)) ||
+			!msglen || type != OBJ_BLOB) {
+		free(msg);
+		return 1;
+	}
+	if (parse_rev_note(msg, &note))
+		return 2;
+	if (fprintf(file, ":%d %s\n", note.rev_nr, sha1_to_hex(object_sha1)) < 1)
+		return 3;
+	return 0;
+}
+
+static void regenerate_marks() {
+	int ret;
+	FILE *marksfile;
+	marksfile = fopen(marksfilename, "w+");
+	if (!marksfile)
+		die_errno("Couldn't create mark file %s.", marksfilename);
+	ret = for_each_note(NULL, 0, note2mark_cb, marksfile);
+	if (ret)
+		die("Regeneration of marks failed, returned %d.", ret);
+	fclose(marksfile);
+}
+
+static void check_or_regenerate_marks(int latestrev) {
+	FILE *marksfile;
+	char *line = NULL;
+	size_t linelen = 0;
+	struct strbuf sb = STRBUF_INIT;
+	int found = 0;
+
+	if (latestrev < 1)
+		return;
+
+	init_notes(NULL, notes_ref, NULL, 0);
+	marksfile = fopen(marksfilename, "r");
+	if (!marksfile)
+		regenerate_marks(marksfile);
+	else {
+		strbuf_addf(&sb, ":%d ", latestrev);
+		while (getline(&line, &linelen, marksfile) != -1) {
+			if (!prefixcmp(line, sb.buf)) {
+				found++;
+				break;
+			}
+		}
+		fclose(marksfile);
+		if (!found)
+			regenerate_marks();
+	}
+	free_notes(NULL);
+	strbuf_release(&sb);
+}
+
 static int cmd_import(const char *line)
 {
 	int code;
@@ -112,6 +174,7 @@ static int cmd_import(const char *line)
 			free(note_msg);
 		}
 	}
+	check_or_regenerate_marks(startrev - 1);
 
 	if(dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
@@ -238,6 +301,9 @@ int main(int argc, const char **argv)
 	strbuf_addf(&buf, "refs/notes/%s/revs", remote->name);
 	notes_ref = strbuf_detach(&buf, NULL);
 
+	strbuf_addf(&buf, "%s/info/fast-import/marks/%s", get_git_dir(), remote->name);
+	marksfilename = strbuf_detach(&buf, NULL);
+
 	while(1) {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
@@ -254,5 +320,6 @@ int main(int argc, const char **argv)
 	free((void*)url);
 	free((void*)private_ref);
 	free((void*)notes_ref);
+	free((void*)marksfilename);
 	return 0;
 }
-- 
1.7.9.5
