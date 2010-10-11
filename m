From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/16] vcs-svn: Collect line_buffer data in a struct
Date: Sun, 10 Oct 2010 21:39:21 -0500
Message-ID: <20101011023921.GC1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 04:42:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58La-0008DV-AT
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab0JKCmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:42:37 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40198 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab0JKCmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:42:36 -0400
Received: by gwj17 with SMTP id 17so839941gwj.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+b+xgoSPOOzk3jYOo70IeiN+ydmxUZgho7/sbhv5bH4=;
        b=Zr5X1nO5NliTiKoQpZ/8Wx0uV8kzHrJ78EIbYp7XVlbc2vZRyABOmoSOGuEIPC7+Xc
         rwKucrHoxvPSNsYdqyQZnfxoWJ3ePkGzVwTZ2aTyC19HSN2JFifiDG79XBXQnJO7cqZc
         LHL+KFzhHxKB7PyUet3H8xN2yDFZnBx1KWt/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RfMxBWxRzcJa3ypqiZ84jNw7Qt1QN3+ANkw8NIjX5iob2g7Vra0LTaH7OJWawYJzc8
         cyjh0rxU0UWgBRdP83zN3VqzumUvv0f4x8Xt3sELhGfE1A/lzDA5FlniJG4EzMGYAbWO
         6yO6FPbNoF9rQPGX7g9L3q3EQRfIt1ZVSVfG0=
Received: by 10.100.253.14 with SMTP id a14mr2332211ani.47.1286764955328;
        Sun, 10 Oct 2010 19:42:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w3sm7586696anw.5.2010.10.10.19.42.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:42:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158733>

Prepare for the line_buffer lib to support input from multiple files,
by collecting global state in a struct that can be easily passed around.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |   45 ++++++++++++++++++++++-----------------------
 vcs-svn/line_buffer.h |   11 +++++++++++
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 6f32f28..e7bc230 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -7,17 +7,16 @@
 #include "line_buffer.h"
 #include "strbuf.h"
 
-#define LINE_BUFFER_LEN 10000
 #define COPY_BUFFER_LEN 4096
-
-static char line_buffer[LINE_BUFFER_LEN];
-static struct strbuf blob_buffer = STRBUF_INIT;
-static FILE *infile;
+static struct line_buffer buf_ = LINE_BUFFER_INIT;
+static struct line_buffer *buf;
 
 int buffer_init(const char *filename)
 {
-	infile = filename ? fopen(filename, "r") : stdin;
-	if (!infile)
+	buf = &buf_;
+
+	buf->infile = filename ? fopen(filename, "r") : stdin;
+	if (!buf->infile)
 		return -1;
 	return 0;
 }
@@ -25,10 +24,10 @@ int buffer_init(const char *filename)
 int buffer_deinit(void)
 {
 	int err;
-	if (infile == stdin)
-		return ferror(infile);
-	err = ferror(infile);
-	err |= fclose(infile);
+	if (buf->infile == stdin)
+		return ferror(buf->infile);
+	err = ferror(buf->infile);
+	err |= fclose(buf->infile);
 	return err;
 }
 
@@ -36,13 +35,13 @@ int buffer_deinit(void)
 char *buffer_read_line(void)
 {
 	char *end;
-	if (!fgets(line_buffer, sizeof(line_buffer), infile))
+	if (!fgets(buf->line_buffer, sizeof(buf->line_buffer), buf->infile))
 		/* Error or data exhausted. */
 		return NULL;
-	end = line_buffer + strlen(line_buffer);
+	end = buf->line_buffer + strlen(buf->line_buffer);
 	if (end[-1] == '\n')
 		end[-1] = '\0';
-	else if (feof(infile))
+	else if (feof(buf->infile))
 		; /* No newline at end of file.  That's fine. */
 	else
 		/*
@@ -51,23 +50,23 @@ char *buffer_read_line(void)
 		 * but for now let's return an error.
 		 */
 		return NULL;
-	return line_buffer;
+	return buf->line_buffer;
 }
 
 char *buffer_read_string(uint32_t len)
 {
-	strbuf_reset(&blob_buffer);
-	strbuf_fread(&blob_buffer, len, infile);
-	return ferror(infile) ? NULL : blob_buffer.buf;
+	strbuf_reset(&buf->blob_buffer);
+	strbuf_fread(&buf->blob_buffer, len, buf->infile);
+	return ferror(buf->infile) ? NULL : buf->blob_buffer.buf;
 }
 
 void buffer_copy_bytes(uint32_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
-	while (len > 0 && !feof(infile) && !ferror(infile)) {
+	while (len > 0 && !feof(buf->infile) && !ferror(buf->infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-		in = fread(byte_buffer, 1, in, infile);
+		in = fread(byte_buffer, 1, in, buf->infile);
 		len -= in;
 		fwrite(byte_buffer, 1, in, stdout);
 		if (ferror(stdout)) {
@@ -81,14 +80,14 @@ void buffer_skip_bytes(uint32_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
-	while (len > 0 && !feof(infile) && !ferror(infile)) {
+	while (len > 0 && !feof(buf->infile) && !ferror(buf->infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-		in = fread(byte_buffer, 1, in, infile);
+		in = fread(byte_buffer, 1, in, buf->infile);
 		len -= in;
 	}
 }
 
 void buffer_reset(void)
 {
-	strbuf_release(&blob_buffer);
+	strbuf_release(&buf->blob_buffer);
 }
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 9c78ae1..4ae1133 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -1,6 +1,17 @@
 #ifndef LINE_BUFFER_H_
 #define LINE_BUFFER_H_
 
+#include "strbuf.h"
+
+#define LINE_BUFFER_LEN 10000
+
+struct line_buffer {
+	char line_buffer[LINE_BUFFER_LEN];
+	struct strbuf blob_buffer;
+	FILE *infile;
+};
+#define LINE_BUFFER_INIT {"", STRBUF_INIT, NULL}
+
 int buffer_init(const char *filename);
 int buffer_deinit(void);
 char *buffer_read_line(void);
-- 
1.7.2.3
