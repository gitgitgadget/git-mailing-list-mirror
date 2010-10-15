From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] compat: add memrchr()
Date: Fri, 15 Oct 2010 10:26:08 -0500
Message-ID: <20101015152608.GA9450@burratino>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org>
 <20101015051750.GA21830@burratino>
 <loom.20101015T105350-205@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Yann Dirson <ydirson@altern.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ludvig Strigeus <ludde@strigeus.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 17:29:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6mEF-0006SN-KN
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 17:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab0JOP3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 11:29:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55284 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab0JOP3m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 11:29:42 -0400
Received: by iwn35 with SMTP id 35so1027053iwn.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sOE0kIf7HjaKnPGfqCDC78pVdtrscdXMv1tCxr319+4=;
        b=D10ZJjKK/RXAlvdQ2MbwcNTIkpFNeNceQE05/10pecEkUb9T1GMBFAnPwOgwvq3DwX
         +fRHnJIVruv36GzYmGLiz2bUJidYbL0vQf8qwgSRnj3oDTRewp9PZvMZakiTEB6Cc0cV
         3CAasZ7UehQGrSFg8pBulY9ky2URvh7LW1jb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bV5SjCuvsHjlGXxlLqp2SsSjUxNx5mcsVMC7VSvmbEyK9KyTvXevpMIvPnM9tkTBMX
         ZK/5lZnhSFS4rCbvzIE+ePlfxZ8KOHaMKQKazT2rlsW2I+xKv20qmzBA+8kupFjCadh9
         oObGSSWsUKS9XNrXai8/SGrNqahj4QqKXXbZo=
Received: by 10.231.31.6 with SMTP id w6mr804234ibc.64.1287156579309;
        Fri, 15 Oct 2010 08:29:39 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d40sm11028555ibc.13.2010.10.15.08.29.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 08:29:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20101015T105350-205@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159121>

Reimplement another handy convenience function from glibc.  memrchr()
searches from the end of a memory area for a particular character.  It
is similar to strrchr() but takes a length argument and is
binary-safe.

The whole-directory rename detection patch could use this to find the
last '/' in a (possibly truncated) pathname.

The system memrchr() is used on glibc systems to provide a sanity
check that our code works with a non-custom implementation.  Yes, the
various BSDs have their own highly optimized memrchr(), too.  The
planned use of memrchr in git is for clarity, not speed, so it is not
obvious that the makefile+autoconf magic to use libc's implementation
on a wide variety of operating systems would be worth the time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Ludvig Strigeus wrote:

> System memrchr uses a byte comparison rather than an int comparison.
> 
> "The memchr() function scans the first n bytes of the memory area pointed to by
> s for the character c. The first byte to match c (interpreted as an unsigned
> character) stops the operation. "

Oh, right.  (strchr() uses char, memchr() uses unsigned char.)

 git-compat-util.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 2af8d3e..6de9dee 100644
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
+	const unsigned char *p = s;
+	p += n;
+	while (p != s)
+		if (*--p == (unsigned char) c)
+			return p;
+	return NULL;
+}
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 typedef void (*try_to_free_t)(size_t);
-- 
1.7.2.3
