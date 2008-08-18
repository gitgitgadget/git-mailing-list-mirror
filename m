From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-compat-util.h: adjust for SGI IRIX 6.5
Date: Mon, 18 Aug 2008 18:05:21 -0500
Message-ID: <pJRtiHdsP9HbnKMePwHZJe4brRLzVt3u6tqH8mkWqf8@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:06:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDnw-0002Jr-1U
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYHRXFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYHRXFY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:05:24 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55809 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbYHRXFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:05:23 -0400
Received: by mail.nrlssc.navy.mil id m7IN5LB2025852; Mon, 18 Aug 2008 18:05:21 -0500
In-Reply-To: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:05:21.0150 (UTC) FILETIME=[E38A31E0:01C90186]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92750>

Don't define _XOPEN_SOURCE
Do    define _SGI_SOURCE
Declare the _xpg5 versions of *snprintf() along with wrapper macros

Defining _XOPEN_SOURCE prevents many of the common functions and macros
from being defined. _Not_ setting _XOPEN_SOURCE, and instead setting
_SGI_SOURCE, provides all of the XPG4, XPG5, BSD, POSIX functions and
declarations, _BUT_ provides a horribly broken snprintf(). The provided
snprintf() can not be worked around using git's compat workaround, since
SGI's vsnprintf() always returns the number of characters written into
the string, instead of -1 which is what git's compat version expects.
SGI does have a working snprintf(), but it is only provided when
_NO_XOPEN5 evaluates to zero, and this only happens if _XOPEN_SOURCE is
defined which, as mentioned above, prevents many other common functions
and defines. The working *snprintf() functions are named _xpg5_vsnprintf()
and _xpg5_snprintf(), so declarations for these two functions were added
to git-compat-util.h and macros were added for vsnprintf and snprintf to
call these versions.
---
 git-compat-util.h |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cf89cdf..f22707c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -39,13 +39,14 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
-#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
+#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(sgi)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
+#define _SGI_SOURCE 1
 
 #include <unistd.h>
 #include <stdio.h>
@@ -262,6 +263,15 @@ extern int git_snprintf(char *str, size_t maxsize,
 #define vsnprintf git_vsnprintf
 extern int git_vsnprintf(char *str, size_t maxsize,
 			 const char *format, va_list ap);
+#elif defined(sgi)
+extern int      _xpg5_vsnprintf(char * __restrict,
+                        __SGI_LIBC_NAMESPACE_QUALIFIER size_t,
+                        const char * __restrict, /* va_list */ char *);
+#define vsnprintf _xpg5_vsnprintf
+extern int      _xpg5_snprintf(char * __restrict,
+                        __SGI_LIBC_NAMESPACE_QUALIFIER size_t,
+                        const char * __restrict, ...);
+#define snprintf _xpg5_snprintf
 #endif
 
 #ifdef __GLIBC_PREREQ
-- 
1.6.0.13.ge1c8
