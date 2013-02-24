From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Sun, 24 Feb 2013 09:36:27 +0200
Message-ID: <CAHXAxrMgJf2C3dAe1O2DW5qFYFnCDhbQNmpnvK4ZOduJnqwQWg@mail.gmail.com>
References: <CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 08:37:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9W8o-0001Kc-9Y
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 08:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab3BXHga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 02:36:30 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:50197 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3BXHg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 02:36:29 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so886518qcs.34
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 23:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=zBzNnmbEStXAzH4Okgf4IeHTd+qUVYGoH7Mb4IU15HA=;
        b=DxDQLPKZyTuuOuNMvIx6sq6+wi6jj7G2gYMssjbvViSLw+nBzGpdWRN8NbP1SxjbKC
         WTORzaY8ZTFJ2LCBBE+/My5lkQ6OUYLcAHqlE4sUCCyi7e0f5TUH/b/Mex/D8KlTzaFu
         Nu6EDxWOvU8uPUmq20oOcurBSZrOa2gZo6LYcPSrjLS8Iv2dc3Fxw9GxolqHmQNlZd5i
         5+g1gnTxhtOlfDLnJbwHYXvXCeD/a7LJ13A/UK5ZutIVND2IZMCFz+9LdV5CWLvlggxH
         0XjPlsV3RWNS02XHyoVVwKMJNBdDsCeUlZAqFy3GzBGYE2f5sXHYA+ZlE9UcYU5AGC9T
         DZxg==
X-Received: by 10.229.171.3 with SMTP id f3mr1286344qcz.41.1361691387700; Sat,
 23 Feb 2013 23:36:27 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Sat, 23 Feb 2013 23:36:27 -0800 (PST)
In-Reply-To: <CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216977>

Hello,

> Here is a small patch with QNX build improvements:
>
> 1) Rename tar.h to tar_git.h. Latest QNX versions have system tar.h
> header according to
> http://pubs.opengroup.org/onlinepubs/009696699/basedefs/tar.h.html ,
> to avoid inclusion of another tar.h, original header was renamed.
> 2) Rename fnmatch.h to fnmatch_gnu.h and fnmatch.c to fnmatch_gnu.c to
> avoid inclusion of system fnmatch.h header in case if -I/usr/include
> path is specified before -Icompat/fnmatch. Which is common situation.
> 3) pager.c - default "less" invocation flags were changed for QNX 6,x
> platform, since QNX has incompatible with GNU coreutils version of
> "less" utility.
> 4) config.mak.uname - a) do not override mkdtemp/mkstemps/strcasestr
> detection, since newer QNX version could contain such functions. Let
> to configure decide what is present in the system. b) getpagesize()
> function is existing under QNX, c) QNX has pthread functions in the
> libc, so do not define NO_PTHREAD macro.

Sorry, in the previous post the patch was not inlined.

diff --git a/Makefile b/Makefile
index ba8e243..f6dd2eb 100644
--- a/Makefile
+++ b/Makefile
@@ -726,7 +726,7 @@ LIB_H += streaming.h
 LIB_H += string-list.h
 LIB_H += submodule.h
 LIB_H += tag.h
-LIB_H += tar.h
+LIB_H += tar_git.h
 LIB_H += thread-utils.h
 LIB_H += transport.h
 LIB_H += tree-walk.h
@@ -1256,12 +1256,12 @@ endif
 ifdef NO_FNMATCH
 	COMPAT_CFLAGS += -Icompat/fnmatch
 	COMPAT_CFLAGS += -DNO_FNMATCH
-	COMPAT_OBJS += compat/fnmatch/fnmatch.o
+	COMPAT_OBJS += compat/fnmatch/fnmatch_gnu.o
 else
 ifdef NO_FNMATCH_CASEFOLD
 	COMPAT_CFLAGS += -Icompat/fnmatch
 	COMPAT_CFLAGS += -DNO_FNMATCH_CASEFOLD
