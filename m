From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 05/16] remote-svn, vcs-svn: Enable fetching to private refs.
Date: Thu, 26 Jul 2012 09:32:26 +0200
Message-ID: <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:34:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIan-0004t5-Su
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab2GZHec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab2GZHea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:30 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6zPmhssX7ZQc19V3ZFJhY7LZ2x5YxzYuz02A8vinnQw=;
        b=UN1fe/UVxlpsoHk7hBBrpDH299OakKpqxahlDlm7Kz6m4q00rE5AH/cr1ZUjrOSxRR
         TSJ6dJ9UN3OpJE6rBbBHSC65QCFjzBp9pY88BNM7TFhnztgOyt06JM6xSrwjxKmMul3P
         ncTBjQE3d+mGq0pANXTkkOn3QRG1/H8z4y79h2tGiO0l8RzAkNw5hNNmDG+MrxTJtFHL
         qTW6QYtz1mnmojVWBxzKj+03BoZeUOJCH20Aj/Qn+ylv8oe6Cd50tvuggDG90ip5YTo8
         Vy+eHmWSv5r3hF9RnEUjJvIKDYKMXEXj40ffKIV20vDJz71g8jJ3BRM1XMAwTMpg69di
         a/Cw==
Received: by 10.204.149.86 with SMTP id s22mr3816674bkv.1.1343288069372;
        Thu, 26 Jul 2012 00:34:29 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.27
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202235>

The reference to update by the fast-import stream is hard-coded.
When fetching from a remote the remote-helper shall update refs
in a private namespace, i.e. a private subdir of refs/.
This namespace is defined by the 'refspec' capability, that the
remote-helper advertises as a reply to the 'capablilities' command.

Extend svndump and fast-export to allow passing the target ref.
Update svn-fe to be compatible.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
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
index 83633a2..bb0e980 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -40,7 +40,7 @@ int main(int argc, char *argv[])
 	if (argc == 2) {
 		if (svndump_init(argv[1]))
 			return 1;
-		svndump_read(NULL);
+		svndump_read(NULL, "refs/remotes/svn/master");
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
index 76b42b2..c0d5931 100644
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
