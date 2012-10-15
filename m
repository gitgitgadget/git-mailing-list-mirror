From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/13] Import wildmatch from rsync
Date: Mon, 15 Oct 2012 13:25:52 +0700
Message-ID: <1350282362-4505-3-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:26:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe8Q-0007O9-G7
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab2JOG0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:26:31 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab2JOG0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:26:31 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4542541pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bIUUB5cy6RyYZminErSSlRVyR4xz1Gz7ZIyJp+tVvSI=;
        b=YunresYQB4xukRdT72T5Hf6RflRcA7sjtwOitySwTKSu1ISrpcES7d5fcNKBWeK3Pe
         WHX/m02PCVw1mP2oHRovm1G+kX+9YN0HGQY9hjUsHoqOP2N/QJvIkS1MY6jQxQw38oyR
         4gZK3ob6oXmZY+gId5Ep5DDlurN60uojnf0/9USCYpwpye9EwIgjP5ld2YdMwN/84xTi
         LMc5yuQ+cNJ7JZv5UdjU2Oiuw0AeituTZEod9f9553G+GAEiHC4R6QUz+rtLn7tFx+jA
         014YxhShDmnhNv5bmFPGzIQ6C/fGarKftUl7yoW4V5GtbyWPw0oGoePwWuVYUSMswtAN
         eJKQ==
Received: by 10.68.195.195 with SMTP id ig3mr34832944pbc.108.1350282390719;
        Sun, 14 Oct 2012 23:26:30 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id nd6sm8569485pbc.68.2012.10.14.23.26.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:26:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:26:20 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207701>

These files are from rsync.git commit
f92f5b166e3019db42bc7fe1aa2f1a9178cd215d, which was the last commit
before rsync turned GPL-3. All files are imported as-is and
no-op. Adaptation is done in a separate patch.

rsync.git           ->  git.git
lib/wildmatch.[ch]      wildmatch.[ch]
wildtest.txt            t/t3070/wildtest.txt

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070/wildtest.txt | 165 +++++++++++++++++++++++
 wildmatch.c          | 368 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 wildmatch.h          |   6 +
 3 files changed, 539 insertions(+)
 create mode 100644 t/t3070/wildtest.txt
 create mode 100644 wildmatch.c
 create mode 100644 wildmatch.h

diff --git a/t/t3070/wildtest.txt b/t/t3070/wildtest.txt
new file mode 100644
index 0000000..42c1678
--- /dev/null
+++ b/t/t3070/wildtest.txt
@@ -0,0 +1,165 @@
+# Input is in the following format (all items white-space separated):
+#
+# The first two items are 1 or 0 indicating if the wildmat call is exp=
ected to
+# succeed and if fnmatch works the same way as wildmat, respectively. =
 After
