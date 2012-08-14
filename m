From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 06/16] remote-svn, vcs-svn: Enable fetching to private refs.
Date: Tue, 14 Aug 2012 21:13:08 +0200
Message-ID: <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1McB-0003IV-7H
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587Ab2HNTRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161Ab2HNTRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:11 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RJ5JZ6sicreX8Eg7zeIzX31aC2xZZgGKOJcjuAMzFQs=;
        b=hg2oYlbunbCN9G0gLjLW0Y/uFwR6yplxZHKJ53cegTxp6Q0zBYE8lzs/7uHd6n4p/V
         LQYytKWkgMhxLV/XtfYFts2Aaz7zFFXjiUK5zql4OObzScDmjgUUw5EQfIUfTPI6Q9+W
         4DnedplrqTKu09ytY543yvOM9Wva5nzzUXVDUKXN3hlqKGC7GV9/r1GFF44nPnH2c4DJ
         C9m//l4Fa7hjMj+6K76eTw5vZzIBhuqduIRqJ+7eFLWMCCdoDf7KT3/yQQzri5V3tGLl
         q7UCg3PVSfqO7jXm3smuNKjX7IVnoTUX2BNA/g7OaK6iHFeRS+PSTCKMKkNzTpbRjgvU
         Tq2Q==
Received: by 10.205.125.4 with SMTP id gq4mr6683562bkc.109.1344971830948;
        Tue, 14 Aug 2012 12:17:10 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.06
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203428>

The reference to update by the fast-import stream is hard-coded.
When fetching from a remote the remote-helper shall update refs
in a private namespace, i.e. a private subdir of refs/.
This namespace is defined by the 'refspec' capability, that the
remote-helper advertises as a reply to the 'capablilities' command.

Extend svndump and fast-export to allow passing the target ref.
Update svn-fe to be compatible.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
- fix hard-coded ref in test-svn-fe.c. Broke a testcase.

 contrib/svn-fe/svn-fe.c |    2 +-
 test-svn-fe.c           |    2 +-
 vcs-svn/fast_export.c   |    4 ++--
 vcs-svn/fast_export.h   |    2 +-
 vcs-svn/svndump.c       |   14 +++++++-------
 vcs-svn/svndump.h       |    2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 35db24f..c796cc0 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -10,7 +10,7 @@ int main(int argc, char **argv)
 {
 	if (svndump_init(NULL))
 		return 1;
-	svndump_read((argc > 1) ? argv[1] : NULL);
+	svndump_read((argc > 1) ? argv[1] : NULL, "refs/heads/master");
 	svndump_deinit();
 	svndump_reset();
 	return 0;
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 83633a2..cb0d80f 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -40,7 +40,7 @@ int main(int argc, char *argv[])
 	if (argc == 2) {
 		if (svndump_init(argv[1]))
 			return 1;
-		svndump_read(NULL);
+		svndump_read(NULL, "refs/heads/master");
 		svndump_deinit();
 		svndump_reset();
 		return 0;
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 1f04697..11f8f94 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -72,7 +72,7 @@ static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log,
 			const char *uuid, const char *url,
-			unsigned long timestamp)
+			unsigned long timestamp, const char *local_ref)
 {
 	static const struct strbuf empty = STRBUF_INIT;
 	if (!log)
@@ -84,7 +84,7 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 	} else {
 		*gitsvnline = '\0';
 	}
-	printf("commit refs/heads/master\n");
+	printf("commit %s\n", local_ref);
 	printf("mark :%"PRIu32"\n", revision);
 	printf("committer %s <%s@%s> %ld +0000\n",
 		   *author ? author : "nobody",
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 8823aca..17eb13b 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -11,7 +11,7 @@ void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,
-			const char *url, unsigned long timestamp);
+			const char *url, unsigned long timestamp, const char *local_ref);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
 void fast_export_blob_delta(uint32_t mode,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index d81a078..288bb42 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -299,22 +299,22 @@ static void handle_node(void)
 				node_ctx.text_length, &input);
 }
 
-static void begin_revision(void)
+static void begin_revision(const char *remote_ref)
 {
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
 	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author.buf,
 		&rev_ctx.log, dump_ctx.uuid.buf, dump_ctx.url.buf,
-		rev_ctx.timestamp);
+		rev_ctx.timestamp, remote_ref);
 }
 
-static void end_revision(void)
+static void end_revision()
 {
 	if (rev_ctx.revision)
 		fast_export_end_commit(rev_ctx.revision);
 }
 
-void svndump_read(const char *url)
+void svndump_read(const char *url, const char *local_ref)
 {
 	char *val;
 	char *t;
@@ -353,7 +353,7 @@ void svndump_read(const char *url)
 			if (active_ctx == NODE_CTX)
 				handle_node();
 			if (active_ctx == REV_CTX)
-				begin_revision();
+				begin_revision(local_ref);
 			if (active_ctx != DUMP_CTX)
 				end_revision();
 			active_ctx = REV_CTX;
@@ -366,7 +366,7 @@ void svndump_read(const char *url)
 				if (active_ctx == NODE_CTX)
 					handle_node();
 				if (active_ctx == REV_CTX)
-					begin_revision();
+					begin_revision(local_ref);
 				active_ctx = NODE_CTX;
 				reset_node_ctx(val);
 				break;
@@ -463,7 +463,7 @@ void svndump_read(const char *url)
 	if (active_ctx == NODE_CTX)
 		handle_node();
 	if (active_ctx == REV_CTX)
-		begin_revision();
+		begin_revision(local_ref);
 	if (active_ctx != DUMP_CTX)
 		end_revision();
 }
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index acb5b47..febeecb 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -3,7 +3,7 @@
 
 int svndump_init(const char *filename);
 int svndump_init_fd(int in_fd, int back_fd);
-void svndump_read(const char *url);
+void svndump_read(const char *url, const char *local_ref);
 void svndump_deinit(void);
 void svndump_reset(void);
 
-- 
1.7.9.5
