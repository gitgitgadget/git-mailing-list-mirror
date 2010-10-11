From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/16] vcs-svn: Allow input errors to be detected early
Date: Sun, 10 Oct 2010 21:51:21 -0500
Message-ID: <20101011025121.GI1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 04:54:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58XH-0004vf-6S
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab0JKCyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:54:38 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56336 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab0JKCyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:54:37 -0400
Received: by gxk9 with SMTP id 9so842437gxk.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aF8wX+eeT67+VY45xS/E8QFKM2bIOkWY76bnSQv7VsM=;
        b=nqNKRhIbArbyJ1B0/QY9Pxqxf1qNOun8n4aJmXgVU2JjZA62w0pGHw/bh/EubYgNVw
         xtZVAhysJ4LAfLip8GHC/tlhYn7fS3eaAJbtpUBVFYzezfGTEXizWE/jJPxEYpTjx70m
         +pe5vg+tn369fwPwbZ8HanvdBAjOzK+qN0BDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jzfNABhVgh16RSoVe/2/1To6J9JgrIdzSsHNh5iouOGmueeahm14Ulp57UzMWxV9/X
         zm1jtAvlAj3r7KqTwOrkjh/7AQCxYfJ9Iz/1XvyfR5bEe8BX26pxB/+GZChu8mFpvBGB
         NN9Yn9CQb0VVSX3goybZA45nXFI9X56N4F2uc=
Received: by 10.236.103.169 with SMTP id f29mr10677299yhg.8.1286765675651;
        Sun, 10 Oct 2010 19:54:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z70sm1264815yhc.36.2010.10.10.19.54.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:54:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158739>

Add a buffer_ferror() function to read the error flag from the input
stream, so callers can do:

	some_error_prone_operation(f, ...);
	if (buffer_ferror(f))
		return error("input error: %s", strerror(errno));

instead of waiting until it is time to close the file.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |    5 +++++
 vcs-svn/line_buffer.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 19caa21..43da509 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -27,6 +27,11 @@ int buffer_deinit(struct line_buffer *buf)
 	return err;
 }
 
+int buffer_ferror(struct line_buffer *buf)
+{
+	return ferror(buf->infile);
+}
+
 int buffer_at_eof(struct line_buffer *buf)
 {
 	int ch;
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 0269aed..4899289 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -14,6 +14,7 @@ struct line_buffer {
 
 int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_deinit(struct line_buffer *buf);
+int buffer_ferror(struct line_buffer *buf);
 int buffer_at_eof(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
-- 
1.7.2.3
