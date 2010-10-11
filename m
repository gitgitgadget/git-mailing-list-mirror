From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/16] vcs-svn: Teach line_buffer to handle multiple input
 files
Date: Sun, 10 Oct 2010 21:41:06 -0500
Message-ID: <20101011024106.GD1553@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 04:44:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58NH-0000U8-Ub
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab0JKCoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:44:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52454 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0JKCoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:44:21 -0400
Received: by gyg13 with SMTP id 13so606991gyg.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7LpBvRPTKychjABxAQsHVaQQOU1iJud1v1lo8ga3eG4=;
        b=hFb++fiD439Bkddk8ko863Iq5KLPnpCSIBo5dq+hhVGtITt5FT6zmlukDFJ30ZAmjn
         KGmLuidCYvlXggI/FCOZ6xBgusHSRt60T936H0Q9OM3fEt4ymeEIo7luKSYqzWG0K+OT
         9nY0ndEuLmmdz91OB5u3y/zJW9a41OVN+WDgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PxKev9WRCfTV/vCU8auSbGdcdPumE7kVhALJytKQBuuOiPpTViWvzTffnktZetlq1r
         W2D/+S8Q6Lb5+wDGxSxXpNZ7SpDL/09IIghNgCcVslJAtXOjIYIDdQsJAye73jIGD9tz
         4iveMHmSeiTC2xEQ8siV+AUoRGiLtwXWcOr8c=
Received: by 10.150.201.4 with SMTP id y4mr5472681ybf.310.1286765061007;
        Sun, 10 Oct 2010 19:44:21 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q41sm5312921ybk.1.2010.10.10.19.44.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:44:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158734>

Collect the line_buffer state in a newly public line_buffer struct.
Callers can use multiple line_buffers to manage input from multiple
files at a time.

The Subversion-format delta applier will use this to stream a delta
and the preimage it applies to at the same time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.txt |    5 +++--
 vcs-svn/fast_export.c   |    6 +++---
 vcs-svn/fast_export.h   |    5 ++++-
 vcs-svn/line_buffer.c   |   20 ++++++++------------
 vcs-svn/line_buffer.h   |   14 +++++++-------
 vcs-svn/svndump.c       |   29 ++++++++++++++++-------------
 test-line-buffer.c      |   17 +++++++++--------
 7 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
index 8906fb1..f8eaa4d 100644
--- a/vcs-svn/line_buffer.txt
+++ b/vcs-svn/line_buffer.txt
@@ -14,14 +14,15 @@ Calling sequence
 
 The calling program:
 
+ - initializes a `struct line_buffer` to LINE_BUFFER_INIT
  - specifies a file to read with `buffer_init`
  - processes input with `buffer_read_line`, `buffer_read_string`,
    `buffer_skip_bytes`, and `buffer_copy_bytes`
  - closes the file with `buffer_deinit`, perhaps to start over and
    read another file.
 
-Before exiting, the caller can use `buffer_reset` to deallocate
-resources for the benefit of profiling tools.
+When finished, the caller can use `buffer_reset` to deallocate
+resources.
 
 Functions
 ---------
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 6cfa256..260cf50 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -63,14 +63,14 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
-void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len)
+void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
-		buffer_skip_bytes(5);
+		buffer_skip_bytes(input, 5);
 		len -= 5;
 	}
 	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
-	buffer_copy_bytes(len);
+	buffer_copy_bytes(input, len);
 	fputc('\n', stdout);
 }
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 2aaaea5..054e7d5 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -1,11 +1,14 @@
 #ifndef FAST_EXPORT_H_
 #define FAST_EXPORT_H_
 
+#include "line_buffer.h"
+
 void fast_export_delete(uint32_t depth, uint32_t *path);
 void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 			uint32_t mark);
 void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url, unsigned long timestamp);
-void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len);
+void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
+		      struct line_buffer *input);
 
 #endif
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index e7bc230..806932b 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -8,20 +8,16 @@
 #include "strbuf.h"
 
 #define COPY_BUFFER_LEN 4096
-static struct line_buffer buf_ = LINE_BUFFER_INIT;
-static struct line_buffer *buf;
 
