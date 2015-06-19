From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/3] Move unsigned long option parsing out of pack-objects.c
Date: Fri, 19 Jun 2015 10:10:58 +0100
Message-ID: <1434705059-2793-3-git-send-email-charles@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
To: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 11:37:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5sjs-0004sp-OC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 11:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbbFSJha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 05:37:30 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:51098 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbbFSJh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 05:37:27 -0400
Received: from hashpling.plus.com ([212.159.69.125]:41965)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z5sKQ-0006de-Eg; Fri, 19 Jun 2015 10:11:14 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434705059-2793-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272114>

From: Charles Bailey <cbailey32@bloomberg.net>

The unsigned long option parsing (including 'k'/'m'/'g' suffix parsing)
is more widely applicable. Add support for OPT_ULONG to parse-options.h
and change pack-objects.c use this support.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 builtin/pack-objects.c   | 17 -----------------
 parse-options.c          | 15 +++++++++++++++
 parse-options.h          |  5 ++++-
 t/t0040-parse-options.sh | 46 ++++++++++++++++++++++++++++++++++++++++++----
 test-parse-options.c     |  3 +++
 5 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80fe8c7..5de76db 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2588,23 +2588,6 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_ulong(const struct option *opt,
-			      const char *arg, int unset)
-{
-	if (unset)
-		die(_("option %s does not accept negative form"),
-		    opt->long_name);
-
-	if (!git_parse_ulong(arg, opt->value))
-		die(_("unable to parse value '%s' for option %s"),
-		    arg, opt->long_name);
-	return 0;
-}
-
-#define OPT_ULONG(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), "n", (h),	\
-	  PARSE_OPT_NONEG, option_parse_ulong }
-
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
diff --git a/parse-options.c b/parse-options.c
index 80106c0..76a5c3e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -180,6 +180,21 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
 
+	case OPTION_ULONG:
+		if (unset) {
+			*(unsigned long *)opt->value = 0;
+			return 0;
+		}
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			*(unsigned long *)opt->value = opt->defval;
+			return 0;
+		}
+		if (get_arg(p, opt, flags, &arg))
+			return -1;
+		if (!git_parse_ulong(arg, opt->value))
+			return opterror(opt, "expects a numerical value", flags);
+		return 0;
+
 	default:
 		die("should not happen, someone must be hit on the forehead");
 	}