+# that is a text string for the match, and a pattern string.  Strings =
can be
+# quoted (if desired) in either double or single quotes, as well as ba=
ckticks.
+#
+# MATCH FNMATCH_SAME "text to match" 'pattern to use'
+
+# Basic wildmat features
+1 1 foo			foo
+0 1 foo			bar
+1 1 ''			""
+1 1 foo			???
+0 1 foo			??
+1 1 foo			*
+1 1 foo			f*
+0 1 foo			*f
+1 1 foo			*foo*
+1 1 foobar		*ob*a*r*
+1 1 aaaaaaabababab	*ab
+1 1 foo*		foo\*
+0 1 foobar		foo\*bar
+1 1 f\oo		f\\oo
+1 1 ball		*[al]?
+0 1 ten			[ten]
+1 1 ten			**[!te]
+0 1 ten			**[!ten]
+1 1 ten			t[a-g]n
+0 1 ten			t[!a-g]n
+1 1 ton			t[!a-g]n
+1 1 ton			t[^a-g]n
+1 1 a]b			a[]]b
+1 1 a-b			a[]-]b
+1 1 a]b			a[]-]b
+0 1 aab			a[]-]b
+1 1 aab			a[]a-]b
+1 1 ]			]
+
+# Extended slash-matching features
+0 1 foo/baz/bar		foo*bar
+1 1 foo/baz/bar		foo**bar
+0 1 foo/bar		foo?bar
+0 1 foo/bar		foo[/]bar
+0 1 foo/bar		f[^eiu][^eiu][^eiu][^eiu][^eiu]r
+1 1 foo-bar		f[^eiu][^eiu][^eiu][^eiu][^eiu]r
+0 1 foo			**/foo
+1 1 /foo		**/foo
+1 1 bar/baz/foo		**/foo
+0 1 bar/baz/foo		*/foo
+0 0 foo/bar/baz		**/bar*
+1 1 deep/foo/bar/baz	**/bar/*
+0 1 deep/foo/bar/baz/	**/bar/*
+1 1 deep/foo/bar/baz/	**/bar/**
+0 1 deep/foo/bar	**/bar/*
+1 1 deep/foo/bar/	**/bar/**
+1 1 foo/bar/baz		**/bar**
+1 1 foo/bar/baz/x	*/bar/**
+0 0 deep/foo/bar/baz/x	*/bar/**
+1 1 deep/foo/bar/baz/x	**/bar/*/*
+
+# Various additional tests
+0 1 acrt		a[c-c]st
+1 1 acrt		a[c-c]rt
+0 1 ]			[!]-]
+1 1 a			[!]-]
+0 1 ''			\
+0 1 \			\
+0 1 /\			*/\
+1 1 /\			*/\\
+1 1 foo			foo
+1 1 @foo		@foo
+0 1 foo			@foo
+1 1 [ab]		\[ab]
+1 1 [ab]		[[]ab]
+1 1 [ab]		[[:]ab]
+0 1 [ab]		[[::]ab]
+1 1 [ab]		[[:digit]ab]
+1 1 [ab]		[\[:]ab]
+1 1 ?a?b		\??\?b
+1 1 abc			\a\b\c
+0 1 foo			''
+1 1 foo/bar/baz/to	**/t[o]
+
+# Character class tests
+1 1 a1B		[[:alpha:]][[:digit:]][[:upper:]]
+0 1 a		[[:digit:][:upper:][:space:]]
+1 1 A		[[:digit:][:upper:][:space:]]
+1 1 1		[[:digit:][:upper:][:space:]]
+0 1 1		[[:digit:][:upper:][:spaci:]]
+1 1 ' '		[[:digit:][:upper:][:space:]]
+0 1 .		[[:digit:][:upper:][:space:]]
+1 1 .		[[:digit:][:punct:][:space:]]
+1 1 5		[[:xdigit:]]
+1 1 f		[[:xdigit:]]
+1 1 D		[[:xdigit:]]
+1 1 _		[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:=
][:print:][:punct:][:space:][:upper:][:xdigit:]]
+#1 1 =85		[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lo=
wer:][:print:][:punct:][:space:][:upper:][:xdigit:]]
+1 1 =7F		[^[:alnum:][:alpha:][:blank:][:digit:][:graph:][:lower:][:pri=
nt:][:punct:][:space:][:upper:][:xdigit:]]
+1 1 .		[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space=
:][:upper:][:xdigit:]]
+1 1 5		[a-c[:digit:]x-z]
+1 1 b		[a-c[:digit:]x-z]
+1 1 y		[a-c[:digit:]x-z]
+0 1 q		[a-c[:digit:]x-z]
+
+# Additional tests, including some malformed wildmats
+1 1 ]		[\\-^]
+0 1 [		[\\-^]
+1 1 -		[\-_]
+1 1 ]		[\]]
+0 1 \]		[\]]
+0 1 \		[\]]
+0 1 ab		a[]b
+0 1 a[]b	a[]b
+0 1 ab[		ab[
+0 1 ab		[!
+0 1 ab		[-
+1 1 -		[-]
+0 1 -		[a-
+0 1 -		[!a-
+1 1 -		[--A]
+1 1 5		[--A]
+1 1 ' '		'[ --]'
+1 1 $		'[ --]'
+1 1 -		'[ --]'
+0 1 0		'[ --]'
+1 1 -		[---]
+1 1 -		[------]
+0 1 j		[a-e-n]
+1 1 -		[a-e-n]
+1 1 a		[!------]
+0 1 [		[]-a]
+1 1 ^		[]-a]
+0 1 ^		[!]-a]
+1 1 [		[!]-a]
+1 1 ^		[a^bc]
+1 1 -b]		[a-]b]
+0 1 \		[\]
+1 1 \		[\\]
+0 1 \		[!\\]
+1 1 G		[A-\\]
+0 1 aaabbb	b*a
+0 1 aabcaa	*ba*
+1 1 ,		[,]
+1 1 ,		[\\,]
+1 1 \		[\\,]
+1 1 -		[,-.]
+0 1 +		[,-.]
+0 1 -.]		[,-.]
+1 1 2		[\1-\3]
+1 1 3		[\1-\3]
+0 1 4		[\1-\3]
+1 1 \		[[-\]]
+1 1 [		[[-\]]
+1 1 ]		[[-\]]
+0 1 -		[[-\]]
+
+# Test recursion and the abort code (use "wildtest -i" to see iteratio=
n counts)
+1 1 -adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1	-*-*-*-*=
-*-*-12-*-*-*-m-*-*-*
+0 1 -adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1	-*-*-*-*=
-*-*-12-*-*-*-m-*-*-*
+0 1 -adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1	-*-*-*-*=
-*-*-12-*-*-*-m-*-*-*
+1 1 /adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1	/*/*/*/*=
/*/*/12/*/*/*/m/*/*/*
+0 1 /adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1	/*/*/*/*=
/*/*/12/*/*/*/m/*/*/*
+1 1 abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt		**/*a*b*g*n*t
+0 1 abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz		**/*a*b*g*n*t
diff --git a/wildmatch.c b/wildmatch.c
new file mode 100644
index 0000000..f3a1731
--- /dev/null
+++ b/wildmatch.c
@@ -0,0 +1,368 @@
+/*
+**  Do shell-style pattern matching for ?, \, [], and * characters.
+**  It is 8bit clean.
+**
+**  Written by Rich $alz, mirror!rs, Wed Nov 26 19:03:17 EST 1986.
+**  Rich $alz is now <rsalz@bbn.com>.
+**
+**  Modified by Wayne Davison to special-case '/' matching, to make '*=
*'
+**  work differently than '*', and to fix the character-class code.
+*/
+
+#include "rsync.h"
+
+/* What character marks an inverted character class? */
+#define NEGATE_CLASS	'!'
+#define NEGATE_CLASS2	'^'
+
+#define FALSE 0
+#define TRUE 1
+#define ABORT_ALL -1
+#define ABORT_TO_STARSTAR -2
+
+#define CC_EQ(class, len, litmatch) ((len) =3D=3D sizeof (litmatch)-1 =
\
+				    && *(class) =3D=3D *(litmatch) \
+				    && strncmp((char*)class, litmatch, len) =3D=3D 0)
+
+#if defined STDC_HEADERS || !defined isascii
+# define ISASCII(c) 1
+#else
+# define ISASCII(c) isascii(c)
+#endif
+
+#ifdef isblank
+# define ISBLANK(c) (ISASCII(c) && isblank(c))
+#else
+# define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D '\t')
+#endif
+
+#ifdef isgraph
+# define ISGRAPH(c) (ISASCII(c) && isgraph(c))
+#else
+# define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace(c))
+#endif
+
+#define ISPRINT(c) (ISASCII(c) && isprint(c))
+#define ISDIGIT(c) (ISASCII(c) && isdigit(c))
+#define ISALNUM(c) (ISASCII(c) && isalnum(c))
+#define ISALPHA(c) (ISASCII(c) && isalpha(c))
+#define ISCNTRL(c) (ISASCII(c) && iscntrl(c))
+#define ISLOWER(c) (ISASCII(c) && islower(c))
+#define ISPUNCT(c) (ISASCII(c) && ispunct(c))
+#define ISSPACE(c) (ISASCII(c) && isspace(c))
+#define ISUPPER(c) (ISASCII(c) && isupper(c))
+#define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
+
+#ifdef WILD_TEST_ITERATIONS
+int wildmatch_iteration_count;
+#endif
+
+static int force_lower_case =3D 0;
+
+/* Match pattern "p" against the a virtually-joined string consisting
+ * of "text" and any strings in array "a". */
+static int dowild(const uchar *p, const uchar *text, const uchar*const=
 *a)
