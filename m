From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 06/11] vcs-svn: move commit parameters logic to svndump.c
Date: Wed, 13 Jul 2011 18:21:08 +0600
Message-ID: <1310559673-5026-7-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyRf-0004ak-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab1GMMV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:21:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab1GMMVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:21:02 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5lgZDUZQSR4C3jVlO7exF3xuQqpOaLWTs2Dn6G+pcyc=;
        b=IJik1lgFEmIgtAGVV898KxG3v85hiu7Al25eHPvCBXMPjeebkLFKOhJ6N/vmeyMwHJ
         kpfDX839lsX2oc8zyutmqJLcog7JunUOlrV1Nhl51wll5Ts5xoA1ckXioRsMzj/aS/Tu
         UE5PaM63LGSlbpcJQhmjNoZK4JNqqbH6AyOdc=
Received: by 10.205.64.135 with SMTP id xi7mr450911bkb.354.1310559662134;
        Wed, 13 Jul 2011 05:21:02 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.21.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:21:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177035>

fast_export.c had logic to set up commit ref, author name, email,
parent commit, import mark and git-svn-id: line based on both it's
own state (current import batch history) and the arguments passed.

Lift the decision on these parameters to the caller. This way it is
easier to customize them. Move progress lines generation to the caller
for the same reason.

Now fast_export doesn't have any internal state except the files set
up in fast_export_init, so it doesn't rely on being passed commits
sequentially and to one and the same branch. It operates just on a
current commit. Which makes it possible to generate an incremental
stream (if stream's first commit parent is set up properly by the
caller) or maybe to generate a stream for multiple svn branches.

Also progress lines generation is lifted up to svndump.o. So further
progress indication enhancements won't need to change fast_export.o
api.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 vcs-svn/fast_export.c |   44 ++++++++++++++------------------------------
 vcs-svn/fast_export.h |    8 +++++---
 vcs-svn/svndump.c     |   30 ++++++++++++++++++++++++++----
 3 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 19d7c34..04001b8 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -13,9 +13,6 @@
 #include "sliding_window.h"
 #include "line_buffer.h"
 
-#define MAX_GITSVN_LINE_LEN 4096
-
-static uint32_t first_commit_done;
 static struct line_buffer postimage = LINE_BUFFER_INIT;
 static struct line_buffer report_buffer = LINE_BUFFER_INIT;
 
@@ -31,7 +28,6 @@ static int init_postimage(void)
 
 void fast_export_init(int fd)
 {
-	first_commit_done = 0;
 	if (buffer_fdinit(&report_buffer, fd))
 		die_errno("cannot read from file descriptor %d", fd);
 }
@@ -73,42 +69,30 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
-static char gitsvnline[MAX_GITSVN_LINE_LEN];
-void fast_export_begin_commit(uint32_t revision, const char *author,
-			const struct strbuf *log,
-			const char *uuid, const char *url,
-			unsigned long timestamp)
+void fast_export_begin_commit(uint32_t set_mark, const char *committer_name,
+			const char *committer_login, const char *committer_domain,
+			const struct strbuf *log, const char *gitsvnline,
+			unsigned long timestamp, uint32_t from_mark,
+			const char *dst_ref)
 {
-	static const struct strbuf empty = STRBUF_INIT;
-	if (!log)
-		log = &empty;
-	if (*uuid && *url) {
-		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN,
-				"\n\ngit-svn-id: %s@%"PRIu32" %s\n",
-				 url, revision, uuid);
-	} else {
-		*gitsvnline = '\0';
-	}
-	printf("commit refs/heads/master\n");
-	printf("mark :%"PRIu32"\n", revision);
+	if (!gitsvnline)
+		gitsvnline = "";
+	printf("commit %s\n", dst_ref);
+	if (set_mark)
+		printf("mark :%"PRIu32"\n", set_mark);
 	printf("committer %s <%s@%s> %ld +0000\n",
-		   *author ? author : "nobody",
-		   *author ? author : "nobody",
-		   *uuid ? uuid : "local", timestamp);
+		committer_name, committer_login, committer_domain,
+		timestamp);
 	printf("data %"PRIuMAX"\n",
 		(uintmax_t) (log->len + strlen(gitsvnline)));
 	fwrite(log->buf, log->len, 1, stdout);
 	printf("%s\n", gitsvnline);
