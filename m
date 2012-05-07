From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 2/3] Integrate wildmatch to git
Date: Mon,  7 May 2012 20:01:56 +0700
Message-ID: <1336395717-7799-3-git-send-email-pclouds@gmail.com>
References: <1336395717-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 15:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRNdZ-0008Lj-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 15:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab2EGNFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 09:05:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51177 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab2EGNFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 09:05:55 -0400
Received: by pbbrp8 with SMTP id rp8so6653083pbb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=R44K1JnP4lUdjbgUjiU4FI/TpWCfTbScZ19TIPiH09w=;
        b=XEhe60hUfHi/A+l9auvbwHWVkUciGRbfyuoVfLljjbOxFzcxufTMRVv9qPccxlt8M/
         aPB76B8PKVqxueqEAkUwqIuiOFg2n6GIh39pNG9VO+004zAIbcRP2HOr/O8NONxR20WJ
         AuHsgM2GpIsY0pSfSDnmmf2XQAGSLKbC7u4S17SWaNqpJtDuySE0DLAgXpYN803jw8w6
         dQp2NLbzW8aSXjEGDvxcDogKnWVaOeEZK0O2v9hHJWh0uBkbn1xpZBqC18OY2Cu0dVQh
         E0gXZ8IFme71QENJwOtFpssJQuEEMAyfkZwBX65ze/YAcoXSEQJbCdPrjY2bIIrlOmBp
         G+bA==
Received: by 10.68.129.194 with SMTP id ny2mr31842193pbb.56.1336395954747;
        Mon, 07 May 2012 06:05:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id ms7sm10865730pbb.19.2012.05.07.06.05.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 06:05:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 May 2012 20:02:17 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336395717-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197267>

 - Make wildmatch.c part of libgit.a
 - Rewrite test-wildmatch.c to follow git coding style (i.e. no
   catching up with mainstream since it has turned GPL-3 anyway)
 - Put wildtest.txt into a real test case

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile             |    3 +
 compat/wildmatch.c   |   26 +---
 t/t3070-wildmatch.sh |   27 +++++
 test-wildmatch.c     |  314 +++++++++++++++++++++---------------------=
--------
 4 files changed, 167 insertions(+), 203 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh

diff --git a/Makefile b/Makefile
index 2fa7211..b82f8b6 100644
--- a/Makefile
+++ b/Makefile
@@ -497,6 +497,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
+TEST_PROGRAMS_NEED_X +=3D test-wildmatch
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
@@ -598,6 +599,7 @@ LIB_H +=3D compat/cygwin.h
 LIB_H +=3D compat/mingw.h
 LIB_H +=3D compat/obstack.h
 LIB_H +=3D compat/terminal.h
+LIB_H +=3D compat/wildmatch.h
 LIB_H +=3D compat/win32/dirent.h
 LIB_H +=3D compat/win32/poll.h
 LIB_H +=3D compat/win32/pthread.h
@@ -693,6 +695,7 @@ LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D compat/obstack.o
 LIB_OBJS +=3D compat/terminal.o
+LIB_OBJS +=3D compat/wildmatch.o
 LIB_OBJS +=3D config.o
 LIB_OBJS +=3D connect.o
 LIB_OBJS +=3D connected.o
diff --git a/compat/wildmatch.c b/compat/wildmatch.c
index f3a1731..791b9ef 100644
--- a/compat/wildmatch.c
+++ b/compat/wildmatch.c
@@ -9,7 +9,13 @@
 **  work differently than '*', and to fix the character-class code.
 */
=20
-#include "rsync.h"
+#include <stddef.h>
+#include <ctype.h>
+#include <string.h>
+
+#include "wildmatch.h"
+
+typedef unsigned char uchar;
=20
 /* What character marks an inverted character class? */
 #define NEGATE_CLASS	'!'
