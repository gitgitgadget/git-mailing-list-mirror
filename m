From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] unbreak and eliminate NO_C99_FORMAT
Date: Wed, 16 Mar 2011 00:15:31 -0500
Message-ID: <20110316051531.GC1932@elie>
References: <27484.1172021696@lotus.CS.Berkeley.EDU>
 <20110316051232.GA1932@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <jason@acm.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 06:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzj5C-0005Fx-GA
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 06:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176Ab1CPFPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 01:15:38 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:51997 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab1CPFPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 01:15:36 -0400
Received: by yia27 with SMTP id 27so519183yia.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+fb/U3OOYEcjZ07e03OeicAukVjd6CxNemOvCuo2r+I=;
        b=aj/ek2nUYltFD9pUUAEmeX1xbg+Ya0P8sTgDgquv1tKRETPFZjp1bsagw9B3VhhOr9
         fQyFibIknR+3xdHwh48L4dsha+DKAIfZizMu8ufMGJtQiwg9FFfaoVgt4oFrkUay7DUV
         soxPVzTpu0qYT8WQ/EAy2tOjv8GrJm/V/ICPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jC7dOykXUo8XDHkINfqaUPO5NAf/H9o8AvN1xufbqziqvVvqyNB2w1ge57OsaILtPv
         pTSqSSqcYeqiqBMk3Ly8+YLqohOU2Z1OCHqPZNi3g0rcCp2qp++zP6mdOpKW/xyBI6v0
         GKXCWmG691Th4+n2CWn333wyD+joprlhPdwaI=
Received: by 10.150.246.6 with SMTP id t6mr897146ybh.251.1300252535597;
        Tue, 15 Mar 2011 22:15:35 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id w15sm3318787ybk.13.2011.03.15.22.15.33
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 22:15:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316051232.GA1932@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169103>

In the spirit of v1.5.0.2~21 (Check for PRIuMAX rather than
NO_C99_FORMAT in fast-import.c, 2007-02-20), use PRIuMAX from
git-compat-util.h on all platforms instead of C99-specific formats
like %zu with dangerous fallbacks to %u or %lu.

So now C99-challenged platforms can build git without provoking
warnings or errors from printf, even if pointers do not have the same
size as an int or long.

The need for a fallback PRIuMAX is detected in git-compat-util.h with
"#ifndef PRIuMAX".  So while at it, simplify the Makefile and configure
script by eliminating the NO_C99_FORMAT knob altogether.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile      |   14 --------------
 alloc.c       |   11 ++---------
 config.mak.in |    1 -
 configure.ac  |   24 ------------------------
 sha1_file.c   |    9 ++-------
 5 files changed, 4 insertions(+), 55 deletions(-)

diff --git a/Makefile b/Makefile
index 775ee83..d9243aa 100644
--- a/Makefile
+++ b/Makefile
@@ -45,11 +45,6 @@ all::
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (Cygwin 1.5, fixed in Cygwin 1.7).
 #
-# Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
-# do not support the 'size specifiers' introduced by C99, namely ll, hh,
-# j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
-# some C compilers supported these specifiers prior to C99 as an extension.
-#
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
 # Define NO_MEMMEM if you don't have memmem.
@@ -870,7 +865,6 @@ ifeq ($(uname_S),SunOS)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_STRLCPY = YesPlease
-		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
@@ -881,21 +875,18 @@ ifeq ($(uname_S),SunOS)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_STRLCPY = YesPlease
-		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
 	ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
-		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
 	ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
-		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
@@ -1074,7 +1065,6 @@ ifeq ($(uname_S),Windows)
 	NO_MEMMEM = YesPlease
 	# NEEDS_LIBICONV = YesPlease
 	NO_ICONV = YesPlease
-	NO_C99_FORMAT = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_STRTOULL = YesPlease
 	NO_MKDTEMP = YesPlease
