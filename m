From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] Move unsigned long option parsing out of pack-objects.c
Date: Sun, 21 Jun 2015 19:25:44 +0100
Message-ID: <1434911144-6781-3-git-send-email-charles@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434911144-6781-1-git-send-email-charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 20:26:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6jwl-00025M-06
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 20:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbbFUS0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 14:26:17 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:56195 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbbFUS0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 14:26:12 -0400
Received: from hashpling.plus.com ([212.159.69.125]:53881)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z6jwY-0003T6-W4; Sun, 21 Jun 2015 19:26:11 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434911144-6781-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272276>

From: Charles Bailey <cbailey32@bloomberg.net>

The unsigned long option parsing (including 'k'/'m'/'g' suffix parsing)
is more widely applicable. Add support for OPT_MAGNITUDE to
parse-options.h and change pack-objects.c use this support.

The error behavior on parse errors follows that of OPT_INTEGER.
The name of the option that failed to parse is reported with a brief
message describing the expect format for the option argument and then
the full usage message for the command invoked.

This is differs from the previous behavior for OPT_ULONG used in
pack-objects for --max-pack-size and --window-memory which used to
display the value supplied in the error message and did not display the
full usage message.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 Documentation/technical/api-parse-options.txt |  6 ++++
 builtin/pack-objects.c                        | 25 +++------------
 parse-options.c                               | 17 ++++++++++
 parse-options.h                               |  3 ++
 t/t0040-parse-options.sh                      | 45 ++++++++++++++++++++++++---
 test-parse-options.c                          |  3 ++
 6 files changed, 73 insertions(+), 26 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 1f2db31..525cb2f 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -168,6 +168,12 @@ There are some macros to easily define options:
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
 
+`OPT_MAGNITUDE(short, long, &unsigned_long_var, description)`::
+	Introduce an option with a size argument. The argument must be a
+	non-negative integer and may include a suffix of 'k', 'm' or 'g' to
+	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
+	The scaled value is put into `unsigned_long_var`.
+
 `OPT_DATE(short, long, &int_var, description)`::
 	Introduce an option with date argument, see `approxidate()`.
 	The timestamp is put into `int_var`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80fe8c7..62cc16d 100644
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
@@ -2627,16 +2610,16 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("version[,offset]"),
 		  N_("write the pack index file in the specified idx format version"),
 		  0, option_parse_index_version },
-		OPT_ULONG(0, "max-pack-size", &pack_size_limit,
-			  N_("maximum size of each output pack file")),
+		OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
+			      N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
 			 N_("ignore borrowed objects from alternate object store")),
 		OPT_BOOL(0, "incremental", &incremental,
 			 N_("ignore packed objects")),
 		OPT_INTEGER(0, "window", &window,
 			    N_("limit pack window by objects")),
-		OPT_ULONG(0, "window-memory", &window_memory_limit,
-			  N_("limit pack window by memory in addition to object limit")),
+		OPT_MAGNITUDE(0, "window-memory", &window_memory_limit,
+			      N_("limit pack window by memory in addition to object limit")),
 		OPT_INTEGER(0, "depth", &depth,
 			    N_("maximum length of delta chain allowed in the resulting pack")),
 		OPT_BOOL(0, "reuse-delta", &reuse_delta,
diff --git a/parse-options.c b/parse-options.c
index 80106c0..101b649 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -180,6 +180,23 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
 
+	case OPTION_MAGNITUDE:
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
+			return opterror(opt,
+				"expects a integer value with an optional k/m/g suffix",
+				flags);
+		return 0;
+
 	default:
 		die("should not happen, someone must be hit on the forehead");
 	}
