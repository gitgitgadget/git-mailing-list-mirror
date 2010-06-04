From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] Add stream helper library
Date: Fri,  4 Jun 2010 15:41:09 +0200
Message-ID: <1275658871-1473-5-git-send-email-artagnon@gmail.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:40:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKX8N-0005nH-OZ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab0FDNj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:39:58 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:41712 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab0FDNjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:39:55 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so312332ewy.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dgShsJZ+fqlJRgAiq5oNrm2oys5L+SB7jCLr5/qzg2o=;
        b=C2VnttjzZzTUmyp4dUWPFw3a1TWMk/0hRPeua/hEqsE3xU+pUanmtq+Qi1IxAdM7wm
         utJHZGxSiKYL95EM/8XstjHYfWav6tIMCkdBOrLwjCFALY6iaWV2PrjRoK3l8APW0xqA
         oagZ4eXraC03LHe+XY6kxIIfLscuAKHGFbROI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kCOW/5FI9j6l/ZRdAFguofTCDaoj4bvnNQcbOz7Ioo3XMrWTIj2+VMNFH1FlcpFxkV
         4AuHz7LEdMwoDs0cBNyLFMPJyLmCDjfNJpMGYWhqlFwaJOeKqDX7nITIBpDRRtPEgPuO
         cRdNhyLd5rM9X7BlJvtjk6hxJi5PC+mX3e+M8=
Received: by 10.213.20.80 with SMTP id e16mr7964537ebb.13.1275658795000;
        Fri, 04 Jun 2010 06:39:55 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm740220ewy.14.2010.06.04.06.39.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 06:39:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148414>

From: David Barr <david.barr@cordelta.com>

This library provides facilities to read streams into buffers. It
maintains a couple of static buffers and provides an API to use them.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/line_buffer.c |  129 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/line_buffer.h |   14 +++++
 2 files changed, 143 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
new file mode 100644
index 0000000..740676d
--- /dev/null
+++ b/vcs-svn/line_buffer.c
@@ -0,0 +1,129 @@
+#include "git-compat-util.h"
+
+#include "line_buffer.h"
+#include "obj_pool.h"
+
+#define LINE_BUFFER_LEN 10000
+#define COPY_BUFFER_LEN 4096
+
+/* Create memory pool for char sequence of known length */
+obj_pool_gen(blob, char, 4096);
+
+static char line_buffer[LINE_BUFFER_LEN];
+static char byte_buffer[COPY_BUFFER_LEN];
+static uint32_t line_buffer_len = 0;
+static uint32_t line_len = 0;
+static FILE *infile;
+
+int buffer_init(char *filename)
+{
+	infile = fopen(filename, "r");
+	if (!infile)
+		return 1;
+	return 0;
+}
+
+int buffer_deinit()
+{
+	fclose(infile);
+	return 0;
+}
+
+char *buffer_read_line(void)
+{
+	char *end;
+	uint32_t n_read;
+
+	if (line_len) {
+		memmove(line_buffer, &line_buffer[line_len],
+			line_buffer_len - line_len);
+		line_buffer_len -= line_len;
+		line_len = 0;
+	}
+
+	end = memchr(line_buffer, '\n', line_buffer_len);
+	while (line_buffer_len < LINE_BUFFER_LEN - 1 &&
+	       !feof(infile) && ferror(infile) && NULL == end) {
+		n_read = fread(&line_buffer[line_buffer_len], 1,
+			       LINE_BUFFER_LEN - 1 - line_buffer_len,
+			       infile);
+		end = memchr(&line_buffer[line_buffer_len], '\n', n_read);
+		line_buffer_len += n_read;
+	}
+
+	if (ferror(infile))
+		return NULL;
+
+	if (end != NULL) {
+		line_len = end - line_buffer;
+		line_buffer[line_len++] = '\0';
+	} else {
+		line_len = line_buffer_len;
+		line_buffer[line_buffer_len] = '\0';
+	}
+
+	if (line_len == 0)
+		return NULL;
+
+	return line_buffer;
+}
+
+char *buffer_read_string(uint32_t len)
+{
+	char *s;
+	blob_free(blob_pool.size);
+	s = blob_pointer(blob_alloc(len + 1));
+	uint32_t offset = 0;
+	if (line_buffer_len > line_len) {
+		offset = line_buffer_len - line_len;
+		if (offset > len)
+			offset = len;
+		memcpy(s, &line_buffer[line_len], offset);
+		line_len += offset;
+	}
+	if (offset < len)
+		offset += fread(&s[offset], 1, len - offset, infile);
+	s[offset] = '\0';
+	return s;
+}
+
+void buffer_copy_bytes(uint32_t len)
+{
+	uint32_t in;
+	if (line_buffer_len > line_len) {
+		in = line_buffer_len - line_len;
+		if (in > len)
+			in = len;
+		fwrite(&line_buffer[line_len], 1, in, stdout);
+		len -= in;
+		line_len += in;
+	}
+	while (len > 0 && !feof(infile)) {
+		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+		in = fread(byte_buffer, 1, in, infile);
+		len -= in;
+		fwrite(byte_buffer, 1, in, stdout);
+	}
+}
+
+void buffer_skip_bytes(uint32_t len)
+{
+	uint32_t in;
+	if (line_buffer_len > line_len) {
+		in = line_buffer_len - line_len;
+		if (in > len)
+			in = len;
+		line_len += in;
+		len -= in;
+	}
+	while (len > 0 && !feof(infile) && !ferror(infile)) {
+		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+		in = fread(byte_buffer, 1, in, infile);
+		len -= in;
+	}
+}
+
+void buffer_reset(void)
+{
+	blob_reset();
+}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
new file mode 100644
index 0000000..a6c42d7
--- /dev/null
+++ b/vcs-svn/line_buffer.h
@@ -0,0 +1,14 @@
+#ifndef LINE_BUFFER_H_
+#define LINE_BUFFER_H_
+
+#include <stdint.h>
+
+int buffer_init(char *filename);
+int buffer_deinit(void);
+char *buffer_read_line(void);
+char *buffer_read_string(uint32_t len);
+void buffer_copy_bytes(uint32_t len);
+void buffer_skip_bytes(uint32_t len);
+void buffer_reset(void);
+
+#endif
-- 
1.7.1
