From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 13/16] remote-svn: add incremental import
Date: Wed, 19 Sep 2012 17:21:27 +0200
Message-ID: <1348068090-31988-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM7h-0006Jl-W4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154Ab2ISPXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:23:06 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32832 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab2ISPW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:22:59 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so597401bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CB+YnLdjF1N1qPdaozsG6o3fvM6ti6xEFPzmRERh05I=;
        b=M3fsBj7/CDiqHvDG3LX0L25tHJiXmZcemtT59Lgege1hMOWyBjd4FCvGWM9UJE9Cyi
         dp1M+R5iR8pFvc6Maj8/7E60utGh4i86PK7XIqDdfRPK9+v1HpjJVxpGNBrAXrkcFNQa
         5sn1I2wCIMQI1aeu+yvFgPiiHS/VCT+ppcGlfl/bB7A6+U1ThcuItGGGyriNyNnTlkwh
         XJkOo7B6SX9v7X4jAkR4LHgbjNkRJxNhwoUkHiiADVl+brgmxtP7K47mCk+cEM6aXr7J
         pcCDuAHg3ODSkOjj91VoKbCOwCQ67QhUS4F9wcsQYtjR25C73goYI7NHmweRAY4LUsrS
         mDFQ==
Received: by 10.204.132.80 with SMTP id a16mr1465516bkt.82.1348068178633;
        Wed, 19 Sep 2012 08:22:58 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.56
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205942>

Search for a note attached to the ref to update and read it's
'Revision-number:'-line. Start import from the next svn revision.

If there is no next revision in the svn repo, svnrdump terminates with
a message on stderr an non-zero return value. This looks a little
weird, but there is no other way to know whether there is a new
revision in the svn repo.

On the start of an incremental import, the parent of the first commit
in the fast-import stream is set to the branch name to update. All
following commits specify their parent by a mark number. Previous mark
files are currently not reused.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff:
- style
- improve error detection while reading notes
- strtol instead of atol
- seperate strbufs in main

 contrib/svn-fe/svn-fe.c |    3 +-
 remote-testsvn.c        |   79 ++++++++++++++++++++++++++++++++++++++++++++---
 test-svn-fe.c           |    2 +-
 vcs-svn/fast_export.c   |   10 ++++--
 vcs-svn/fast_export.h   |    6 ++--
 vcs-svn/svndump.c       |   10 +++---
 vcs-svn/svndump.h       |    2 +-
 7 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index c796cc0..f363505 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -10,7 +10,8 @@ int main(int argc, char **argv)
 {
 	if (svndump_init(NULL))
 		return 1;
-	svndump_read((argc > 1) ? argv[1] : NULL, "refs/heads/master");
+	svndump_read((argc > 1) ? argv[1] : NULL, "refs/heads/master",
+			"refs/notes/svn/revs");
 	svndump_deinit();
 	svndump_reset();
 	return 0;
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 45eba9f..b741f6d 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -12,7 +12,8 @@ static const char *url;
 static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
-static const char *marksfilename;
+static const char *marksfilename, *notes_ref;
+struct rev_note { unsigned int rev_nr; };
 
 static int cmd_capabilities(const char *line);
 static int cmd_import(const char *line);
@@ -48,14 +49,79 @@ static void terminate_batch(void)
 	fflush(stdout);
 }
 
+/* NOTE: 'ref' refers to a git reference, while 'rev' refers to a svn revision. */
+static char *read_ref_note(const unsigned char sha1[20])
+{
+	const unsigned char *note_sha1;
+	char *msg = NULL;
+	unsigned long msglen;
+	enum object_type type;
+
+	init_notes(NULL, notes_ref, NULL, 0);
+	if (!(note_sha1 = get_note(NULL, sha1)))
+		return NULL;	/* note tree not found */
+	if (!(msg = read_sha1_file(note_sha1, &type, &msglen)))
+		error("Empty notes tree. %s", notes_ref);
+	else if (!msglen || type != OBJ_BLOB) {
+		error("Note contains unusable content. "
+			"Is something else using this notes tree? %s", notes_ref);
+		free(msg);
+		msg = NULL;
+	}
+	free_notes(NULL);
+	return msg;
+}
+
+static int parse_rev_note(const char *msg, struct rev_note *res)
+{
+	const char *key, *value, *end;
+	size_t len;
+
+	while (*msg) {
+		end = strchr(msg, '\n');
+		len = end ? end - msg : strlen(msg);
+
+		key = "Revision-number: ";
+		if (!prefixcmp(msg, key)) {
+			long i;
+			char *end;
+			value = msg + strlen(key);
+			i = strtol(value, &end, 0);
+			if (end == value || i < 0 || i > UINT32_MAX)
+				return -1;
+			res->rev_nr = i;
+		}
+		msg += len + 1;
+	}
+	return 0;
+}
+
 static int cmd_import(const char *line)
 {
 	int code;
 	int dumpin_fd;
-	unsigned int startrev = 0;
+	char *note_msg;
+	unsigned char head_sha1[20];
+	unsigned int startrev;
 	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
 	struct child_process svndump_proc;
 
+	if (read_ref(private_ref, head_sha1))
+		startrev = 0;
+	else {
+		note_msg = read_ref_note(head_sha1);
+		if(note_msg == NULL) {
+			warning("No note found for %s.", private_ref);
+			startrev = 0;
+		} else {
+			struct rev_note note = { 0 };
+			if (parse_rev_note(note_msg, &note))
+				die("Revision number couldn't be parsed from note.");
+			startrev = note.rev_nr + 1;
+			free(note_msg);
+		}
+	}
+
 	if (dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
 		if(dumpin_fd < 0)
@@ -79,7 +145,7 @@ static int cmd_import(const char *line)
 			"feature export-marks=%s\n", marksfilename, marksfilename);
 
 	svndump_init_fd(dumpin_fd, STDIN_FILENO);
-	svndump_read(url, private_ref);
+	svndump_read(url, private_ref, notes_ref);
 	svndump_deinit();
 	svndump_reset();
 
@@ -150,7 +216,8 @@ static int do_command(struct strbuf *line)
 int main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT, url_sb = STRBUF_INIT,
-			private_ref_sb = STRBUF_INIT, marksfilename_sb = STRBUF_INIT;
+			private_ref_sb = STRBUF_INIT, marksfilename_sb = STRBUF_INIT,
+			notes_ref_sb = STRBUF_INIT;
 	static struct remote *remote;
 	const char *url_in;
 
@@ -176,6 +243,9 @@ int main(int argc, const char **argv)
 	strbuf_addf(&private_ref_sb, "refs/svn/%s/master", remote->name);
 	private_ref = private_ref_sb.buf;
 
+	strbuf_addf(&notes_ref_sb, "refs/notes/%s/revs", remote->name);
+	notes_ref = notes_ref_sb.buf;
+
 	strbuf_addf(&marksfilename_sb, "%s/info/fast-import/remote-svn/%s.marks",
 		get_git_dir(), remote->name);
 	marksfilename = marksfilename_sb.buf;
@@ -195,6 +265,7 @@ int main(int argc, const char **argv)
 	strbuf_release(&buf);
 	strbuf_release(&url_sb);
 	strbuf_release(&private_ref_sb);
+	strbuf_release(&notes_ref_sb);
 	strbuf_release(&marksfilename_sb);
 	return 0;
 }
