From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/5] parseopt: add OPT_NEGBIT
Date: Thu, 07 May 2009 21:44:17 +0200
Message-ID: <1241725457.4772.7.camel@ubuntu.ubuntu-domain>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 21:44:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29W6-0002DM-59
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZEGToT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbZEGToT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:44:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:37363 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbZEGToS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:44:18 -0400
Received: from [10.0.1.101] (p57B7C554.dip.t-dialin.net [87.183.197.84])
	by india601.server4you.de (Postfix) with ESMTPSA id D77662F8003;
	Thu,  7 May 2009 21:44:17 +0200 (CEST)
In-Reply-To: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118512>

Add OPTION_NEGBIT and OPT_NEGBIT, mirroring OPTION_BIT and OPT_BIT.
OPT_NEGBIT can be used together with OPT_BIT to define two options
that cancel each other out.

Note: this patch removes the reminder from the test script because
it adds a test for --no-or4 and there already was one for --or4.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |    4 +++
 parse-options.c                               |    8 ++++++
 parse-options.h                               |    2 +
 t/t0040-parse-options.sh                      |   31 +++++++++++++++++++++++-
 test-parse-options.c                          |    1 +
 5 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index e66ca9f..794194b 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -137,6 +137,10 @@ There are some macros to easily define options:
 	Introduce a boolean option.
 	If used, `int_var` is bitwise-ored with `mask`.
 
+`OPT_NEGBIT(short, long, &int_var, description, mask)`::
+	Introduce a boolean option.
+	If used, `int_var` is bitwise-anded with the inverted `mask`.
+
 `OPT_SET_INT(short, long, &int_var, description, integer)`::
 	Introduce a boolean option.
 	If used, set `int_var` to `integer`.
diff --git a/parse-options.c b/parse-options.c
index cf71bcf..a8c05e3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -50,6 +50,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			/* FALLTHROUGH */
 		case OPTION_BOOLEAN:
 		case OPTION_BIT:
+		case OPTION_NEGBIT:
 		case OPTION_SET_INT:
 		case OPTION_SET_PTR:
 			return opterror(opt, "takes no value", flags);
@@ -66,6 +67,13 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value |= opt->defval;
 		return 0;
 
+	case OPTION_NEGBIT:
+		if (unset)
+			*(int *)opt->value |= opt->defval;
+		else
+			*(int *)opt->value &= ~opt->defval;
+		return 0;
+
 	case OPTION_BOOLEAN:
 		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
 		return 0;
diff --git a/parse-options.h b/parse-options.h
index b54eec1..f1e2452 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -8,6 +8,7 @@ enum parse_opt_type {
 	OPTION_GROUP,
 	/* options with no arguments */
 	OPTION_BIT,
+	OPTION_NEGBIT,
 	OPTION_BOOLEAN, /* _INCR would have been a better name */
 	OPTION_SET_INT,
 	OPTION_SET_PTR,
@@ -93,6 +94,7 @@ struct option {
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, (h) }
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), 0, NULL, (b) }
+#define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, (h), 0, NULL, (b) }
 #define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v), NULL, (h) }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, (h), 0, NULL, (i) }
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, (h), 0, NULL, (p) }
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index e38241c..9054ed6 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -12,6 +12,7 @@ usage: test-parse-options <options>
 
     -b, --boolean         get a boolean
     -4, --or4             bitwise-or boolean with ...0100
+    --neg-or4             same as --no-or4
 
     -i, --integer <n>     get a integer
     -j <n>                get a integer, too
@@ -245,7 +246,33 @@ test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
 	test_cmp expect output
 '
 
-# --or4
-# --no-or4
+test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
+	test-parse-options --set23 -bbbbb --neg-or4 > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+boolean: 6
+integer: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
+EOF
+
+test_expect_success 'OPT_BIT() works' '
+	test-parse-options -bb --or4 > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
+test_expect_success 'OPT_NEGBIT() works' '
+	test-parse-options -bb --no-neg-or4 > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
 
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index 61d2c39..eddc026 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -29,6 +29,7 @@ int main(int argc, const char **argv)
 		OPT_BOOLEAN('b', "boolean", &boolean, "get a boolean"),
 		OPT_BIT('4', "or4", &boolean,
 			"bitwise-or boolean with ...0100", 4),
+		OPT_NEGBIT(0, "neg-or4", &boolean, "same as --no-or4", 4),
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
-- 
1.6.3
