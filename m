From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/12] vcs-svn: teach line_buffer about temporary files
Date: Sun, 2 Jan 2011 21:10:59 -0600
Message-ID: <20110103031059.GE10143@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
 <20110103030328.GA10143@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 04:11:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZapG-0002Fn-UL
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 04:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab1ACDLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 22:11:09 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43118 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1ACDLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 22:11:08 -0500
Received: by qyk12 with SMTP id 12so14616741qyk.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 19:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CFpWSPmT82XlfTSojgqxW0YSl9JU3uy3vquC92hq20Q=;
        b=ligbKDh/YEHltPKNDDatnL05SoaKZNFLcguFHTMKedCSJIHqVrzPzdHDZV1B5iP9FJ
         aNsSU5tt73VhAb7GvylqTUMBzcujPjmcH3YDtxQvK+T3cDO1QwiJG38ZFpqsvu5IvUJy
         yLC5HMoOrCmyE4eZkkwzU3CgrvurbB+qP4SUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XbTPzyjnKhh0RH7Yf6lybl1dOTqfd8Jrl92aCuQOYCxucM81x4Kgs7Aurl+LZd7/yQ
         3whq/SDfLXNsNhyNRbIK1rNL9rbdw/A4YbCZo92wCSFQ3X163jL8lgD8rUcFyJ3piz/y
         +PYsnq1c68z11KVj2sh6moGRrUPAyTwuMi7w0=
Received: by 10.224.61.21 with SMTP id r21mr6499023qah.245.1294024268116;
        Sun, 02 Jan 2011 19:11:08 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id g32sm11722968qck.34.2011.01.02.19.11.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 19:11:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103030328.GA10143@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164441>

It can sometimes be useful to write information temporarily to file,
to read back later.  These functions allow a program to use the
line_buffer facilities when doing so.

It works like this:

 1. find a unique filename with buffer_tmpfile_init.
 2. rewind with buffer_tmpfile_rewind.  This returns a stdio
    handle for writing.
 3. when finished writing, declare so with
    buffer_tmpfile_prepare_to_read.  The return value indicates
    how many bytes were written.
 4. read whatever portion of the file is needed.
 5. if finished, remove the temporary file with buffer_deinit.
    otherwise, go back to step 2,

The svn support would use this to buffer the postimage from delta
application until the length is known and fast-import can receive
the resulting blob.

Based-on-patch-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
David, this is another piece of infrastructure from early svn-fe3
history.  I've cleaned up the API a little bit but the idea is the
same.  Thank you.

 vcs-svn/line_buffer.c   |   24 ++++++++++++++++++++++++
 vcs-svn/line_buffer.h   |    7 ++++++-
 vcs-svn/line_buffer.txt |   22 ++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index e29a81a..aedf105 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -25,6 +25,14 @@ int buffer_fdinit(struct line_buffer *buf, int fd)
 	return 0;
 }
 
+int buffer_tmpfile_init(struct line_buffer *buf)
+{
+	buf->infile = tmpfile();
+	if (!buf->infile)
+		return -1;
+	return 0;
+}
+
 int buffer_deinit(struct line_buffer *buf)
 {
 	int err;
@@ -35,6 +43,22 @@ int buffer_deinit(struct line_buffer *buf)
 	return err;
 }
 
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
index 630d83c..96ce966 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -15,12 +15,17 @@ struct line_buffer {
 int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_fdinit(struct line_buffer *buf, int fd);
 int buffer_deinit(struct line_buffer *buf);
+void buffer_reset(struct line_buffer *buf);
+
+int buffer_tmpfile_init(struct line_buffer *buf);
+FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to write. */
+long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
+
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
 void buffer_copy_bytes(struct line_buffer *buf, uint32_t len);
 void buffer_skip_bytes(struct line_buffer *buf, uint32_t len);
-void buffer_reset(struct line_buffer *buf);
 
 #endif
diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
index 4e8fb71..e89cc41 100644
--- a/vcs-svn/line_buffer.txt
+++ b/vcs-svn/line_buffer.txt
@@ -24,6 +24,28 @@ The calling program:
 When finished, the caller can use `buffer_reset` to deallocate
 resources.
 
+Using temporary files
+---------------------
+
+Temporary files provide a place to store data that should not outlive
+the calling program.  A program
+
+ - initializes a `struct line_buffer` to LINE_BUFFER_INIT
+ - requests a temporary file with `buffer_tmpfile_init`
+ - acquires an output handle by calling `buffer_tmpfile_rewind`
+ - uses standard I/O functions like `fprintf` and `fwrite` to fill
+   the temporary file
+ - declares writing is over with `buffer_tmpfile_prepare_to_read`
+ - can re-read what was written with `buffer_read_line`,
+   `buffer_read_string`, and so on
+ - can reuse the temporary file by calling `buffer_tmpfile_rewind`
+   again
+ - removes the temporary file with `buffer_deinit`, perhaps to
+   reuse the line_buffer for some other file.
+
+When finished, the calling program can use `buffer_reset` to deallocate
+resources.
+
 Functions
 ---------
 
-- 
1.7.4.rc0.580.g89dc.dirty
