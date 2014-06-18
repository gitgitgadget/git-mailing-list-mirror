From: David Turner <dturner@twopensource.com>
Subject: [PATCH v11] refs.c: SSE2 optimizations for check_refname_component
Date: Wed, 18 Jun 2014 01:54:42 -0400
Message-ID: <1403070882-12044-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, neleai@seznam.cz
X-From: git-owner@vger.kernel.org Wed Jun 18 07:55:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx8px-0001Ke-H8
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 07:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608AbaFRFzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2014 01:55:03 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:53704 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbaFRFzB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 01:55:01 -0400
Received: by mail-qa0-f52.google.com with SMTP id w8so301993qac.39
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 22:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=rlqbNDa+4YZqfLI6GQEqtzD3f0rsKLUrHbyyk/uMPo0=;
        b=gUToewBiTUGHLkeDZMahjnbYZVOSTvYPscTxd/lqqSRMd1QKpxwJlS8mOtOCabuwCY
         PJmZ4sjOKGJ6FbDQdnPhbmXR8J1zFN68HLvuMfXCa6tDyS5btOqomZYH7BCWavox1XMx
         PMFNRPgQLuxGNncwaQjTAYppmsSZoi5QPcRSy7kwbROmkX56k3qaVChUKLUCBX1LCPtq
         pqNMLtavRuvSFnuWRamDAiRZ4FZTUVV6w1O4Lvb+KPUX/uXZtF7k0htNiXQyGILF55sO
         kCIYCvxPgSGAS5np29faWo+9PT8rmRKN+D1L6etet2vIsqgeEjcynDcPZixUXOWNoNlJ
         97UQ==
X-Gm-Message-State: ALoCoQlzeOE3OX5Z5s7uHx0ajVAkEZFjaWCFiT9D0aHQzxPs9j16WFK+qQ3brW3EEdKzWLnxtdVi
X-Received: by 10.224.3.68 with SMTP id 4mr38413223qam.24.1403070900318;
        Tue, 17 Jun 2014 22:55:00 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.196.26])
        by mx.google.com with ESMTPSA id r14sm651083qga.4.2014.06.17.22.54.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 22:54:59 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.24.g9a2fcb5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251968>

Optimize check_refname_component using SSE2 on x86_64.

git rev-parse HEAD is a good test-case for this, since it does almost
nothing except parse refs.  For one particular repo with about 60k
refs, almost all packed, the timings are:

Look up table: 29 ms
SSE2:          23 ms

This cuts about 20% off of the runtime.

Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> suggested an SSE2 approach to=
 the
substring searches, which netted a speed boost over the SSE4.2 code I
had initially written.

Signed-off-by: David Turner <dturner@twitter.com>
---
 git-compat-util.h           |  11 +++
 refs.c                      | 234 ++++++++++++++++++++++++++++++++++++=
