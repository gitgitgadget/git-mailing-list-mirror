From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] Integrate wildmatch to git
Date: Wed, 26 Sep 2012 18:25:40 +0700
Message-ID: <1348658741-8146-5-git-send-email-pclouds@gmail.com>
References: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 13:34:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGptF-0005qJ-NX
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 13:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab2IZLeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 07:34:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55406 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab2IZLen (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 07:34:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1747509pbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=71lYV0d1HDEnVb4w3p11QuLqhfYFjw0G8UhApZ80w0k=;
        b=A1wKS2timTx2fXuR6oFP/1hqH6xVJpF/YtqQZ77xP3IyXDYB2dFjm1YiINtiLhaGCI
         di2EG0S3Wk5xPXDlEDm+YcvzEV4LfFsxIlsbHwUx+D99FHBE3VqIiYyTt6W5gtL3AxL7
         9e3TLj45EoNWQfPC7BUm6eg6tRbnBhU9i1irIOAi8sS4HL1C0XbqBjHFQi3kra7qvU83
         fOeVw3MuXlTraaJf4Sz3ZVmk4GikdoxdgWhnd/odEWdKRH3vjOH/2MiFnpJKQWCHuBdx
         IxElAInTNYKev92pMFSlB3t4M+Ja39IvelE+j/sVivQHKRbtWsfObW3qe7aehmgv+yND
         MEvA==
Received: by 10.68.242.9 with SMTP id wm9mr1773329pbc.62.1348659283472;
        Wed, 26 Sep 2012 04:34:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id wl6sm1947908pbc.9.2012.09.26.04.34.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 04:34:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 26 Sep 2012 18:27:56 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206410>

This makes wildmatch.c part of libgit.a and builds test-wildmatch; the
dependency on libpopt in the original has been replaced with the use
of our parse-options. Global variables in test-wildmatch are marked
static to avoid sparse warnings.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore           |  1 +
 Makefile             |  3 ++
 t/t3070-wildmatch.sh | 27 ++++++++++++++++
 test-wildmatch.c     | 88 ++++++++++++++++++++++----------------------=
--------
 wildmatch.c          | 26 +++++-----------
 5 files changed, 75 insertions(+), 70 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh

diff --git a/.gitignore b/.gitignore
index 68fe464..54b1b3b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -196,6 +196,7 @@
 /test-sigchain
 /test-subprocess
 /test-svn-fe
+/test-wildmatch
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 26b697d..d6235e6 100644
--- a/Makefile
+++ b/Makefile
@@ -504,6 +504,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
+TEST_PROGRAMS_NEED_X +=3D test-wildmatch
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
@@ -676,6 +677,7 @@ LIB_H +=3D userdiff.h
 LIB_H +=3D utf8.h
 LIB_H +=3D varint.h
 LIB_H +=3D walker.h
+LIB_H +=3D wildmatch.h
 LIB_H +=3D wt-status.h
 LIB_H +=3D xdiff-interface.h
 LIB_H +=3D xdiff/xdiff.h
@@ -807,6 +809,7 @@ LIB_OBJS +=3D utf8.o
 LIB_OBJS +=3D varint.o
 LIB_OBJS +=3D version.o
 LIB_OBJS +=3D walker.o
+LIB_OBJS +=3D wildmatch.o
 LIB_OBJS +=3D wrapper.o
 LIB_OBJS +=3D write_or_die.o
 LIB_OBJS +=3D ws.o
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
new file mode 100755
index 0000000..c4da26c
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
+	test-wildmatch $* ../t3070/wildtest.txt >actual &&
+	echo 'No wildmatch errors found.' >expected &&
+	test_cmp expected actual
+    "
+}
+
+test_wildmatch -x1
+test_wildmatch -x1 -e1
+test_wildmatch -x1 -else
+test_wildmatch -x2
+test_wildmatch -x2 -ese
+test_wildmatch -x3
+test_wildmatch -x3 -e1
+test_wildmatch -x4
+test_wildmatch -x4 -e2e
+test_wildmatch -x5
+test_wildmatch -x5 -es
+
+test_done
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 88585c2..bb726c8 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -19,34 +19,38 @@
=20
 /*#define COMPARE_WITH_FNMATCH*/
