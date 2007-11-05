Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 22616 invoked by uid 111); 5 Nov 2007 12:03:48 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 07:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbXKEMDf (ORCPT <rfc822;peff@peff.net>);
	Mon, 5 Nov 2007 07:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbXKEMDf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:03:35 -0500
Received: from pan.madism.org ([88.191.52.104]:52839 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbXKEMD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:03:27 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9F9952888C;
	Mon,  5 Nov 2007 13:03:25 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7AB6B8AD4; Mon,  5 Nov 2007 13:03:24 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/4] Implement OPTION_SUBARRAY handling.
Date:	Mon,  5 Nov 2007 13:03:24 +0100
Message-Id: <1194264204-3475-5-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1531.g59008
In-Reply-To: <1194264204-3475-4-git-send-email-madcoder@debian.org>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
 <1194264204-3475-3-git-send-email-madcoder@debian.org>
 <1194264204-3475-4-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Basically, an OPTION_SUBARRAY is a pointer to a new `struct option` array.
This array should start with an OPTION_BASEOFFSET used to relocate ->value
pointers.

The sizeof() of the struct used for the BASEOFFSET entry is also stored so
that a subarray can also have global side effects (->values pointers that
are not in the memory range of the BASE struct are not relocated).

Arbitrary nesting of subarrays is supported, though no checks that there is
a subarray loop is performed.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c          |   78 +++++++++++++++++++++++++++++++++++++++------
 parse-options.h          |    5 +++
 t/t0040-parse-options.sh |   31 +++++++++++++++++-
 test-parse-options.c     |   25 ++++++++++++++-
 4 files changed, 126 insertions(+), 13 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 5cea511..001d1e5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -4,6 +4,12 @@
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
+struct optreloc_t {
+	const char *base;
+	const char *end;
+	intptr_t offs;
+};
+
 struct optparse_t {
 	const char **argv;
 	int argc;
@@ -11,6 +17,8 @@ struct optparse_t {
 
 	const struct option *abbrev_option, *conflict_option;
 	int abbrev_flags, conflict_flags;
+
+	struct optreloc_t reloc;
 };
 
 static inline const char *get_arg(struct optparse_t *p)
@@ -39,10 +47,32 @@ static int opterror(const struct option *opt, const char *reason, int flags)
 	return error("option `%s' %s", opt->long_name, reason);
 }
 
+static void *reloc_value(struct optparse_t *p, const struct option *opt)
+{
+	char *value = opt->value;
+	if (value >= p->reloc.base && value < p->reloc.end)
+		return value + p->reloc.offs;
+	return value;
+}
+
+static const struct option *reloc_option(struct optparse_t *p,
+                                         const struct option *opt,
+                                         struct option *buf)
+{
+	char *value = opt->value;
+	if (value >= p->reloc.base && value < p->reloc.end) {
+		*buf = *opt;
+		buf->value = value + p->reloc.offs;
+		return buf;
+	}
+	return opt;
+}
+
 static int get_value(struct optparse_t *p,
                      const struct option *opt, int flags)
 {
 	const char *s, *arg;
+	struct option tmp;
 	arg = p->opt ? p->opt : (p->argc > 1 ? p->argv[1] : NULL);
 
 	if (p->opt && (flags & OPT_UNSET))
@@ -53,26 +83,27 @@ static int get_value(struct optparse_t *p,
 		if (!(flags & OPT_SHORT) && p->opt)
 			return opterror(opt, "takes no value", flags);
 		if (flags & OPT_UNSET)
-			*(int *)opt->value = 0;
+			*(int *)reloc_value(p, opt) = 0;
 		else
-			(*(int *)opt->value)++;
+			(*(int *)reloc_value(p, opt))++;
 		return 0;
 
 	case OPTION_STRING:
 		if (flags & OPT_UNSET) {
-			*(const char **)opt->value = (const char *)NULL;
+			*(const char **)reloc_value(p, opt) = (const char *)NULL;
 			return 0;
 		}
 		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg == '-')) {
-			*(const char **)opt->value = (const char *)opt->defval;
+			*(const char **)reloc_value(p, opt) = (const char *)opt->defval;
 			return 0;
 		}
 		if (!arg)
 			return opterror(opt, "requires a value", flags);
