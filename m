From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 13/16] remote-svn: add incremental import
Date: Mon, 20 Aug 2012 23:52:19 +0200
Message-ID: <1345499542-15536-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
	id 1T3Zux-0008V9-Gv
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab2HTVxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:39 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64082 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947Ab2HTVxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:30 -0400
Received: by wicr5 with SMTP id r5so4068327wic.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=e/UoMC1WTmNoG3Gx+CiepNxaMxl+yfeyzmQhktDdvAI=;
        b=0dViHauAKqEHpqhKqzdJXgwuijlE+AMsI4FwxYOxX6jvxblsksoytYCy2RihpcNWKo
         CP78+FAD5kg2GTXcNts8ZET/sfrnrLt0RDBpbDYRYESfKPcmhK5Mp9PIZ6rFYVv8z3a0
         wFt8WBiZ5buXyQmpoYpXtq30rxh+d7gPGnOOm8odFlzTcpGTmCv/Tykqj78EaN4DhDSY
         GiWnhDGRhOvgUjGeMR9xkCtwP7yF5y3OrBAuvMAfxI3RlJ40zSn8n3CDsIa9ZMiVBOFs
         s28KYDQfzteiHPt6JAeQGv8V9sA2jx/nrhOtTpLdfDOPHaxpdmksXa0MGu/p+VPHnsTm
         2Cxw==
Received: by 10.180.103.136 with SMTP id fw8mr32307394wib.20.1345499608405;
        Mon, 20 Aug 2012 14:53:28 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.26
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203887>

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
 contrib/svn-fe/svn-fe.c |    3 ++-
 remote-testsvn.c        |   67 ++++++++++++++++++++++++++++++++++++++++++++---
 test-svn-fe.c           |    2 +-
 vcs-svn/fast_export.c   |   10 +++++--
 vcs-svn/fast_export.h   |    6 ++---
 vcs-svn/svndump.c       |   10 +++----
 vcs-svn/svndump.h       |    2 +-
 7 files changed, 84 insertions(+), 16 deletions(-)

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
index b6e7968..e90d221 100644
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
@@ -47,14 +48,70 @@ static void terminate_batch(void)
 	fflush(stdout);
 }
 
+/* NOTE: 'ref' refers to a git reference, while 'rev' refers to a svn revision. */
+static char *read_ref_note(const unsigned char sha1[20]) {
+	const unsigned char *note_sha1;
+	char *msg = NULL;
+	unsigned long msglen;
+	enum object_type type;
+	init_notes(NULL, notes_ref, NULL, 0);
+	if(	(note_sha1 = get_note(NULL, sha1)) == NULL ||
+			!(msg = read_sha1_file(note_sha1, &type, &msglen)) ||
+			!msglen || type != OBJ_BLOB) {
+		free(msg);
+		return NULL;
+	}
+	free_notes(NULL);
+	return msg;
+}
+
+static int parse_rev_note(const char *msg, struct rev_note *res) {
+	const char *key, *value, *end;
+	size_t len;
+	while(*msg) {
+		end = strchr(msg, '\n');
+		len = end ? end - msg : strlen(msg);
+
+		key = "Revision-number: ";
+		if(!prefixcmp(msg, key)) {
+			long i;
+			value = msg + strlen(key);
+			i = atol(value);
+			if(i < 0 || i > UINT32_MAX)
+				return 1;
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
 
+	if(read_ref(private_ref, head_sha1))
+		startrev = 0;
+	else {
+		note_msg = read_ref_note(head_sha1);
+		if(note_msg == NULL) {
+			warning("No note found for %s.", private_ref);
+			startrev = 0;
+		}
+		else {
+			struct rev_note note = { 0 };
+			parse_rev_note(note_msg, &note);
+			startrev = note.rev_nr + 1;
+			free(note_msg);
+		}
+	}
+
 	if (dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
 		if(dumpin_fd < 0) {
@@ -80,7 +137,7 @@ static int cmd_import(const char *line)
 			"feature export-marks=%s\n", marksfilename, marksfilename);
 
 	svndump_init_fd(dumpin_fd, STDIN_FILENO);
-	svndump_read(url, private_ref);
+	svndump_read(url, private_ref, notes_ref);
 	svndump_deinit();
 	svndump_reset();
 
@@ -177,6 +234,9 @@ int main(int argc, const char **argv)
 	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
 	private_ref = strbuf_detach(&buf, NULL);
 
+	strbuf_addf(&buf, "refs/notes/%s/revs", remote->name);
+	notes_ref = strbuf_detach(&buf, NULL);
+
 	strbuf_addf(&buf, "%s/info/fast-import/remote-svn/%s.marks",
 		get_git_dir(), remote->name);
 	marksfilename = strbuf_detach(&buf, NULL);
@@ -196,6 +256,7 @@ int main(int argc, const char **argv)
 	strbuf_release(&buf);
 	free((void*)url);
 	free((void*)private_ref);
+	free((void*)notes_ref);
 	free((void*)marksfilename);
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
index cd65b51..31d1d83 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -309,20 +309,20 @@ static void begin_revision(const char *remote_ref)
 		rev_ctx.timestamp, remote_ref);
 }
 
-static void end_revision()
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