+{
+    uchar p_ch;
+
+#ifdef WILD_TEST_ITERATIONS
+    wildmatch_iteration_count++;
+#endif
+
+    for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
+	int matched, special;
+	uchar t_ch, prev_ch;
+	while ((t_ch =3D *text) =3D=3D '\0') {
+	    if (*a =3D=3D NULL) {
+		if (p_ch !=3D '*')
+		    return ABORT_ALL;
+		break;
+	    }
+	    text =3D *a++;
+	}
+	if (force_lower_case && ISUPPER(t_ch))
+	    t_ch =3D tolower(t_ch);
+	switch (p_ch) {
+	  case '\\':
+	    /* Literal match with following character.  Note that the test
+	     * in "default" handles the p[1] =3D=3D '\0' failure case. */
+	    p_ch =3D *++p;
+	    /* FALLTHROUGH */
+	  default:
+	    if (t_ch !=3D p_ch)
+		return FALSE;
+	    continue;
+	  case '?':
+	    /* Match anything but '/'. */
+	    if (t_ch =3D=3D '/')
+		return FALSE;
+	    continue;
+	  case '*':
+	    if (*++p =3D=3D '*') {
+		while (*++p =3D=3D '*') {}
+		special =3D TRUE;
+	    } else
+		special =3D FALSE;
+	    if (*p =3D=3D '\0') {
+		/* Trailing "**" matches everything.  Trailing "*" matches
+		 * only if there are no more slash characters. */
+		if (!special) {
+		    do {
+			if (strchr((char*)text, '/') !=3D NULL)
+			    return FALSE;
+		    } while ((text =3D *a++) !=3D NULL);
+		}
+		return TRUE;
+	    }
+	    while (1) {
+		if (t_ch =3D=3D '\0') {
+		    if ((text =3D *a++) =3D=3D NULL)
+			break;
+		    t_ch =3D *text;
+		    continue;
+		}
+		if ((matched =3D dowild(p, text, a)) !=3D FALSE) {
+		    if (!special || matched !=3D ABORT_TO_STARSTAR)
+			return matched;
+		} else if (!special && t_ch =3D=3D '/')
+		    return ABORT_TO_STARSTAR;
+		t_ch =3D *++text;
+	    }
+	    return ABORT_ALL;
+	  case '[':
+	    p_ch =3D *++p;
+#ifdef NEGATE_CLASS2
+	    if (p_ch =3D=3D NEGATE_CLASS2)
+		p_ch =3D NEGATE_CLASS;
+#endif
+	    /* Assign literal TRUE/FALSE because of "matched" comparison. */
+	    special =3D p_ch =3D=3D NEGATE_CLASS? TRUE : FALSE;
+	    if (special) {
+		/* Inverted character class. */
+		p_ch =3D *++p;
+	    }
+	    prev_ch =3D 0;
+	    matched =3D FALSE;
+	    do {
+		if (!p_ch)
+		    return ABORT_ALL;
+		if (p_ch =3D=3D '\\') {
+		    p_ch =3D *++p;
+		    if (!p_ch)
+			return ABORT_ALL;
+		    if (t_ch =3D=3D p_ch)
+			matched =3D TRUE;
+		} else if (p_ch =3D=3D '-' && prev_ch && p[1] && p[1] !=3D ']') {
+		    p_ch =3D *++p;
+		    if (p_ch =3D=3D '\\') {
+			p_ch =3D *++p;
+			if (!p_ch)
+			    return ABORT_ALL;
+		    }
+		    if (t_ch <=3D p_ch && t_ch >=3D prev_ch)
+			matched =3D TRUE;
+		    p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
+		} else if (p_ch =3D=3D '[' && p[1] =3D=3D ':') {
+		    const uchar *s;
+		    int i;
+		    for (s =3D p +=3D 2; (p_ch =3D *p) && p_ch !=3D ']'; p++) {} /*S=
HARED ITERATOR*/
+		    if (!p_ch)
+			return ABORT_ALL;
+		    i =3D p - s - 1;
+		    if (i < 0 || p[-1] !=3D ':') {
+			/* Didn't find ":]", so treat like a normal set. */
+			p =3D s - 2;
+			p_ch =3D '[';
+			if (t_ch =3D=3D p_ch)
+			    matched =3D TRUE;
+			continue;
+		    }
+		    if (CC_EQ(s,i, "alnum")) {
+			if (ISALNUM(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "alpha")) {
+			if (ISALPHA(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "blank")) {
+			if (ISBLANK(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "cntrl")) {
+			if (ISCNTRL(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "digit")) {
+			if (ISDIGIT(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "graph")) {
+			if (ISGRAPH(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "lower")) {
+			if (ISLOWER(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "print")) {
+			if (ISPRINT(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "punct")) {
+			if (ISPUNCT(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "space")) {
+			if (ISSPACE(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "upper")) {
+			if (ISUPPER(t_ch))
+			    matched =3D TRUE;
+		    } else if (CC_EQ(s,i, "xdigit")) {
+			if (ISXDIGIT(t_ch))
+			    matched =3D TRUE;
+		    } else /* malformed [:class:] string */
+			return ABORT_ALL;
+		    p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
+		} else if (t_ch =3D=3D p_ch)
+		    matched =3D TRUE;
+	    } while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
+	    if (matched =3D=3D special || t_ch =3D=3D '/')
+		return FALSE;
+	    continue;
+	}
+    }
+
+    do {
+	if (*text)
+	    return FALSE;
+    } while ((text =3D *a++) !=3D NULL);
+
+    return TRUE;
+}
+
+/* Match literal string "s" against the a virtually-joined string cons=
isting
+ * of "text" and any strings in array "a". */
+static int doliteral(const uchar *s, const uchar *text, const uchar*co=
nst *a)
+{
+    for ( ; *s !=3D '\0'; text++, s++) {
+	while (*text =3D=3D '\0') {
+	    if ((text =3D *a++) =3D=3D NULL)
+		return FALSE;
+	}
+	if (*text !=3D *s)
+	    return FALSE;
+    }
+
+    do {
+	if (*text)
+	    return FALSE;
+    } while ((text =3D *a++) !=3D NULL);
+
+    return TRUE;
+}
+
+/* Return the last "count" path elements from the concatenated string.
+ * We return a string pointer to the start of the string, and update t=
he
+ * array pointer-pointer to point to any remaining string elements. */
+static const uchar *trailing_N_elements(const uchar*const **a_ptr, int=
 count)
+{
+    const uchar*const *a =3D *a_ptr;
+    const uchar*const *first_a =3D a;
+
+    while (*a)
+	    a++;
+
+    while (a !=3D first_a) {
+	const uchar *s =3D *--a;
+	s +=3D strlen((char*)s);
+	while (--s >=3D *a) {
+	    if (*s =3D=3D '/' && !--count) {
+		*a_ptr =3D a+1;
+		return s+1;
+	    }
+	}
+    }
+
+    if (count =3D=3D 1) {
+	*a_ptr =3D a+1;
+	return *a;
+    }
+
+    return NULL;
+}
+
+/* Match the "pattern" against the "text" string. */
+int wildmatch(const char *pattern, const char *text)
+{
+    static const uchar *nomore[1]; /* A NULL pointer. */
+#ifdef WILD_TEST_ITERATIONS
+    wildmatch_iteration_count =3D 0;
+#endif
+    return dowild((const uchar*)pattern, (const uchar*)text, nomore) =3D=
=3D TRUE;
+}
+
+/* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
+int iwildmatch(const char *pattern, const char *text)
+{
+    static const uchar *nomore[1]; /* A NULL pointer. */
+    int ret;
+#ifdef WILD_TEST_ITERATIONS
+    wildmatch_iteration_count =3D 0;
+#endif
+    force_lower_case =3D 1;
+    ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore) =
=3D=3D TRUE;
+    force_lower_case =3D 0;
+    return ret;
+}
+
+/* Match pattern "p" against the a virtually-joined string consisting
+ * of all the pointers in array "texts" (which has a NULL pointer at t=
he
+ * end).  The int "where" can be 0 (normal matching), > 0 (match only
+ * the trailing N slash-separated filename components of "texts"), or =
< 0
+ * (match the "pattern" at the start or after any slash in "texts"). *=
/
+int wildmatch_array(const char *pattern, const char*const *texts, int =
where)
+{
+    const uchar *p =3D (const uchar*)pattern;
+    const uchar*const *a =3D (const uchar*const*)texts;
+    const uchar *text;
+    int matched;
+
+#ifdef WILD_TEST_ITERATIONS
+    wildmatch_iteration_count =3D 0;
+#endif
+
+    if (where > 0)
+	text =3D trailing_N_elements(&a, where);
+    else
+	text =3D *a++;
+    if (!text)
+	return FALSE;
+
+    if ((matched =3D dowild(p, text, a)) !=3D TRUE && where < 0
+     && matched !=3D ABORT_ALL) {
+	while (1) {
+	    if (*text =3D=3D '\0') {
+		if ((text =3D (uchar*)*a++) =3D=3D NULL)
+		    return FALSE;
+		continue;
+	    }
+	    if (*text++ =3D=3D '/' && (matched =3D dowild(p, text, a)) !=3D F=
ALSE
+	     && matched !=3D ABORT_TO_STARSTAR)
+		break;
+	}
+    }
+    return matched =3D=3D TRUE;
+}
+
+/* Match literal string "s" against the a virtually-joined string cons=
isting
+ * of all the pointers in array "texts" (which has a NULL pointer at t=
he
+ * end).  The int "where" can be 0 (normal matching), or > 0 (match
+ * only the trailing N slash-separated filename components of "texts")=
=2E */
+int litmatch_array(const char *string, const char*const *texts, int wh=
ere)
+{
+    const uchar *s =3D (const uchar*)string;
+    const uchar*const *a =3D (const uchar* const*)texts;
+    const uchar *text;
+
+    if (where > 0)
+	text =3D trailing_N_elements(&a, where);
+    else
+	text =3D *a++;
+    if (!text)
+	return FALSE;
+
+    return doliteral(s, text, a) =3D=3D TRUE;
+}
diff --git a/wildmatch.h b/wildmatch.h
new file mode 100644
index 0000000..e7f1a35
--- /dev/null
+++ b/wildmatch.h
@@ -0,0 +1,6 @@
+/* wildmatch.h */
+
+int wildmatch(const char *pattern, const char *text);
+int iwildmatch(const char *pattern, const char *text);
+int wildmatch_array(const char *pattern, const char*const *texts, int =
where);
+int litmatch_array(const char *string, const char*const *texts, int wh=
ere);
--=20
1.8.0.rc0.29.g1fdd78f
