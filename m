From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 4/5] vcs-svn: Add outfile option to buffer_copy_bytes()
Date: Fri, 15 Oct 2010 23:54:15 +1100
Message-ID: <1287147256-9457-5-git-send-email-david.barr@cordelta.com>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 14:55:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6joh-0007tx-8v
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 14:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab0JOMyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 08:54:47 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:37302 "EHLO
	mail08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755330Ab0JOMyh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 08:54:37 -0400
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o9FCsPso006314;
	Fri, 15 Oct 2010 23:54:31 +1100
X-Mailer: git-send-email 1.7.3.32.g634ef
In-Reply-To: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159118>

Explicitly declare that output is to stdout for existing use.
Allow users of buffer_copy_bytes() to specify the output file.

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 test-line-buffer.c    |    2 +-
 vcs-svn/fast_export.c |    2 +-
 vcs-svn/line_buffer.c |    6 +++---
 vcs-svn/line_buffer.h |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/test-line-buffer.c b/test-line-buffer.c
index f9af892..adc23e8 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -36,7 +36,7 @@ int main(int argc, char *argv[])
 		buffer_skip_bytes(&buf, 1);
 		if (!(s = buffer_read_line(&buf)))
 			break;
-		buffer_copy_bytes(&buf, strtouint32(s) + 1);
+		buffer_copy_bytes(&buf, stdout, strtouint32(s) + 1);
 	}
 	if (buffer_deinit(&buf))
 		die("input error");
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index d984aaa..b017dfb 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -73,6 +73,6 @@ void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
 		len -= 5;
 	}
 	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
-	buffer_copy_bytes(input, len);
+	buffer_copy_bytes(input, stdout, len);
 	fputc('\n', stdout);
 }
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index c54031b..676cb62 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -82,7 +82,7 @@ void buffer_read_binary(struct strbuf *sb, uint32_t size,
 	strbuf_fread(sb, size, buf->infile);
 }
 
-void buffer_copy_bytes(struct line_buffer *buf, off_t len)
+void buffer_copy_bytes(struct line_buffer *buf, FILE *outfile, off_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
@@ -90,8 +90,8 @@ void buffer_copy_bytes(struct line_buffer *buf, off_t len)
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
 		in = fread(byte_buffer, 1, in, buf->infile);
 		len -= in;
-		fwrite(byte_buffer, 1, in, stdout);
-		if (ferror(stdout)) {
+		fwrite(byte_buffer, 1, in, outfile);
+		if (ferror(outfile)) {
 			buffer_skip_bytes(buf, len);
 			return;
 		}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 2375ee1..23f4931 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -20,7 +20,7 @@ char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct strbuf *sb, uint32_t len, struct line_buffer *f);
-void buffer_copy_bytes(struct line_buffer *buf, off_t len);
+void buffer_copy_bytes(struct line_buffer *buf, FILE *outfile, off_t len);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
 void buffer_reset(struct line_buffer *buf);
 
-- 
1.7.3.32.g634ef
