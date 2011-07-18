From: Jeff King <peff@peff.net>
Subject: [PATCH 01/14] parse-options: add OPT_STRING_LIST helper
Date: Mon, 18 Jul 2011 03:48:19 -0400
Message-ID: <20110718074819.GA12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiiZ1-0003XP-Gy
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab1GRHsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:48:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50613
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab1GRHsV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:48:21 -0400
Received: (qmail 19689 invoked by uid 107); 18 Jul 2011 07:48:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:48:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:48:19 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177344>

This just adds repeated invocations of an option to a list
of strings. Using the "--no-<var>" form will reset the list
to empty.

Signed-off-by: Jeff King <peff@peff.net>
---
As I mentioned elsewhere, this is a cherry-pick of c8ba163 and can be
dropped.

 parse-options.c          |   17 +++++++++++++++++
 parse-options.h          |    4 ++++
 t/t0040-parse-options.sh |   17 +++++++++++++++++
 test-parse-options.c     |    6 ++++++
 4 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 73bd28a..879ea82 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
+#include "string-list.h"
 
 static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 			       const char * const *usagestr,
@@ -687,3 +688,19 @@ int parse_options_concat(struct option *dst, size_t dst_size, struct option *src
 	}
 	return -1;
 }
+
+int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list *v = opt->value;
+
+	if (unset) {
+		string_list_clear(v, 0);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	string_list_append(v, xstrdup(arg));
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index d1b12fe..05eb09b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -130,6 +130,9 @@ struct option {
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "n", (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
+#define OPT_STRING_LIST(s, l, v, a, h) \
+				    { OPTION_CALLBACK, (s), (l), (v), (a), \
+				      (h), 0, &parse_opt_string_list }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_DATE(s, l, v, h) \
@@ -204,6 +207,7 @@ extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
+extern int parse_opt_string_list(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_BOOLEAN('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_BOOLEAN('q', "quiet",   (var), (h))
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ae26614..007f39d 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -28,6 +28,7 @@ String options
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
     --default-string      set string to default
+    --list <str>          add str to list
 
 Magic arguments
     --quux                means --quux
@@ -337,4 +338,20 @@ test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
 	test_cmp expect output
 '
 
+cat >>expect <<'EOF'
+list: foo
+list: bar
+list: baz
+EOF
+test_expect_success '--list keeps list of strings' '
+	test-parse-options --list foo --list=bar --list=baz >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--no-list resets list' '
+	test-parse-options --list=other --list=irrelevant --list=options \
+		--no-list --list=foo --list=bar --list=baz >output &&
+	test_cmp expect output
+'
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index 4e3710b..91a5701 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "parse-options.h"
+#include "string-list.h"
 
 static int boolean = 0;
 static int integer = 0;
@@ -9,6 +10,7 @@ static int verbose = 0, dry_run = 0, quiet = 0;
 static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
+static struct string_list list;
 
 static int length_callback(const struct option *opt, const char *arg, int unset)
 {
@@ -54,6 +56,7 @@ int main(int argc, const char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_SET_PTR(0, "default-string", &string,
 			"set string to default", (unsigned long)"default"),
+		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
@@ -85,6 +88,9 @@ int main(int argc, const char **argv)
 	printf("dry run: %s\n", dry_run ? "yes" : "no");
 	printf("file: %s\n", file ? file : "(not set)");
 
+	for (i = 0; i < list.nr; i++)
+		printf("list: %s\n", list.items[i].string);
+
 	for (i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
 
-- 
1.7.6.rc1.12.g65e2
