From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 1/1] refs.c: SSE4.2 optimizations for check_refname_component
Date: Thu,  5 Jun 2014 19:56:15 -0400
Message-ID: <1402012575-16546-2-git-send-email-dturner@twitter.com>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jun 06 01:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WshYF-0008At-VX
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbaFEX60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:58:26 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:64119 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbaFEX6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:58:24 -0400
Received: by mail-qa0-f46.google.com with SMTP id w8so2501107qac.33
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDn1D5Ew6vQ4zhaHd0Dc2Joeaj1jFro5wN5DmUIuvXY=;
        b=ZzgewdcFjw4v2aGJLDgiAzPrsgHudWCHA76LRBdW/5L8hXUxqbn9B2D6eKHjdG06r5
         hQBofj1m0Ccp6Abh7QZUinY1plYtnE2mQNAJN5JopueM9N+BnNY9czYMvIqvF79BW4ig
         DFHX0OR+HHK/za1gfdb5FA1AJsBYlaSGuCYN23DL6U9ywyz+3J2eNgA8kDtY4AIg6Joh
         /HVrUHgqAHllvZ9hNKHVvqFNI5V7RvzElr/Q6sCBnkkD3fDNO23M6e4+MgNXq4wqemRk
         lVjn4YxUyf+OqSeOA9Y1QS25b/1RMv7EQ+41xUbRK5oNQJZKZjgqXHnqti1BFaorIbv/
         gABg==
X-Gm-Message-State: ALoCoQkZ3LmwqdzWf2glYs8jRliOBWUTUcXlK1DVHziVDxBv7C83KKuZA/Gtb0QGlMqujvje+omV
X-Received: by 10.224.98.197 with SMTP id r5mr1503370qan.57.1402012704070;
        Thu, 05 Jun 2014 16:58:24 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id l46sm4719383qga.21.2014.06.05.16.58.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:58:23 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.24.g0588c94.dirty
In-Reply-To: <1402012575-16546-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250883>

Optimize check_refname_component using SSE4.2, where available.

git rev-parse HEAD is a good test-case for this, since it does almost
nothing except parse refs.  For one particular repo with about 60k
refs, almost all packed, the timings are:

Look up table: 29 ms
SSE4.2:        25 ms

This is about a 15% improvement.

The configure.ac changes include code from the GNU C Library written
by Joseph S. Myers <joseph at codesourcery dot com>.

Only supports GCC and Clang at present, because C interfaces to the
cpuid instruction are not well-standardized.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Makefile           |   6 +++
 aclocal.m4         |   6 +++
 compat/cpuid.h     |  25 +++++++++
 configure.ac       |  17 ++++++
 git-compat-util.h  |  23 ++++++++
 refs.c             | 150 +++++++++++++++++++++++++++++++++++++++++++++++------
 t/t5511-refspec.sh |  13 +++++
 7 files changed, 225 insertions(+), 15 deletions(-)
 create mode 100644 compat/cpuid.h

diff --git a/Makefile b/Makefile
index a53f3a8..dd2127a 100644
--- a/Makefile
+++ b/Makefile
@@ -1326,6 +1326,11 @@ else
 		COMPAT_OBJS += compat/win32mmap.o
 	endif
 endif
+ifdef NO_SSE42
+	BASIC_CFLAGS += -DNO_SSE42
+else
+	BASIC_CFLAGS += -msse4.2
+endif
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
@@ -2199,6 +2204,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+	@echo NO_SSE42=\''$(subst ','\'',$(subst ','\'',$(NO_SSE42)))'\' >>$@
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@
 endif
diff --git a/aclocal.m4 b/aclocal.m4
index f11bc7e..d9f3f19 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -38,3 +38,9 @@ AC_DEFUN([TYPE_SOCKLEN_T],
       [#include <sys/types.h>
 #include <sys/socket.h>])
 ])
+
+dnl Test a compiler option or options with an empty input file.
+dnl LIBC_TRY_CC_OPTION([options], [action-if-true], [action-if-false])
+AC_DEFUN([LIBC_TRY_CC_OPTION],
+[AS_IF([AC_TRY_COMMAND([${CC-cc} $1 -xc /dev/null -S -o /dev/null])],
+	[$2], [$3])])
diff --git a/compat/cpuid.h b/compat/cpuid.h
new file mode 100644
index 0000000..7709e35
--- /dev/null
+++ b/compat/cpuid.h
@@ -0,0 +1,25 @@
+#ifndef COMPAT_CPUID_H
+#define COMPAT_CPUID_H
+
+#if (defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__)))
+#include <cpuid.h>
+#define CPUID_SSE42_BIT (1 << 20)
+
+static int processor_supports_sse42(void)
+{
+	unsigned eax, ebx, ecx, edx;
+	__cpuid(1, eax, ebx, ecx, edx);
+	return ecx & CPUID_SSE42_BIT;
+}
+
+#else
+
+static int processor_supports_sse42(void)
+{
+	/* TODO: handle CPUID on non-GCC compilers */
+	return 0;
+}
+
+#endif
+
+#endif /* COMPAT_CPUID_H */
diff --git a/configure.ac b/configure.ac
index b711254..3a5bda9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -382,6 +382,23 @@ AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),
 GIT_PARSE_WITH(tcltk))
 #
 
