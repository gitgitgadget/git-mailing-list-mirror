From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] vcs-svn: teach line_buffer to handle multiple input files
Date: Fri, 24 Dec 2010 02:28:46 -0600
Message-ID: <20101224082846.GE29681@burratino>
References: <20101224080505.GA29681@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 09:29:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW31K-0000Sc-Ux
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 09:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab0LXI25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 03:28:57 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45006 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab0LXI24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 03:28:56 -0500
Received: by gwj20 with SMTP id 20so3845684gwj.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 00:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fSHkDX8gP+vYP9sm40tQwiq+HpXjV11Lfg/vDbMTr6Q=;
        b=n3Qgm4B50zl9v+ijAcDTIazS/m/oXL1ABnfpFw+N7jV3H3/rYlOUZwnKXJvBGQqNTz
         A4wlfjGf6JrZ2qKjFXYVn8txy0Kde3mTkQ59Sc6ssxDZA2FWPlqTOwTYdV1/hqNPDUD0
         NyjFmQGKhy6liZRS9flu31WzQAAzXPJDRInEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jEM8dZ1C6FGd01oFuLlMu/FM3m/BfHc5M2pLcm8i2BylEgY8CZbF1OJORgqO+mCsXd
         yCU5uFkCT3AXri2FBxlzOl8z8DgQs0/FZXgUiLmtm5v7EDcvehkDnqo2E5bj5h76Ch6M
         JrvzzVrsEfx7IPesDoTgITwxzmm39y719xDYw=
Received: by 10.100.106.5 with SMTP id e5mr5557107anc.214.1293179336015;
        Fri, 24 Dec 2010 00:28:56 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id j14sm13583030anb.39.2010.12.24.00.28.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 00:28:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101224080505.GA29681@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164150>

Date: Sun, 10 Oct 2010 21:41:06 -0500

Collect the line_buffer state in a newly public line_buffer struct.
Callers can use multiple line_buffers to manage input from multiple
files at a time.

svn-fe's delta applier will use this to stream a delta from svnrdump
and the preimage it applies to from fast-import at the same time.

The tests don't take advantage of the new features, but I think that's
okay.  It is easier to find lingering examples of nonreentrant code by
searching for "static" in line_buffer.c.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's it.  The API change feels inevitable to me, perhaps because it
has been in use for so long.  Hopefully it can be a good basis for
future changes:

 - buffer_tmpfile_{init,rewind,prepare_to_read}, for when files are
   just a place to stash data for later
 - buffer_fdopen to read from a file descriptor
 - buffer_interactive for deadlock avoidance (if that turns out to
   be needed)

I would be happy to hear any thoughts you have, even as basic as
"looks ok" or "confusing".

thanks,
Jonathan

 test-line-buffer.c      |   17 +++++++++--------
 vcs-svn/fast_export.c   |    6 +++---
 vcs-svn/fast_export.h   |    5 ++++-
 vcs-svn/line_buffer.c   |   20 ++++++++------------
 vcs-svn/line_buffer.h   |   14 +++++++-------
 vcs-svn/line_buffer.txt |    5 +++--
 vcs-svn/svndump.c       |   29 ++++++++++++++++-------------
 7 files changed, 50 insertions(+), 46 deletions(-)

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
-- 
1.7.2.3.554.gc9b5c.dirty
