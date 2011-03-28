From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/16] vcs-svn: skeleton of an svn delta parser
Date: Sun, 27 Mar 2011 22:30:13 -0500
Message-ID: <20110328033013.GD11987@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-7-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 05:30:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q43A0-0003a5-B9
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 05:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab1C1Da0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 23:30:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62562 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1C1DaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 23:30:24 -0400
Received: by ywj3 with SMTP id 3so1030922ywj.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JZ1IEVGKO8pX8X/YOqIJStUL9owMz2w0NFaNxGIeD14=;
        b=adv1UUb6ZBWmqftTYJJTcmB/BAH12Kt2pjXR4GzJm31lteGoFJ/hGEcUU9HRhif1/V
         i+aiyyXytgROCAPSX7WJL5a8vlqVbtnJZwQDG+RD4ZOmO/nfj93wU/Ik4DsklngbMF6P
         bnEUki4MANqcp1n+A8IZKjryM1bBH814hO5dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fd3qbkEJ2R2mhYIPRKqz26lqNzvkZ8ShtZvjUQLpBMUzbLUf4Zez3Tyuku2FDZkYy0
         yvJJTSvaz94ReDL0VEUgMtFe9HxMVCid4ow2vsrjKH1fVLX2VCWpip7T2IEpxlwPERqb
         S/OxDO3e4hhizg9erXcGd3ICTnIzoGgGGj534=
Received: by 10.91.95.11 with SMTP id x11mr3363002agl.192.1301283023256;
        Sun, 27 Mar 2011 20:30:23 -0700 (PDT)
Received: from elie ([68.255.101.206])
        by mx.google.com with ESMTPS id u37sm1153402yba.7.2011.03.27.20.30.18
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 20:30:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300519254-20201-7-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170098>

(culling cc list)
Hi,

David Barr wrote:

> --- a/vcs-svn/line_buffer.c
> +++ b/vcs-svn/line_buffer.c
> @@ -98,10 +98,10 @@ char *buffer_read_string(struct line_buffer *buf, uint32_t len)
>  	return ferror(buf->infile) ? NULL : buf->blob_buffer.buf;
>  }
>  
> -void buffer_read_binary(struct line_buffer *buf,
> -				struct strbuf *sb, uint32_t size)
> +off_t buffer_read_binary(struct line_buffer *buf,
> +				struct strbuf *sb, off_t size)
>  {
> -	strbuf_fread(sb, size, buf->infile);
> +	return strbuf_fread(sb, size, buf->infile);
>  }

Apparently this change is from in an evil merge.  Yikes.

Anyway, I think the original patch was something like the following.
Would you mind if the parameter and return value go back to being of
type size_t (to avoid a possibly problematic conversion when passing
values to and from strbuf_fread)?

-- 8< --
Date: Sun, 2 Jan 2011 21:37:36 -0600
Subject: vcs-svn: make buffer_read_binary API more convenient

buffer_read_binary is a thin wrapper around fread, but its signature
is wrong:

 - fread can fill an arbitrary in-memory buffer.  buffer_read_binary
   is limited to buffers whose size is representable by a 32-bit
   integer.
 - The result from fread is the number of bytes actually read.
   buffer_read_binary only reports the number of bytes read by
   incrementing sb->len by that amount and returns void.

Fix both: let buffer_read_binary accept a size_t instead of uint32_t
for the number of bytes to try to read and as a convenience return the
number of bytes read.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |    6 +++---
 vcs-svn/line_buffer.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index c390387..01fcb84 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -91,10 +91,10 @@ char *buffer_read_line(struct line_buffer *buf)
 	return buf->line_buffer;
 }
 
-void buffer_read_binary(struct line_buffer *buf,
-				struct strbuf *sb, uint32_t size)
+size_t buffer_read_binary(struct line_buffer *buf,
+				struct strbuf *sb, size_t size)
 {
-	strbuf_fread(sb, size, buf->infile);
+	return strbuf_fread(sb, size, buf->infile);
 }
 
 off_t buffer_copy_bytes(struct line_buffer *buf, off_t nbytes)
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index d0b22dd..8901f21 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -23,7 +23,7 @@ long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
 int buffer_ferror(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 int buffer_read_char(struct line_buffer *buf);
-void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
+size_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, size_t len);
 /* Returns number of bytes read (not necessarily written). */
 off_t buffer_copy_bytes(struct line_buffer *buf, off_t len);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
-- 
1.7.4.2.660.g270d4b.dirty