+# Declare the with-sse42/without-sse42 options.
+AC_ARG_WITH(sse42,
+AS_HELP_STRING([--with-sse42],[use SSE4.2 instructions])
+AS_HELP_STRING([],[(default is YES if your compiler supports -msse4.2)]),
+GIT_PARSE_WITH(sse42))
+
+if test "$NO_SSE42" != "YesPlease"; then
+   dnl Check if -msse4.2 works.
+   AC_CACHE_CHECK(for SSE4.2 support, cc_cv_sse42, [dnl
+   LIBC_TRY_CC_OPTION([-msse4.2], [cc_cv_sse42=yes], [cc_cv_sse42=no])
+   ])
+   if test $cc_cv_sse42 = no; then
+     NO_SSE42=1
+   fi
+fi
+
+GIT_CONF_SUBST([NO_SSE42])
 
 ## Checks for programs.
 AC_MSG_NOTICE([CHECKS for programs])
diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..2c66d6d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -668,6 +668,29 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #endif
 #endif
 
+#ifndef NO_SSE42
+#include <nmmintrin.h>
+#include "compat/cpuid.h"
+/*
+ * Clang ships with a version of nmmintrin.h that's incomplete; if
+ * necessary, we define the constants that we're going to use.
+ */
+#ifndef _SIDD_UBYTE_OPS
+#define _SIDD_UBYTE_OPS                 0x00
+#define _SIDD_CMP_EQUAL_ANY             0x00
+#define _SIDD_CMP_RANGES                0x04
+#define _SIDD_CMP_EQUAL_ORDERED         0x0c
+#define _SIDD_NEGATIVE_POLARITY         0x10
+#endif
+
+/* This is the system memory page size; it's used so that we can read
+ * outside the bounds of an allocation without segfaulting.
+ */
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+#endif
+
 #ifdef UNRELIABLE_FSTAT
 #define fstat_is_reliable() 0
 #else
diff --git a/refs.c b/refs.c
index 46139d2..b3bd333 100644
--- a/refs.c
+++ b/refs.c
@@ -24,6 +24,25 @@ static unsigned char refname_disposition[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
 };
 
+static int check_refname_component_trailer(const char *cp, const char *refname, int flags)
+{
+	if (cp == refname)
+		return 0; /* Component has zero length. */
+	if (refname[0] == '.') {
+		if (!(flags & REFNAME_DOT_COMPONENT))
+			return -1; /* Component starts with '.'. */
+		/*
+		 * Even if leading dots are allowed, don't allow "."
+		 * as a component (".." is prevented by a rule above).
+		 */
+		if (refname[1] == '\0')
+			return -1; /* Component equals ".". */
+	}
+	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
+		return -1; /* Refname ends with ".lock". */
+	return cp - refname;
+}
+
 /*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
@@ -37,7 +56,7 @@ static unsigned char refname_disposition[256] = {
  * - it ends with ".lock"
  * - it contains a "\" (backslash)
  */
-static int check_refname_component(const char *refname, int flags)
+static int check_refname_component_bytewise(const char *refname, int flags)
 {
 	const char *cp;
 	char last = '\0';
@@ -47,7 +66,7 @@ static int check_refname_component(const char *refname, int flags)
 		unsigned char disp = refname_disposition[ch];
 		switch(disp) {
 		case 1:
-			goto out;
+			return check_refname_component_trailer(cp, refname, flags);
 		case 2:
 			if (last == '.')
 				return -1; /* Refname contains "..". */
@@ -61,24 +80,125 @@ static int check_refname_component(const char *refname, int flags)
 		}
 		last = ch;
 	}