-int buffer_init(const char *filename)
+int buffer_init(struct line_buffer *buf, const char *filename)
 {
-	buf = &buf_;
-
 	buf->infile = filename ? fopen(filename, "r") : stdin;
 	if (!buf->infile)
 		return -1;
 	return 0;
 }
 
-int buffer_deinit(void)
+int buffer_deinit(struct line_buffer *buf)
 {
 	int err;
 	if (buf->infile == stdin)
@@ -32,7 +28,7 @@ int buffer_deinit(void)
 }
 
 /* Read a line without trailing newline. */
-char *buffer_read_line(void)
+char *buffer_read_line(struct line_buffer *buf)
 {
 	char *end;
 	if (!fgets(buf->line_buffer, sizeof(buf->line_buffer), buf->infile))
@@ -53,14 +49,14 @@ char *buffer_read_line(void)
 	return buf->line_buffer;
 }
 
-char *buffer_read_string(uint32_t len)
+char *buffer_read_string(struct line_buffer *buf, uint32_t len)
 {
 	strbuf_reset(&buf->blob_buffer);
 	strbuf_fread(&buf->blob_buffer, len, buf->infile);
 	return ferror(buf->infile) ? NULL : buf->blob_buffer.buf;
 }
 
-void buffer_copy_bytes(uint32_t len)
+void buffer_copy_bytes(struct line_buffer *buf, uint32_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
@@ -70,13 +66,13 @@ void buffer_copy_bytes(uint32_t len)
 		len -= in;
 		fwrite(byte_buffer, 1, in, stdout);
 		if (ferror(stdout)) {
-			buffer_skip_bytes(len);
+			buffer_skip_bytes(buf, len);
 			return;
 		}
 	}
 }
 
-void buffer_skip_bytes(uint32_t len)
+void buffer_skip_bytes(struct line_buffer *buf, uint32_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
@@ -87,7 +83,7 @@ void buffer_skip_bytes(uint32_t len)
 	}
 }
 
-void buffer_reset(void)
+void buffer_reset(struct line_buffer *buf)
 {
 	strbuf_release(&buf->blob_buffer);
 }
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 4ae1133..fb37390 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -12,12 +12,12 @@ struct line_buffer {
 };
 #define LINE_BUFFER_INIT {"", STRBUF_INIT, NULL}
 
-int buffer_init(const char *filename);
-int buffer_deinit(void);
-char *buffer_read_line(void);
-char *buffer_read_string(uint32_t len);
-void buffer_copy_bytes(uint32_t len);
-void buffer_skip_bytes(uint32_t len);
-void buffer_reset(void);
+int buffer_init(struct line_buffer *buf, const char *filename);
+int buffer_deinit(struct line_buffer *buf);
+char *buffer_read_line(struct line_buffer *buf);
+char *buffer_read_string(struct line_buffer *buf, uint32_t len);
+void buffer_copy_bytes(struct line_buffer *buf, uint32_t len);
+void buffer_skip_bytes(struct line_buffer *buf, uint32_t len);
+void buffer_reset(struct line_buffer *buf);
 
 #endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 53d0215..3bba0fe 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -30,6 +30,8 @@
 /* Create memory pool for log messages */
 obj_pool_gen(log, char, 4096)
 
