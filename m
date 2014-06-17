From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9] refs.c: SSE2 optimizations for check_refname_component
Date: Mon, 16 Jun 2014 23:10:42 -0400
Message-ID: <1402974642-13808-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, neleai@seznam.cz
X-From: git-owner@vger.kernel.org Tue Jun 17 05:11:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwjng-0001rE-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 05:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbaFQDLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2014 23:11:04 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:54334 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbaFQDLC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 23:11:02 -0400
Received: by mail-qa0-f54.google.com with SMTP id v10so8637035qac.27
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 20:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=C2OQvVNUi7nXMWkjmNpTkzsIR7K0dvNYwKDNSZx8elg=;
        b=R50KuhRsfGHBLfjLLYz2tW0gqjJOEefWhxm1G6EkJinm9+2+x894B7kHaGwejDq3rm
         j2FIf9if8vnJyZgNRg2VHTT6R0XABkjUi/XHx/c7n1WZUFIh47pUiV6wmphUVMgyXcCA
         LtX5Y7HM455V/2FvMKfNo1HKH9RitViOyNIIx9zX0eh5UzOjFsRnKoVFjJqjZ+SYEJly
         Qvlkm/+N2LldIssOpWLQjIMXSr39fsXcQQBs99Mk1bfylQE5J/gYwpjQmCeDxL0wJJuh
         7Ylhz5qpGtDTNm97HZ0wFmKuQcOnndndRiRARLeJ9zbRzudbOU+BGT4scmX4ZYqgPIjA
         gVmg==
X-Gm-Message-State: ALoCoQmV4tjKZc9PSPK9Yb9pdXYdsjoAk2U1jhpg3AhF0w0aQqNp6p8it2DxyDuxSUDVuObm7SgU
X-Received: by 10.140.43.132 with SMTP id e4mr1669923qga.32.1402974661291;
        Mon, 16 Jun 2014 20:11:01 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id d8sm24893184qas.24.2014.06.16.20.10.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 20:11:00 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.24.g0588c94.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251842>

Optimize check_refname_component using SSE2 on x86_64.

git rev-parse HEAD is a good test-case for this, since it does almost
nothing except parse refs.  For one particular repo with about 60k
refs, almost all packed, the timings are:

Look up table: 29 ms
SSE2:          23 ms

This cuts about 20% off of the runtime.

The configure.ac changes include code from the GNU C Library written
by Joseph S. Myers <joseph at codesourcery dot com>.

Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> suggested an SSE2 approach to=
 the
substring searches, which netted a speed boost over the SSE4.2 code I
had initially written.

Signed-off-by: David Turner <dturner@twitter.com>
---
 git-compat-util.h  |  11 +++
 refs.c             | 223 +++++++++++++++++++++++++++++++++++++++++++++=