++++----
 t/t1402-check-ref-format.sh |  15 +++
 t/valgrind/default.supp     |   8 ++
 4 files changed, 250 insertions(+), 18 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6f03b3..96f5554 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -685,6 +685,17 @@ void git_qsort(void *base, size_t nmemb, size_t si=
ze,
 #endif
 #endif
=20
+#if defined(__GNUC__) && defined(__x86_64__)
+#include <emmintrin.h>
+/*
+ * This is the system memory page size; it's used so that we can read
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
index dc45774..20e2bf1 100644
--- a/refs.c
+++ b/refs.c
@@ -7,21 +7,27 @@
=20
 /*
  * How to handle various characters in refnames:
+ * This table is used by both the SIMD and non-SIMD code.  It has
+ * some cases that are only useful for the SIMD; these are handled
+ * equivalently to the listed disposition in the non-SIMD code.
  * 0: An acceptable character for refs
- * 1: End-of-component
- * 2: ., look for a preceding . to reject .. in refs
- * 3: {, look for a preceding @ to reject @{ in refs
- * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
+ * 1: @, look for a following { to reject @{ in refs (SIMD or =3D 0)
+ * 2: \0: End-of-component and string
+ * 3: /: End-of-component (SIMD or =3D 2)
+ * 4: ., look for a preceding . to reject .. in refs
+ * 5: {, look for a preceding @ to reject @{ in refs
+ * 6: *, usually a bad character except, once as a wildcard (SIMD or =3D=
 7)
+ * 7: A bad character except * (see check_refname_component below)
  */
 static unsigned char refname_disposition[256] =3D {
-	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
+	2, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 4, 3,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 7,
+	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 0, 7, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 7, 7
 };
=20
 /*
@@ -33,8 +39,9 @@ static unsigned char refname_disposition[256] =3D {
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
- * - it ends with a "/".
- * - it ends with ".lock"
+ * - it has pattern-matching notation "*", "?", "[", anywhere, or
+ * - it ends with a "/", or
+ * - it ends with ".lock", or
  * - it contains a "\" (backslash)
  */
 static int check_refname_component(const char *refname, int flags)
@@ -46,17 +53,19 @@ static int check_refname_component(const char *refn=
ame, int flags)
 		int ch =3D *cp & 255;
 		unsigned char disp =3D refname_disposition[ch];
 		switch (disp) {
-		case 1:
+		case 2: /* fall-through */
+		case 3:
 			goto out;
-		case 2:
+		case 4:
 			if (last =3D=3D '.')
 				return -1; /* Refname contains "..". */
 			break;
-		case 3:
+		case 5:
 			if (last =3D=3D '@')
 				return -1; /* Refname contains "@{". */
 			break;
-		case 4:
+		case 6: /* fall-through */
+		case 7:
 			return -1;
 		}
 		last =3D ch;
@@ -79,7 +88,7 @@ out:
 	return cp - refname;
 }
=20
-int check_refname_format(const char *refname, int flags)
+static int check_refname_format_bytewise(const char *refname, int flag=
s)
 {
 	int component_len, component_count =3D 0;
=20
@@ -115,6 +124,195 @@ int check_refname_format(const char *refname, int=
 flags)
 	return 0;
 }
