From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] parseopt: introduce OPT_RECURSE to specify shared options
Date: Mon, 5 Nov 2007 12:09:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711051209061.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 05 13:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip0n2-000486-4C
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbXKEMKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 07:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbXKEMKd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:10:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:47023 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753313AbXKEMKc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:10:32 -0500
Received: (qmail invoked by alias); 05 Nov 2007 12:10:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 05 Nov 2007 13:10:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qC700DZ6qh/tGvpsWc+EK58MtIA1JXJCwqHxyA+
	58EPGVMyQ4TW75
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63502>


The diff options should not need to be defined in every user of the
diffcore.  This provides the framework:

	extern struct option *diff_options;

	struct option options[] = {
		OPT_RECURSE(diff_options),
		...
		OPT_END(),
	};

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is not yet clever enough to show the correct usage when
	some sub option uses the same short or long name as one that
	has already been printed.

	Add the superlevel options struct as another parameter to
	usage_show_options(), and write an unset_option() function
	which takes a short name, a long name, and that superlevel
	options struct, and unsets all options which match.

	Then teach usage_show_options() to skip those options which
	have a short name '\0' and a long name NULL.

	But I leave that as an exercise to the reader.

 parse-options.c          |   68 +++++++++++++++++++++++++++++++++++-----------
 parse-options.h          |    2 +
 t/t0040-parse-options.sh |   24 ++++++++++++++++
 test-parse-options.c     |   10 +++++++
 4 files changed, 88 insertions(+), 16 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cc09c98..66f79a1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -4,6 +4,8 @@
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
+#define OPT_NOT_FOUND -2
+
 struct optparse_t {
 	const char **argv;
 	int argc;
@@ -111,8 +113,14 @@ static int parse_short_opt(struct optparse_t *p, const struct option *options)
 			p->opt = p->opt[1] ? p->opt + 1 : NULL;
 			return get_value(p, options, OPT_SHORT);
 		}
+		if (options->type == OPTION_RECURSE) {
+			const struct option *sub = options->value;
+			int result = parse_short_opt(p, sub);
+			if (result != OPT_NOT_FOUND)
+				return result;
+		}
 	}
-	return error("unknown switch `%c'", *p->opt);
+	return OPT_NOT_FOUND;
 }
 
 static int parse_long_opt(struct optparse_t *p, const char *arg,
@@ -129,6 +137,13 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 		const char *rest;
 		int flags = 0;
 
+		if (options->type == OPTION_RECURSE) {
+			const struct option *sub = options->value;
+			int result = parse_long_opt(p, arg, sub);
+			if (result != OPT_NOT_FOUND)
+				return result;
+		}
+
 		if (!options->long_name)
 			continue;
 
@@ -178,14 +193,14 @@ is_abbreviated:
 	}
 	if (abbrev_option)
 		return get_value(p, abbrev_option, abbrev_flags);
