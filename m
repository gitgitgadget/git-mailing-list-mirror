From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/16] vcs-svn: Make buffer_skip_bytes() report partial reads
Date: Sun, 10 Oct 2010 21:44:21 -0500
Message-ID: <20101011024421.GE1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 04:47:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58QQ-0001vt-DZ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab0JKCrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:47:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59468 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0JKCrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:47:36 -0400
Received: by gyg13 with SMTP id 13so607491gyg.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lUBDkT9mhZZazIWiLKPRl6KD0S3RxKwHrMQHng8wgX8=;
        b=UO6ZauxYd/sKKJfKYSgEpd8G8Wec4JqBbpBdTPyQXMNJlNquaiL/+N9r4bACKYGkkq
         FlmiS94NS8K0pZUJG5SXEjtXxL9UMU+KSDSYnk8oM/1RDvtMlOaHeCSK+JfOP4wtn7tf
         GJJeWh3+9/751U3lvSHHRIGkKiCIS0oqYFPsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YOPb7djI3rZ0N/IgtU3aaCxvdqdFuJuzqJ6ciBrpBSFTVxgV5UrwoTcf6vR1amnmgn
         4EXQHywdYQVvW5aluv2T/MT6KQqi9RRUZzrc4kEQEzk6C6pHAh/lW8BMQT9PGR2qAYnw
         VXJqUlfNOfHh26eDo4qB4462X7iGtThFGDq4g=
Received: by 10.150.11.5 with SMTP id 5mr6097802ybk.110.1286765255422;
        Sun, 10 Oct 2010 19:47:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q41sm5315795ybk.1.2010.10.10.19.47.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:47:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158735>

Tell the caller know how many bytes were actually skipped.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.txt |    3 ++-
 vcs-svn/line_buffer.c   |   15 ++++++++-------
 vcs-svn/line_buffer.h   |    2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
index f8eaa4d..d06db24 100644
--- a/vcs-svn/line_buffer.txt
+++ b/vcs-svn/line_buffer.txt
@@ -53,7 +53,8 @@ Functions
 
 `buffer_skip_bytes`::
 	Discards `len` bytes from the input stream (stopping early
-	if necessary because of an error or eof).
+	if necessary because of an error or eof).  Return value is
+	the number of bytes successfully read.
 
 `buffer_reset`::
 	Deallocates non-static buffers.
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 806932b..999368b 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -72,15 +72,16 @@ void buffer_copy_bytes(struct line_buffer *buf, uint32_t len)
 	}
 }
 
-void buffer_skip_bytes(struct line_buffer *buf, uint32_t len)
+uint32_t buffer_skip_bytes(struct line_buffer *buf, uint32_t nbytes)
 {
-	char byte_buffer[COPY_BUFFER_LEN];
-	uint32_t in;
-	while (len > 0 && !feof(buf->infile) && !ferror(buf->infile)) {
-		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-		in = fread(byte_buffer, 1, in, buf->infile);
-		len -= in;
+	uint32_t done = 0;
+	while (done < nbytes && !feof(buf->infile) && !ferror(buf->infile)) {
+		char byte_buffer[COPY_BUFFER_LEN];
+		uint32_t len = nbytes - done;
+		uint32_t in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+		done += fread(byte_buffer, 1, in, buf->infile);
 	}
+	return done;
 }
 
 void buffer_reset(struct line_buffer *buf)
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index fb37390..2796ba7 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -17,7 +17,7 @@ int buffer_deinit(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 void buffer_copy_bytes(struct line_buffer *buf, uint32_t len);
-void buffer_skip_bytes(struct line_buffer *buf, uint32_t len);
+uint32_t buffer_skip_bytes(struct line_buffer *buf, uint32_t len);
 void buffer_reset(struct line_buffer *buf);
 
 #endif
-- 
1.7.2.3
