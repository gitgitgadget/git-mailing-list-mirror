From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 2/2] refs.c: SSE4.2 optimizations for check_refname_component
Date: Mon,  2 Jun 2014 02:20:15 -0400
Message-ID: <1401690015-19191-2-git-send-email-dturner@twitter.com>
References: <1401690015-19191-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 08:22:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrLda-00032c-7J
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 08:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaFBGWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 02:22:19 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:55638 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbaFBGWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 02:22:17 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so3874206pbc.2
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 23:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/ZahfdMo9TK8/5rOjIT5wnt93ZzyphU58BCGcYcYaM=;
        b=jeayyRf3EIZJ0AIF86OK/Z9Gc2q/w8fjKj8ZK9meQqnKi6gTD2/RC01QDhEEKWCm0z
         I3ituvVUhCf+6VHW1psTZiuojZNAuqm6juPfM5lLJuMxOAcs4WSQ3QjInk/pKjTR6wQI
         P3fhAaJs24oBm7EbRADFnG11/WkaO9+afa9QcEVJEDLNHNxCcIssVwfqmHQzcN+z4WPG
         S8ckBd2AwYhCXFCeWGiFiCljzNMYjF68IKu4w7f4fxTskewfeu2AuKIVhIhc7W79yUtV
         HQmtGF4hvpaMNcdR/N1OVHmELNqpYpJ4jIGJXEwKhwFZ0l20NA4fwSOnp72tVAcpjrO1
         Qs9g==
X-Gm-Message-State: ALoCoQnLEix2hweay5yFyA7xo0j5fs/0OrepnF/elZWwBuF+9oQ/80EuR7TEQaKufiJ2rwNFz/yo
X-Received: by 10.68.240.34 with SMTP id vx2mr38096382pbc.1.1401690137055;
        Sun, 01 Jun 2014 23:22:17 -0700 (PDT)
Received: from stross.twitter.corp (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id mt1sm18534676pbb.31.2014.06.01.23.22.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Jun 2014 23:22:16 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.18.gf763c0f
In-Reply-To: <1401690015-19191-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250552>

Optimize check_refname_component using SSE4.2, where available.

git rev-parse HEAD is a good test-case for this, since it does almost
nothing except parse refs.  For one particular repo with about 60k
refs, almost all packed, the timings are:

Look up table: 29 ms
SSE4.2:        25 ms

This is about a 15% improvement.

The configure.ac changes include code from the GNU C Library written
by Joseph S. Myers <joseph at codesourcery dot com>.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Makefile           |   6 +++
 aclocal.m4         |   6 +++
 configure.ac       |  17 ++++++++
 git-compat-util.h  |  20 +++++++++
 refs.c             | 116 +++++++++++++++++++++++++++++++++++++++++++++--------
 t/t5511-refspec.sh |  13 ++++++
 6 files changed, 161 insertions(+), 17 deletions(-)

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
index f6d3a46..254487a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -668,6 +668,26 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #endif
 #endif
 
+#ifndef NO_SSE42
+#include <nmmintrin.h>
+/* Clang ships with a version of nmmintrin.h that's incomplete; if
+ * necessary, we define the constants that we're going to use. */
+#ifndef _SIDD_UBYTE_OPS
+#define _SIDD_UBYTE_OPS                 0x00
+#define _SIDD_CMP_EQUAL_ANY             0x00
+#define _SIDD_CMP_RANGES                0x04
+#define _SIDD_CMP_EQUAL_ORDERED         0x0c
+#define _SIDD_NEGATIVE_POLARITY         0x10
+#endif
+
+/* This is the system memory page size; it's used so that we can read
+ * outside the bounds of an allocation without segfaulting. It is
+ * assumed to be a power of 2. */
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+#endif
+
 #ifdef UNRELIABLE_FSTAT
 #define fstat_is_reliable() 0
 #else
diff --git a/refs.c b/refs.c
index dd28f2a..22a2dae 100644
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
+static int check_refname_component_1(const char *refname, int flags)
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
@@ -61,23 +80,86 @@ static int check_refname_component(const char *refname, int flags)
 		}
 		last = ch;
 	}
-out:
-	if (cp == refname)
-		return 0; /* Component has zero length. */
-	if (refname[0] == '.') {
-		if (!(flags & REFNAME_DOT_COMPONENT))
-			return -1; /* Component starts with '.'. */
-		/*
-		 * Even if leading dots are allowed, don't allow "."
-		 * as a component (".." is prevented by a rule above).
-		 */
-		if (refname[1] == '\0')
-			return -1; /* Component equals ".". */
+}
+
+#ifdef NO_SSE42
+#define check_refname_component check_refname_component_1
+#else
+#define BLOCK_SIZE 16
+
+/* Vectorized version of check_refname_component */
+static int check_refname_component(const char *refname, int flags)
+{
+	const __m128i *refname_vec = (__m128i*) refname;
+
+	/* Character ranges for characters forbidden in refs; see
+	 * above */
+	static const __v16qi bad = {
+		0x01, 0x20,  0x7e, 0x7f,  0x5e, 0x5e,  0x3a, 0x3a,
+		0x5b, 0x5c,  0x2a, 0x2a,  0x3f, 0x3f,  0x3f, 0x3f};
+
+	static const __v16qi nonslashes = {
+		'\001', '/' -1, '/' + 1, 0xff,
+	};
+
+	static const __v16qi dotdot = {'.','.',0};
+	static const __v16qi atcurly = {'@','{',0};
+
+	const __m128i *vp;
+	const char *cp = (const char *)refname_vec;
+
+	int dotdotpos = BLOCK_SIZE, atcurlypos = BLOCK_SIZE;
+	for (vp = refname_vec; ; vp++) {
+		__m128i tmp;
+		int endpos;
+
+		/* Handle case of forbidden substrings .. and @{ crossing
+		 * sixteen-byte boundaries */
+		if (dotdotpos == 15 && *cp == '.')
+			return -1;
+
+		if (atcurlypos == 15 && *cp == '{')
+			return -1;
+
+		if (((uintptr_t) vp & (PAGE_SIZE - 1)) > PAGE_SIZE - BLOCK_SIZE)
+			/* End-of-page; fall back to slow method for
+			 * this entire component. */
+			return check_refname_component_1(refname, flags);
+
+		tmp = _mm_lddqu_si128(vp);
+
+		/* Find slashes or end-of-string. The double-negative
+		 * (negative-polarity search for non-slashes) is
+		 * necessary so that \0 will also be counted.  */
+		endpos = _mm_cmpistri((__m128i) nonslashes, tmp,
+				      _SIDD_UBYTE_OPS | _SIDD_CMP_RANGES |
+				      _SIDD_NEGATIVE_POLARITY);
+
+		if (_mm_cmpestrc((__m128i) bad, BLOCK_SIZE, tmp, endpos,
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
+		if (endpos < BLOCK_SIZE) {
+			cp = ((const char*) vp) + endpos;
+			break;
+		}
+		cp = (const char*) vp + BLOCK_SIZE;
 	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
-		return -1; /* Refname ends with ".lock". */
-	return cp - refname;
+	return check_refname_component_trailer(cp, refname, flags);
 }
+#endif
 
 int check_refname_format(const char *refname, int flags)
 {
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index 1571176..6fc00fb 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -88,4 +88,17 @@ test_refspec fetch "refs/heads/${good}"
 bad=$(echo -n '\011')
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
2.0.0.rc1.18.gf763c0f