+static struct line_buffer input = LINE_BUFFER_INIT;
+
 static char* log_copy(uint32_t length, char *log)
 {
 	char *buffer;
@@ -113,14 +115,14 @@ static void read_props(void)
 	uint32_t key = ~0;
 	char *val = NULL;
 	char *t;
-	while ((t = buffer_read_line()) && strcmp(t, "PROPS-END")) {
+	while ((t = buffer_read_line(&input)) && strcmp(t, "PROPS-END")) {
 		if (!strncmp(t, "K ", 2)) {
 			len = atoi(&t[2]);
-			key = pool_intern(buffer_read_string(len));
-			buffer_read_line();
+			key = pool_intern(buffer_read_string(&input, len));
+			buffer_read_line(&input);
 		} else if (!strncmp(t, "V ", 2)) {
 			len = atoi(&t[2]);
-			val = buffer_read_string(len);
+			val = buffer_read_string(&input, len);
 			if (key == keys.svn_log) {
 				/* Value length excludes terminating nul. */
 				rev_ctx.log = log_copy(len + 1, val);
@@ -135,7 +137,7 @@ static void read_props(void)
 				node_ctx.type = REPO_MODE_LNK;
 			}
 			key = ~0;
-			buffer_read_line();
+			buffer_read_line(&input);
 		}
 	}
 }
@@ -177,9 +179,10 @@ static void handle_node(void)
 		node_ctx.type = node_ctx.srcMode;
 
 	if (node_ctx.mark)
-		fast_export_blob(node_ctx.type, node_ctx.mark, node_ctx.textLength);
+		fast_export_blob(node_ctx.type,
+				 node_ctx.mark, node_ctx.textLength, &input);
 	else if (node_ctx.textLength != LENGTH_UNKNOWN)
-		buffer_skip_bytes(node_ctx.textLength);
+		buffer_skip_bytes(&input, node_ctx.textLength);
 }
 
 static void handle_revision(void)
@@ -198,7 +201,7 @@ void svndump_read(const char *url)
 	uint32_t key;
 
 	reset_dump_ctx(pool_intern(url));
-	while ((t = buffer_read_line())) {
+	while ((t = buffer_read_line(&input))) {
 		val = strstr(t, ": ");
 		if (!val)
 			continue;
@@ -250,7 +253,7 @@ void svndump_read(const char *url)
 			node_ctx.propLength = atoi(val);
 		} else if (key == keys.content_length) {
 			len = atoi(val);
-			buffer_read_line();
+			buffer_read_line(&input);
 			if (active_ctx == REV_CTX) {
 				read_props();
 			} else if (active_ctx == NODE_CTX) {
@@ -258,7 +261,7 @@ void svndump_read(const char *url)
 				active_ctx = REV_CTX;
 			} else {
 				fprintf(stderr, "Unexpected content length header: %"PRIu32"\n", len);
-				buffer_skip_bytes(len);
+				buffer_skip_bytes(&input, len);
 			}
 		}
 	}
@@ -270,7 +273,7 @@ void svndump_read(const char *url)
 
 void svndump_init(const char *filename)
 {
-	buffer_init(filename);
+	buffer_init(&input, filename);
 	repo_init();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
@@ -285,7 +288,7 @@ void svndump_deinit(void)
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
-	if (buffer_deinit())
+	if (buffer_deinit(&input))
 		fprintf(stderr, "Input error\n");
 	if (ferror(stdout))
 		fprintf(stderr, "Output error\n");
@@ -294,7 +297,7 @@ void svndump_deinit(void)
 void svndump_reset(void)
 {
 	log_reset();
-	buffer_reset();
+	buffer_reset(&input);
 	repo_reset();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
diff --git a/test-line-buffer.c b/test-line-buffer.c
index c11bf7f..f9af892 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -22,25 +22,26 @@ static uint32_t strtouint32(const char *s)
 
 int main(int argc, char *argv[])
 {
+	struct line_buffer buf = LINE_BUFFER_INIT;
 	char *s;
 
 	if (argc != 1)
 		usage("test-line-buffer < input.txt");
-	if (buffer_init(NULL))
+	if (buffer_init(&buf, NULL))
 		die_errno("open error");
-	while ((s = buffer_read_line())) {
-		s = buffer_read_string(strtouint32(s));
+	while ((s = buffer_read_line(&buf))) {
+		s = buffer_read_string(&buf, strtouint32(s));
 		fputs(s, stdout);
 		fputc('\n', stdout);
-		buffer_skip_bytes(1);
-		if (!(s = buffer_read_line()))
+		buffer_skip_bytes(&buf, 1);
+		if (!(s = buffer_read_line(&buf)))
 			break;
-		buffer_copy_bytes(strtouint32(s) + 1);
+		buffer_copy_bytes(&buf, strtouint32(s) + 1);
 	}
-	if (buffer_deinit())
+	if (buffer_deinit(&buf))
 		die("input error");
 	if (ferror(stdout))
 		die("output error");
-	buffer_reset();
+	buffer_reset(&buf);
 	return 0;
 }
-- 
1.7.2.3