-	return error("unknown option `%s'", arg);
+	return OPT_NOT_FOUND;
 }
 
 int parse_options(int argc, const char **argv, const struct option *options,
                   const char * const usagestr[], int flags)
 {
 	struct optparse_t args = { argv + 1, argc - 1, NULL };
-	int j = 0;
+	int j = 0, result;
 
 	for (; args.argc; args.argc--, args.argv++) {
 		const char *arg = args.argv[0];
@@ -200,8 +215,13 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			do {
 				if (*args.opt == 'h')
 					usage_with_options(usagestr, options);
-				if (parse_short_opt(&args, options) < 0)
+				result = parse_short_opt(&args, options);
+				if (result < 0) {
+					if (result == OPT_NOT_FOUND)
+						error("unknown switch `%c'",
+								arg[1]);
 					usage_with_options(usagestr, options);
+				}
 			} while (args.opt);
 			continue;
 		}
@@ -216,8 +236,12 @@ int parse_options(int argc, const char **argv, const struct option *options,
 
 		if (!strcmp(arg + 2, "help"))
 			usage_with_options(usagestr, options);
-		if (parse_long_opt(&args, arg + 2, options))
+		result = parse_long_opt(&args, arg + 2, options);
+		if (result) {
+			if (result == OPT_NOT_FOUND)
+				error("unknown option `%s'", arg + 2);
 			usage_with_options(usagestr, options);
+		}
 	}
 
 	memmove(argv + j, args.argv, args.argc * sizeof(*argv));
@@ -228,22 +252,18 @@ int parse_options(int argc, const char **argv, const struct option *options,
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
-void usage_with_options(const char * const *usagestr,
-                        const struct option *opts)
+static void usage_show_options(const struct option *opts)
 {
-	fprintf(stderr, "usage: %s\n", *usagestr++);
-	while (*usagestr && **usagestr)
-		fprintf(stderr, "   or: %s\n", *usagestr++);
-	while (*usagestr)
-		fprintf(stderr, "    %s\n", *usagestr++);
-
-	if (opts->type != OPTION_GROUP)
-		fputc('\n', stderr);
-
 	for (; opts->type != OPTION_END; opts++) {
 		size_t pos;
 		int pad;
 
+		if (opts->type == OPTION_RECURSE) {
+			const struct option *sub = opts->value;
+			usage_show_options(sub);
+			continue;
+		}
+
 		if (opts->type == OPTION_GROUP) {
 			fputc('\n', stderr);
 			if (*opts->help)
@@ -295,6 +315,22 @@ void usage_with_options(const char * const *usagestr,
 		}
 		fprintf(stderr, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
 	}
+}
+
+void usage_with_options(const char * const *usagestr,
+                        const struct option *opts)
+{
+	fprintf(stderr, "usage: %s\n", *usagestr++);
+	while (*usagestr && **usagestr)
+		fprintf(stderr, "   or: %s\n", *usagestr++);
+	while (*usagestr)
+		fprintf(stderr, "    %s\n", *usagestr++);
+
+	if (opts->type != OPTION_GROUP)
+		fputc('\n', stderr);
+
+	usage_show_options(opts);
+
 	fputc('\n', stderr);
 
 	exit(129);
diff --git a/parse-options.h b/parse-options.h
index 3a470e5..9ec1e35 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -8,6 +8,7 @@ enum parse_opt_type {
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_CALLBACK,
+	OPTION_RECURSE,
 };
 
 enum parse_opt_flags {
@@ -44,6 +45,7 @@ struct option {
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
+#define OPT_RECURSE(options)        { OPTION_RECURSE, 0, NULL, options }
 
 /* parse_options() will filter out the processed options and leave the
  * non-option argments in argv[].
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ae49424..de2d285 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -13,6 +13,8 @@ usage: test-parse-options <options>
     -b, --boolean         get a boolean
     -i, --integer <n>     get a integer
     -j <n>                get a integer, too
+    -n, --narf            what are we doing tonight?
+    -z, --zort <n>        try to take over the world
 
 string options
     -s, --string <string>
@@ -28,6 +30,8 @@ test_expect_success 'test help' '
 '
 
 cat > expect << EOF
+narf: 0
+zort: 1
 boolean: 2
 integer: 1729
 string: 123
@@ -39,6 +43,8 @@ test_expect_success 'short options' '
 	test ! -s output.err
 '
 cat > expect << EOF
+narf: 0
+zort: 1
 boolean: 2
 integer: 1729
 string: 321
@@ -52,6 +58,8 @@ test_expect_success 'long options' '
 '
 
 cat > expect << EOF
+narf: 0
+zort: 1
 boolean: 1
 integer: 13
 string: 123
@@ -68,6 +76,8 @@ test_expect_success 'intermingled arguments' '
 '
 
 cat > expect << EOF
+narf: 0
+zort: 1
 boolean: 0
 integer: 2
 string: (not set)
@@ -90,4 +100,18 @@ test_expect_failure 'ambiguously abbreviated option' '
         test $? != 129
 '
 
+cat > expect << EOF
+narf: 1
+zort: 5
+boolean: 0
+integer: 3
+string: (not set)
+EOF
+
+test_expect_success 'recurse works' '
+	test-parse-options --narf -z5 --int=3 > output 2> output.err &&
+	test ! -s output.err &&
+	git diff expect output
+'
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index 277cfe4..24613f8 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "parse-options.h"
 
+static int narf = 0;
+static int zort = 1;
 static int boolean = 0;
 static int integer = 0;
 static char *string = NULL;
@@ -11,10 +13,16 @@ int main(int argc, const char **argv)
 		"test-parse-options <options>",
 		NULL
 	};
+	struct option sub[] = {
+		OPT_BOOLEAN('n', "narf", &narf, "what are we doing tonight?"),
+		OPT_INTEGER('z', "zort", &zort, "try to take over the world"),
+		OPT_END(),
+	};
 	struct option options[] = {
 		OPT_BOOLEAN('b', "boolean", &boolean, "get a boolean"),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
+		OPT_RECURSE(sub),
 		OPT_GROUP("string options"),
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
@@ -24,6 +32,8 @@ int main(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, usage, 0);
 
+	printf("narf: %d\n", narf);
+	printf("zort: %d\n", zort);
 	printf("boolean: %d\n", boolean);
 	printf("integer: %d\n", integer);
 	printf("string: %s\n", string ? string : "(not set)");
-- 
1.5.3.5.1549.g91a3
