From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/16] vcs-svn: Eliminate global byte_buffer[] array
Date: Sun, 10 Oct 2010 21:37:10 -0500
Message-ID: <20101011023710.GA1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 04:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58Jb-0007JL-PP
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab0JKCke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:40:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61142 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0JKCke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:40:34 -0400
Received: by yxm8 with SMTP id 8so48881yxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SSQllt/NlOqJ7nxOjy8aIYGQsAZHWF2Zlp7JF6ciPIo=;
        b=u+ue7zBUM44Su7QIFN1eTdaasiDFBm1uJO+0UvBoQgDT422ONzJv/fZDy26zpDBZsa
         4DrPLipPggayRelTufRqvxBuoZ5yXtb2SONAVJ11t0CjBnm5ZlI6ACVxmJaWHUosrPmV
         fxsmoj11X3HpMjSUZWxEVyIYpuIdIACN88wI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c9hTyYX7c8jYKLFjEqiDQ8nArgU3+/J+Ry4PHVkeYKqaJmeTIK76/ZGtUFP9yMQfl/
         QkQFI4RuVt3l6oOTb47jsKcggPjce44khQQG/cxuw1gUAb0qGNyoZieY4I5asQUeR6QE
         XRPi+RCRePqs0wi+XiAntdaZnXh1pSgy3PCQM=
Received: by 10.151.49.19 with SMTP id b19mr6054434ybk.194.1286764833499;
        Sun, 10 Oct 2010 19:40:33 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q18sm2297916ybk.15.2010.10.10.19.40.32
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:40:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158732>

The data stored in byte_buffer[] is always either discarded or
written to stdout immediately.  No need for it to persist between
function calls.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 1543567..f22c94f 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -14,7 +14,6 @@
 obj_pool_gen(blob, char, 4096)
 
 static char line_buffer[LINE_BUFFER_LEN];
-static char byte_buffer[COPY_BUFFER_LEN];
 static FILE *infile;
 
 int buffer_init(const char *filename)
@@ -68,6 +67,7 @@ char *buffer_read_string(uint32_t len)
 
 void buffer_copy_bytes(uint32_t len)
 {
+	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
 	while (len > 0 && !feof(infile) && !ferror(infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
@@ -83,6 +83,7 @@ void buffer_copy_bytes(uint32_t len)
 
 void buffer_skip_bytes(uint32_t len)
 {
+	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
 	while (len > 0 && !feof(infile) && !ferror(infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-- 
1.7.2.3