diff --git a/parse-options.h b/parse-options.h
index c71e9da..2ddb26f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -18,7 +18,8 @@ enum parse_opt_type {
 	OPTION_INTEGER,
 	OPTION_CALLBACK,
 	OPTION_LOWLEVEL_CALLBACK,
-	OPTION_FILENAME
+	OPTION_FILENAME,
+	OPTION_ULONG
 };
 
 enum parse_opt_flags {
@@ -129,6 +130,8 @@ struct option {
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
+#define OPT_ULONG(s, l, v, h)       { OPTION_ULONG, (s), (l), (v), N_("n"), \
+				      (h), PARSE_OPT_NONEG }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ecb7417..55b3dba 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -19,6 +19,8 @@ usage: test-parse-options <options>
 
     -i, --integer <n>     get a integer
     -j <n>                get a integer, too
+    -u, --unsigned-long <n>
+                          get an unsigned long
     --set23               set integer to 23
     -t <time>             get timestamp of <time>
     -L, --length <str>    get length of <str>
@@ -58,6 +60,7 @@ mv expect expect.err
 cat >expect.template <<EOF
 boolean: 0
 integer: 0
+unsigned long: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -132,9 +135,32 @@ test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear
 
 test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
 
+test_expect_success 'OPT_INT() negative' 'check integer: -2345 -i -2345'
+
+test_expect_success 'OPT_ULONG() simple' '
+	check "unsigned long:" 2345678 -u 2345678
+'
+
+test_expect_success 'OPT_ULONG() kilo' '
+	check "unsigned long:" 239616 -u 234k
+'
+
+test_expect_success 'OPT_ULONG() mega' '
+	check "unsigned long:" 104857600 -u 100m
+'
+
+test_expect_success 'OPT_ULONG() giga' '
+	check "unsigned long:" 1073741824 -u 1g
+'
+
+test_expect_success 'OPT_ULONG() 3giga' '
+	check "unsigned long:" 3221225472 -u 3g
+'
+
 cat > expect << EOF
 boolean: 2
 integer: 1729
+unsigned long: 16384
 timestamp: 0
 string: 123
 abbrev: 7
@@ -145,7 +171,7 @@ file: prefix/my.file
 EOF
 
 test_expect_success 'short options' '
-	test-parse-options -s123 -b -i 1729 -b -vv -n -F my.file \
+	test-parse-options -s123 -b -i 1729 -u 16k -b -vv -n -F my.file \
 	> output 2> output.err &&
 	test_cmp expect output &&
 	test_must_be_empty output.err
@@ -156,6 +182,7 @@ test_expect_success 'OPT_INT() negative' 'check integer: -2345 -i -2345'
 cat > expect << EOF
 boolean: 2
 integer: 1729
+unsigned long: 16384
 timestamp: 0
 string: 321
 abbrev: 10
@@ -166,9 +193,10 @@ file: prefix/fi.le
 EOF
 
 test_expect_success 'long options' '
-	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
-		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le\
-		--obsolete > output 2> output.err &&
+	test-parse-options --boolean --integer 1729 --unsigned-long 16k \
+		--boolean --string2=321 --verbose --verbose --no-dry-run \
+		--abbrev=10 --file fi.le --obsolete \
+		> output 2> output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
@@ -182,6 +210,7 @@ test_expect_success 'missing required value' '
 cat > expect << EOF
 boolean: 1
 integer: 13
+unsigned long: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -204,6 +233,7 @@ test_expect_success 'intermingled arguments' '
 cat > expect << EOF
 boolean: 0
 integer: 2
+unsigned long: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -232,6 +262,7 @@ test_expect_success 'ambiguously abbreviated option' '
 cat > expect << EOF
 boolean: 0
 integer: 0
+unsigned long: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -270,6 +301,7 @@ test_expect_success 'detect possible typos' '
 cat > expect <<EOF
 boolean: 0
 integer: 0
+unsigned long: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -289,6 +321,7 @@ test_expect_success 'keep some options as arguments' '
 cat > expect <<EOF
 boolean: 0
 integer: 0
+unsigned long: 0
 timestamp: 1
 string: (not set)
 abbrev: 7
@@ -310,6 +343,7 @@ cat > expect <<EOF
 Callback: "four", 0
 boolean: 5
 integer: 4
+unsigned long: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -338,6 +372,7 @@ test_expect_success 'OPT_CALLBACK() and callback errors work' '
 cat > expect <<EOF
 boolean: 1
 integer: 23
+unsigned long: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -362,6 +397,7 @@ test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
 cat > expect <<EOF
 boolean: 6
 integer: 0
+unsigned long: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -392,6 +428,7 @@ test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
 cat > expect <<EOF
 boolean: 0
 integer: 12345
+unsigned long: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -410,6 +447,7 @@ test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 cat >expect <<EOF
 boolean: 0
 integer: 0
+unsigned long: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
diff --git a/test-parse-options.c b/test-parse-options.c
index 7c492cf..e592d7e 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -4,6 +4,7 @@
 
 static int boolean = 0;
 static int integer = 0;
+static unsigned long unsigned_long = 0;
 static unsigned long timestamp;
 static int abbrev = 7;
 static int verbose = 0, dry_run = 0, quiet = 0;
@@ -48,6 +49,7 @@ int main(int argc, char **argv)
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
+		OPT_ULONG('u', "unsigned-long", &unsigned_long, "get an unsigned long"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
 		OPT_CALLBACK('L', "length", &integer, "str",
@@ -83,6 +85,7 @@ int main(int argc, char **argv)
 
 	printf("boolean: %d\n", boolean);
 	printf("integer: %d\n", integer);
+	printf("unsigned long: %lu\n", unsigned_long);
 	printf("timestamp: %lu\n", timestamp);
 	printf("string: %s\n", string ? string : "(not set)");
 	printf("abbrev: %d\n", abbrev);
-- 
2.4.0.53.g8440f74
