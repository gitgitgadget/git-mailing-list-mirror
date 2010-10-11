From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/16] vcs-svn: Learn to check for SVN\0 magic
Date: Sun, 10 Oct 2010 21:58:00 -0500
Message-ID: <20101011025800.GM1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 05:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58dd-0007nQ-Dp
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 05:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab0JKDBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 23:01:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40060 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab0JKDBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 23:01:15 -0400
Received: by gwj17 with SMTP id 17so843071gwj.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wqYVRlKpgBG4etUfzhm6fNNkDhXPA9wmQgq5cqOTICg=;
        b=n6a/WkTvJe1ZpmYUpS8nWVrOZBolVPuUmfVro4tpvoCxZqBf9c0xsyztpEqA7K3I2M
         U8Ch0U3UirjmCvdKBQNzOPQvP3ibIwLPKBTvWXqpEBaRqGz727+ZB70VYAKyENtBAEMq
         j4Yhx1SStnjjXKrBhNvlkF3bFad2Ejp86aWz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fo8ub9zOJjTpp0ai6J2VqoKAzwr3EfPqRRg/xaXuKrLwJBZfTexhqE8d/4i6PG/4v5
         OY7KKGe+R5+MATtOSrgQnlWhxglfqbeGi73f/DfC9yNTSVC/U3VLAhMaix9p42uxUhYS
         utQobe6fzPoul5ZBjJ4CvZbZySYWhzhkIRJ2I=
Received: by 10.150.146.1 with SMTP id t1mr3635372ybd.308.1286766074355;
        Sun, 10 Oct 2010 20:01:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q14sm5325210ybk.19.2010.10.10.20.01.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 20:01:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158743>

The magic number of svn deltas is SVN followed by a null byte.
An alternative format (with compressed text) uses magic number SVN\1,
but that is deprecated in favor of compressing the deltas as a whole
as far as I can tell.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndiff.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 4d122a5..df0b1a2 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -11,6 +11,7 @@
  *
  * See http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff.
  *
+ * svndiff0 ::= 'SVN\0' window window*;
  * int ::= highdigit* lowdigit;
  * highdigit ::= # binary 1000 0000 OR-ed with 7 bit value;
  * lowdigit ::= # 7 bit value;
@@ -20,6 +21,23 @@
 #define VLI_DIGIT_MASK	0x7f
 #define VLI_BITS_PER_DIGIT 7
 
+static int read_magic(struct line_buffer *in, off_t *len)
+{
+	static const char magic[] = {'S', 'V', 'N', '\0'};
+	struct strbuf sb = STRBUF_INIT;
+	if (*len < sizeof(magic))
+		return error("Invalid delta: no file type header");
+	buffer_read_binary(&sb, sizeof(magic), in);
+	if (sb.len != sizeof(magic))
+		return error("Invalid delta: no file type header");
+	if (memcmp(sb.buf, magic, sizeof(magic)))
+		return error("Unrecognized file type %.*s",
+			     (int) sizeof(magic), sb.buf);
+	*len -= sizeof(magic);
+	strbuf_release(&sb);
+	return 0;
+}
+
 static int read_int(struct line_buffer *in, uintmax_t *result, off_t *len)
 {
 	off_t sz = *len;
-- 
1.7.2.3