=20
+#if defined(__GNUC__) && defined(__x86_64__)
+#define SSE_VECTOR_BYTES 16
+
+/* Vectorized version of check_refname_format. */
+int check_refname_format(const char *refname, int flags)
+{
+	const char *cp =3D refname;
+
+	const __m128i dot =3D _mm_set1_epi8('.');
+	const __m128i at =3D _mm_set1_epi8('@');
+	const __m128i curly =3D _mm_set1_epi8('{');
+	const __m128i slash =3D _mm_set1_epi8('/');
+	const __m128i zero =3D _mm_set1_epi8('\000');
+	const __m128i el =3D _mm_set1_epi8('l');
+
+	/* below '*', all characters are forbidden or rare */
+	const __m128i star_ub =3D _mm_set1_epi8('*' + 1);
+
+	const __m128i colon =3D _mm_set1_epi8(':');
+	const __m128i question =3D _mm_set1_epi8('?');
+
+	/* '['..'^' contains 4 characters: 3 forbidden and 1 rare */
+	const __m128i bracket_lb =3D _mm_set1_epi8('[' - 1);
+	const __m128i caret_ub =3D _mm_set1_epi8('^' + 1);
+
+	/* '~' and above are forbidden */
+	const __m128i tilde_lb =3D _mm_set1_epi8('~' - 1);
+
+	int component_count =3D 0;
+
+	if (refname[0] =3D=3D 0 || refname[0] =3D=3D '/') {
+		/* entirely empty ref or initial ref component */
+		return -1;
+	}
+
+	/*
+	 * Initial ref component of '.'; below we look for /. so we'll
+	 * miss this.
+	 */
+	if (refname[0] =3D=3D '.') {
+		if (refname[1] =3D=3D '/' || refname[1] =3D=3D '\0')
+			return -1;
+		if (!(flags & REFNAME_DOT_COMPONENT))
+			return -1;
+	}
+	while(1) {
+		__m128i tmp, tmp1, result;
+		uint64_t mask;
+
+		if ((uintptr_t) cp % PAGE_SIZE > PAGE_SIZE - SSE_VECTOR_BYTES  - 1)
+			/*
+			 * End-of-page; fall back to slow method for
+			 * this entire ref.
+			 */
+			return check_refname_format_bytewise(refname, flags);
+
+		tmp =3D _mm_loadu_si128((__m128i *)cp);
+		tmp1 =3D _mm_loadu_si128((__m128i *)(cp + 1));
+
+		/*
+		 * This range (note the lt) contains some
+		 * permissible-but-rare characters (including all
+		 * characters >=3D 128), which we handle later.  It also
+		 * includes \000.
+		 */
+		result =3D _mm_cmplt_epi8(tmp, star_ub);
+
+		result =3D _mm_or_si128(result, _mm_cmpeq_epi8(tmp, question));
+		result =3D _mm_or_si128(result, _mm_cmpeq_epi8(tmp, colon));
+
+		/* This range contains the permissible ] as bycatch */
+		result =3D _mm_or_si128(result, _mm_and_si128(
+					      _mm_cmpgt_epi8(tmp, bracket_lb),
+					      _mm_cmplt_epi8(tmp, caret_ub)));
+
+		result =3D _mm_or_si128(result, _mm_cmpgt_epi8(tmp, tilde_lb));
+
+		/* .. */
+		result =3D _mm_or_si128(result, _mm_and_si128(
+					      _mm_cmpeq_epi8(tmp, dot),
+					      _mm_cmpeq_epi8(tmp1, dot)));
+		/* @{ */
+		result =3D _mm_or_si128(result, _mm_and_si128(
+					      _mm_cmpeq_epi8(tmp, at),
+					      _mm_cmpeq_epi8(tmp1, curly)));
+		/* // */
+		result =3D _mm_or_si128(result, _mm_and_si128(
+					      _mm_cmpeq_epi8(tmp, slash),
+					      _mm_cmpeq_epi8(tmp1, slash)));
+		/* trailing / */
+		result =3D _mm_or_si128(result, _mm_and_si128(
+					      _mm_cmpeq_epi8(tmp, slash),
+					      _mm_cmpeq_epi8(tmp1, zero)));
+		/* .l, beginning of .lock */
+		result =3D _mm_or_si128(result, _mm_and_si128(
+					      _mm_cmpeq_epi8(tmp, dot),
+					      _mm_cmpeq_epi8(tmp1, el)));
+		/*
+		 * Even though /. is not necessarily an error, we flag
+		 * it anyway. If we find it, we'll check if it's valid
+		 * and if so we'll advance just past it.
+		 */
+		result =3D _mm_or_si128(result, _mm_and_si128(
+					      _mm_cmpeq_epi8(tmp, slash),
+					      _mm_cmpeq_epi8(tmp1, dot)));
+
+		mask =3D _mm_movemask_epi8(result);
+		if (mask) {
+			/*
+			 * We've found either end-of-string, or some
+			 * probably-bad character or substring.
+			 */
+			int i =3D __builtin_ctz(mask);
+			switch (refname_disposition[cp[i] & 255]) {
+			case 0: /* fall-through */
+			case 5:
+				/*
+				 * bycatch: a good character that's in
+				 * one of the ranges of mostly-forbidden
+				 * characters
+				 */
+				cp +=3D i + 1;
+				break;
+			case 1:
+				if (cp[i + 1] =3D=3D '{')
+					return -1;
+				cp +=3D i + 1;
+				break;
+			case 2:
+				if (!(flags & REFNAME_ALLOW_ONELEVEL)
+				    && !component_count && !strchr(refname, '/'))
+					/* Refname has only one component. */
+					return -1;
+				return 0;
+			case 3:
+				component_count ++;
+				/*
+				 * Even if leading dots are allowed, don't
+				 * allow "." as a component (".." is
+				 * prevented by case 4 below).
+				 */
+				if (cp[i + 1] =3D=3D '.') {
+					if (cp[i + 2] =3D=3D '\0')
+						return -1;
+					if (flags & REFNAME_DOT_COMPONENT) {
+						/* skip to just after the /. */
+						cp +=3D i + 2;
+						break;
+					}
+					return -1;
+				} else if (cp[i + 1] =3D=3D '/' || cp[i + 1] =3D=3D '\0')
+					return -1;
+				break;
+			case 4:
+				if (cp[i + 1] =3D=3D '.' || cp[i + 1] =3D=3D '\0')
+					return -1;
+				/* .lock as end-of-component or end-of-string */
+				if ((!strncmp(cp + i, ".lock", 5))
+				    && (cp[i + 5] =3D=3D '/' || cp[i + 5] =3D=3D 0))
+					return -1;
+				cp +=3D 1;
+				break;
+			case 6:
+				if (((cp =3D=3D refname + i) || cp[i - 1] =3D=3D '/')
+				    && (cp[i + 1] =3D=3D '/' || cp[i + 1] =3D=3D 0))
+					if (flags & REFNAME_REFSPEC_PATTERN) {
+						flags &=3D ~REFNAME_REFSPEC_PATTERN;
+						/* restart after the * */
+						cp +=3D i + 1;
+						continue;
+					}
+				/* fall-through */
+			case 7:
+				return -1;
+			}
+		} else
+			cp +=3D SSE_VECTOR_BYTES;
+	}
+}
+
+#else
+
+int check_refname_format (const char *refname, int flags)
+{
+	return check_refname_format_bytewise(refname, flags);
+}
+
+#endif
+
 struct ref_entry;