+++-----
 t/t5511-refspec.sh |  20 +++++
 3 files changed, 236 insertions(+), 18 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..0aec58e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -668,6 +668,17 @@ void git_qsort(void *base, size_t nmemb, size_t si=
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
index 46139d2..5c2f68b 100644
--- a/refs.c
+++ b/refs.c
@@ -8,20 +8,22 @@
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
- * 1: End-of-component
- * 2: ., look for a preceding . to reject .. in refs
- * 3: {, look for a preceding @ to reject @{ in refs
- * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
+ * 1: \0: End-of-component and string
+ * 2: /: End-of-component
+ * 3: ., look for a preceding . to reject .. in refs
+ * 4: {, look for a preceding @ to reject @{ in refs
+ * 5: *, usually a bad character except, once as a wildcard
+ * 6: A bad character except * (see check_refname_component below)
  */
 static unsigned char refname_disposition[256] =3D {
-	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
+	1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
+	6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
+	6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 3, 2,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 6,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 0, 6, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 6, 6
 };
=20
 /*
@@ -33,8 +35,9 @@ static unsigned char refname_disposition[256] =3D {
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
@@ -46,17 +49,19 @@ static int check_refname_component(const char *refn=
ame, int flags)
 		int ch =3D *cp & 255;
 		unsigned char disp =3D refname_disposition[ch];
 		switch(disp) {
-		case 1:
-			goto out;
+		case 1: /* fall-through */
 		case 2:
+			goto out;
+		case 3:
 			if (last =3D=3D '.')
 				return -1; /* Refname contains "..". */
 			break;
-		case 3:
+		case 4:
 			if (last =3D=3D '@')
 				return -1; /* Refname contains "@{". */
 			break;
-		case 4:
+		case 5: /* fall-through */
+		case 6:
 			return -1;
 		}
 		last =3D ch;
@@ -79,14 +84,13 @@ out:
 	return cp - refname;
 }
=20
-int check_refname_format(const char *refname, int flags)
+static int check_refname_format_bytewise(const char *refname, int flag=
s)
 {
 	int component_len, component_count =3D 0;
=20
 	if (!strcmp(refname, "@"))
 		/* Refname is a single character '@'. */
 		return -1;
-
 	while (1) {
 		/* We are at the start of a path component. */
 		component_len =3D check_refname_component(refname, flags);
@@ -115,6 +119,189 @@ int check_refname_format(const char *refname, int=
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
+			case 0:
+				/*
+				 * bycatch: a good character that's in
+				 * one of the ranges of mostly-forbidden
+				 * characters
+				 */
+				cp +=3D i + 1;
+				break;
+			case 1:
+				cp +=3D i;
+				goto success;
+			case 2:
+				/*
+				 * Even if leading dots are allowed, don't
+				 * allow "." as a component (".." is
+				 * prevented by case 3 below).
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
+			case 3:
+				if (cp[i + 1] =3D=3D '.' || cp[i + 1] =3D=3D '\0')
+					return -1;
+				/* .lock as end-of-component or end-of-string */
+				if ((!strncmp(cp + i, ".lock", 5))
+				    && (cp[i + 5] =3D=3D '/' || cp[i + 5] =3D=3D 0))
+					return -1;
+				cp +=3D 1;
+				break;
+			case 4:
+				if (cp[i + 1] =3D=3D '{')
+					return -1;
+				break;
+			case 5:
+				if (((cp =3D=3D refname + i) || cp[i - 1] =3D=3D '/')
+				    && (cp[i + 1] =3D=3D '/' || cp[i + 1] =3D=3D 0))
+					if (flags & REFNAME_REFSPEC_PATTERN) {
+						flags &=3D ~REFNAME_REFSPEC_PATTERN;
+						/* restart after the * */
+						cp +=3D i + 1;
+						continue;
+					}
+				/* fall-through */
+			case 6:
+				return -1;
+			}
+		} else
+			cp +=3D SSE_VECTOR_BYTES;
+	}
+success:
+	return 0;
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
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index de6db86..51d23b1 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -29,6 +29,10 @@ test_refspec push '+:'
 test_refspec fetch ''
 test_refspec fetch ':'
 test_refspec fetch '::'						invalid
+test_refspec fetch '.'						invalid
+test_refspec fetch './frotz'					invalid
+test_refspec fetch 'refs/.'					invalid
+test_refspec push '*//:refs/remotes/frotz/*'			invalid
=20
 test_refspec push 'refs/heads/*:refs/remotes/frotz/*'
 test_refspec push 'refs/heads/*:refs/remotes/frotz'		invalid
@@ -71,6 +75,9 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
 test_refspec push ':refs/remotes/frotz/delete me'		invalid
 test_refspec fetch ':refs/remotes/frotz/HEAD to me'		invalid
=20
+test_refspec fetch ':refs/remotes/frotz/something.lock'		invalid
+test_refspec fetch ':refs/remotes/frotz/a.lock/b'		invalid
+
 test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' i=
nvalid
 test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' in=
valid
=20
@@ -88,4 +95,17 @@ test_refspec fetch "refs/heads/${good}"
 bad=3D$(printf '\011tab')
 test_refspec fetch "refs/heads/${bad}"				invalid
=20
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
--=20
2.0.0.rc1.24.g0588c94.dirty