-	COMPAT_OBJS += compat/fnmatch/fnmatch.o
+	COMPAT_OBJS += compat/fnmatch/fnmatch_gnu.o
 endif
 endif
 ifdef USE_WILDMATCH
diff --git a/archive-tar.c b/archive-tar.c
index 719b629..8e24336 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -2,7 +2,7 @@
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
 #include "cache.h"
-#include "tar.h"
+#include "tar_git.h"
 #include "archive.h"
 #include "streaming.h"
 #include "run-command.h"
diff --git a/builtin/tar-tree.c b/builtin/tar-tree.c
index 3f1e701..b0e4551 100644
--- a/builtin/tar-tree.c
+++ b/builtin/tar-tree.c
@@ -3,7 +3,7 @@
  */
 #include "cache.h"
 #include "commit.h"
-#include "tar.h"
+#include "tar_git.h"
 #include "builtin.h"
 #include "quote.h"

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch_gnu.c
similarity index 99%
rename from compat/fnmatch/fnmatch.c
rename to compat/fnmatch/fnmatch_gnu.c
index 5ef0685..f9a5e5b 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch_gnu.c
@@ -26,7 +26,7 @@
 #endif

 #include <errno.h>
-#include <fnmatch.h>
+#include <fnmatch_gnu.h>
 #include <ctype.h>

 #if HAVE_STRING_H || defined _LIBC
diff --git a/compat/fnmatch/fnmatch.h b/compat/fnmatch/fnmatch_gnu.h
similarity index 100%
rename from compat/fnmatch/fnmatch.h
rename to compat/fnmatch/fnmatch_gnu.h
diff --git a/config.mak.uname b/config.mak.uname
index 8743a6d..2d42ffe 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -527,14 +527,21 @@ ifeq ($(uname_S),QNX)
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_SOCKET = YesPlease
 	NO_FNMATCH_CASEFOLD = YesPlease
-	NO_GETPAGESIZE = YesPlease
 	NO_ICONV = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_NSEC = YesPlease
-	NO_PTHREADS = YesPlease
 	NO_R_TO_GCC_LINKER = YesPlease
-	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
+	# All QNX 6.x versions have pthread functions in libc
+	# and getpagesize. Leave mkstemps/mkdtemp/strcasestr for
+	# autodetection.
+	ifeq ($(shell expr "$(uname_R)" : '6\.[0-9]\.[0-9]'),5)
+		PTHREAD_LIBS = ""
+	else
+		NO_PTHREADS = YesPlease
+		NO_GETPAGESIZE = YesPlease
+		NO_STRCASESTR = YesPlease
+		NO_MKSTEMPS = YesPlease
+		NO_MKDTEMP = YesPlease
+	endif
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index b7eaaa9..f59d696 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -113,7 +113,11 @@
 #include <time.h>
 #include <signal.h>
 #ifndef USE_WILDMATCH
+#if defined(NO_FNMATCH) || defined(NO_FNMATCH_CASEFOLD)
+#include <fnmatch_gnu.h>
+#else
 #include <fnmatch.h>
+#endif /* NO_FNMATCH */
 #endif
 #include <assert.h>
 #include <regex.h>
diff --git a/pager.c b/pager.c
index c1ecf65..bed627a 100644
--- a/pager.c
+++ b/pager.c
@@ -81,7 +81,11 @@ void setup_pager(void)
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
 	if (!getenv("LESS")) {
+	#if !defined(__QNXNTO__)
 		static const char *env[] = { "LESS=FRSX", NULL };
+	#else
+		static const char *env[] = { "LESS=rS", NULL };
+	#endif /* __QNXNTO__ */
 		pager_process.env = env;
 	}
 	if (start_command(&pager_process))
diff --git a/tar.h b/tar_git.h
similarity index 100%
rename from tar.h
rename to tar_git.h
