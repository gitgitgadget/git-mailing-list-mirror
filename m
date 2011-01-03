From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/12] vcs-svn: allow input from file descriptor
Date: Sun, 2 Jan 2011 21:09:38 -0600
Message-ID: <20110103030938.GD10143@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
 <20110103030328.GA10143@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 04:09:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZanw-0001U0-J8
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 04:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab1ACDJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 22:09:47 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54091 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1ACDJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 22:09:46 -0500
Received: by ywl5 with SMTP id 5so5145359ywl.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 19:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PSVDX5SVL46iMiIxAT8wF5HJ5e/XCzp4Z8YnKJDNmOY=;
        b=nhlv//lf9C46Ky5+zbT/kSthM8rqFh0EIlg1LoT59LvxNK4bt0GPGor40VbXMMfrf2
         RbOhjSXTHwoZt2l6jMoW1NC5TEjgYF1S+rId2U6h4Zi9Qh21oBe9A7v/3ANUxBnW8gEd
         8a+tnpwxGLOy6uQkqH64uGc8Dth4IfzRT6YoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OWGKvEjCHDkKg3zED6iDJv9gsiivTsTlIzBPTSkPOFeZhSwWcQZaJOZkY8lKbmXX9I
         5Wa4k+1TKGPs7HTTG4iRKarVXAy4THqe1kWZZwcXPFA0BAPXI3dWBNzk+rX6+SIl8o0J
         wRCZxc2Qjr84idTPGvqvCPkxlGZwo2ZCBt2wI=
Received: by 10.146.86.14 with SMTP id j14mr28318923yab.31.1294024185971;
        Sun, 02 Jan 2011 19:09:45 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id i10sm27510088anh.12.2011.01.02.19.09.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 19:09:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103030328.GA10143@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164440>

Based-on-patch-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
No fd_buffer.  This is essentially the way David did it in the first
place; sorry to have doubted.

 t/t0081-line-buffer.sh  |    9 +++++++++
 test-line-buffer.c      |   11 ++++++++---
 vcs-svn/line_buffer.c   |    8 ++++++++
 vcs-svn/line_buffer.h   |    1 +
 vcs-svn/line_buffer.txt |    9 +++++----
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index a8eeb20..550fad0 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -131,6 +131,15 @@ test_expect_success PIPE,EXPENSIVE 'longer read (around 65536 bytes)' '
 	long_read_test 65536
 '
 
+test_expect_success 'read from file descriptor' '
+	rm -f input &&
+	echo hello >expect &&
+	echo hello >input &&
+	echo copy 6 |
+	test-line-buffer "&4" 4<input >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'buffer_read_string copes with null byte' '
 	>expect &&
 	q_to_nul <<-\EOF | test-line-buffer >actual &&
diff --git a/test-line-buffer.c b/test-line-buffer.c
index 19bf2d4..25b20b9 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -69,13 +69,18 @@ int main(int argc, char *argv[])
 	else if (argc == 2)
 		filename = argv[1];
 	else
-		usage("test-line-buffer [file] < script");
+		usage("test-line-buffer [file | &fd] < script");
 
 	if (buffer_init(&stdin_buf, NULL))
 		die_errno("open error");
 	if (filename) {
-		if (buffer_init(&file_buf, filename))
-			die_errno("error opening %s", filename);
+		if (*filename == '&') {
+			if (buffer_fdinit(&file_buf, strtouint32(filename + 1)))
+				die_errno("error opening fd %s", filename + 1);
+		} else {
+			if (buffer_init(&file_buf, filename))
+				die_errno("error opening %s", filename);
+		}
 		input = &file_buf;
 	}
 
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 37ec56e..e29a81a 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -17,6 +17,14 @@ int buffer_init(struct line_buffer *buf, const char *filename)
 	return 0;
 }
 
+int buffer_fdinit(struct line_buffer *buf, int fd)
+{
+	buf->infile = fdopen(fd, "r");
+	if (!buf->infile)
+		return -1;
+	return 0;
+}
+
 int buffer_deinit(struct line_buffer *buf)
 {
 	int err;
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 0a59c73..630d83c 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -13,6 +13,7 @@ struct line_buffer {
 #define LINE_BUFFER_INIT {"", STRBUF_INIT, NULL}
 
 int buffer_init(struct line_buffer *buf, const char *filename);
+int buffer_fdinit(struct line_buffer *buf, int fd);
 int buffer_deinit(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
index f8eaa4d..4e8fb71 100644
--- a/vcs-svn/line_buffer.txt
+++ b/vcs-svn/line_buffer.txt
@@ -27,10 +27,11 @@ resources.
 Functions
 ---------
 
-`buffer_init`::
-	Open the named file for input.  If filename is NULL,
-	start reading from stdin.  On failure, returns -1 (with
-	errno indicating the nature of the failure).
+`buffer_init`, `buffer_fdinit`::
+	Open the named file or file descriptor for input.
+	buffer_init(buf, NULL) prepares to read from stdin.
+	On failure, returns -1 (with errno indicating the nature
+	of the failure).
 
 `buffer_deinit`::
 	Stop reading from the current file (closing it unless
-- 
1.7.4.rc0.580.g89dc.dirty
