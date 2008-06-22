From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/2] Extend parse-options test suite
Date: Sun, 22 Jun 2008 02:00:02 +0200
Message-ID: <1214092802-8175-2-git-send-email-s-beyer@gmx.net>
References: <1214092802-8175-1-git-send-email-s-beyer@gmx.net>
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 02:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAD1A-0003FD-6S
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 02:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYFVAAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 20:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbYFVAAT
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 20:00:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:47312 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751480AbYFVAAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 20:00:18 -0400
Received: (qmail invoked by alias); 22 Jun 2008 00:00:16 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp008) with SMTP; 22 Jun 2008 02:00:16 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18zkRI/LwEz0V3sB2PsiTer+NDLcu/rkHJ5NnaoEt
	pyYH4SPvpUUJ6B
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KACzy-00028G-Nj; Sun, 22 Jun 2008 02:00:02 +0200
X-Mailer: git-send-email 1.5.6.310.g344d
In-Reply-To: <1214092802-8175-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85742>

This patch serves two purposes:
 1. test-parse-option.c should be a more complete
    example for the parse-options API, and
 2. there have been no tests for OPT_CALLBACK,
    OPT_DATE, OPT_BIT, OPT_SET_INT and OPT_SET_PTR
    before.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
On reviewing you should perhaps first have a look at the .c file,
then the changes of t0040 make more sense.

 t/t0040-parse-options.sh |  116 +++++++++++++++++++++++++++++++++++++++++++---
 test-parse-options.c     |   39 ++++++++++++++--
 2 files changed, 144 insertions(+), 11 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 9965cfa..87c6164 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -11,23 +11,35 @@ cat > expect.err << EOF
 usage: test-parse-options <options>
 
     -b, --boolean         get a boolean
+    -4, --or4             bitwise-or boolean with ...0100
+
     -i, --integer <n>     get a integer
     -j <n>                get a integer, too
+    --set23               set integer to 23
+    -t <time>             get timestamp of <time>
+    -L, --length <str>    get length of <str>
 
-string options
+String options
     -s, --string <string>
                           get a string
     --string2 <str>       get another string
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
+    --default-string      set string to default
 
-magic arguments
+Magic arguments
     --quux                means --quux
 
+Standard options
+    --abbrev [<n>]        use <n> digits to display SHA-1s
+    -v, --verbose         be verbose
+    -n, --dry-run         dry run
+    -q, --quiet           be quiet
+
 EOF
 
 test_expect_success 'test help' '
-	! test-parse-options -h > output 2> output.err &&
+	test_must_fail test-parse-options -h > output 2> output.err &&
 	test ! -s output &&
 	test_cmp expect.err output.err
 '
@@ -36,21 +48,31 @@ cat > expect << EOF
 boolean: 2
 integer: 1729
 string: 123
+abbrev: 7
+verbose: 2
+quiet: no
+dry run: yes
 EOF
 
 test_expect_success 'short options' '
-	test-parse-options -s123 -b -i 1729 -b > output 2> output.err &&
+	test-parse-options -s123 -b -i 1729 -b -vv -n > output 2> output.err &&
 	test_cmp expect output &&
 	test ! -s output.err
 '
+
 cat > expect << EOF
 boolean: 2
 integer: 1729
 string: 321
+abbrev: 10
+verbose: 2
+quiet: no
+dry run: no
 EOF
 
 test_expect_success 'long options' '
 	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
+		--verbose --verbose --no-dry-run --abbrev=10 \
 		> output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
@@ -60,6 +82,10 @@ cat > expect << EOF
 boolean: 1
 integer: 13
 string: 123
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
 arg 00: a1
 arg 01: b1
 arg 02: --boolean
@@ -76,6 +102,10 @@ cat > expect << EOF
 boolean: 0
 integer: 2
 string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
@@ -99,6 +129,10 @@ cat > expect << EOF
 boolean: 0
 integer: 0
 string: 123
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
 EOF
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
@@ -107,20 +141,24 @@ test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 	test_cmp expect output
 '
 
