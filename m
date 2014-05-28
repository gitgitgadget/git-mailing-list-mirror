From: David Turner <dturner@twopensource.com>
Subject: [PATCH] check_refname_component: Optimize
Date: Wed, 28 May 2014 17:04:15 -0400
Message-ID: <1401311055-480-2-git-send-email-dturner@twitter.com>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed May 28 23:04:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpl1r-0002Fe-7j
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbaE1VEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:04:51 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:56215 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbaE1VEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 17:04:50 -0400
Received: by mail-qg0-f51.google.com with SMTP id q107so19505390qgd.38
        for <git@vger.kernel.org>; Wed, 28 May 2014 14:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RKRWZxLIr4Zx3M/dODZyLlnExTZaQos0vi8cDw+0pH0=;
        b=GS9lEVbAMg1T2jI4ggGmcxHZkA5F2D8YGM+oOQEOISsHthnG7OHNDX3+AB9iml7Jgs
         1HO8wBzxKdX8QLLW5XOTUEp21SR8HVRq15VbwkFHUdYJhcEuUua6gKZP2SQyfKl3OjKg
         9tfgJ0C9Ws3FcRveVNl3j9UclzrrQ22/ImLRRpGx42KZj0AoW8w27+4+tS4EQrFKYwIj
         FMhH0Apq24G5GRrfN+1MbuZoA/GkOELmfVAggKQnboaLFGz2At7Nydw7tXt0xGjdfeyG
         MyTY1ZVWcR1tZiXCD0kpvNVJolNZZ1EtX+64cyhqY8BPcMk5ZAQZh6bvSZV85XHn+A0S
         k/fw==
X-Gm-Message-State: ALoCoQnDuGYGRdyWXS6PDB40fTKI5CdMpAlA9c+Vq03Ef4RzJr5Fgb2xBgT9hOFVkGQfi8l/dED6
X-Received: by 10.224.25.133 with SMTP id z5mr3212678qab.97.1401311089518;
        Wed, 28 May 2014 14:04:49 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id 91sm12856578qgp.41.2014.05.28.14.04.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 May 2014 14:04:48 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.18.gf763c0f
In-Reply-To: <1401311055-480-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250329>

In a repository with tens of thousands of refs, the command
~/git/git-diff-index --cached --quiet --ignore-submodules [revision]
is a bit slow.  check_refname_component is a major contributor to the
runtime.  Provide two optimized versions of this function: one for
machines with SSE4.2, and one for machines without.  The speedup for
this command on one particular repo (with about 60k refs) is about 12%
for the SSE version and 8% for the non-SSE version.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Makefile           |   6 +++
 configure.ac       |   6 +++
 refs.c             | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 t/t5511-refspec.sh |  13 +++++
 4 files changed, 172 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index a53f3a8..123e2fc 100644
--- a/Makefile
+++ b/Makefile
@@ -1326,6 +1326,11 @@ else
 		COMPAT_OBJS += compat/win32mmap.o
 	endif
 endif
+ifdef NO_SSE
+	BASIC_CFLAGS += -DNO_SSE
+else
+	BASIC_CFLAGS += -msse4
+endif
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
@@ -2199,6 +2204,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+	@echo NO_SSE=\''$(subst ','\'',$(subst ','\'',$(NO_SSE)))'\' >>$@
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@
 endif
diff --git a/configure.ac b/configure.ac
index b711254..71a9429 100644
--- a/configure.ac
+++ b/configure.ac
@@ -382,6 +382,11 @@ AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),
 GIT_PARSE_WITH(tcltk))
 #
 
+# Declare the with-sse/without-sse options.
+AC_ARG_WITH(sse,
+AS_HELP_STRING([--with-sse],[use SSE instructions (default is YES)]),
+GIT_PARSE_WITH(sse))
+
 
 ## Checks for programs.
 AC_MSG_NOTICE([CHECKS for programs])
@@ -449,6 +454,7 @@ else
   fi
 fi
 GIT_CONF_SUBST([TCLTK_PATH])
+GIT_CONF_SUBST([NO_SSE])
 AC_CHECK_PROGS(ASCIIDOC, [asciidoc])
 if test -n "$ASCIIDOC"; then
 	AC_MSG_CHECKING([for asciidoc version])
diff --git a/refs.c b/refs.c
index 28d5eca..8f0de04 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,8 @@
 #include "dir.h"
 #include "string-list.h"
 
+#include <nmmintrin.h>
+
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
@@ -29,30 +31,169 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
+char refname_disposition[] = {
+       1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+       0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 9, 9, 9, 2, 1,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 9, 9, 9, 9, 0,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 9, 0, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 3, 9, 9, 0, 0,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
+};
+
 /*
  * Try to read one refname component from the front of refname.  Return
  * the length of the component found, or -1 if the component is not
  * legal.
  */
-static int check_refname_component(const char *refname, int flags)
+static int check_refname_component_1(const char *refname, int flags)
 {
 	const char *cp;
 	char last = '\0';
 
 	for (cp = refname; ; cp++) {
-		char ch = *cp;
-		if (ch == '\0' || ch == '/')
+		unsigned char ch = (unsigned char) *cp;
+		char disp = refname_disposition[ch];
+		switch(disp) {
+		case 0:
+		       return -1;
+		case 1:
+			goto out;
+		case 2:
+			if (last == '.')
+				return -1;
 			break;
-		if (bad_ref_char(ch))
-			return -1; /* Illegal character in refname. */
+		case 3:
+		       if (last == '@')
+			       return -1;
+		       break;
+	       }
+
 		if (last == '.' && ch == '.')
 			return -1; /* Refname contains "..". */
 		if (last == '@' && ch == '{')
 			return -1; /* Refname contains "@{". */
 		last = ch;
 	}
+out:
+	if (cp == refname)
+		return 0; /* Component has zero length. */
+
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
+#ifdef NO_SSE
+#define check_refname_component check_refname_component_1
+#else
+
+#ifndef _SIDD_UBYTE_OPS
+#define _SIDD_UBYTE_OPS                 0x00
+#define _SIDD_CMP_EQUAL_ANY             0x00
+#define _SIDD_CMP_RANGES                0x04
+#define _SIDD_CMP_EQUAL_ORDERED         0x0c
+#define _SIDD_NEGATIVE_POLARITY         0x10
+#endif
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
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
+
+	int dotdotpos = BLOCK_SIZE, atcurlypos = BLOCK_SIZE;
+	for (vp = refname_vec; ; vp++) {
+		__m128i tmp;
+		int endpos;
+
+		/* Handle case of forbidden substrings .. and @{ crossing
+		 * sixteen-byte boudaries */
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
+	}
+
 	if (cp == refname)
 		return 0; /* Component has zero length. */
+
 	if (refname[0] == '.') {
 		if (!(flags & REFNAME_DOT_COMPONENT))
 			return -1; /* Component starts with '.'. */
@@ -67,6 +208,7 @@ static int check_refname_component(const char *refname, int flags)
 		return -1; /* Refname ends with ".lock". */
 	return cp - refname;
 }
+#endif
 
 int check_refname_format(const char *refname, int flags)
 {
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index c289322..0f03f9c 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -84,4 +84,17 @@ test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
 test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*'
 test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*'
 
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
