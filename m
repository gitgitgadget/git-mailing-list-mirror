From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 15/16] remote-svn: add marks-file regeneration
Date: Mon, 20 Aug 2012 23:52:21 +0200
Message-ID: <1345499542-15536-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Zuy-0008V9-R9
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab2HTVxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:48 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63386 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab2HTVxc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:32 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so4065368wib.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fhRRAditqWK0ipf2k9odP3tmjka6OEsbKcSeLy+KyoY=;
        b=gcUobvZLmVDFT9OgKSxpih78/IbbTiFrQ/ju6rPH3sUe+w/GC3VvMe+oe8bkAHweEK
         4xM5XV144m99VsxpNA+TBMYgTGPqMWzNZVwZUFJC/IM0vKcTi6LZts/YmdEBDUVGP6QT
         y7TGMOk5Q3Qp29nkgIkmj6FtDjyDcHx+JGn/hfJ3Ixi60dHYn8IlNrk/sWyVp6QxhGqR
         0xEiKFqMUpowr4uKRblJpDwrdo2wdiW89n4RHBVn1DtLHimp0VohI84Vsghv2MMS7zX4
         U8P8+V1a8LjR3K9l2X/l9whOsFavglztuJsQBh5NY3YpOQmF3jb0x67s9c5Tk4naCmo/
         PWNw==
Received: by 10.180.75.209 with SMTP id e17mr37543332wiw.0.1345499612015;
        Mon, 20 Aug 2012 14:53:32 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.30
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203890>

fast-import mark files are stored outside the object database and are
therefore not fetched and can be lost somehow else.  marks provide a
svn revision --> git sha1 mapping, while the notes that are attached
to each commit when it is imported provide a git sha1 --> svn revision
mapping.

If the marks file is not available or not plausible, regenerate it by
walking through the notes tree.  , i.e.  The plausibility check tests
if the highest revision in the marks file matches the revision of the
top ref. It doesn't ensure that the mark file is completely correct.
This could only be done with an effort equal to unconditional
regeneration.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-testsvn.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index e90d221..2c0dc99 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -86,6 +86,68 @@ static int parse_rev_note(const char *msg, struct rev_note *res) {
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
@@ -111,6 +173,7 @@ static int cmd_import(const char *line)
 			free(note_msg);
 		}
 	}
+	check_or_regenerate_marks(startrev - 1);
 
 	if (dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
-- 
1.7.9.5