-out:
-	if (cp == refname)
-		return 0; /* Component has zero length. */
-	if (refname[0] == '.') {
-		if (!(flags & REFNAME_DOT_COMPONENT))
-			return -1; /* Component starts with '.'. */
+}
+
+#if defined(NO_SSE42) || !(defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__)))
+#define check_refname_component check_refname_component_bytewise
+#else
+#define SSE_VECTOR_BYTES 16
+
+/* Vectorized version of check_refname_component */
+static int check_refname_component_sse42(const char *refname, int flags)
+{
+	const __m128i *refname_vec = (__m128i*) refname;
+
+	/* Character ranges for characters forbidden in refs; see above */
+	static const __v16qi bad = {
+		0x01, 0x20,  0x7e, 0x7f,  0x5e, 0x5e,  0x3a, 0x3a,
+		0x5b, 0x5c,  0x2a, 0x2a,  0x3f, 0x3f,  0x3f, 0x3f};
+
+	static const __v16qi nonslashes = {
+		'\001', '/' -1, '/' + 1, 0xff,
+	};
+
+	static const __v16qi dotdot = {'.', '.', 0};
+	static const __v16qi atcurly = {'@', '{', 0};
+
+	const __m128i *vp;
+	const char *cp = (const char *)refname_vec;
+
+	int dotdotpos = SSE_VECTOR_BYTES, atcurlypos = SSE_VECTOR_BYTES;
+	for (vp = refname_vec; ; vp++) {
+		__m128i tmp;
+		int endpos;
+
 		/*
-		 * Even if leading dots are allowed, don't allow "."
-		 * as a component (".." is prevented by a rule above).
+		 * Handle case of forbidden substrings .. and @{ crossing
+		 * sixteen-byte boundaries
 		 */
-		if (refname[1] == '\0')
-			return -1; /* Component equals ".". */
+		if (dotdotpos == 15 && *cp == '.')
+			return -1;
+
+		if (atcurlypos == 15 && *cp == '{')
+			return -1;
+
+		if (((uintptr_t) vp % PAGE_SIZE) > PAGE_SIZE - SSE_VECTOR_BYTES)
+			/*
+			 * End-of-page; fall back to slow method for
+			 * this entire component.
+			 */
+			return check_refname_component_bytewise(refname, flags);
+
+		tmp = _mm_lddqu_si128(vp);
+
+		/*
+		 * Find slashes or end-of-string. The double-negative
+		 * (negative-polarity search for non-slashes) is
+		 * necessary so that \0 will also be counted.
+		 */
+		endpos = _mm_cmpistri((__m128i) nonslashes, tmp,
+				      _SIDD_UBYTE_OPS | _SIDD_CMP_RANGES |
+				      _SIDD_NEGATIVE_POLARITY);
+
+		if (_mm_cmpestrc((__m128i) bad, SSE_VECTOR_BYTES, tmp, endpos,
+				 _SIDD_UBYTE_OPS | _SIDD_CMP_RANGES))
+			return -1;
+
+		dotdotpos = _mm_cmpestri((__m128i) dotdot, 2, tmp, endpos,
+					 _SIDD_UBYTE_OPS |
+					 _SIDD_CMP_EQUAL_ORDERED);
+		if (dotdotpos < 15)
+			return -1;
+
+		atcurlypos = _mm_cmpestri((__m128i) atcurly, 2, tmp, endpos,
+					  _SIDD_UBYTE_OPS |
+					  _SIDD_CMP_EQUAL_ORDERED);
+		if (atcurlypos < 15)
+			return -1;
+
+		if (endpos < SSE_VECTOR_BYTES) {
+			cp = ((const char*) vp) + endpos;
+			break;
+		}
+		cp = (const char*) vp + SSE_VECTOR_BYTES;
 	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
-		return -1; /* Refname ends with ".lock". */
-	return cp - refname;
+	return check_refname_component_trailer(cp, refname, flags);
+}
+
+static void* find_check_refname_component(void)
+{
+	if (processor_supports_sse42())
+		return check_refname_component_sse42;
+	else
+		return check_refname_component_bytewise;
 }
 
+#ifdef __clang__
+
+static int check_refname_component_autodetect(const char *refname, int flags);
+
+static int (*check_refname_component)(const char *, int) = check_refname_component_autodetect;
+
+/*
+ * On the first run of check_refname_component, autodetect the correct
+ * version for this CPU.  This is necessary because Clang doesn't support
+ * ifunc.
+ */
+static int check_refname_component_autodetect(const char *refname, int flags)
+{
+	check_refname_component = find_check_refname_component();
+	return check_refname_component(refname, flags);
+}
+
+#else
+
+static int check_refname_component(const char *refname, int flags)
+	__attribute__ ((ifunc ("find_check_refname_component")));
+
+#endif /* __clang__ */
+
+#endif /* NO_SSE42 */
+
 int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index de6db86..7f1bd74 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -88,4 +88,17 @@ test_refspec fetch "refs/heads/${good}"
 bad=$(printf '\011tab')
 test_refspec fetch "refs/heads/${bad}"				invalid
 
+test_refspec fetch 'refs/heads/a-very-long-refname'
+test_refspec fetch 'refs/heads/.a-very-long-refname'		invalid
+test_refspec fetch 'refs/heads/abcdefgh0123..'			invalid
+test_refspec fetch 'refs/heads/abcdefgh01234..'			invalid
+test_refspec fetch 'refs/heads/abcdefgh012345..'		invalid
+test_refspec fetch 'refs/heads/abcdefgh0123456..'		invalid
+test_refspec fetch 'refs/heads/abcdefgh01234567..'		invalid
+test_refspec fetch 'refs/heads/abcdefgh0123.a'
+test_refspec fetch 'refs/heads/abcdefgh01234.a'
+test_refspec fetch 'refs/heads/abcdefgh012345.a'
+test_refspec fetch 'refs/heads/abcdefgh0123456.a'
+test_refspec fetch 'refs/heads/abcdefgh01234567.a'
+
 test_done
-- 
2.0.0.rc1.24.g0588c94.dirty
