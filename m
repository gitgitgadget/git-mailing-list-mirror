From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 15/16] remote-svn: add marks-file regeneration.
Date: Thu, 26 Jul 2012 09:32:36 +0200
Message-ID: <1343287957-22040-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIbF-0005DO-PT
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab2GZHe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab2GZHey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aT2mNhzBF+9PyAA4eWiLNaAwxXdNMjZRc83AG9fUsWg=;
        b=W6xwucpDDjieK5ACdbaOTVY+7kvrjNtaE8mI2n0owI+X/Kd6AQx2/UVrwvrOo0LzDL
         ihD5NLTFIDq45VWf3c3BgTmM2TCuSulDJ4zI/d7fb9LMsBxKsXg0z67WIcYHEs3mRU+0
         TwEw64XlPvUve+8crw35XY3Cncl1wKod9R9QTxqsUzmDugMln4k71e3vY87xbK5O8tFk
         pfhbput9DTSOlsnlluEBsXgJZCbIDZB+f2HzRrfUw2toTOLTPC5vwgYnwkjDvsxWikFG
         nv1zbVZINYDWsf7/6R/Vs4MNmJ6OewIjR01bY6uPLmpyATfe6sn2zLMCg3UvmKhycmxq
         1Dnw==
Received: by 10.204.152.152 with SMTP id g24mr13132388bkw.104.1343288093786;
        Thu, 26 Jul 2012 00:34:53 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.52
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202242>

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
 contrib/svn-fe/remote-svn.c |   78 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index f23b82f..054433b 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
@@ -27,7 +27,7 @@ static const char *url;
 static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
-static const char *notes_ref;
+static const char *notes_ref, *marksfilename;
 struct rev_note { unsigned int rev_nr; };
 
 /*
@@ -97,6 +97,75 @@ static int parse_rev_note(const char *msg, struct rev_note *res) {
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
+	printd("checking marks file %s.", marksfilename);
+	init_notes(NULL, notes_ref, NULL, 0);
+	marksfile = fopen(marksfilename, "r");
+	if (!marksfile) {
+		printd("no marks found, regenerate.");
+		regenerate_marks(marksfile);
+	}
+	else {
+		strbuf_addf(&sb, ":%d ", latestrev);
+		while (getline(&line, &linelen, marksfile) != -1) {
+			if (!prefixcmp(line, sb.buf)) {
+				found++;
+				break;
+			}
+		}
+		fclose(marksfile);
+		if (!found) {
+			printd("marks found but doesn't contain highest rev, regenerate.");
+			regenerate_marks();
+		}
+		else
+			printd("marks found and ok.");
+	}
+	free_notes(NULL);
+	strbuf_release(&sb);
+}
+
 enum cmd_result cmd_import(struct strbuf *line)
 {
 	static int batch_active;
@@ -168,6 +237,8 @@ enum cmd_result cmd_import(struct strbuf *line)
 		}
 	}
 
+	check_or_regenerate_marks(startrev - 1);
+
 	printd("starting import from revision %u", startrev);
 
 	if(dump_from_file) {
@@ -288,6 +359,10 @@ int main(int argc, const char **argv)
 	strbuf_addf(&buf, "refs/notes/%s/revs", remote->name);
 	notes_ref = strbuf_detach(&buf, NULL);
 
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/info/fast-import/marks/%s", get_git_dir(), remote->name);
+	marksfilename = strbuf_detach(&buf, NULL);
+
 	while(1) {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
@@ -304,5 +379,6 @@ int main(int argc, const char **argv)
 	free((void*)url);
 	free((void*)private_ref);
 	free((void*)notes_ref);
+	free((void*)marksfilename);
 	return 0;
 }
-- 
1.7.9.5
