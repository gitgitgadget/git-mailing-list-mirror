From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 15/16] remote-svn: add marks-file regeneration.
Date: Fri, 17 Aug 2012 22:25:56 +0200
Message-ID: <1345235157-702-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T9X-0007Ci-70
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421Ab2HQU1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:27:46 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33589 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758905Ab2HQU1N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:27:13 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3663336wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R0Zt8PZ95WrrO4AG5ad1mNdt0qUvdcD0kdavGEsgSAU=;
        b=NJPw9XwflJzdTVK/XvztH/N0LgHJwFWyX4XUt1YNOtbpO3UOaF6/ZhvSjlWMmfWBIt
         YRrZGUkOlJLSAEaF6uCjWdomkLE03PlB5hqyfzRRQ6onlnn1H6/PT/6oPeLS1wIUUZ/I
         jSXXuEyKYXljfg36lUaGGv0VYh0cz0AlZtULFwriNAb3PlJgNC+88W3xymuzLcYPkBI3
         y3M4AdbHJSgEUVsVTTXHUOeiiKcB3dvQTBa0RTOQivVWvY0luC5kgdEOsiAQ7UBXTXi8
         pjZjEiFHGNXHYNNQ/6Y1KjAhDX0T5SUFPc5n5SpPbdIkQ12Rq0rq3nAxbyIvw56g01zV
         XKgw==
Received: by 10.180.14.8 with SMTP id l8mr7797403wic.6.1345235232537;
        Fri, 17 Aug 2012 13:27:12 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.27.10
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:27:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203657>

fast-import mark files are stored outside the object database and are therefore
not fetched and can be lost somehow else.
marks provide a svn revision --> git sha1 mapping, while the notes that are attached
to each commit when it is imported provide a git sha1 --> svn revision mapping.

If the marks file is not available or not plausible, regenerate it by walking through
the notes tree.
, i.e.
The plausibility check tests if the highest revision in the marks file matches the
revision of the top ref. It doesn't ensure that the mark file is completely correct.
This could only be done with an effort equal to unconditional regeneration.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   63 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index b385682..d34ef2f 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
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
