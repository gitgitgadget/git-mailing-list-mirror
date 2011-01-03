From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/12] vcs-svn: add binary-safe read function
Date: Sun, 2 Jan 2011 21:05:46 -0600
Message-ID: <20110103030546.GB10143@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
 <20110103030328.GA10143@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 04:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZakx-0008TF-5A
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 04:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab1ACDFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 22:05:55 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37675 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab1ACDFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 22:05:55 -0500
Received: by gwj20 with SMTP id 20so6061187gwj.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 19:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rDjs1DxNxjC8tnD8CoMGiFPUjOff/vyOUddyzbmh2mI=;
        b=PGVIPFvQn7K7aksGu6lB2l9ZdJ2TlRno2igRZAvHGLbAHwQRJsgHRbePZ0u17YWvgD
         4ujLMGR3NQmcXRYrIZ6Zf7LRhR1Q1uYAJFq3iXlKKwTLqD3vbrs3PqRpikbf6RMh2Ewh
         mCdjOONObWtfnOHGNtMCo2zQCuShVbs8rmN2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NIvdvhEwd3RRdwsXGKypbZqWUSSkxYuTrqNIM5q4V/JvGZthm/dEIeF12nubjMIXyM
         yDDzjwgdefc3pmDjiY81lKt7wK0gnI5kD4zCXKWquoPC9M5ZYT3C54tBGYzwpjkF3BJm
         6iM9IuuAALG/laHI6/5+VMAPd9JKbjn1DzzEA=
Received: by 10.147.182.5 with SMTP id j5mr16038090yap.18.1294023954341;
        Sun, 02 Jan 2011 19:05:54 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id i52sm11955056yhd.41.2011.01.02.19.05.52
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 19:05:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103030328.GA10143@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164438>

buffer_read_string works well for non line-oriented input except for
one problem: it does not tell the caller how many bytes were actually
written.  This means that unless one is very careful about checking
for errors (and eof) the calling program cannot tell the difference
between the string "foo" followed by an early end of file and the
string "foo\0bar\0baz".

So introduce a variant that reports the length, too, a thinner wrapper
around strbuf_fread.  Its result is written to a strbuf so the caller
does not need to keep track of the number of bytes read.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0081-line-buffer.sh |   18 ++++++++++++++++++
 test-line-buffer.c     |   10 ++++++++++
 vcs-svn/line_buffer.c  |    6 ++++++
 vcs-svn/line_buffer.h  |    1 +
 4 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 33a728e..a8eeb20 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -151,6 +151,15 @@ test_expect_success 'skip, copy null byte' '
 	test_cmp expect actual
 '
 
+test_expect_success 'read null byte' '
+	echo ">QhelloQ" | q_to_nul >expect &&
+	q_to_nul <<-\EOF | test-line-buffer >actual &&
+	binary 8
+	QhelloQ
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'long reads are truncated' '
 	echo foo >expect &&
 	test-line-buffer <<-\EOF >actual &&
@@ -171,4 +180,13 @@ test_expect_success 'long copies are truncated' '
 	test_cmp expect actual
 '
 
+test_expect_success 'long binary reads are truncated' '
+	echo ">foo" >expect &&
+	test-line-buffer <<-\EOF >actual &&
+	binary 5
+	foo
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-line-buffer.c b/test-line-buffer.c
index ec19b13..19bf2d4 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -3,6 +3,7 @@
  */
 
 #include "git-compat-util.h"
+#include "strbuf.h"
 #include "vcs-svn/line_buffer.h"
 
 static uint32_t strtouint32(const char *s)
@@ -17,6 +18,15 @@ static uint32_t strtouint32(const char *s)
 static void handle_command(const char *command, const char *arg, struct line_buffer *buf)
 {
 	switch (*command) {
+	case 'b':
+		if (!prefixcmp(command, "binary ")) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addch(&sb, '>');
+			buffer_read_binary(buf, &sb, strtouint32(arg));
+			fwrite(sb.buf, 1, sb.len, stdout);
+			strbuf_release(&sb);
+			return;
+		}
 	case 'c':
 		if (!prefixcmp(command, "copy ")) {
 			buffer_copy_bytes(buf, strtouint32(arg));
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 806932b..661b007 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -56,6 +56,12 @@ char *buffer_read_string(struct line_buffer *buf, uint32_t len)
 	return ferror(buf->infile) ? NULL : buf->blob_buffer.buf;
 }
 
+void buffer_read_binary(struct line_buffer *buf,
+				struct strbuf *sb, uint32_t size)
+{
+	strbuf_fread(sb, size, buf->infile);
+}
+
 void buffer_copy_bytes(struct line_buffer *buf, uint32_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index fb37390..0c2d3d9 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -16,6 +16,7 @@ int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_deinit(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
+void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
 void buffer_copy_bytes(struct line_buffer *buf, uint32_t len);
 void buffer_skip_bytes(struct line_buffer *buf, uint32_t len);
 void buffer_reset(struct line_buffer *buf);
-- 
1.7.4.rc0.580.g89dc.dirty