@@ -1151,7 +1141,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MEMMEM = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	OLD_ICONV = YesPlease
-	NO_C99_FORMAT = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
@@ -1354,9 +1343,6 @@ endif
 ifdef NO_NSEC
 	BASIC_CFLAGS += -DNO_NSEC
 endif
-ifdef NO_C99_FORMAT
-	BASIC_CFLAGS += -DNO_C99_FORMAT
-endif
 ifdef SNPRINTF_RETURNS_BOGUS
 	COMPAT_CFLAGS += -DSNPRINTF_RETURNS_BOGUS
 	COMPAT_OBJS += compat/snprintf.o
diff --git a/alloc.c b/alloc.c
index 6ef6753..aeae55c 100644
--- a/alloc.c
+++ b/alloc.c
@@ -51,19 +51,12 @@ DEFINE_ALLOCATOR(commit, struct commit)
 DEFINE_ALLOCATOR(tag, struct tag)
 DEFINE_ALLOCATOR(object, union any_object)
 
-#ifdef NO_C99_FORMAT
-#define SZ_FMT "%u"
-#else
-#define SZ_FMT "%zu"
-#endif
-
 static void report(const char *name, unsigned int count, size_t size)
 {
-    fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, size);
+	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
+			name, count, (uintmax_t) size);
 }
 
-#undef SZ_FMT
-
 #define REPORT(name)	\
     report(#name, name##_allocs, name##_allocs*sizeof(struct name) >> 10)
 
diff --git a/config.mak.in b/config.mak.in
index 9614973..e378534 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -43,7 +43,6 @@ NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
 NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
 NO_SOCKADDR_STORAGE=@NO_SOCKADDR_STORAGE@
 NO_IPV6=@NO_IPV6@
-NO_C99_FORMAT=@NO_C99_FORMAT@
 NO_HSTRERROR=@NO_HSTRERROR@
 NO_STRCASESTR=@NO_STRCASESTR@
 NO_STRTOK_R=@NO_STRTOK_R@
diff --git a/configure.ac b/configure.ac
index 20039c5..dd07907 100644
--- a/configure.ac
+++ b/configure.ac
@@ -686,30 +686,6 @@ AC_CHECK_TYPE([struct addrinfo],[
 ])
 AC_SUBST(NO_IPV6)
 #
-# Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
-# do not support the 'size specifiers' introduced by C99, namely ll, hh,
-# j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
-# some C compilers supported these specifiers prior to C99 as an extension.
-AC_CACHE_CHECK([whether formatted IO functions support C99 size specifiers],
- [ac_cv_c_c99_format],
-[# Actually git uses only %z (%zu) in alloc.c, and %t (%td) in mktag.c
-AC_RUN_IFELSE(
-	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
-		[[char buf[64];
-		if (sprintf(buf, "%lld%hhd%jd%zd%td", (long long int)1, (char)2, (intmax_t)3, (size_t)4, (ptrdiff_t)5) != 5)
-		  return 1;
-		else if (strcmp(buf, "12345"))
-		  return 2;]])],
-	[ac_cv_c_c99_format=yes],
-	[ac_cv_c_c99_format=no])
-])
-if test $ac_cv_c_c99_format = no; then
-	NO_C99_FORMAT=YesPlease
-else
-	NO_C99_FORMAT=
-fi
-AC_SUBST(NO_C99_FORMAT)
-#
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 AC_CACHE_CHECK([whether the platform regex can handle null bytes],
  [ac_cv_c_excellent_regex], [
diff --git a/sha1_file.c b/sha1_file.c
index 27730c3..ea99f6f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -25,13 +25,8 @@
 #endif
 #endif
 
-#ifdef NO_C99_FORMAT
-#define SZ_FMT "lu"
-static unsigned long sz_fmt(size_t s) { return (unsigned long)s; }
-#else
-#define SZ_FMT "zu"
-static size_t sz_fmt(size_t s) { return s; }
-#endif
+#define SZ_FMT PRIuMAX
+static inline uintmax_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 
-- 
1.7.4.1
