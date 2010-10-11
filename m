From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/16] vcs-svn: Add binary-safe read() function
Date: Sun, 10 Oct 2010 21:47:02 -0500
Message-ID: <20101011024702.GG1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 04:50:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58T2-00033I-0u
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab0JKCuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:50:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51668 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab0JKCuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:50:16 -0400
Received: by yxm8 with SMTP id 8so50462yxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZnwsSptY8HR06kn3Ul2jiEkoQS6f2guQZAqp/WzYAIg=;
        b=qMiXEf6BfZ0MOheMUrY+w32md+lDUamOoEy4ue82Dp8lmjN/5GOQlRrhxusCNX2COQ
         d3OfJyCJ2dMqz0oKzpb+a1lSp5/GmvVWp55cOo8DqOQLfjsLmNKZ+pQ9e1EdBEG68SZf
         X4JU/9gd9JzH9z8xOUcgfN2BbUmwTxY4vwNgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dP1ishmJZtYcqpncRD9pc8vjzK+nRDRau9x/wfSJV3uUe1fOSH/IAWtN2QKp1afac8
         ZrABKG03sznbAiSHy0Rz5d0J25dq5/ZTFgWOvCEhmoF1Gcv0VhCi1RW0SYHZgijZFuEo
         Wc8iSMl+00x/0uFfugu9yNSmBkpDHjAa4gGt4=
Received: by 10.236.108.44 with SMTP id p32mr10669986yhg.12.1286765416067;
        Sun, 10 Oct 2010 19:50:16 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 27sm4690715yhl.34.2010.10.10.19.50.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:50:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158737>

buffer_read_binary() writes to a strbuf so the caller does not need
to keep track of the number of bytes read.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |    6 ++++++
 vcs-svn/line_buffer.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index fd1d3c3..6dd0189 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -56,6 +56,12 @@ char *buffer_read_string(struct line_buffer *buf, uint32_t len)
 	return ferror(buf->infile) ? NULL : buf->blob_buffer.buf;
 }
 
+void buffer_read_binary(struct strbuf *sb, uint32_t size,
+			struct line_buffer *buf)
+{
+	strbuf_fread(sb, size, buf->infile);
+}
+
 void buffer_copy_bytes(struct line_buffer *buf, off_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 2849faa..873b0e4 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -16,6 +16,7 @@ int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_deinit(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
+void buffer_read_binary(struct strbuf *sb, uint32_t len, struct line_buffer *f);
 void buffer_copy_bytes(struct line_buffer *buf, off_t len);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
 void buffer_reset(struct line_buffer *buf);
-- 
1.7.2.3
