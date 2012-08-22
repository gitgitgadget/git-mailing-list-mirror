From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 15/16] remote-svn: add marks-file regeneration
Date: Wed, 22 Aug 2012 21:16:00 +0200
Message-ID: <1345662961-9587-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:17:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQk-0002J7-Ru
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071Ab2HVTRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:17:16 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53740 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965060Ab2HVTQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:59 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so449687bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SK1lnRH7mMr4ETCTGVec4QzV7/oXsxJ4skceMLdfL3o=;
        b=fXMv6f4qsu7AVZfFhqBvsT28V1d9IGUL6FoTgIXU23q9Y3zS6eF9Z+pvJYKSz/od8C
         d3/zpHKqFRgsJFJhjCbwDJeZZp0K4v20JH6W69uRd8k5aPWV+GwEoHjey95IE19R1Mq8
         jlUVcQY3/JTcP3Cq2Vk/HFUUnWRI8vjUlovLuz0aEViltlXfJeIekpTVeSmoDXmQtXr9
         VcEY2b0CFLJdlrgFBkL2Vm8X2+9wnccprdrAZnzTSmSekPKHomj8dj9Fpxo5oEgnXLxB
         IBOfkH46JsXYNIXBJqFcDqucYIMUjoSkQds14ynM+mmTNrG8Mo4f5O468nvuIiuJTMV2
         PWtA==
Received: by 10.205.128.141 with SMTP id he13mr7137377bkc.112.1345663018446;
        Wed, 22 Aug 2012 12:16:58 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.56
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204079>

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
 remote-testsvn.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index e90d221..09dc304 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -86,6 +86,73 @@ static int parse_rev_note(const char *msg, struct rev_note *res) {
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
+static void regenerate_marks(void)
+{
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
+	if (!marksfile) {
+		regenerate_marks();
+		marksfile = fopen(marksfilename, "r");
+		if (!marksfile)
+			die_errno("cannot read marks file %s!", marksfilename);
+		fclose(marksfile);
+	} else {
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
@@ -111,6 +178,7 @@ static int cmd_import(const char *line)
 			free(note_msg);
 		}
 	}
+	check_or_regenerate_marks(startrev - 1);
 
 	if (dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
-- 
1.7.9.5
