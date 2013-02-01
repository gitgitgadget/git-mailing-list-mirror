From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATH/RFC] Revert "compat: add strtok_r()"
Date: Fri,  1 Feb 2013 11:33:06 +0100
Message-ID: <1359714786-1912-1-git-send-email-kusmabite@gmail.com>
Cc: Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 11:33:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Dw5-0006Qb-A6
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 11:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab3BAKdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 05:33:11 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:34099 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579Ab3BAKdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 05:33:09 -0500
Received: by mail-ea0-f177.google.com with SMTP id n13so1610419eaa.22
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 02:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jhyfm0xVCk/mJ38u2aHUqOOJ5PFz1s3zG4TAO3r1rTo=;
        b=yM7d8ELGkNpuDQusIxMfnFomUUGAqGzAzguh1VJ3S6Bts2pa5eXK8uWylQUiMNrGzG
         OhPjH8mDP9Nay63zlDcirRkpo57AfNTO/w/47Ios/SBw8ECW3sjfWx2mj9byeIvehA+j
         HHJb9xJIGxWiePBq99rWAvUmrEsQm6x4DFzS/eIrEqIHhDnofW8PTn7QedsJS2UPckFl
         Y1iOqb6RWEtlAe6XtnR7tJKyCk3yaT8uzjLSQyl/N74azpMfmTRLwZTo4rOhPDmQ7zia
         16STv6dIqbkGMCr5E+TD57wjCan+FGeh5doD6capPP7RHN1X/EZ+bU4SJ2KtWT053S+F
         fRSg==
X-Received: by 10.14.174.198 with SMTP id x46mr38121649eel.23.1359714788001;
        Fri, 01 Feb 2013 02:33:08 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 43sm11824360eed.10.2013.02.01.02.33.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 02:33:06 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.3.gd0186ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215230>

This reverts commit 78457bc0ccc1af8b9eb776a0b17986ebd50442bc.

commit 28c5d9e ("vcs-svn: drop string_pool") previously removed
the only call-site for strtok_r. So let's get rid of the compat
implementation as well.

Conflicts:
	Makefile
	config.mak.in
	configure.ac
---

I just noticed that we have an unused compat-implementation of strtok_r,
so here's a patch to get rid of it.

 Makefile          |  6 ------
 compat/strtok_r.c | 61 -------------------------------------------------------
 configure.ac      |  6 ------
 git-compat-util.h |  5 -----
 4 files changed, 78 deletions(-)
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
