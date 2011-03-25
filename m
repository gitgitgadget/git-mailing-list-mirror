From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] vcs-svn: remove buffer_read_string
Date: Thu, 24 Mar 2011 23:09:19 -0500
Message-ID: <20110325040919.GC3007@elie>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
 <20110325033431.GA3007@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 05:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2yL5-00054h-AS
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 05:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337Ab1CYEJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 00:09:25 -0400
Received: from mail-gw0-f51.google.com ([74.125.83.51]:49121 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1CYEJY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 00:09:24 -0400
Received: by gwj17 with SMTP id 17so67384gwj.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+hRCOqYQScB8LC2oZe5NJXDEhF/EeTKYfF6ReIusolg=;
        b=TnkrR8Bo/3R9OH/lX5+qcRGwX7CpqXnyVEgBd/WtoMiShDFLOkXdl1OxZsicxLJoib
         nRbB9F4oSgG2aRJIMI35oztZ3hGYILslCAzzAK9TcbJfeqxHBuhwlGBp6En2vcjWyTJr
         gl0Lasth9FbsGIVx3Akf0a01GC1tV+WUtDGWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VMeCnLOFZtX7JJnE+GlBtwLcnFhyATEYTUoVsMUbzv4vlB364oxWAqK7ISktQLCjNB
         zwcF2llFmLjQhGapEymKRti3G08uH2V4BFJwApqGCWwfzKfH8eeJTFtWvy3W+Nqc8iCU
         9w78bDzjQplkwyavFgbOErsOh8bOSLBMgf9k4=
Received: by 10.236.190.69 with SMTP id d45mr446239yhn.60.1301026164037;
        Thu, 24 Mar 2011 21:09:24 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.sbcglobal.net [68.255.102.141])
        by mx.google.com with ESMTPS id u5sm343538yhn.51.2011.03.24.21.09.22
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 21:09:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110325033431.GA3007@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169961>

All previous users of buffer_read_string have already been converted
to use the more intuitive buffer_read_binary, so remove the old API to
avoid some confusion.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0081-line-buffer.sh  |   35 +++++++++++++----------------------
 test-line-buffer.c      |    6 ------
 vcs-svn/line_buffer.c   |    8 --------
 vcs-svn/line_buffer.h   |    4 +---
 vcs-svn/line_buffer.txt |   12 +++---------
 5 files changed, 17 insertions(+), 48 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 550fad0..1dbe1c9 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -53,7 +53,7 @@ long_read_test () {
 		} >input &
 	} &&
 	test-line-buffer input <<-EOF >output &&
-	read $readsize
+	binary $readsize
 	copy $copysize
 	EOF
 	kill $! &&
@@ -71,23 +71,23 @@ test_expect_success 'setup: have pipes?' '
 '
 
 test_expect_success 'hello world' '
-	echo HELLO >expect &&
+	echo ">HELLO" >expect &&
 	test-line-buffer <<-\EOF >actual &&
-	read 6
+	binary 6
 	HELLO
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success PIPE '0-length read, no input available' '
-	>expect &&
+	printf ">" >expect &&
 	rm -f input &&
 	mkfifo input &&
 	{
 		sleep 100 >input &
 	} &&
 	test-line-buffer input <<-\EOF >actual &&
-	read 0
+	binary 0
 	copy 0
 	EOF
 	kill $! &&
@@ -95,9 +95,9 @@ test_expect_success PIPE '0-length read, no input available' '
 '
 
 test_expect_success '0-length read, send along greeting' '
-	echo HELLO >expect &&
+	echo ">HELLO" >expect &&
 	test-line-buffer <<-\EOF >actual &&
-	read 0
+	binary 0
 	copy 6
 	HELLO
 	EOF
@@ -105,7 +105,7 @@ test_expect_success '0-length read, send along greeting' '
 '
 
 test_expect_success PIPE '1-byte read, no input available' '
-	printf "%s" ab >expect &&
+	printf ">%s" ab >expect &&
 	rm -f input &&
 	mkfifo input &&
 	{
@@ -116,7 +116,7 @@ test_expect_success PIPE '1-byte read, no input available' '
 		} >input &
 	} &&
 	test-line-buffer input <<-\EOF >actual &&
-	read 1
+	binary 1
 	copy 1
 	EOF
 	kill $! &&
@@ -140,15 +140,6 @@ test_expect_success 'read from file descriptor' '
 	test_cmp expect actual
 '
 