@@ -53,10 +59,6 @@
 #define ISUPPER(c) (ISASCII(c) && isupper(c))
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
-#ifdef WILD_TEST_ITERATIONS
-int wildmatch_iteration_count;
-#endif
-
 static int force_lower_case =3D 0;
=20
 /* Match pattern "p" against the a virtually-joined string consisting
@@ -65,10 +67,6 @@ static int dowild(const uchar *p, const uchar *text,=
 const uchar*const *a)
 {
     uchar p_ch;
=20
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count++;
-#endif
-
     for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
 	int matched, special;
 	uchar t_ch, prev_ch;
@@ -288,9 +286,6 @@ static const uchar *trailing_N_elements(const uchar=
*const **a_ptr, int count)
 int wildmatch(const char *pattern, const char *text)
 {
     static const uchar *nomore[1]; /* A NULL pointer. */
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count =3D 0;
-#endif
     return dowild((const uchar*)pattern, (const uchar*)text, nomore) =3D=
=3D TRUE;
 }
=20
@@ -299,9 +294,6 @@ int iwildmatch(const char *pattern, const char *tex=
t)
 {
     static const uchar *nomore[1]; /* A NULL pointer. */
     int ret;
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count =3D 0;
-#endif
     force_lower_case =3D 1;
     ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore) =
=3D=3D TRUE;
     force_lower_case =3D 0;
@@ -320,10 +312,6 @@ int wildmatch_array(const char *pattern, const cha=
r*const *texts, int where)
     const uchar *text;
     int matched;
=20
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count =3D 0;
-#endif
-
     if (where > 0)
 	text =3D trailing_N_elements(&a, where);
     else
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
new file mode 100755
index 0000000..e748fc7
--- /dev/null
+++ b/t/t3070-wildmatch.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description=3D'wildmatch tests'
+
+. ./test-lib.sh
+
+test_wildmatch() {
+    test_expect_success "wildmatch $*" "
+	test-wildmatch $* ../t3070-wildmatch/wildtest.txt >actual &&
+	echo 'No wildmatch errors found.' >expected &&
+	test_cmp expected actual
+    "
+}
+
+test_wildmatch -x1
+test_wildmatch -x1 -E1
+test_wildmatch -x1 -E1 -se
+test_wildmatch -x2
+test_wildmatch -x2 -se
+test_wildmatch -x3
+test_wildmatch -x3 -E1
+test_wildmatch -x4
+test_wildmatch -x4 -E2 -e
+test_wildmatch -x5
+test_wildmatch -x5 -s
+
+test_done
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 3456bac..b832dee 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -17,200 +17,146 @@
  * 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.
  */
