From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 1/5] vcs-svn: Add sha1 calculaton to fast_export and line_buffer.
Date: Fri, 17 Aug 2012 22:40:06 +0200
Message-ID: <1345236010-1648-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:40:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2TLi-0006Pq-0h
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496Ab2HQUks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:40:48 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43758 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932460Ab2HQUk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:40:26 -0400
Received: by wicr5 with SMTP id r5so2014067wic.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dZXKjsvIy9FLBMDZGwS0z6VzopCyz2oH76Ae5Eq4bnE=;
        b=WclcqzDw52BigW4w8uslfi/RoBbgztlS0/HQD2jMRJPTNtoRr9lir5n3WzN+4jB3OS
         Qd/XA6KKYJP7DU7HXAEZYfIhmSzbjMKVierbWAHsFDqUpdv+ZZ1mFBsj9zgU+lucTRJr
         TmGrEzXQfzDlAQF/baJXHdTKyepMxG/vPV1k8uy/QWOf+xO03OX+q+r2VUNV96GzcD2I
         eSc/Kb8r5QX47hzddsrTU+75SQIqzd20Fj77chT+CO7o4aJzBHy0P0MVWF1OYQ2u1Vdb
         beQ3y+B8Mjr9vy1prVMwc+6SKUpgdSSfdE+fNYmuIBp6dm9ZYyrCl+q7EKHZstrZ2UMj
         rUGQ==
Received: by 10.180.106.97 with SMTP id gt1mr7788208wib.5.1345236025387;
        Fri, 17 Aug 2012 13:40:25 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id b7sm17480686wiz.9.2012.08.17.13.40.23
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:40:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203660>

The functions fast_export_blob_delta, fast_export_data are used to
feed the data of blobs into fast-import. Both use line_buffer's
buffer_copy_bytes to write the preprocessed data to the stream.

Allow for calculating the resulting blob's sha1 by adding and
adding an addtional argument to fast_export_blob_delta and
fast_export_data that -- if not NULL -- is set to the sha1
of the new blob.

Becuase these two functions are only used in vcs-svn/, replace
the existing ones.

The calculated sha1 can be used to refer to the blob later
in the fast-import command stream.
E.g.:
add a blob with the 'blob' command and use it later
inside a 'commit' command.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 test-line-buffer.c    |    2 +-
 vcs-svn/fast_export.c |   35 +++++++++++++++++++++++++++++++----
 vcs-svn/fast_export.h |    5 +++--
 vcs-svn/line_buffer.c |    7 ++++---
 vcs-svn/line_buffer.h |    4 ++--
 vcs-svn/svndump.c     |    4 ++--
 6 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/test-line-buffer.c b/test-line-buffer.c
index ef1d7ba..0c126b2 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -29,7 +29,7 @@ static void handle_command(const char *command, const char *arg, struct line_buf
 		}
 	case 'c':
 		if (!prefixcmp(command, "copy ")) {
-			buffer_copy_bytes(buf, strtouint32(arg));
+			buffer_copy_bytes(buf, strtouint32(arg), NULL);
 			return;
 		}
 	case 's':
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 872ef81..c780d32 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -250,8 +250,11 @@ void fast_export_buf_to_data(const struct strbuf *data)
 	fputc('\n', stdout);
 }
 
-void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input)
+void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input,
+		unsigned char sha1[20])
 {
+	git_SHA_CTX sha1_ctx;
+	struct strbuf sb = STRBUF_INIT;
 	assert(len >= 0);
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
@@ -261,10 +264,21 @@ void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input)
 		if (buffer_skip_bytes(input, 5) != 5)
 			die_short_read(input);
 	}
+	if (sha1) {
+		/* don't forget to inlude the header in the sha1 */
+		git_SHA1_Init(&sha1_ctx);
+		strbuf_addf(&sb, "blob %" PRIuMAX, (uintmax_t) len);
+		git_SHA1_Update(&sha1_ctx, sb.buf, sb.len + 1);
+		strbuf_release(&sb);
+	}
+
 	printf("data %"PRIuMAX"\n", (uintmax_t) len);
-	if (buffer_copy_bytes(input, len) != len)
+	if (buffer_copy_bytes(input, len, sha1 ? &sha1_ctx : NULL) != len)
 		die_short_read(input);
 	fputc('\n', stdout);
