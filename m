From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] vcs-svn: collect line_buffer data in a struct
Date: Fri, 24 Dec 2010 02:18:44 -0600
Message-ID: <20101224081844.GD29681@burratino>
References: <20101224080505.GA29681@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 09:25:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW2xU-0007Ec-Fc
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 09:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab0LXIY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 03:24:59 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46363 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab0LXIY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 03:24:58 -0500
Received: by ywl5 with SMTP id 5so2928537ywl.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=m9BhPX9RjeOfXEMmyra47KRwvHewCql5AZtdTkDdqtI=;
        b=YXokMl3X9XTmOW9GCKO0DhGjS/ZlJ1kab1VD3m6bjSXnZ6SQrgehIvc+ndwF8upAY8
         OM1jjX9fL8CWBb9r7+Pzpv2HbCkVVTpoyWzB2tUSYRMrdobtefBW+uXd4ZuPaja5xzPZ
         b76wTG7l3PdpUP9qH8Y+b3Eqetw9kx9VKcacQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xFw4FVRCu7CEVcScizIqUY+1mgmyx2lRhFcSsQHAirD3P2bxK4l6hLxXUVsHxuvEim
         xjomNCw6XbkIlJkTnLmo4pyigbj3zfAUUp2hg6D++NZDpyLcrrQ6xRhmswPQcPTFzvRQ
         NMhXiIRqHoAyYWbi/IpzSJfVLgphTwTwuINis=
Received: by 10.236.109.141 with SMTP id s13mr17818492yhg.16.1293178734367;
        Fri, 24 Dec 2010 00:18:54 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id i60sm4930982yhj.17.2010.12.24.00.18.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 00:18:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101224080505.GA29681@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164149>

Date: Sun, 10 Oct 2010 21:39:21 -0500

Prepare for the line_buffer lib to support input from multiple files,
by collecting global state in a struct that can be easily passed
around.

No API change yet.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
A simple search-and-replace kind of job.  If gcc is smart, there
should be no change in code size or performance, but I haven't
checked.  

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
1.7.2.3.554.gc9b5c.dirty
