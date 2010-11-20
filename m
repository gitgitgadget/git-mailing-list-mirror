From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/8] vcs-svn: Teach line_buffer about temporary files
Date: Sat, 20 Nov 2010 13:29:04 -0600
Message-ID: <20101120192904.GH17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt7d-00034R-DV
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab0KTT3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:29:13 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42755 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0KTT3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:29:12 -0500
Received: by gyb11 with SMTP id 11so599539gyb.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gkSzO9ZEGGrgQkPJzMcoJ5gCuK1nXCMo6pUUL8hh0OY=;
        b=TKATPPEHBUmPzSLtGxsSXPeT3Exp9lNEphZREtuiAJCU0MWAV9CcMB+lG4iE06YgnY
         iK27Q9JURoGHjnIfS96bL92paFPgjZitFTtyxELe3Cg5YI8ztp8LdLH4Vx8bGDscpc7W
         4DjiIPt4xGelWIvqLmYtro8QB0EHiMfE7Pi5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k2vUMgd1yrxclMLbTksYB9uJCdYBAspnXdW8ibkIK4YrV4TBzKp2Ppk63B/HhQXfiW
         8bUR3Ebo/ZX3g1PQJ+8FsbBP9ZI6Wfbt3bTrBk7TH9Lp4gQ/rj443ci19NqiuOQYqnXH
         ahkaV2J0gfLCvfNeW03xT7mbamidavZvjzYT8=
Received: by 10.90.23.27 with SMTP id 27mr3242100agw.39.1290281351338;
        Sat, 20 Nov 2010 11:29:11 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id i2sm1986295yha.31.2010.11.20.11.29.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:29:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161837>

It can sometimes be useful to write information temporarily to file,
to read back later.  These functions allow you to do so.

The dump file importer would use this to save a postimage from delta
application until the length is known and fast-import is ready to read
it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c   |   24 ++++++++++++++++++++++++
 vcs-svn/line_buffer.h   |    7 ++++++-
 vcs-svn/line_buffer.txt |   22 ++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index c54031b..f583623 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -42,6 +42,30 @@ int buffer_at_eof(struct line_buffer *buf)
 	return 0;
 }
 
+int buffer_tmpfile_init(struct line_buffer *buf)
+{
+	buf->infile = tmpfile();
+	if (!buf->infile)
+		return error("cannot open temporary file: %s", strerror(errno));
+	return 0;
+}
+
+FILE *buffer_tmpfile_rewind(struct line_buffer *buf)
+{
+	rewind(buf->infile);
+	return buf->infile;
+}
+
+long buffer_tmpfile_prepare_to_read(struct line_buffer *buf)
+{
+	long pos = ftell(buf->infile);
+	if (pos < 0)
+		return error("ftell error: %s", strerror(errno));
+	if (fseek(buf->infile, 0, SEEK_SET))
+		return error("seek error: %s", strerror(errno));
+	return pos;
+}
+
 int buffer_read_char(struct line_buffer *buf)
 {
 	return fgetc(buf->infile);
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 2375ee1..1db7434 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -16,12 +16,17 @@ int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_deinit(struct line_buffer *buf);
 int buffer_ferror(struct line_buffer *buf);
 int buffer_at_eof(struct line_buffer *buf);
+void buffer_reset(struct line_buffer *buf);
+
+int buffer_tmpfile_init(struct line_buffer *buf);
+FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to write. */
+long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
+
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct strbuf *sb, uint32_t len, struct line_buffer *f);
 void buffer_copy_bytes(struct line_buffer *buf, off_t len);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
-void buffer_reset(struct line_buffer *buf);
 
 #endif
diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
index d06db24..344efc3 100644
--- a/vcs-svn/line_buffer.txt
+++ b/vcs-svn/line_buffer.txt
@@ -24,6 +24,28 @@ The calling program:
 When finished, the caller can use `buffer_reset` to deallocate
 resources.
 
+Using temporary files
+---------------------
+
+Sometimes a file is just a convenient place to stash data for
+later.  A program
+
+ - initializes a `struct line_buffer` to LINE_BUFFER_INIT
+ - allocates a temporary file with `buffer_tmpfile_init`
+ - acquires an output handle by calling `buffer_tmpfile_rewind`
+ - uses standard I/O functions like `fprintf` and `fwrite` to fill
+   the temporary file
+ - declares writing is over with `buffer_tmpfile_prepare_to_read`
+ - can re-read what was written with `buffer_read_line`,
+   `buffer_read_string`, and so on
+ - can reuse the temporary file by calling `buffer_tmpfile_rewind`
+   again
+ - cleans up the temporary file with `buffer_deinit`, perhaps to
+   reuse the line_buffer for some other file.
+
+When finished, the program should use `buffer_reset` to deallocate
+resources.
+
 Functions
 ---------
 
-- 
1.7.2.3