diff --git a/test-svn-fe.c b/test-svn-fe.c
index cb0d80f..0f2d9a4 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -40,7 +40,7 @@ int main(int argc, char *argv[])
 	if (argc == 2) {
 		if (svndump_init(argv[1]))
 			return 1;
-		svndump_read(NULL, "refs/heads/master");
+		svndump_read(NULL, "refs/heads/master", "refs/notes/svn/revs");
 		svndump_deinit();
 		svndump_reset();
 		return 0;
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index df51c59..f2b23c8 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -68,13 +68,19 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 }
 
 void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, unsigned long timestamp)
+		const char *log, unsigned long timestamp, const char *note_ref)
 {
+	static int firstnote = 1;
 	size_t loglen = strlen(log);
-	printf("commit refs/notes/svn/revs\n");
+	printf("commit %s\n", note_ref);
 	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local", timestamp);
 	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
 	fwrite(log, loglen, 1, stdout);
+	if (firstnote) {
+		if (revision > 1)
+			printf("from %s^0", note_ref);
+		firstnote = 0;
+	}
 	fputc('\n', stdout);
 }
 
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index c2f6f11..c8b5adb 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -11,10 +11,10 @@ void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
 void fast_export_note(const char *committish, const char *dataref);
 void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, unsigned long timestamp);
+		const char *log, unsigned long timestamp, const char *note_ref);
 void fast_export_begin_commit(uint32_t revision, const char *author,
-			const struct strbuf *log, const char *uuid,
-			const char *url, unsigned long timestamp, const char *local_ref);
+			const struct strbuf *log, const char *uuid,const char *url,
+			unsigned long timestamp, const char *local_ref);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
 void fast_export_buf_to_data(const struct strbuf *data);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 7ec1a5b..31d1d83 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -309,20 +309,20 @@ static void begin_revision(const char *remote_ref)
 		rev_ctx.timestamp, remote_ref);
 }
 
-static void end_revision(void)
+static void end_revision(const char *note_ref)
 {
 	struct strbuf mark = STRBUF_INIT;
 	if (rev_ctx.revision) {
 		fast_export_end_commit(rev_ctx.revision);
 		fast_export_begin_note(rev_ctx.revision, "remote-svn",
-				"Note created by remote-svn.", rev_ctx.timestamp);
+				"Note created by remote-svn.", rev_ctx.timestamp, note_ref);
 		strbuf_addf(&mark, ":%"PRIu32, rev_ctx.revision);
 		fast_export_note(mark.buf, "inline");
 		fast_export_buf_to_data(&rev_ctx.note);
 	}
 }
 
-void svndump_read(const char *url, const char *local_ref)
+void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 {
 	char *val;
 	char *t;
@@ -363,7 +363,7 @@ void svndump_read(const char *url, const char *local_ref)
 			if (active_ctx == REV_CTX)
 				begin_revision(local_ref);
 			if (active_ctx != DUMP_CTX)
-				end_revision();
+				end_revision(notes_ref);
 			active_ctx = REV_CTX;
 			reset_rev_ctx(atoi(val));
 			strbuf_addf(&rev_ctx.note, "%s\n", t);
@@ -479,7 +479,7 @@ void svndump_read(const char *url, const char *local_ref)
 	if (active_ctx == REV_CTX)
 		begin_revision(local_ref);
 	if (active_ctx != DUMP_CTX)
-		end_revision();
+		end_revision(notes_ref);
 }
 
 static void init(int report_fd)
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index febeecb..b8eb129 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -3,7 +3,7 @@
 
 int svndump_init(const char *filename);
 int svndump_init_fd(int in_fd, int back_fd);
-void svndump_read(const char *url, const char *local_ref);
+void svndump_read(const char *url, const char *local_ref, const char *notes_ref);
 void svndump_deinit(void);
 void svndump_reset(void);
 
-- 
1.7.9.5
