From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/12] vcs-svn: allow character-oriented input
Date: Sun, 2 Jan 2011 21:06:32 -0600
Message-ID: <20110103030632.GC10143@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
 <20110103030328.GA10143@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 04:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZakx-0008TF-LS
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 04:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329Ab1ACDGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 22:06:42 -0500
Received: from mail-gy0-f194.google.com ([209.85.160.194]:41498 "EHLO
	mail-gy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1ACDGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 22:06:41 -0500
Received: by gyf1 with SMTP id 1so3108202gyf.1
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 19:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5IqJsNnMaOIIu4uyh90/D7ZkRM/Qu5uSYaO3BNclYvY=;
        b=V1S1fgE32QkDofUf43Ezga8jy9IBsct/z22Ow13fu8c2LuiqwoyE79nVIokbJJYy0Q
         nDz0pNI7O9jfs+DkYjpKMNo+FtOq/ubScVdrV6YoI6X9OQ0j8+6vpnyjgVZogSmGGfMZ
         kPwUHuoePOzQwBqZcfrFCuFr/nLIIH0CJ1Xrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P4rJ1HC+7hwV1RyJEGsYcgLyPRf9b/v9KVfqZMe2IEdnYFYinakOa0VHga/NOoPJSb
         HgVAImiB7DNExQ/xNF9X3rtWnIwNWsE04pQzQYWl7jmi2HLOFSdJ4GUpmvXeHcOyQDz2
         uUm/fFDxKSsOUUaXpdI0M2DymckGzPooVKfwM=
Received: by 10.90.115.12 with SMTP id n12mr11635630agc.195.1294024000621;
        Sun, 02 Jan 2011 19:06:40 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id y21sm11930813yhc.10.2011.01.02.19.06.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 19:06:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103030328.GA10143@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164439>

buffer_read_char can be used in place of buffer_read_string(1) to
avoid consuming valuable static buffer space.  The delta applier will
use this to read variable-length integers one byte at a time.

Underneath, it is fgetc, wrapped so the line_buffer library can
maintain its role as gatekeeper of input.

Later it might be worth checking if fgetc_unlocked is faster ---
most line_buffer functions are not thread-safe anyway.

Helpd-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |    5 +++++
 vcs-svn/line_buffer.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 661b007..37ec56e 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -27,6 +27,11 @@ int buffer_deinit(struct line_buffer *buf)
 	return err;
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
index 0c2d3d9..0a59c73 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -16,6 +16,7 @@ int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_deinit(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
+int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
 void buffer_copy_bytes(struct line_buffer *buf, uint32_t len);
 void buffer_skip_bytes(struct line_buffer *buf, uint32_t len);
-- 
1.7.4.rc0.580.g89dc.dirty
