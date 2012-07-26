From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 12/16] remote-svn: add incremental import.
Date: Thu, 26 Jul 2012 09:32:33 +0200
Message-ID: <1343287957-22040-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:35:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIbE-0005DO-37
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab2GZHev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:51 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab2GZHeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:46 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qYfqFlAaCUs4orP7TNxCjcF7TZRtScP4KCObujLNZV8=;
        b=0gdRodlbPEHKLn0wiGSN5HwMpTjXXT1cszc4WVaWM7ozkMXRWsAwudrfoNwRvFjWrk
         SNzvR2hNGhL6ONVRJQzQDPLjxooX0LlbFO8UKI3vuugksb2Tq5YgcWvFY4xsnN0IFXWT
         kStCR67OSBQpj4yAefTXLooy9pBmEVhQXUCIqtiSzgrcwrLAnG+uHXCa6wrnRtfMf7hL
         sXdlwdXeYgFvQJDzQN+VuDGUaEJaItV4EZGBDU66gkraJ19bjOUiKS8KXrhw1tH8BGTQ
         3qK6XJtmxEBC2Zm7knqdoEfLTovd+kfGXIhRKVckY6B7sZ91oWFbyBjPOy0tYNsJiswE
         3/0w==
Received: by 10.204.152.152 with SMTP id g24mr13132286bkw.104.1343288085986;
        Thu, 26 Jul 2012 00:34:45 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.44
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202244>

Search for a note attached to the ref to update and read it's
'Revision-number:'-line. Start import from the next svn revision.

If there is no next revision in the svn repo, svnrdump terminates
with a message on stderr an non-zero return value. This looks a
little weird, but there is no other way to know whether there is
a new revision in the svn repo.

On the start of an incremental import, the parent of the first commit
in the fast-import stream is set to the branch name to update. All
following commits specify their parent by a mark number. Previous
mark files are currently not reused.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   73 +++++++++++++++++++++++++++++++++++++++++--
 contrib/svn-fe/svn-fe.c     |    3 +-
 test-svn-fe.c               |    2 +-
 vcs-svn/fast_export.c       |   16 +++++++---
 vcs-svn/fast_export.h       |    6 ++--
 vcs-svn/svndump.c           |   12 +++----
 vcs-svn/svndump.h           |    2 +-
 7 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index 862b739..f23b82f 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "svndump.h"
+#include "notes.h"
 #include "argv-array.h"
 
 static int debug;
@@ -26,6 +27,8 @@ static const char *url;
 static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
+static const char *notes_ref;
+struct rev_note { unsigned int rev_nr; };
 
 /*
  * remote-helpers receive commands on their stdin. Command handler functions
@@ -56,13 +59,53 @@ enum cmd_result cmd_capabilities(struct strbuf *line)
 	return SUCCESS;
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
 enum cmd_result cmd_import(struct strbuf *line)
 {
 	static int batch_active;
 	int code, report_fd;
 	char *back_pipe_env;
 	int dumpin_fd;
-	unsigned int startrev = 0;
+	char *note_msg;
+	unsigned char head_sha1[20];
+	unsigned int startrev;
 	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
 	struct child_process svndump_proc;
 
@@ -106,6 +149,27 @@ enum cmd_result cmd_import(struct strbuf *line)
 	}
 	printd("Opened fast-import back-pipe %s for reading.", back_pipe_env);
 
+	if(read_ref(private_ref, head_sha1)) {
+		printd("New branch");
+		startrev = 0;
+	} else {
+		note_msg = read_ref_note(head_sha1);
+		if(note_msg == NULL) {
+			warning("No note found for %s.", private_ref);
+			startrev = 0;
+		}
+		else {
+			struct rev_note note = { 0 };
+			printd("Note found for %s", private_ref);
+			printd("Note:\n%s", note_msg);
+			parse_rev_note(note_msg, &note);
+			startrev = note.rev_nr + 1;
+			free(note_msg);
+		}
+	}
+
+	printd("starting import from revision %u", startrev);
+
 	if(dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
 		if(dumpin_fd < 0) {
@@ -130,7 +194,7 @@ enum cmd_result cmd_import(struct strbuf *line)
 
 
 	svndump_init_fd(dumpin_fd, report_fd);
-	svndump_read(url, private_ref);
+	svndump_read(url, private_ref, notes_ref);
 	svndump_deinit();
 	svndump_reset();
 
@@ -220,6 +284,10 @@ int main(int argc, const char **argv)
 	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
 	private_ref = strbuf_detach(&buf, NULL);
 
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "refs/notes/%s/revs", remote->name);
+	notes_ref = strbuf_detach(&buf, NULL);
+
 	while(1) {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
@@ -235,5 +303,6 @@ int main(int argc, const char **argv)
 	strbuf_release(&buf);
 	free((void*)url);
 	free((void*)private_ref);
+	free((void*)notes_ref);
 	return 0;
 }
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
diff --git a/test-svn-fe.c b/test-svn-fe.c
index bb0e980..2740570 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -40,7 +40,7 @@ int main(int argc, char *argv[])
 	if (argc == 2) {
 		if (svndump_init(argv[1]))
 			return 1;
-		svndump_read(NULL, "refs/remotes/svn/master");
+		svndump_read(NULL, "refs/remotes/svn/master", "refs/notes/svn/revs");
 		svndump_deinit();
 		svndump_reset();
 		return 0;
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 796dd1a..32f71a1 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -70,14 +70,20 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 }
 
 void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, unsigned long timestamp)
+		const char *log, unsigned long timestamp, const char *note_ref)
 {
+	static int firstnote = 1;
 	timestamp = 1341914616;
 	size_t loglen = strlen(log);
-	printf("commit refs/notes/svn/revs\n");
+	printf("commit %s\n", note_ref);
 	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local", timestamp);
 	printf("data %"PRIuMAX"\n", loglen);
 	fwrite(log, loglen, 1, stdout);
+	if (firstnote) {
+		if (revision > 1)
+			printf("from %s^0", note_ref);
+		firstnote = 0;
+	}
 	fputc('\n', stdout);
 }
 
@@ -90,7 +96,7 @@ static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log,
 			const char *uuid, const char *url,
-			unsigned long timestamp, const char *local_ref)
+			unsigned long timestamp, const char *local_ref, const char *parent)
 {
 	static const struct strbuf empty = STRBUF_INIT;
 	if (!log)
@@ -113,7 +119,9 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 	fwrite(log->buf, log->len, 1, stdout);
 	printf("%s\n", gitsvnline);
 	if (!first_commit_done) {
-		if (revision > 1)
+		if(parent)
+			printf("from %s^0\n", parent);
+		else if (revision > 1)
 			printf("from :%"PRIu32"\n", revision - 1);
 		first_commit_done = 1;
 	}
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index c2f6f11..5174aae 100644
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
+			unsigned long timestamp, const char *local_ref, const char *parent);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
 void fast_export_buf_to_data(const struct strbuf *data);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index f0633c6..b64802c 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -306,23 +306,23 @@ static void begin_revision(const char *remote_ref)
 		return;
 	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author.buf,
 		&rev_ctx.log, dump_ctx.uuid.buf, dump_ctx.url.buf,
-		rev_ctx.timestamp, remote_ref);
+		rev_ctx.timestamp, remote_ref, rev_ctx.revision == 1 ? NULL : remote_ref);
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
