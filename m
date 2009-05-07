From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/5] parseopt: add OPT_NUMBER_CALLBACK
Date: Thu, 07 May 2009 21:45:08 +0200
Message-ID: <1241725508.4772.8.camel@ubuntu.ubuntu-domain>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 21:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29Wv-0002bE-9o
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbZEGTpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbZEGTpL
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:45:11 -0400
Received: from india601.server4you.de ([85.25.151.105]:37367 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbZEGTpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:45:09 -0400
Received: from [10.0.1.101] (p57B7C554.dip.t-dialin.net [87.183.197.84])
	by india601.server4you.de (Postfix) with ESMTPSA id 3E1722F8003;
	Thu,  7 May 2009 21:45:09 +0200 (CEST)
In-Reply-To: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118513>

Add a way to recognize numerical options.  The number is passed to
a callback function as a string.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |    8 +++++++
 parse-options.c                               |   26 ++++++++++++++++++++++++-
 parse-options.h                               |    4 +++
 t/t0040-parse-options.sh                      |   18 +++++++++++++++++
 test-parse-options.c                          |    8 +++++++
 5 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 794194b..beca98d 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -170,6 +170,14 @@ There are some macros to easily define options:
 `OPT_ARGUMENT(long, description)`::
 	Introduce a long-option argument that will be kept in `argv[]`.
 
+`OPT_NUMBER_CALLBACK(&var, description, func_ptr)`::
+	Recognize numerical options like -123 and feed the integer as
+	if it was an argument to the function given by `func_ptr`.
+	The result will be put into `var`.  There can be only one such
+	option definition.  It cannot be negated and it takes no
+	arguments.  Short options that happen to be digits take
+	precedence over it.
+
 
 The last element of the array must be `OPT_END()`.
 
diff --git a/parse-options.c b/parse-options.c
index a8c05e3..aaa218d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -129,11 +129,33 @@ static int get_value(struct parse_opt_ctx_t *p,
 
 static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *options)
 {
+	const struct option *numopt = NULL;
+
 	for (; options->type != OPTION_END; options++) {
 		if (options->short_name == *p->opt) {
 			p->opt = p->opt[1] ? p->opt + 1 : NULL;
 			return get_value(p, options, OPT_SHORT);
 		}
+
+		/*
+		 * Handle the numerical option later, explicit one-digit
+		 * options take precedence over it.
+		 */
+		if (options->type == OPTION_NUMBER)
+			numopt = options;
+	}
+	if (numopt && isdigit(*p->opt)) {
+		size_t len = 1;
+		char *arg;
+		int rc;
+
+		while (isdigit(p->opt[len]))
+			len++;
+		arg = xmemdupz(p->opt, len);
+		p->opt = p->opt[len] ? p->opt + len : NULL;
+		rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
+		free(arg);
+		return rc;
 	}
 	return -2;
 }
@@ -411,6 +433,8 @@ int usage_with_options_internal(const char * const *usagestr,
 			pos += fprintf(stderr, ", ");
 		if (opts->long_name)
 			pos += fprintf(stderr, "--%s", opts->long_name);
+		if (opts->type == OPTION_NUMBER)
+			pos += fprintf(stderr, "-NUM");
 
 		switch (opts->type) {
 		case OPTION_ARGUMENT:
@@ -447,7 +471,7 @@ int usage_with_options_internal(const char * const *usagestr,
 					pos += fprintf(stderr, " ...");
 			}
 			break;
-		default: /* OPTION_{BIT,BOOLEAN,SET_INT,SET_PTR} */
+		default: /* OPTION_{BIT,BOOLEAN,NUMBER,SET_INT,SET_PTR} */
 			break;
 		}
 
diff --git a/parse-options.h b/parse-options.h
index f1e2452..77919a7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -6,6 +6,7 @@ enum parse_opt_type {
 	OPTION_END,
 	OPTION_ARGUMENT,
 	OPTION_GROUP,
+	OPTION_NUMBER,
 	/* options with no arguments */
 	OPTION_BIT,
 	OPTION_NEGBIT,
@@ -105,6 +106,9 @@ struct option {
 	  parse_opt_approxidate_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
+#define OPT_NUMBER_CALLBACK(v, h, f) \
+	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
 
 /* parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[].
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 9054ed6..8ca62ef 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -30,6 +30,7 @@ String options
 
 Magic arguments
     --quux                means --quux
+    -NUM                  set integer to NUM
 
 Standard options
     --abbrev[=<n>]        use <n> digits to display SHA-1s
@@ -275,4 +276,21 @@ test_expect_success 'OPT_NEGBIT() works' '
 	test_cmp expect output
 '
 
+cat > expect <<EOF
+boolean: 0
+integer: 12345
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
+EOF
+
+test_expect_success 'OPT_NUMBER_CALLBACK() works' '
+	test-parse-options -12345 > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index eddc026..d46eac2 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -19,6 +19,12 @@ int length_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int number_callback(const struct option *opt, const char *arg, int unset)
+{
+	*(int *)opt->value = strtol(arg, NULL, 10);
+	return 0;
+}
+
 int main(int argc, const char **argv)
 {
 	const char *usage[] = {
@@ -46,6 +52,8 @@ int main(int argc, const char **argv)
 			"set string to default", (unsigned long)"default"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
+		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
+			number_callback),
 		OPT_GROUP("Standard options"),
 		OPT__ABBREV(&abbrev),
 		OPT__VERBOSE(&verbose),
-- 
1.6.3