diff --git a/parse-options.h b/parse-options.h
index c71e9da..ca865f6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -16,6 +16,7 @@ enum parse_opt_type {
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
+	OPTION_MAGNITUDE,
 	OPTION_CALLBACK,
 	OPTION_LOWLEVEL_CALLBACK,
 	OPTION_FILENAME
@@ -129,6 +130,8 @@ struct option {
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
+#define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
+				      N_("n"), (h), PARSE_OPT_NONEG }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 372d521..9be6411 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -19,6 +19,7 @@ usage: test-parse-options <options>
 
     -i, --integer <n>     get a integer
     -j <n>                get a integer, too
+    -m, --magnitude <n>   get a magnitude
     --set23               set integer to 23
     -t <time>             get timestamp of <time>
     -L, --length <str>    get length of <str>
@@ -58,6 +59,7 @@ mv expect expect.err
 cat >expect.template <<EOF
 boolean: 0
 integer: 0
+magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -134,9 +136,30 @@ test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
 
 test_expect_success 'OPT_INT() negative' 'check integer: -2345 -i -2345'
 
+test_expect_success 'OPT_MAGNITUDE() simple' '
+	check magnitude: 2345678 -m 2345678
+'
+
+test_expect_success 'OPT_MAGNITUDE() kilo' '
+	check magnitude: 239616 -m 234k
+'
+
+test_expect_success 'OPT_MAGNITUDE() mega' '
+	check magnitude: 104857600 -m 100m
+'
+
+test_expect_success 'OPT_MAGNITUDE() giga' '
+	check magnitude: 1073741824 -m 1g
+'
+
+test_expect_success 'OPT_MAGNITUDE() 3giga' '
+	check magnitude: 3221225472 -m 3g
+'
+
 cat > expect << EOF
 boolean: 2
 integer: 1729
+magnitude: 16384
 timestamp: 0
 string: 123
 abbrev: 7
@@ -147,8 +170,8 @@ file: prefix/my.file
 EOF
 
 test_expect_success 'short options' '
-	test-parse-options -s123 -b -i 1729 -b -vv -n -F my.file \
-	> output 2> output.err &&
+	test-parse-options -s123 -b -i 1729 -m 16k -b -vv -n -F my.file \
+	>output 2>output.err &&
 	test_cmp expect output &&
 	test_must_be_empty output.err
 '
@@ -156,6 +179,7 @@ test_expect_success 'short options' '
 cat > expect << EOF
 boolean: 2
 integer: 1729
+magnitude: 16384
 timestamp: 0
 string: 321
 abbrev: 10
@@ -166,9 +190,10 @@ file: prefix/fi.le
 EOF
 
 test_expect_success 'long options' '
-	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
-		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le\
-		--obsolete > output 2> output.err &&
+	test-parse-options --boolean --integer 1729 --magnitude 16k \
+		--boolean --string2=321 --verbose --verbose --no-dry-run \
+		--abbrev=10 --file fi.le --obsolete \
+		>output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
@@ -182,6 +207,7 @@ test_expect_success 'missing required value' '
 cat > expect << EOF
 boolean: 1
 integer: 13
+magnitude: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -204,6 +230,7 @@ test_expect_success 'intermingled arguments' '
 cat > expect << EOF
 boolean: 0
 integer: 2
+magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -232,6 +259,7 @@ test_expect_success 'ambiguously abbreviated option' '
 cat > expect << EOF
 boolean: 0
 integer: 0
+magnitude: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -270,6 +298,7 @@ test_expect_success 'detect possible typos' '
 cat > expect <<EOF
 boolean: 0
 integer: 0
+magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -289,6 +318,7 @@ test_expect_success 'keep some options as arguments' '
 cat > expect <<EOF
 boolean: 0
 integer: 0
+magnitude: 0
 timestamp: 1
 string: (not set)
 abbrev: 7
@@ -310,6 +340,7 @@ cat > expect <<EOF
 Callback: "four", 0
 boolean: 5
 integer: 4
+magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -338,6 +369,7 @@ test_expect_success 'OPT_CALLBACK() and callback errors work' '
 cat > expect <<EOF
 boolean: 1
 integer: 23
+magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -362,6 +394,7 @@ test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
 cat > expect <<EOF
 boolean: 6
 integer: 0
+magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -392,6 +425,7 @@ test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
 cat > expect <<EOF
 boolean: 0
 integer: 12345
+magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -410,6 +444,7 @@ test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 cat >expect <<EOF
 boolean: 0
 integer: 0
+magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
diff --git a/test-parse-options.c b/test-parse-options.c
index 7c492cf..2c8c8f1 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -4,6 +4,7 @@
 
 static int boolean = 0;
 static int integer = 0;
+static unsigned long magnitude = 0;
 static unsigned long timestamp;
 static int abbrev = 7;
 static int verbose = 0, dry_run = 0, quiet = 0;
@@ -48,6 +49,7 @@ int main(int argc, char **argv)
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
+		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
 		OPT_CALLBACK('L', "length", &integer, "str",
@@ -83,6 +85,7 @@ int main(int argc, char **argv)
 
 	printf("boolean: %d\n", boolean);
 	printf("integer: %d\n", integer);
+	printf("magnitude: %lu\n", magnitude);
 	printf("timestamp: %lu\n", timestamp);
 	printf("string: %s\n", string ? string : "(not set)");
 	printf("abbrev: %d\n", abbrev);
-- 
2.4.0.53.g8440f74