=20
-/*#define COMPARE_WITH_FNMATCH*/
-
-#define WILD_TEST_ITERATIONS
-#include "lib/wildmatch.c"
-
-#include <popt.h>
-
-#ifdef COMPARE_WITH_FNMATCH
-#include <fnmatch.h>
-
-int fnmatch_errors =3D 0;
-#endif
-
-int wildmatch_errors =3D 0;
-
-typedef char bool;
-
-int output_iterations =3D 0;
-int explode_mod =3D 0;
-int empties_mod =3D 0;
-int empty_at_start =3D 0;
-int empty_at_end =3D 0;
-
-static struct poptOption long_options[] =3D {
-  /* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
-  {"iterations",     'i', POPT_ARG_NONE,   &output_iterations, 0, 0, 0=
},
-  {"empties",        'e', POPT_ARG_STRING, 0, 'e', 0, 0},
-  {"explode",        'x', POPT_ARG_INT,    &explode_mod, 0, 0, 0},
-  {0,0,0,0, 0, 0, 0}
-};
+#include "cache.h"
+#include "parse-options.h"
+#include "compat/wildmatch.h"
+
+static int compare_fnmatch;
+static int fnmatch_errors;
+static int wildmatch_errors;
+static int explode_mod;
+static int empties_mod;
+static int empty_at_start;
+static int empty_at_end;
=20
 /* match just at the start of string (anchored tests) */
-static void
-run_test(int line, bool matches, bool same_as_fnmatch,
-	 const char *text, const char *pattern)
+static void run_test(int line, int matches, int same_as_fnmatch,
+		     const char *text, const char *pattern)
 {
-    bool matched;
-#ifdef COMPARE_WITH_FNMATCH
-    bool fn_matched;
-    int flags =3D strstr(pattern, "**")? 0 : FNM_PATHNAME;
-#else
-    same_as_fnmatch =3D 0; /* Get rid of unused-variable compiler warn=
ing. */
-#endif
-
-    if (explode_mod) {
-	char buf[MAXPATHLEN*2], *texts[MAXPATHLEN];
-	int pos =3D 0, cnt =3D 0, ndx =3D 0, len =3D strlen(text);
+	int matched;
+	int fn_matched;
+	int flags =3D compare_fnmatch && strstr(pattern, "**") ? 0 : FNM_PATH=
NAME;
+
+	if (explode_mod) {
+		char buf[PATH_MAX * 2], *texts[PATH_MAX];
+		int pos =3D 0, cnt =3D 0, ndx =3D 0, len =3D strlen(text);
+
+		if (empty_at_start)
+			texts[ndx++] =3D "";
+		/* An empty string must turn into at least one empty array item. */
+		while (1) {
+			texts[ndx] =3D buf + ndx * (explode_mod + 1);
+			strlcpy(texts[ndx++], text + pos, explode_mod + 1);
+			if (pos + explode_mod >=3D len)
+				break;
+			pos +=3D explode_mod;
+			if (!(++cnt % empties_mod))
+				texts[ndx++] =3D "";
+		}
+		if (empty_at_end)
+			texts[ndx++] =3D "";
+		texts[ndx] =3D NULL;
+		matched =3D wildmatch_array(pattern, (const char**)texts, 0);
+	} else
+		matched =3D wildmatch(pattern, text);
+	if (compare_fnmatch)
+		fn_matched =3D !fnmatch(pattern, text, flags);
+
+	if (matched !=3D matches) {
+		printf("wildmatch failure on line %d:\n  %s\n  %s\n  expected %s mat=
ch\n",
+		       line, text, pattern, matches ? "a" : "NO");
+		wildmatch_errors++;
+	}
=20
-	if (empty_at_start)
-	    texts[ndx++] =3D "";
-	/* An empty string must turn into at least one empty array item. */
-	while (1) {
-	    texts[ndx] =3D buf + ndx * (explode_mod + 1);
-	    strlcpy(texts[ndx++], text + pos, explode_mod + 1);
-	    if (pos + explode_mod >=3D len)
-		break;
-	    pos +=3D explode_mod;
-	    if (!(++cnt % empties_mod))
-		texts[ndx++] =3D "";
+	if (compare_fnmatch && fn_matched !=3D (matches ^ !same_as_fnmatch)) =
{
+		printf("fnmatch disagreement on line %d:\n  %s\n  %s\n  expected %s =
match\n",
+		       line, text, pattern, matches ^ !same_as_fnmatch ? "a" : "NO")=
;
+		fnmatch_errors++;
 	}
-	if (empty_at_end)
-	    texts[ndx++] =3D "";
-	texts[ndx] =3D NULL;
-	matched =3D wildmatch_array(pattern, (const char**)texts, 0);
-    } else
-	matched =3D wildmatch(pattern, text);
-#ifdef COMPARE_WITH_FNMATCH
-    fn_matched =3D !fnmatch(pattern, text, flags);
-#endif
-    if (matched !=3D matches) {
-	printf("wildmatch failure on line %d:\n  %s\n  %s\n  expected %s matc=
h\n",
-	       line, text, pattern, matches? "a" : "NO");
-	wildmatch_errors++;
-    }
-#ifdef COMPARE_WITH_FNMATCH
-    if (fn_matched !=3D (matches ^ !same_as_fnmatch)) {
-	printf("fnmatch disagreement on line %d:\n  %s\n  %s\n  expected %s m=
atch\n",
-	       line, text, pattern, matches ^ !same_as_fnmatch? "a" : "NO");
-	fnmatch_errors++;
-    }
-#endif
-    if (output_iterations) {
-	printf("%d: \"%s\" iterations =3D %d\n", line, pattern,
-	       wildmatch_iteration_count);
-    }
 }
=20
-int
-main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
-    char buf[2048], *s, *string[2], *end[2];
-    const char *arg;
-    FILE *fp;
-    int opt, line, i, flag[2];
-    poptContext pc =3D poptGetContext("wildtest", argc, (const char**)=
argv,
-				    long_options, 0);
-
-    while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
-	switch (opt) {
-	  case 'e':
-	    arg =3D poptGetOptArg(pc);
-	    empties_mod =3D atoi(arg);
-	    if (strchr(arg, 's'))
-		empty_at_start =3D 1;
-	    if (strchr(arg, 'e'))
-		empty_at_end =3D 1;
-	    if (!explode_mod)
-		explode_mod =3D 1024;
-	    break;
-	  default:
-	    fprintf(stderr, "%s: %s\n",
-		    poptBadOption(pc, POPT_BADOPTION_NOALIAS),
-		    poptStrerror(opt));
-	    exit(1);
-	}
-    }
-
-    if (explode_mod && !empties_mod)
-	empties_mod =3D 1024;
-
-    argv =3D (char**)poptGetArgs(pc);
-    if (!argv || argv[1]) {
-	fprintf(stderr, "Usage: wildtest [OPTIONS] TESTFILE\n");
-	exit(1);
-    }
-
-    if ((fp =3D fopen(*argv, "r")) =3D=3D NULL) {
-	fprintf(stderr, "Unable to open %s\n", *argv);
-	exit(1);
-    }
-
-    line =3D 0;
-    while (fgets(buf, sizeof buf, fp)) {
-	line++;
-	if (*buf =3D=3D '#' || *buf =3D=3D '\n')
-	    continue;
-	for (s =3D buf, i =3D 0; i <=3D 1; i++) {
-	    if (*s =3D=3D '1')
-		flag[i] =3D 1;
-	    else if (*s =3D=3D '0')
-		flag[i] =3D 0;
-	    else
-		flag[i] =3D -1;
-	    if (*++s !=3D ' ' && *s !=3D '\t')
-		flag[i] =3D -1;
-	    if (flag[i] < 0) {
-		fprintf(stderr, "Invalid flag syntax on line %d of %s:\n%s",
-			line, *argv, buf);
-		exit(1);
-	    }
-	    while (*++s =3D=3D ' ' || *s =3D=3D '\t') {}
-	}
-	for (i =3D 0; i <=3D 1; i++) {
-	    if (*s =3D=3D '\'' || *s =3D=3D '"' || *s =3D=3D '`') {
-		char quote =3D *s++;
-		string[i] =3D s;
-		while (*s && *s !=3D quote) s++;
-		if (!*s) {
-		    fprintf(stderr, "Unmatched quote on line %d of %s:\n%s",
-			    line, *argv, buf);
-		    exit(1);
+	char buf[2048];
+	FILE *fp;
+	int line;
+	const struct option opts[] =3D {
+		OPT_INTEGER('E', "empties", &empties_mod, ""),
+		OPT_INTEGER('x', "explode", &explode_mod, "explode mode"),
+		OPT_BOOL('s', NULL, &empty_at_start, ""),
+		OPT_BOOL('e', NULL, &empty_at_end, ""),
+		OPT_BOOL(0, "fnmatch", &compare_fnmatch, "compare with fnmatch()"),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, NULL, opts, NULL, 0);
+	if (argc !=3D 1)
+		die("unknown option");
+
+	if (explode_mod && !empties_mod)
+		empties_mod =3D 1024;
+
+	if ((fp =3D fopen(*argv, "r")) =3D=3D NULL)
+		die_errno("Unable to open %s\n", *argv);
+
+	line =3D 0;
+	while (fgets(buf, sizeof buf, fp)) {
+		char *s, *string[2], *end[2];
+		int i, flag[2];
+
+		line++;
+		if (*buf =3D=3D '#' || *buf =3D=3D '\n')
+			continue;
+		for (s =3D buf, i =3D 0; i <=3D 1; i++) {
+			if (*s =3D=3D '1')
+				flag[i] =3D 1;
+			else if (*s =3D=3D '0')
+				flag[i] =3D 0;
+			else
+				flag[i] =3D -1;
+			if (*++s !=3D ' ' && *s !=3D '\t')
+				flag[i] =3D -1;
+			if (flag[i] < 0)
+				die("Invalid flag syntax on line %d of %s:\n%s",
+				    line, *argv, buf);
+			while (*++s =3D=3D ' ' || *s =3D=3D '\t') {}
 		}
-		end[i] =3D s;
-	    }
-	    else {
-		if (!*s || *s =3D=3D '\n') {
-		    fprintf(stderr, "Not enough strings on line %d of %s:\n%s",
-			    line, *argv, buf);
-		    exit(1);
+		for (i =3D 0; i <=3D 1; i++) {
+			if (*s =3D=3D '\'' || *s =3D=3D '"' || *s =3D=3D '`') {
+				char quote =3D *s++;
+				string[i] =3D s;
+				while (*s && *s !=3D quote) s++;
+				if (!*s)
+					die("Unmatched quote on line %d of %s:\n%s",
+					    line, *argv, buf);
+				end[i] =3D s;
+			}
+			else {
+				if (!*s || *s =3D=3D '\n')
+					die("Not enough strings on line %d of %s:\n%s",
+					    line, *argv, buf);
+				string[i] =3D s;
+				while (*++s && *s !=3D ' ' && *s !=3D '\t' && *s !=3D '\n') {}
+				end[i] =3D s;
+			}
+			while (*++s =3D=3D ' ' || *s =3D=3D '\t') {}
 		}
-		string[i] =3D s;
-		while (*++s && *s !=3D ' ' && *s !=3D '\t' && *s !=3D '\n') {}
-		end[i] =3D s;
-	    }
-	    while (*++s =3D=3D ' ' || *s =3D=3D '\t') {}
+		*end[0] =3D *end[1] =3D '\0';
+		run_test(line, flag[0], flag[1], string[0], string[1]);
 	}
-	*end[0] =3D *end[1] =3D '\0';
-	run_test(line, flag[0], flag[1], string[0], string[1]);
-    }
-
-    if (!wildmatch_errors)
-	fputs("No", stdout);
-    else
-	printf("%d", wildmatch_errors);
-    printf(" wildmatch error%s found.\n", wildmatch_errors =3D=3D 1? "=
" : "s");
-
-#ifdef COMPARE_WITH_FNMATCH
-    if (!fnmatch_errors)
-	fputs("No", stdout);
-    else
-	printf("%d", fnmatch_errors);
-    printf(" fnmatch error%s found.\n", fnmatch_errors =3D=3D 1? "" : =
"s");
=20
-#endif
-
-    return 0;
+	if (!wildmatch_errors)
+		fputs("No", stdout);
+	else
+		printf("%d", wildmatch_errors);
+	printf(" wildmatch error%s found.\n", wildmatch_errors =3D=3D 1 ? "" =
: "s");
+
+	if (compare_fnmatch) {
+		if (!fnmatch_errors)
+			fputs("No", stdout);
+		else
+			printf("%d", fnmatch_errors);
+		printf(" fnmatch error%s found.\n", fnmatch_errors =3D=3D 1 ? "" : "=
s");
+	}
+	return 0;
 }
--=20
1.7.8.36.g69ee2