+
+	if (sha1)
+		git_SHA1_Final(sha1, &sha1_ctx);
 }
 
 static int parse_ls_response(const char *response, uint32_t *mode,
@@ -323,9 +337,11 @@ int fast_export_ls(const char *path, uint32_t *mode, struct strbuf *dataref)
 
 void fast_export_blob_delta(uint32_t mode,
 				uint32_t old_mode, const char *old_data,
-				off_t len, struct line_buffer *input)
+				off_t len, struct line_buffer *input, unsigned char sha1[20])
 {
 	long postimage_len;
+	git_SHA_CTX sha1_ctx;
+	struct strbuf sb = STRBUF_INIT;
 
 	assert(len >= 0);
 	postimage_len = apply_delta(len, input, old_data, old_mode);
@@ -333,7 +349,18 @@ void fast_export_blob_delta(uint32_t mode,
 		buffer_skip_bytes(&postimage, strlen("link "));
 		postimage_len -= strlen("link ");
 	}
+	if (sha1) {
+		/* don't forget to inlude the header in the sha1 */
+		git_SHA1_Init(&sha1_ctx);
+		strbuf_addf(&sb, "blob %" PRIuMAX, (uintmax_t) postimage_len);
+		git_SHA1_Update(&sha1_ctx, sb.buf, sb.len + 1);
+		strbuf_release(&sb);
+	}
+
 	printf("data %ld\n", postimage_len);
-	buffer_copy_bytes(&postimage, postimage_len);
+	buffer_copy_bytes(&postimage, postimage_len, sha1 ? &sha1_ctx : NULL);
 	fputc('\n', stdout);
+
+	if (sha1)
+		git_SHA1_Final(sha1, &sha1_ctx);
 }
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index c8b5adb..f89e1b1 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -16,11 +16,12 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,const char *url,
 			unsigned long timestamp, const char *local_ref);
 void fast_export_end_commit(uint32_t revision);
-void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
+void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input,
+		unsigned char sha1[20]);
 void fast_export_buf_to_data(const struct strbuf *data);
 void fast_export_blob_delta(uint32_t mode,
 			uint32_t old_mode, const char *old_data,
-			off_t len, struct line_buffer *input);
+			off_t len, struct line_buffer *input, unsigned char sha1[20]);
 
 /* If there is no such file at that rev, returns -1, errno == ENOENT. */
 int fast_export_ls_rev(uint32_t rev, const char *path,
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 57cc1ce..e9c1b7f 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -3,9 +3,8 @@
  * See LICENSE for details.
  */
 
-#include "git-compat-util.h"
+#include "cache.h"
 #include "line_buffer.h"
-#include "strbuf.h"
 
 #define COPY_BUFFER_LEN 4096
 
@@ -97,7 +96,7 @@ size_t buffer_read_binary(struct line_buffer *buf,
 	return strbuf_fread(sb, size, buf->infile);
 }
 
-off_t buffer_copy_bytes(struct line_buffer *buf, off_t nbytes)
+off_t buffer_copy_bytes(struct line_buffer *buf, off_t nbytes, git_SHA_CTX *sha1_ctx)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
 	off_t done = 0;
@@ -107,6 +106,8 @@ off_t buffer_copy_bytes(struct line_buffer *buf, off_t nbytes)
 		in = fread(byte_buffer, 1, in, buf->infile);
 		done += in;
 		fwrite(byte_buffer, 1, in, stdout);
+		if (sha1_ctx)
+			git_SHA1_Update(sha1_ctx, byte_buffer, in);
 		if (ferror(stdout))
 			return done + buffer_skip_bytes(buf, nbytes - done);
 	}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index ee23b4f..5b57cdd 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -1,7 +1,7 @@
 #ifndef LINE_BUFFER_H_
 #define LINE_BUFFER_H_
 
-#include "strbuf.h"
+#include "cache.h"
 
 #define LINE_BUFFER_LEN 10000
 
@@ -24,7 +24,7 @@ char *buffer_read_line(struct line_buffer *buf);
 int buffer_read_char(struct line_buffer *buf);
 size_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, size_t len);
 /* Returns number of bytes read (not necessarily written). */
-off_t buffer_copy_bytes(struct line_buffer *buf, off_t len);
+off_t buffer_copy_bytes(struct line_buffer *buf, off_t len, git_SHA_CTX *sha1_ctx);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
 
 #endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 31d1d83..7592c8e 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -292,12 +292,12 @@ static void handle_node(void)
 	}
 	if (!node_ctx.text_delta) {
 		fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
-		fast_export_data(node_ctx.type, node_ctx.text_length, &input);
+		fast_export_data(node_ctx.type, node_ctx.text_length, &input, NULL);
 		return;
 	}
 	fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
 	fast_export_blob_delta(node_ctx.type, old_mode, old_data,
-				node_ctx.text_length, &input);
+				node_ctx.text_length, &input, NULL);
 }
 
 static void begin_revision(const char *remote_ref)
-- 
1.7.9.5
