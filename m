From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 15/16] remote-svn: add marks-file regeneration
Date: Wed, 19 Sep 2012 17:21:29 +0200
Message-ID: <1348068090-31988-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:23:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM7j-0006Jl-0t
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab2ISPXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:23:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32832 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab2ISPXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:23:03 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so597401bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q7kYKlBCRlO2e4YwNneJUK2iQdBi+I1/p5X7erg70S4=;
        b=BOZE+tWpeMoGrr3yDS4B0BYmOkMLPpPRUhIljKUsB7OJpqDZBSQ614UOJohnds7REx
         WFFFBsY+avsUncc0WhVFtTAkXY21sX4/UjioHJkAgnHLFFM6w86eJE19fP4sTrDnonBK
         Cmr7OUPO630Puo00gw5VqxKYVTiCX13YlSJB2Sfd4yd6Ptzh47xH0bxno0X2nn89Tb6Y
         FSVgZQ7igMU0a1ZrHP2VvXvtrPS/4V2KM3JPzSLA0AH5vxQiX3gdLFKzcl9SZqM5uZDW
         p41AYds7kSyhDifqpUX44NqvZJsHYGl2siBQMQDRUBpfRGAiNHgyW3DcHMavfTi6ovFn
         ijGw==
Received: by 10.204.132.80 with SMTP id a16mr1465660bkt.82.1348068183047;
        Wed, 19 Sep 2012 08:23:03 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.23.00
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:23:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205941>

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
diff:
- style
 remote-testsvn.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index b741f6d..51fba05 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -96,6 +96,76 @@ static int parse_rev_note(const char *msg, struct rev_note *res)
 	return 0;
 }
 
+static int note2mark_cb(const unsigned char *object_sha1,
+		const unsigned char *note_sha1, char *note_path,
+		void *cb_data)
+{
+	FILE *file = (FILE *)cb_data;
+	char *msg;
+	unsigned long msglen;
+	enum object_type type;
+	struct rev_note note;
+
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
+static void regenerate_marks(void)
+{
+	int ret;
+	FILE *marksfile = fopen(marksfilename, "w+");
+
+	if (!marksfile)
+		die_errno("Couldn't create mark file %s.", marksfilename);
+	ret = for_each_note(NULL, 0, note2mark_cb, marksfile);
+	if (ret)
+		die("Regeneration of marks failed, returned %d.", ret);
+	fclose(marksfile);
+}
+
+static void check_or_regenerate_marks(int latestrev)
+{
+	FILE *marksfile;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf line = STRBUF_INIT;
+	int found = 0;
+
+	if (latestrev < 1)
+		return;
+
+	init_notes(NULL, notes_ref, NULL, 0);
+	marksfile = fopen(marksfilename, "r");
+	if (!marksfile) {
+		regenerate_marks();
+		marksfile = fopen(marksfilename, "r");
+		if (!marksfile)
+			die_errno("cannot read marks file %s!", marksfilename);
+		fclose(marksfile);
+	} else {
+		strbuf_addf(&sb, ":%d ", latestrev);
+		while (strbuf_getline(&line, marksfile, '\n') != EOF) {
+			if (!prefixcmp(line.buf, sb.buf)) {
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
+	strbuf_release(&line);
+}
+
 static int cmd_import(const char *line)
 {
 	int code;
@@ -121,6 +191,7 @@ static int cmd_import(const char *line)
 			free(note_msg);
 		}
 	}
+	check_or_regenerate_marks(startrev - 1);
 
 	if (dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
-- 
1.7.9.5