-		*(const char **)opt->value = get_arg(p);
+		*(const char **)reloc_value(p, opt) = get_arg(p);
 		return 0;
 
 	case OPTION_CALLBACK:
+		opt = reloc_option(p, opt, &tmp);
 		if (flags & OPT_UNSET)
 			return (*opt->callback)(opt, NULL, 1);
 		if (opt->flags & PARSE_OPT_NOARG) {
@@ -88,16 +119,16 @@ static int get_value(struct optparse_t *p,
 
 	case OPTION_INTEGER:
 		if (flags & OPT_UNSET) {
-			*(int *)opt->value = 0;
+			*(int *)reloc_value(p, opt) = 0;
 			return 0;
 		}
 		if (opt->flags & PARSE_OPT_OPTARG && (!arg || !isdigit(*arg))) {
-			*(int *)opt->value = opt->defval;
+			*(int *)reloc_value(p, opt) = opt->defval;
 			return 0;
 		}
 		if (!arg)
 			return opterror(opt, "requires a value", flags);
-		*(int *)opt->value = strtol(get_arg(p), (char **)&s, 10);
+		*(int *)reloc_value(p, opt) = strtol(get_arg(p), (char **)&s, 10);
 		if (*s)
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
@@ -107,9 +138,24 @@ static int get_value(struct optparse_t *p,
 	}
 }
 
+static const struct option *prepare_recursion(struct optparse_t *p,
+                                              const struct option *opt)
+{
+	const struct option *subarray = (const struct option *)opt->defval;
+	if (subarray->type != OPTION_BASEOFFSET)
+		die("subarray does not begins with a relocation stanza");
+	p->reloc.base = subarray->value;
+	p->reloc.end  = p->reloc.base + subarray->defval;
+	p->reloc.offs = (const char *)opt->value - p->reloc.base;
+	return ++subarray;
+}
+
 static int parse_short_opt(struct optparse_t *p, const struct option *options,
                            int level)
 {
+	struct optreloc_t reloc;
+	int res;
+
 	for (;; options++) {
 		switch (options->type) {
 		case OPTION_END:
@@ -118,7 +164,11 @@ static int parse_short_opt(struct optparse_t *p, const struct option *options,
 		case OPTION_BASEOFFSET:
 			continue;
 		case OPTION_SUBARRAY:
-			die("unsupported yet");
+			reloc = p->reloc;
+			res = parse_short_opt(p, prepare_recursion(p, options), level + 1);
+			p->reloc = reloc;
+			if (!res)
+				return 0;
 			break;
 		default:
 			if (options->short_name != *p->opt)
@@ -141,15 +191,21 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 		arg_end = arg + strlen(arg);
 
 	for (; options->type != OPTION_END; options++) {
+		struct optreloc_t reloc;
 		const char *rest;
-		int flags = 0;
+		int res, flags = 0;
 
 		switch (options->type) {
 		case OPTION_GROUP:
 		case OPTION_BASEOFFSET:
 			continue;
 		case OPTION_SUBARRAY:
-			die("unsupported yet");
+			reloc = p->reloc;
+			res = parse_long_opt(p, arg, prepare_recursion(p, options),
+			                     level + 1);
+			p->reloc = reloc;
+			if (!res)
+				return 0;
 			break;
 		default:
 			break;
diff --git a/parse-options.h b/parse-options.h
index 6668924..4f5a241 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -84,6 +84,11 @@ struct option {
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
 
+#define OPT_BASEOFFS(v)                 \
+	{ OPTION_BASEOFFSET, 0, NULL, (v), NULL, NULL, 0, NULL, sizeof(*(v)) }
+#define OPT_SUBARRAY(v, sub)            \
+	{ OPTION_SUBARRAY, 0, NULL, (v), NULL, NULL, 0, NULL, (intptr_t)sub }
+
 /* parse_options() will filter out the processed options and leave the
  * non-option argments in argv[].
  * Returns the number of arguments left in argv[].
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ee758e5..c7a754e 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -20,6 +20,10 @@ string options
     --string2 <str>       get another string
     --st <st>             get another string (pervert ordering)
 
+test subarray
+    --incr-reloc          increment a relocated integer
+    --incr-fixed          increment a fixed integer
+
 EOF
 
 test_expect_success 'test help' '
@@ -32,6 +36,8 @@ cat > expect << EOF
 boolean: 2
 integer: 1729
 string: 123
+diverted i: 0
+fixed i: 0
 EOF
 
 test_expect_success 'short options' '
@@ -43,6 +49,8 @@ cat > expect << EOF
 boolean: 2
 integer: 1729
 string: 321
+diverted i: 0
+fixed i: 0
 EOF
 
 test_expect_success 'long options' '
@@ -56,6 +64,8 @@ cat > expect << EOF
 boolean: 1
 integer: 13
 string: 123
+diverted i: 0
+fixed i: 0
 arg 00: a1
 arg 01: b1
 arg 02: --boolean
@@ -72,6 +82,8 @@ cat > expect << EOF
 boolean: 0
 integer: 2
 string: (not set)
+diverted i: 0
+fixed i: 0
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
@@ -93,11 +105,28 @@ test_expect_failure 'ambiguously abbreviated option' '
 
 cat > expect << EOF
 boolean: 0
+integer: 0
+string: (not set)
+diverted i: 1
+fixed i: 2
+EOF
+
+test_expect_success 'subarrays and partial relocation of options' '
+	test-parse-options --incr-reloc --incr-fixed --incr-fixed > output 2> output.err &&
+	test ! -s output.err &&
+	git diff expect output
+'
+
+test_done
+cat > expect << EOF
+boolean: 0
 integer: 2
 string: 123
+diverted i: 0
+fixed i: 0
 EOF
 
-test_expect_failure 'non ambiguous option (after two options it abbreviates)' '
+test_expect_failure 'non ambiguous option (after two options it abbreviates, across subarray)' '
 	test-parse-options --st 123 &&
 	test ! -s output.err &&
 	git diff expect output
diff --git a/test-parse-options.c b/test-parse-options.c
index 4d3e2ec..5f740da 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -1,16 +1,34 @@
 #include "cache.h"
 #include "parse-options.h"
 
+struct reloc_me_please {
+	int integer;
+};
+
 static int boolean = 0;
 static int integer = 0;
 static char *string = NULL;
 
+static int reloc_integer = 0;
+static int fixed_integer = 0;
+
+static const struct option subopts[] = {
+	OPT_BASEOFFS(&reloc_integer),
+	OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
+	OPT_GROUP("test subarray"),
+	OPT_BOOLEAN(0, "incr-reloc", &reloc_integer, "increment a relocated integer"),
+	OPT_BOOLEAN(0, "incr-fixed", &fixed_integer, "increment a fixed integer"),
+	OPT_END(),
+};
+
 int main(int argc, const char **argv)
 {
 	const char *usage[] = {
 		"test-parse-options <options>",
 		NULL
 	};
+	int diverted_integer = 0;
+
 	struct option options[] = {
 		OPT_BOOLEAN('b', "boolean", &boolean, "get a boolean"),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
@@ -18,7 +36,7 @@ int main(int argc, const char **argv)
 		OPT_GROUP("string options"),
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
-		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
+		OPT_SUBARRAY(&diverted_integer, subopts),
 		OPT_END(),
 	};
 	int i;
@@ -28,9 +46,14 @@ int main(int argc, const char **argv)
 	printf("boolean: %d\n", boolean);
 	printf("integer: %d\n", integer);
 	printf("string: %s\n", string ? string : "(not set)");
+	printf("diverted i: %d\n", diverted_integer);
+	printf("fixed i: %d\n", fixed_integer);
 
 	for (i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
 
+	if (reloc_integer)
+		die("reloc_integer should not ever change");
+
 	return 0;
 }
-- 
1.5.3.5.1531.g59008

