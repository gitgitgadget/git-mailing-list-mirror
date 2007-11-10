From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Simplify strchrnul() compat code
Date: Sat, 10 Nov 2007 12:55:48 +0100
Message-ID: <47359C44.6090903@lsrfire.ath.cx>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqows-00009F-Ht
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbXKJL4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 06:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbXKJL4K
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:56:10 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:58305
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751324AbXKJL4J (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 06:56:09 -0500
Received: from [10.0.1.201] (p57B7EF01.dip.t-dialin.net [87.183.239.1])
	by neapel230.server4you.de (Postfix) with ESMTP id A126E873BA;
	Sat, 10 Nov 2007 12:56:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <473434ED.50002@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64336>

From: Andreas Ericsson <ae@op5.se>

strchrnul() was introduced in glibc in April 1999 and included in
glibc-2.1. Checking for that version means the majority of all git
users would get to use the optimized version in glibc. Of the
remaining few some might get to use a slightly slower version
than necessary but probably not slower than what we have today.

Rediffed-against-next-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
I agree that we can do without providing a way to use a native
version outside glibc until we actually encounter such a thing.

 Makefile           |   13 -------------
 compat/strchrnul.c |    8 --------
 git-compat-util.h  |    9 +++++++--
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index 4f1d7ca..4a5d2b9 100644
--- a/Makefile
+++ b/Makefile
@@ -30,8 +30,6 @@ all::
 #
 # Define NO_MEMMEM if you don't have memmem.
 #
-# Define NO_STRCHRNUL if you don't have strchrnul.
-#
 # Define NO_STRLCPY if you don't have strlcpy.
 #
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
@@ -409,7 +407,6 @@ ifeq ($(uname_S),Darwin)
 	OLD_ICONV = UnfortunatelyYes
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_STRCHRNUL = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -417,7 +414,6 @@ ifeq ($(uname_S),SunOS)
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_STRCHRNUL = YesPlease
 	NO_HSTRERROR = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
@@ -443,7 +439,6 @@ ifeq ($(uname_O),Cygwin)
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_STRCHRNUL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
@@ -458,14 +453,12 @@ endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_STRCHRNUL = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_STRCHRNUL = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
@@ -481,7 +474,6 @@ endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
-	NO_STRCHRNUL = YesPlease
 	NO_STRLCPY = YesPlease
 	NEEDS_LIBICONV=YesPlease
 endif
@@ -494,7 +486,6 @@ ifeq ($(uname_S),IRIX64)
 	NO_SETENV=YesPlease
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
-	NO_STRCHRNUL = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_SOCKADDR_STORAGE=YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
@@ -705,10 +696,6 @@ ifdef NO_MEMMEM
 	COMPAT_CFLAGS += -DNO_MEMMEM
 	COMPAT_OBJS += compat/memmem.o
 endif
-ifdef NO_STRCHRNUL
-	COMPAT_CFLAGS += -DNO_STRCHRNUL
-	COMPAT_OBJS += compat/strchrnul.o
-endif
 
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
diff --git a/compat/strchrnul.c b/compat/strchrnul.c
deleted file mode 100644
index 51839fe..0000000
--- a/compat/strchrnul.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include "../git-compat-util.h"
-
-char *gitstrchrnul(const char *s, int c)
-{
-	while (*s && *s != c)
-		s++;
-	return (char *)s;
-}
diff --git a/git-compat-util.h b/git-compat-util.h
index e72654b..11e6df6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -183,9 +183,14 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
                 const void *needle, size_t needlelen);
 #endif
 
-#ifdef NO_STRCHRNUL
+#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
 #define strchrnul gitstrchrnul
-char *gitstrchrnul(const char *s, int c);
+static inline char *gitstrchrnul(const char *s, int c)
+{
+        while (*s && *s != c)
+                s++;
+        return (char *)s;
+}
 #endif
 
 extern void release_pack_memory(size_t, int);
