From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/16] vcs-svn: Replace buffer_read_string() memory pool with
 a strbuf
Date: Sun, 10 Oct 2010 22:11:42 -0500
Message-ID: <20101011031142.GQ1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 05:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58qt-0005Pr-Uv
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 05:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab0JKDO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 23:14:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44369 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab0JKDO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 23:14:57 -0400
Received: by gxk9 with SMTP id 9so845780gxk.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 20:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4G8p3QlHJi/AEEFTMjpi4vpvNENAhdbuwRZojvqIHOo=;
        b=GWAizG131upWVr7oceGfZohEK8P3sW1JHJa4MZ8eMP6eyCyZEJesDecGeTyO0hzxbg
         VnTbBPw+bPmYqQqJ0e7gjoCq5eM7ItYQ9htdVrWtsWIVsO+AU8sYjL1VFa7MJ7Yuub7U
         pWOdaU3SqhzuLyBnybgIfR5P+leJQ7nxPrFcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UYJ6qvLq12AV3s7ak4hRJvrWfFW+ya3rUtApepc3PXkTSae2SSwQ2X7FaVN17csCTJ
         YNcOHvKr6LxWX/koHktrS4DK7ukh3IaPMjeixXKbcOg/CBvYxFeOmWoIV3ncmUqJVzzm
         N2kBU0ruVTCm4Kax9fiYbHEAKqim+fIAqct5g=
Received: by 10.150.197.19 with SMTP id u19mr6018532ybf.131.1286766896337;
        Sun, 10 Oct 2010 20:14:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q14sm5336606ybk.19.2010.10.10.20.14.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 20:14:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158747>

The buffer_read_string() function returns a temporary string of
size specified by the caller.  It currently uses an obj_pool to
store the return value, but that is overkill: all we need is a
buffer that can grow between requests to accomodate larger
strings.

Use a strbuf instead.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[Resent after messing up the message header; sorry for the noise.]

 vcs-svn/line_buffer.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index f22c94f..6f32f28 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -5,15 +5,13 @@
 
 #include "git-compat-util.h"
 #include "line_buffer.h"
-#include "obj_pool.h"
+#include "strbuf.h"
 
 #define LINE_BUFFER_LEN 10000
 #define COPY_BUFFER_LEN 4096
 
-/* Create memory pool for char sequence of known length */
-obj_pool_gen(blob, char, 4096)
-
 static char line_buffer[LINE_BUFFER_LEN];
+static struct strbuf blob_buffer = STRBUF_INIT;
 static FILE *infile;
 
 int buffer_init(const char *filename)
@@ -58,11 +56,9 @@ char *buffer_read_line(void)
 
 char *buffer_read_string(uint32_t len)
 {
-	char *s;
-	blob_free(blob_pool.size);
-	s = blob_pointer(blob_alloc(len + 1));
-	s[fread(s, 1, len, infile)] = '\0';
-	return ferror(infile) ? NULL : s;
+	strbuf_reset(&blob_buffer);
+	strbuf_fread(&blob_buffer, len, infile);
+	return ferror(infile) ? NULL : blob_buffer.buf;
 }
 
 void buffer_copy_bytes(uint32_t len)
@@ -94,5 +90,5 @@ void buffer_skip_bytes(uint32_t len)
 
 void buffer_reset(void)
 {
-	blob_reset();
+	strbuf_release(&blob_buffer);
 }
-- 
1.7.2.3