=20
-#define WILD_TEST_ITERATIONS
-#include "lib/wildmatch.c"
+#include "cache.h"
+#include "parse-options.h"
+#include "wildmatch.h"
=20
-#include <popt.h>
+#ifndef MAXPATHLEN
+#define MAXPATHLEN 1024
+#endif
+#ifdef NO_STRLCPY
+#include "compat/strlcpy.c"
+#define strlcpy gitstrlcpy
+#endif
=20
 #ifdef COMPARE_WITH_FNMATCH
 #include <fnmatch.h>
=20
-int fnmatch_errors =3D 0;
+static int fnmatch_errors =3D 0;
 #endif
=20
-int wildmatch_errors =3D 0;
-char number_separator =3D ',';
+static int wildmatch_errors =3D 0;
=20
 typedef char bool;
=20
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
+static int explode_mod =3D 0;
+static int empties_mod =3D 0;
+static int empty_at_start =3D 0;
+static int empty_at_end =3D 0;
+static char *empties;
+
+static struct option options[] =3D {
+  OPT_STRING('e', "empties", &empties, "", ""),
+  OPT_INTEGER('x', "explode", &explode_mod, ""),
+  OPT_END(),
 };
=20
 /* match just at the start of string (anchored tests) */
@@ -100,51 +104,33 @@ run_test(int line, bool matches,
 	fnmatch_errors++;
     }
 #endif
-    if (output_iterations) {
-	printf("%d: \"%s\" iterations =3D %d\n", line, pattern,
-	       wildmatch_iteration_count);
-    }
 }
=20
 int
 main(int argc, char **argv)
 {
     char buf[2048], *s, *string[2], *end[2];
-    const char *arg;
     FILE *fp;
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
+    int line, i, flag[2];
+    const char *help[] =3D { NULL };
+
+    argc =3D parse_options(argc, (const char **)argv, "", options, hel=
p, 0);
+    if (argc !=3D 1)
+	    die("redundant options");
+    if (empties) {
+	const char *arg =3D empties;
+	empties_mod =3D atoi(arg);
+	if (strchr(empties, 's'))
+	    empty_at_start =3D 1;
+	if (strchr(arg, 'e'))
+	    empty_at_end =3D 1;
+	if (!explode_mod)
+	    explode_mod =3D 1024;
     }
=20
     if (explode_mod && !empties_mod)
 	empties_mod =3D 1024;
=20
-    argv =3D (char**)poptGetArgs(pc);
-    if (!argv || argv[1]) {
-	fprintf(stderr, "Usage: wildtest [OPTIONS] TESTFILE\n");
-	exit(1);
-    }
-
     if ((fp =3D fopen(*argv, "r")) =3D=3D NULL) {
 	fprintf(stderr, "Unable to open %s\n", *argv);
 	exit(1);
diff --git a/wildmatch.c b/wildmatch.c
index c7f7f9f..f153f8a 100644
--- a/wildmatch.c
+++ b/wildmatch.c
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
 /* Match pattern "p" against the a virtually-joined string consisting
  * of "text" and any strings in array "a". */
 static int dowild(const uchar *p, const uchar *text,
@@ -64,10 +66,6 @@ static int dowild(const uchar *p, const uchar *text,
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
@@ -289,9 +287,6 @@ static const uchar *trailing_N_elements(const uchar=
*const **a_ptr, int count)
 int wildmatch(const char *pattern, const char *text)
 {
     static const uchar *nomore[1]; /* A NULL pointer. */
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count =3D 0;
-#endif
     return dowild((const uchar*)pattern, (const uchar*)text, nomore, 0=
) =3D=3D TRUE;
 }
=20
@@ -300,9 +295,6 @@ int iwildmatch(const char *pattern, const char *tex=
t)
 {
     static const uchar *nomore[1]; /* A NULL pointer. */
     int ret;
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count =3D 0;
-#endif
     ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore, =
1) =3D=3D TRUE;
     return ret;
 }
@@ -319,10 +311,6 @@ int wildmatch_array(const char *pattern, const cha=
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
--=20
1.7.12.1.406.g6ab07c4