-test_expect_success 'buffer_read_string copes with null byte' '
-	>expect &&
-	q_to_nul <<-\EOF | test-line-buffer >actual &&
-	read 2
-	Q
-	EOF
-	test_cmp expect actual
-'
-
 test_expect_success 'skip, copy null byte' '
 	echo Q | q_to_nul >expect &&
 	q_to_nul <<-\EOF | test-line-buffer >actual &&
@@ -170,18 +161,18 @@ test_expect_success 'read null byte' '
 '
 
 test_expect_success 'long reads are truncated' '
-	echo foo >expect &&
+	echo ">foo" >expect &&
 	test-line-buffer <<-\EOF >actual &&
-	read 5
+	binary 5
 	foo
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'long copies are truncated' '
-	printf "%s\n" "" foo >expect &&
+	printf "%s\n" ">" foo >expect &&
 	test-line-buffer <<-\EOF >actual &&
-	read 1
+	binary 1
 
 	copy 5
 	foo
diff --git a/test-line-buffer.c b/test-line-buffer.c
index 25b20b9..7ec9b13 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -32,12 +32,6 @@ static void handle_command(const char *command, const char *arg, struct line_buf
 			buffer_copy_bytes(buf, strtouint32(arg));
 			return;
 		}
-	case 'r':
-		if (!prefixcmp(command, "read ")) {
-			const char *s = buffer_read_string(buf, strtouint32(arg));
-			fputs(s, stdout);
-			return;
-		}
 	case 's':
 		if (!prefixcmp(command, "skip ")) {
 			buffer_skip_bytes(buf, strtouint32(arg));
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 33e733a..c390387 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -91,13 +91,6 @@ char *buffer_read_line(struct line_buffer *buf)
 	return buf->line_buffer;
 }
 
-char *buffer_read_string(struct line_buffer *buf, uint32_t len)
-{
-	strbuf_reset(&buf->blob_buffer);
-	strbuf_fread(&buf->blob_buffer, len, buf->infile);
-	return ferror(buf->infile) ? NULL : buf->blob_buffer.buf;
-}
-
 void buffer_read_binary(struct line_buffer *buf,
 				struct strbuf *sb, uint32_t size)
 {
@@ -134,5 +127,4 @@ off_t buffer_skip_bytes(struct line_buffer *buf, off_t nbytes)
 
 void buffer_reset(struct line_buffer *buf)
 {
-	strbuf_release(&buf->blob_buffer);
 }
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index f5c468a..d0b22dd 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -7,10 +7,9 @@
 
 struct line_buffer {
 	char line_buffer[LINE_BUFFER_LEN];
-	struct strbuf blob_buffer;
 	FILE *infile;
 };
-#define LINE_BUFFER_INIT {"", STRBUF_INIT, NULL}
+#define LINE_BUFFER_INIT { "", NULL }
 
 int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_fdinit(struct line_buffer *buf, int fd);
@@ -23,7 +22,6 @@ long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
 
 int buffer_ferror(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
-char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
 /* Returns number of bytes read (not necessarily written). */
diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
index 4ef0755..8e139eb 100644
--- a/vcs-svn/line_buffer.txt
+++ b/vcs-svn/line_buffer.txt
@@ -16,8 +16,8 @@ The calling program:
 
  - initializes a `struct line_buffer` to LINE_BUFFER_INIT
  - specifies a file to read with `buffer_init`
- - processes input with `buffer_read_line`, `buffer_read_string`,
-   `buffer_skip_bytes`, and `buffer_copy_bytes`
+ - processes input with `buffer_read_line`, `buffer_skip_bytes`,
+   and `buffer_copy_bytes`
  - closes the file with `buffer_deinit`, perhaps to start over and
    read another file.
 
@@ -37,7 +37,7 @@ the calling program.  A program
    the temporary file
  - declares writing is over with `buffer_tmpfile_prepare_to_read`
  - can re-read what was written with `buffer_read_line`,
-   `buffer_read_string`, and so on
+   `buffer_copy_bytes`, and so on
  - can reuse the temporary file by calling `buffer_tmpfile_rewind`
    again
  - removes the temporary file with `buffer_deinit`, perhaps to
@@ -64,12 +64,6 @@ Functions
 	Read a line and strip off the trailing newline.
 	On failure or end of file, returns NULL.
 
-`buffer_read_string`::
-	Read `len` characters of input or up to the end of the
-	file, whichever comes first.  Returns NULL on error.
-	Returns whatever characters were read (possibly "")
-	for end of file.
-
 `buffer_copy_bytes`::
 	Read `len` bytes of input and dump them to the standard output
 	stream.  Returns early for error or end of file.
-- 
1.7.4.1
