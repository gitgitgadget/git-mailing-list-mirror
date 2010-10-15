From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] compat: add memrchr()
Date: Fri, 15 Oct 2010 00:17:50 -0500
Message-ID: <20101015051750.GA21830@burratino>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 07:21:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6cjN-0004Yp-8m
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 07:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab0JOFVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 01:21:20 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57628 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0JOFVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 01:21:19 -0400
Received: by gxk6 with SMTP id 6so175868gxk.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 22:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4+Kns+4uedpVfKGHEXz06sGatdZkBdx9Eir35DnqQBI=;
        b=J4OzNnV6nEodVX4b6X5KwpzAIP9Y+e/g0waXWzeWYpy6V5KZiCMluLvWg2U7eXkyHH
         1BXotILgfunoz2ligiISGpocwFfnLvI0kMc2MoZmt10P+In9TIjxNMfcUbJe9Xye4vhY
         0DKI3w9TZsFDHC1Np06bjJBn8pe6qBqsiFFh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gu6Z8FN747dV7rmdpglhFId2/hq3cnTKbfY3GyNMmnVAU0wo2Wk+yldiIPclPbSTmT
         rz3ryE+aUwU3b0yd7Xq840hvP8XQ2NHNpMDz4yvcHUSf+NFE7I6C1GzedUFtH/M1jSqO
         9I/aSMLLbUY1H9/jfmXsQt8AfYKizmSbPWnJ8=
Received: by 10.150.202.12 with SMTP id z12mr862303ybf.279.1287120078719;
        Thu, 14 Oct 2010 22:21:18 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id t9sm10134138ybe.21.2010.10.14.22.21.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 22:21:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287098999-9244-1-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159093>

Reimplement another handy convenience function from glibc.  memrchr()
searches from the end of a memory area for a particular character.  It
is similar to strrchr() but takes a length argument and is
binary-safe.

The whole-directory rename detection patch could use this to find the
last directory separator in a (possibly truncated) pathname.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Yann Dirson wrote:

> * memrchr() implementation for portability

Something like this?  Untested.

 git-compat-util.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 2af8d3e..6f1020e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -366,6 +366,9 @@ extern int git_vsnprintf(char *str, size_t maxsize,
 #define HAVE_STRCHRNUL
 #define HAVE_MEMPCPY
 #endif
+#if __GLIBC_PREREQ(2, 2)
+#define HAVE_MEMRCHR
+#endif
 #endif
 
 #ifndef HAVE_STRCHRNUL
@@ -386,6 +389,19 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
 }
 #endif
 
+#ifndef HAVE_MEMRCHR
+#define memrchr gitmemrchr
+static inline void *gitmemrchr(const void *s, int c, size_t n)
+{
+	const char *p = s;
+	p += n;
+	while (p != s)
+		if (*--p == c)
+			return p;
+	return NULL;
+}
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 typedef void (*try_to_free_t)(size_t);
-- 
1.7.2.3
