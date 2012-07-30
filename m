From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 15/16] remote-svn: add marks-file regeneration.
Date: Mon, 30 Jul 2012 16:31:22 +0200
Message-ID: <1343658683-10713-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr8S-00086y-Un
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab2G3Ojq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:46 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39226 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab2G3Ojj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:39 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859087bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5Z4w8TO/82ZN0nC5ptAHnHEI+oXBWfnhBur26U2Cuns=;
        b=CykKMuzEk5a/JrADbeSLZkUi5dNbJaDfICJFMTMQ9g17ejn5qw0tD72Yr79qArHRPJ
         DklrZWNBQbdv7k7VrXD/krqioi9KocKHd0D0u6WbX8pN6R6rcnnVJYDzaikJoB81Qqma
         CMIPFzuKkyUI0ElBzSp73yKUPqk12XSY6xbAjCzApxQLnXocTpSiLPodK5n6005j7Ia1
         RhMkdGxW9oR2g+GDJr46aL9Q7r7IaL8zWEEFu7N4l1wuS1E9GVxLwPGSWYuvNBVHAZXh
         J+Z6WLe0Z28oe7sX4QUKvIKB+r6JngYHxiZMAhgvGtZkujyQSOcQPJVe1CXZuphz+hOB
         XILA==
Received: by 10.205.133.11 with SMTP id hw11mr4127777bkc.46.1343659178944;
        Mon, 30 Jul 2012 07:39:38 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.37
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202554>

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
 contrib/svn-fe/remote-svn.c |   74 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index 2b4c827..168c973 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
@@ -13,7 +13,7 @@ static const char *url;
 static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
-static const char *notes_ref;
+static const char *notes_ref, *marksfilename;
 struct rev_note { unsigned int rev_nr; };
 
 int cmd_capabilities(struct strbuf *line);
@@ -86,8 +86,69 @@ static int parse_rev_note(const char *msg, struct rev_note *res) {
 	return 0;
 }
 
-int cmd_import(struct strbuf *line)
-{
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
+int cmd_import(struct strbuf *line) {
 	int code, report_fd;
 	char *back_pipe_env;
 	int dumpin_fd;
@@ -133,7 +194,7 @@ int cmd_import(struct strbuf *line)
 			free(note_msg);
 		}
 	}
-
+	check_or_regenerate_marks(startrev - 1);
 
 	if(dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
@@ -254,6 +315,10 @@ int main(int argc, const char **argv)
 	strbuf_addf(&buf, "refs/notes/%s/revs", remote->name);
 	notes_ref = strbuf_detach(&buf, NULL);
 
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/info/fast-import/marks/%s", get_git_dir(), remote->name);
+	marksfilename = strbuf_detach(&buf, NULL);
+
 	while(1) {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
@@ -270,5 +335,6 @@ int main(int argc, const char **argv)
 	free((void*)url);
 	free((void*)private_ref);
 	free((void*)notes_ref);
+	free((void*)marksfilename);
 	return 0;
 }
-- 
1.7.9.5
