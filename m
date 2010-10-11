From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/16] vcs-svn: Allow character-oriented input
Date: Sun, 10 Oct 2010 21:52:17 -0500
Message-ID: <20101011025217.GJ1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 04:55:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58Y5-0005KX-A1
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab0JKCzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:55:32 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:32911 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab0JKCzc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:55:32 -0400
Received: by gxk9 with SMTP id 9so842595gxk.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JOWT6JF1R5rfadlSaOpPxe3kRs5LyXYwzl7R99KNEx8=;
        b=mmEbsCsLFzPFgwV0wJabUCzocOG96KdU3F4EqVFqSYN1TZbD/yhcS6gi1cKuREb2yW
         9N8Dt6yDZr9OUVTSyeHNIpdTaCBM2we3WyNyNgHy5rXCic3Na3+jXfo7O4pcf1EuW/6x
         lx6R1miF50HfML7FLn+3MZbPr1WlFPH5U9KhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tuR2Cav8V/bha9oBlLL5hzr+xJDefKcGza6y97U+KJhHyfEXdZ/+TmF6KQaIzbe0+M
         h2vHkcuQ9hEgqAcWm53LNg9F0qmm/Cu8okg9Acr0LRZQyWMNLt0hfLKGF4K6rrrv3lsi
         TlwqjWdZ/I8DtUpRRhcALQv8Uj8HhvrIsdje4=
Received: by 10.236.110.52 with SMTP id t40mr10623087yhg.61.1286765731539;
        Sun, 10 Oct 2010 19:55:31 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x45sm4697247yhc.45.2010.10.10.19.55.30
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:55:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158740>

buffer_read_char() can be used in place of buffer_read_string(1)
to avoid consuming valuable static buffer space.  The delta applier
will use this to read variable-length integers one byte at a time.

Underneath, it is fgetc(), wrapped so the line_buffer library can
maintain its role as gatekeeper of input.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |    5 +++++
 vcs-svn/line_buffer.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 43da509..c54031b 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -42,6 +42,11 @@ int buffer_at_eof(struct line_buffer *buf)
 	return 0;
 }
 
+int buffer_read_char(struct line_buffer *buf)
+{
+	return fgetc(buf->infile);
+}
+
 /* Read a line without trailing newline. */
 char *buffer_read_line(struct line_buffer *buf)
 {
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 4899289..2375ee1 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -18,6 +18,7 @@ int buffer_ferror(struct line_buffer *buf);
 int buffer_at_eof(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
+int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct strbuf *sb, uint32_t len, struct line_buffer *f);
 void buffer_copy_bytes(struct line_buffer *buf, off_t len);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
-- 
1.7.2.3
