From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH] Port to HP NonStop
Date: Wed, 19 Sep 2012 12:03:30 +0200
Message-ID: <000101cd964e$06a255d0$13e70170$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Jan Engelhardt'" <jengelh@inai.de>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 12:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEH8D-0005oP-Ge
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 12:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab2ISKDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 06:03:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:63424 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab2ISKDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 06:03:34 -0400
Received: from DualCore (dsdf-4d0a1993.pool.mediaWays.net [77.10.25.147])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Lucts-1TedhT3TQu-010Kuc; Wed, 19 Sep 2012 12:03:33 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2WTJ+eOm9OLHa2Q4SjHUxeg7zbHA==
Content-Language: de
X-Provags-ID: V02:K0:ObFcLvaALzYYrcojiTLK7XFtzMhSSS83ED11kxy5zO0
 fqqMvQpAuBA1dLSymQ/skvW/P05t1cCJEfU07U96SG+JEI6WHZ
 y9QZ4G+BnNC6qssDYmgE2WNpkji39h5JY+bFxCOSjnX+hNrJKW
 AvbBnwsj2qLRq35VQRmwrxPw2vCLGJvGngzwLpwNalRjGxDStl
 y028tmgJriNFCROxN/5KBqPuKNdIItR7V/xLYAcgV3Q/9umJf7
 MU5gd6D9qu+NzxXnIB4zSEBNYNigGVkFdBqnlUalsEgwNWY6SX
 taMOQwZ0nY8wXCJbYdCYQViOBkzHqaqw7DDYoOyV2/qWZtw+/P
 JYwajsmMUjwj9KOwdcZ0mjFXj2E0BtOgf2GzQpIy0Q4RMhYZ4W
 bLX1NjSQqj4aQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205920>

Includes the addition of some new defines and their description for others to use.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
This needs my 4 compat-poll patches posted earlier, which are in pu currently

 Makefile          | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h | 17 +++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e022fc4..3823968 100644
--- a/Makefile
+++ b/Makefile
@@ -145,6 +145,12 @@ all::
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 #
+# Define NEEDS_LIBINTL_BEFORE_LIBICONV if you need libintl before libiconv.
+#
+# Define NO_INTPTR_T if you don't have intptr_t nor uintptr_t.
+#
+# Define NO_UINTMAX_T if you don't have uintmax_t.
+#
# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 #
@@ -1327,6 +1333,61 @@ ifeq ($(uname_S),Minix)
 	NO_CURL =
 	NO_EXPAT =
 endif
+ifeq ($(uname_S),NONSTOP_KERNEL)
+	# Needs some C99 features, "inline" is just one of them.
+	# INLINE='' would just replace one set of warnings with another and
+	# still not compile in c89 mode, due to non-const array initializations.
+	CC = cc -c99
+	# Disable all optimization, seems to result in bad code, with -O or -O2
+	# or even -O1 (default), /usr/local/libexec/git-core/git-pack-objects
+	# abends on "git push". Needs more investigation.
+	CFLAGS = -g -O0
+	# We'd want it to be here.
+	prefix = /usr/local
+	# Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
+	PERL_PATH = ${prefix}/bin/perl
+	PYTHON_PATH = ${prefix}/bin/python
+
+	# As detected by './configure'.
+	# Missdetected, hence commented out, see below.
+	#NO_CURL = YesPlease
+	# Added manually, see above.
+	NEEDS_SSL_WITH_CURL = YesPlease
+	HAVE_LIBCHARSET_H = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
+	NO_SYS_SELECT_H = UnfortunatelyYes
+	NO_D_TYPE_IN_DIRENT = YesPlease
+	NO_HSTRERROR = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_FNMATCH_CASEFOLD = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_SETENV = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
+	# Currently libiconv-1.9.1.
+	OLD_ICONV = UnfortunatelyYes
+	NO_REGEX = YesPlease
+	NO_PTHREADS = UnfortunatelyYes
+
+	# Not detected (nor checked for) by './configure'.
+	# We don't have SA_RESTART on NonStop, unfortunalety.
+	COMPAT_CFLAGS += -DSA_RESTART=0
+	# Apparently needed in compat/fnmatch/fnmatch.c.
+	COMPAT_CFLAGS += -DHAVE_STRING_H=1
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	NO_NSEC = YesPlease
+	NO_PREAD = YesPlease
+	NO_MMAP = YesPlease
+	NO_POLL = YesPlease
+	NO_INTPTR_T = UnfortunatelyYes
+	# Bug report 10-120822-4477 submitted to HP NonStop development.
+	MKDIR_WO_TRAILING_SLASH = YesPlease
+	# RFE 10-120912-4693 submitted to HP NonStop development.
+	NO_SETITIMER = UnfortunatelyYes
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -1563,6 +1624,9 @@ ifdef NEEDS_LIBICONV
 	else
 		ICONV_LINK =
 	endif
+	ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
+		ICONV_LINK += -lintl
+	endif
 	EXTLIBS += $(ICONV_LINK) -liconv
 endif
 ifdef NEEDS_LIBGEN
@@ -1723,6 +1787,9 @@ endif
 ifdef NO_IPV6
 	BASIC_CFLAGS += -DNO_IPV6
 endif
+ifdef NO_INTPTR_T
+	COMPAT_CFLAGS += -DNO_INTPTR_T
+endif
 ifdef NO_UINTMAX_T
 	BASIC_CFLAGS += -Duintmax_t=uint32_t
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 24b5432..2fbf1fd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -74,7 +74,8 @@
 # define _XOPEN_SOURCE 500
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
-      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__)
+      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
+      !defined(__TANDEM)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
@@ -98,6 +99,9 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
+#ifdef __TANDEM /* or HAVE_STRINGS_H or !NO_STRINGS_H? */
+#include <strings.h> /* for strcasecmp() */
+#endif
 #include <errno.h>
 #include <limits.h>
 #include <sys/param.h>
@@ -141,6 +145,17 @@
 #else
 #include <stdint.h>
 #endif
+#ifdef NO_INTPTR_T
+/*
+ * On I16LP32, ILP32 and LP64 "long" is the save bet, however
+ * on LLP86, IL33LLP64 and P64 it needs to be "long long",
+ * while on IP16 and IP16L32 it is "int" (resp. "short")
+ * Size needs to match (or exceed) 'sizeof(void *)'.
+ * We can't take "long long" here as not everybody has it.
+ */
+typedef long intptr_t;
+typedef unsigned long uintptr_t;
+#endif
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
--
1.7.12