=20
 /*
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1a5a5f3..9aeb352 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -64,6 +64,7 @@ valid_ref "$(printf 'heads/fu\303\237')"
 invalid_ref 'heads/*foo/bar' --refspec-pattern
 invalid_ref 'heads/foo*/bar' --refspec-pattern
 invalid_ref 'heads/f*o/bar' --refspec-pattern
+invalid_ref 'heads/foo*//bar' --refspec-pattern
=20
 ref=3D'foo'
 invalid_ref "$ref"
@@ -128,6 +129,20 @@ valid_ref NOT_MINGW "$ref" '--allow-onelevel --nor=
malize'
 invalid_ref NOT_MINGW "$ref" '--refspec-pattern --normalize'
 valid_ref NOT_MINGW "$ref" '--refspec-pattern --allow-onelevel --norma=
lize'
=20
+
+valid_ref 'refs/heads/a-very-long-refname'
+invalid_ref 'refs/heads/.a-very-long-refname'
+invalid_ref 'refs/heads/abcdefgh0123..'
+invalid_ref 'refs/heads/abcdefgh01234..'
+invalid_ref 'refs/heads/abcdefgh012345..'
+invalid_ref 'refs/heads/abcdefgh0123456..'
+invalid_ref 'refs/heads/abcdefgh01234567..'
+valid_ref 'refs/heads/abcdefgh0123.a'
+valid_ref 'refs/heads/abcdefgh01234.a'
+valid_ref 'refs/heads/abcdefgh012345.a'
+valid_ref 'refs/heads/abcdefgh0123456.a'
+valid_ref 'refs/heads/abcdefgh01234567.a'
+
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=3D$(git write-tree) &&
 	sha1=3D$(echo A | git commit-tree $T) &&
diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 0a6724f..332ab1a 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -49,3 +49,11 @@
 	Memcheck:Addr4
 	fun:copy_ref
 }
+{
+	ignore-sse-check_refname_format
+	Memcheck:Addr8
+	fun:check_refname_format
+	fun:cmd_check_ref_format
+	fun:handle_builtin
+	fun:main
+}
--=20
2.0.0.rc1.24.g9a2fcb5