-	if (!first_commit_done) {
-		if (revision > 1)
-			printf("from :%"PRIu32"\n", revision - 1);
-		first_commit_done = 1;
-	}
+	if (from_mark)
+		printf("from :%"PRIu32"\n", from_mark);
 }
 
 void fast_export_end_commit(uint32_t revision)
 {
-	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
 static void ls_from_rev(uint32_t rev, const char *path)
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 43d05b6..6c1c2be 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -10,9 +10,11 @@ void fast_export_reset(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
-void fast_export_begin_commit(uint32_t revision, const char *author,
-			const struct strbuf *log, const char *uuid,
-			const char *url, unsigned long timestamp);
+void fast_export_begin_commit(uint32_t set_mark, const char *committer_name,
+			const char *committer_login, const char *committer_domain,
+			const struct strbuf *log, const char *gitsvnline,
+			unsigned long timestamp, uint32_t from_mark,
+			const char *dst_ref);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
 void fast_export_blob_delta(uint32_t mode,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 60cccad..c58262a 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -37,6 +37,8 @@
 #define LENGTH_UNKNOWN (~0)
 #define DATE_RFC2822_LEN 31
 
+#define MAX_GITSVN_LINE_LEN 4096
+
 static struct line_buffer input = LINE_BUFFER_INIT;
 
 static struct {
@@ -54,6 +56,7 @@ static struct {
 static struct {
 	uint32_t version;
 	struct strbuf uuid, url;
+	int first_commit_done;
 } dump_ctx;
 
 static void reset_node_ctx(char *fname)
@@ -86,6 +89,7 @@ static void reset_dump_ctx(const char *url)
 		strbuf_addstr(&dump_ctx.url, url);
 	dump_ctx.version = 1;
 	strbuf_reset(&dump_ctx.uuid);
+	dump_ctx.first_commit_done = 0;
 }
 
 static void handle_property(const struct strbuf *key_buf,
@@ -299,19 +303,37 @@ static void handle_node(void)
 				node_ctx.textLength, &input);
 }
 
+static char gitsvnline[MAX_GITSVN_LINE_LEN];
 static void begin_revision(void)
 {
+	int from_mark;
+	const char *author;
+	const char *domain;
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
-	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author.buf,
-		&rev_ctx.log, dump_ctx.uuid.buf, dump_ctx.url.buf,
-		rev_ctx.timestamp);
+	if (*dump_ctx.uuid.buf && *dump_ctx.url.buf) {
+		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN,
+				"\n\ngit-svn-id: %s@%"PRIu32" %s\n",
+				 dump_ctx.url.buf, rev_ctx.revision, dump_ctx.uuid.buf);
+	} else {
+		*gitsvnline = 0;
+	}
+	from_mark = dump_ctx.first_commit_done ? rev_ctx.revision - 1 : 0;
+	author = *rev_ctx.author.buf ? rev_ctx.author.buf : "nobody";
+	domain = *dump_ctx.uuid.buf ? dump_ctx.uuid.buf : "local";
+
+	fast_export_begin_commit(rev_ctx.revision, author, author, domain,
+		&rev_ctx.log, gitsvnline, rev_ctx.timestamp,
+		from_mark);
 }
 
 static void end_revision(void)
 {
-	if (rev_ctx.revision)
+	if (rev_ctx.revision) {
 		fast_export_end_commit(rev_ctx.revision);
+		printf("progress Imported commit %"PRIu32".\n\n", rev_ctx.revision);
+		dump_ctx.first_commit_done = 1;
+	}
 }
 
 void svndump_read(void)
-- 
1.7.3.4
