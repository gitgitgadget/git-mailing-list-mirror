From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2] Revert "compat: add strtok_r()"
Date: Tue, 26 Feb 2013 17:58:38 +0100
Message-ID: <1361897918-8824-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, b@rr-dav.id.au,
	Erik Faye-Lund <kusmabite@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 26 17:59:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UANrx-00014X-HC
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 17:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab3BZQ6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 11:58:43 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:50007 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab3BZQ6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 11:58:42 -0500
Received: by mail-lb0-f169.google.com with SMTP id m4so3295611lbo.14
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=kcIPVk/2ccRBTUkhgRJDgbjsytWY36+cjgTqxKtV6B4=;
        b=rWSgXFdQ/cw0NxnU6qk0kfxwRPeYJW7A/rLiHUqOXJ8qLwL5b73ILSVHADNTda61KW
         V3C6UqQ+3/6RRlJMP+O3V6IvXL0V6QpUNYRrRqaaoI/rfQA2OcX+3+uvXpm8QruJoWxC
         QOuzY3Zuinv3nlIljYjRJOS7sJrp5aYIHp45pOVxQt+OqR8ys5ahbAuL2+GzOGBsVzkf
         jEGAJa+3/kLbbsqXj8yIB4rwZsF/00eiZ+kQGVGSG0cXfMWDjWCPHuVe0f59B8EgS8ZG
         QJIPcYKpb0woCrjr6FreZMtH+HvQS+C0aQ/VFWF0GggEEPCO2I5F50P+nixyApxZJ3JJ
         qALw==
X-Received: by 10.152.47.242 with SMTP id g18mr14093219lan.42.1361897921044;
        Tue, 26 Feb 2013 08:58:41 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id m1sm729239lbh.5.2013.02.26.08.58.38
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 08:58:39 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.3.gd0186ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217148>

This reverts commit 78457bc0ccc1af8b9eb776a0b17986ebd50442bc.

commit 28c5d9e ("vcs-svn: drop string_pool") previously removed
the only call-site for strtok_r. So let's get rid of the compat
implementation as well.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile          |  6 ------
 compat/strtok_r.c | 61 -------------------------------------------------------
 config.mak.uname  |  2 --
 configure.ac      |  6 ------
 git-compat-util.h |  5 -----
 5 files changed, 80 deletions(-)
 delete mode 100644 compat/strtok_r.c

diff --git a/Makefile b/Makefile
index 1b30d7b..6d16a52 100644
--- a/Makefile
+++ b/Makefile
@@ -98,8 +98,6 @@ all::
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
-# Define NO_STRTOK_R if you don't have strtok_r in the C library.
-#
 # Define NO_FNMATCH if you don't have fnmatch in the C library.
 #
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
@@ -1202,10 +1200,6 @@ endif
 ifdef NO_STRTOULL
 	COMPAT_CFLAGS += -DNO_STRTOULL
 endif
-ifdef NO_STRTOK_R
-	COMPAT_CFLAGS += -DNO_STRTOK_R
-	COMPAT_OBJS += compat/strtok_r.o
-endif
 ifdef NO_FNMATCH
 	COMPAT_CFLAGS += -Icompat/fnmatch
 	COMPAT_CFLAGS += -DNO_FNMATCH
diff --git a/compat/strtok_r.c b/compat/strtok_r.c
deleted file mode 100644
index 7b5d568..0000000
--- a/compat/strtok_r.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/* Reentrant string tokenizer.  Generic version.
-   Copyright (C) 1991,1996-1999,2001,2004 Free Software Foundation, Inc.
-   This file is part of the GNU C Library.
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public
-   License as published by the Free Software Foundation; either
-   version 2.1 of the License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
-
-   You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
-   02111-1307 USA.  */
-
-#include "../git-compat-util.h"
-
-/* Parse S into tokens separated by characters in DELIM.
-   If S is NULL, the saved pointer in SAVE_PTR is used as
-   the next starting point.  For example:
-	char s[] = "-abc-=-def";
-	char *sp;
-	x = strtok_r(s, "-", &sp);	// x = "abc", sp = "=-def"
-	x = strtok_r(NULL, "-=", &sp);	// x = "def", sp = NULL
-	x = strtok_r(NULL, "=", &sp);	// x = NULL
-		// s = "abc\0-def\0"
-*/
-char *
-gitstrtok_r (char *s, const char *delim, char **save_ptr)
-{
-  char *token;
-
-  if (s == NULL)
-    s = *save_ptr;
-
-  /* Scan leading delimiters.  */
-  s += strspn (s, delim);
-  if (*s == '\0')
-    {
-      *save_ptr = s;
-      return NULL;
-    }
-
-  /* Find the end of the token.  */
-  token = s;
-  s = strpbrk (token, delim);
-  if (s == NULL)
-    /* This token finishes the string.  */
-    *save_ptr = token + strlen (token);
-  else
-    {
-      /* Terminate the token and make *SAVE_PTR point past it.  */
-      *s = '\0';
-      *save_ptr = s + 1;
-    }
-  return token;
-}
diff --git a/config.mak.uname b/config.mak.uname
index bea34f0..7f3018f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -321,7 +321,6 @@ ifeq ($(uname_S),Windows)
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
-	NO_STRTOK_R = YesPlease
 	NO_FNMATCH = YesPlease
 	NO_MEMMEM = YesPlease
 	# NEEDS_LIBICONV = YesPlease
@@ -476,7 +475,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
-	NO_STRTOK_R = YesPlease
 	NO_FNMATCH = YesPlease
 	NO_MEMMEM = YesPlease
 	NEEDS_LIBICONV = YesPlease
diff --git a/configure.ac b/configure.ac
index 1991258..f3462d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -901,12 +901,6 @@ GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=YesPlease])
 GIT_CONF_SUBST([NO_STRCASESTR])
 #
-# Define NO_STRTOK_R if you don't have strtok_r
-GIT_CHECK_FUNC(strtok_r,
-[NO_STRTOK_R=],
-[NO_STRTOK_R=YesPlease])
-GIT_CONF_SUBST([NO_STRTOK_R])
-#
 # Define NO_FNMATCH if you don't have fnmatch
 GIT_CHECK_FUNC(fnmatch,
 [NO_FNMATCH=],
diff --git a/git-compat-util.h b/git-compat-util.h
index e5a4b74..89a44ab 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -408,11 +408,6 @@ extern uintmax_t gitstrtoumax(const char *, char **, int);
 extern intmax_t gitstrtoimax(const char *, char **, int);
 #endif
 
-#ifdef NO_STRTOK_R
-#define strtok_r gitstrtok_r
-extern char *gitstrtok_r(char *s, const char *delim, char **save_ptr);
-#endif
-
 #ifdef NO_HSTRERROR
 #define hstrerror githstrerror
 extern const char *githstrerror(int herror);
-- 
1.8.0.msysgit.0.3.gd0186ec