-cat > expect.err << EOF
+cat > typo.err << EOF
 error: did you mean \`--boolean\` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	! test-parse-options -boolean > output 2> output.err &&
+	test_must_fail test-parse-options -boolean > output 2> output.err &&
 	test ! -s output &&
-	test_cmp expect.err output.err
+	test_cmp typo.err output.err
 '
 
 cat > expect <<EOF
 boolean: 0
 integer: 0
 string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
 arg 00: --quux
 EOF
 
@@ -130,4 +168,68 @@ test_expect_success 'keep some options as arguments' '
         test_cmp expect output
 '
 
+cat > expect <<EOF
+boolean: 0
+integer: 1
+string: default
+abbrev: 7
+verbose: 0
+quiet: yes
+dry run: no
+arg 00: foo
+EOF
+
+test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
+	test-parse-options -t "1970-01-01 00:00:01 +0000" --default-string \
+		foo -q > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+Callback: "four", 0
+boolean: 5
+integer: 4
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
+EOF
+
+test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
+	test-parse-options --length=four -b -4 > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+Callback: "not set", 1
+EOF
+
+test_expect_success 'OPT_CALLBACK() and callback errors work' '
+	test_must_fail test-parse-options --no-length > output 2> output.err &&
+	test_cmp expect output &&
+	test_cmp expect.err output.err
+'
+
+cat > expect <<EOF
+boolean: 1
+integer: 23
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
+EOF
+
+test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
+	test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
+# --or4
+# --no-or4
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index 73360d7..2a79e72 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -2,9 +2,22 @@
 #include "parse-options.h"
 
 static int boolean = 0;
-static int integer = 0;
+static unsigned long integer = 0;
+static int abbrev = 7;
+static int verbose = 0, dry_run = 0, quiet = 0;
 static char *string = NULL;
 
+int length_callback(const struct option *opt, const char *arg, int unset)
+{
+	printf("Callback: \"%s\", %d\n",
+		(arg ? arg : "not set"), unset);
+	if (unset)
+		return 1; /* do not support unset */
+
+	*(unsigned long *)opt->value = strlen(arg);
+	return 0;
+}
+
 int main(int argc, const char **argv)
 {
 	const char *usage[] = {
@@ -13,15 +26,29 @@ int main(int argc, const char **argv)
 	};
 	struct option options[] = {
 		OPT_BOOLEAN('b', "boolean", &boolean, "get a boolean"),
+		OPT_BIT('4', "or4", &boolean,
+			"bitwise-or boolean with ...0100", 4),
+		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
-		OPT_GROUP("string options"),
+		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
+		OPT_DATE('t', NULL, &integer, "get timestamp of <time>"),
+		OPT_CALLBACK('L', "length", &integer, "str",
+			"get length of <str>", length_callback),
+		OPT_GROUP("String options"),
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
 		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
-		OPT_GROUP("magic arguments"),
+		OPT_SET_PTR(0, "default-string", &string,
+			"set string to default", (unsigned long)"default"),
+		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
+		OPT_GROUP("Standard options"),
+		OPT__ABBREV(&abbrev),
+		OPT__VERBOSE(&verbose),
+		OPT__DRY_RUN(&dry_run),
+		OPT__QUIET(&quiet),
 		OPT_END(),
 	};
 	int i;
@@ -29,8 +56,12 @@ int main(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, usage, 0);
 
 	printf("boolean: %d\n", boolean);
-	printf("integer: %d\n", integer);
+	printf("integer: %lu\n", integer);
 	printf("string: %s\n", string ? string : "(not set)");
+	printf("abbrev: %d\n", abbrev);
+	printf("verbose: %d\n", verbose);
+	printf("quiet: %s\n", quiet ? "yes" : "no");
+	printf("dry run: %s\n", dry_run ? "yes" : "no");
 
 	for (i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
-- 
1.5.6.310.g344d
