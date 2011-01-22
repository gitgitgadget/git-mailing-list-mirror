From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [FYI/PATCH] vcs-svn: give control over temporary file names
Date: Sat, 22 Jan 2011 00:42:35 -0600
Message-ID: <20110122064235.GA10304@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
 <20110103030328.GA10143@burratino>
 <20110103031059.GE10143@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 22 07:43:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgXBr-0005XA-Sa
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 07:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab1AVGnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jan 2011 01:43:01 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63444 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab1AVGnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jan 2011 01:43:00 -0500
Received: by gwj20 with SMTP id 20so750014gwj.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 22:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=A0sq26Xtl3JHDbSgiphT0L5tdYO1EDPHJraaHclrMi4=;
        b=S34zZ06hyfStWJWM2lrK+j60c+gADemSq/bgFxC/soOIU0DG3mvpr4SOs7oWhY09UO
         fffsqAGnZkrDeV+DweQBxgfrNMdpgE48D/Q1rqiB4opjOI7E+dojobplDxq24FVVYQ1A
         YQiiephd8SCsYdYjxuJO1kJK5ZTEdCCJSRvnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F0bfo6oHkhF/Aq5G3yoMiVra0pAymAA+LoMuNiV0mVdCjKNyVKjQ1wyQS2Zi3VtIGk
         9dxJBP8WLr4SDoJJug8Qps3ZDQ5b9nPZvX6jro8LjoeC/3JnhSEBfARHhu9Y9x4NThzB
         MI+Dd1AJD7YFquNPkzECwnz0wIZDcyoQ4SCwI=
Received: by 10.100.112.4 with SMTP id k4mr1123871anc.66.1295678579454;
        Fri, 21 Jan 2011 22:42:59 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id c7sm12587974ana.17.2011.01.21.22.42.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 22:42:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103031059.GE10143@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165407>

Allow users of the line_buffer library to specify what directory and
filename to use for temporary files.  For example:

	struct line_buffer tmp = LINE_BUFFER_INIT;
	if (buffer_tmpfile_init(&tmp, ".git", "svnfe_blob.XXXXXX"))
		die_errno("opening temporary file");
	...
	if (buffer_deinit(&tmp))
		die_errno("removing temporary file");

On Windows, something like this is needed if users without write
permission to the root directory are to be able to use temporary
files.

Unlike the implementation using tmpfile, this would not take
care of automatically removing the temporary file on exit.  The
user is responsible for now for installing appropriate signal and
atexit handlers to take care of that.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I have an odd feeling this will be necessary at some point but I'm not
sure if it's a good idea or not.  Although tmpfile(3) is a limited
interface, it's pretty much exactly what we want.

See [1] for tmpfile on Windows.

This is just to get the idea out there.  I don't think this patch's
moment has come (though I'd be interested in your thoughts either
way).

[1] http://msdn.microsoft.com/en-us/library/x8x7sakw.aspx

 vcs-svn/line_buffer.c |   35 ++++++++++++++++++++++++++++++-----
 vcs-svn/line_buffer.h |    6 ++++--
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index aedf105..4131e08 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -3,7 +3,7 @@
  * See LICENSE for details.
  */
 
-#include "git-compat-util.h"
+#include "cache.h"
 #include "line_buffer.h"
 #include "strbuf.h"
 
@@ -25,12 +25,33 @@ int buffer_fdinit(struct line_buffer *buf, int fd)
 	return 0;
 }
 
-int buffer_tmpfile_init(struct line_buffer *buf)
+int buffer_tmpfile_init(struct line_buffer *buf,
+			const char *dirname, const char *pattern)
 {
-	buf->infile = tmpfile();
-	if (!buf->infile)
-		return -1;
+	int fd, saved_errno;
+	int mode = 0444;	/* just remove write permission. */
+	strbuf_addstr(&buf->temp_filename, dirname);
+	strbuf_addch(&buf->temp_filename, '/');
+	strbuf_addstr(&buf->temp_filename, pattern);
+
+	fd = git_mkstemp_mode(buf->temp_filename.buf, mode);
+	if (fd < 0) {
+		saved_errno = errno;
+		goto fail_mktemp;
+	}
+	buf->infile = fdopen(fd, "r+");
+	if (!buf->infile) {
+		saved_errno = errno;
+		goto fail_fdopen;
+	}
 	return 0;
+
+fail_fdopen:
+	close(fd);
+fail_mktemp:
+	strbuf_reset(&buf->temp_filename);
+	errno = saved_errno;
+	return -1;
 }
 
 int buffer_deinit(struct line_buffer *buf)
@@ -40,6 +61,9 @@ int buffer_deinit(struct line_buffer *buf)
 		return ferror(buf->infile);
 	err = ferror(buf->infile);
 	err |= fclose(buf->infile);
+	if (buf->temp_filename.len)
+		err |= unlink_or_warn(buf->temp_filename.buf);
+	strbuf_reset(&buf->temp_filename);
 	return err;
 }
 
@@ -129,4 +153,5 @@ void buffer_skip_bytes(struct line_buffer *buf, uint32_t len)
 void buffer_reset(struct line_buffer *buf)
 {
 	strbuf_release(&buf->blob_buffer);
+	strbuf_release(&buf->temp_filename);
 }
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 96ce966..bd1a621 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -9,15 +9,17 @@ struct line_buffer {
 	char line_buffer[LINE_BUFFER_LEN];
 	struct strbuf blob_buffer;
 	FILE *infile;
+	struct strbuf temp_filename;
 };
-#define LINE_BUFFER_INIT {"", STRBUF_INIT, NULL}
+#define LINE_BUFFER_INIT {"", STRBUF_INIT, NULL, STRBUF_INIT}
 
 int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_fdinit(struct line_buffer *buf, int fd);
 int buffer_deinit(struct line_buffer *buf);
 void buffer_reset(struct line_buffer *buf);
 
-int buffer_tmpfile_init(struct line_buffer *buf);
+int buffer_tmpfile_init(struct line_buffer *buf,
+		const char *directory, const char *pattern);
 FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to write. */
 long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
 
-- 
1.7.4.rc2
