From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] parse-options: fix parsing of "--foobar=" with no value
Date: Tue, 22 Jul 2008 20:44:27 +0200
Message-ID: <1216752267-12138-1-git-send-email-dkr+ml.git@free.fr>
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 20:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLMrb-00075g-JU
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 20:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbYGVSob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbYGVSoa
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 14:44:30 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:36646 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbYGVSoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 14:44:30 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 4F2A112B6F8;
	Tue, 22 Jul 2008 20:44:28 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id ED95A12B73D;
	Tue, 22 Jul 2008 20:44:27 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.16.gb169.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89510>

From: Olivier Marin <dkr@freesurf.fr>

Before this patch, running a git command with a "--foobar=" argument
will set the "foobar" option with a random value and continue.
We should instead, exit with an error if a value is required, or use
the default one if the value is optional.

This patch fix the above issue and add some test cases.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 parse-options.c          |    8 ++++----
 t/t0040-parse-options.sh |   25 +++++++++++++++++++++++++
 test-parse-options.c     |    3 +++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 71a7acf..67be197 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -17,7 +17,7 @@ static int opterror(const struct option *opt, const char *reason, int flags)
 static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
 		   int flags, const char **arg)
 {
-	if (p->opt) {
+	if (p->opt && *p->opt) {
 		*arg = p->opt;
 		p->opt = NULL;
 	} else if (p->argc == 1 && (opt->flags & PARSE_OPT_LASTARG_DEFAULT)) {
@@ -80,7 +80,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 	case OPTION_STRING:
 		if (unset)
 			*(const char **)opt->value = NULL;
-		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+		else if (opt->flags & PARSE_OPT_OPTARG && (!p->opt || !*p->opt))
 			*(const char **)opt->value = (const char *)opt->defval;
 		else
 			return get_arg(p, opt, flags, (const char **)opt->value);
@@ -91,7 +91,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
 		if (opt->flags & PARSE_OPT_NOARG)
 			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+		if (opt->flags & PARSE_OPT_OPTARG && (!p->opt || !*p->opt))
 			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
@@ -102,7 +102,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value = 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+		if (opt->flags & PARSE_OPT_OPTARG && (!p->opt || !*p->opt)) {
 			*(int *)opt->value = opt->defval;
 			return 0;
 		}
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 03dbe00..7ce2e86 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -26,6 +26,8 @@ String options
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
     --default-string      set string to default
+    --optional-string[=<string>]
+                          set string to optional if none given
 
 Magic arguments
     --quux                means --quux
@@ -85,6 +87,29 @@ test_expect_success 'missing required value' '
 	test $? = 129
 '
 
+test_expect_success 'missing required value with "--foobar="' '
+	test-parse-options --length=;
+	test $? = 129 &&
+	test-parse-options --len=;
+	test $? = 129
+'
+
+cat > expect << EOF
+boolean: 0
+integer: 0
+string: optional
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
+EOF
+
+test_expect_success 'optional value with "--foobar="' '
+	test-parse-options --optional-string= > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
 cat > expect << EOF
 boolean: 1
 integer: 13
diff --git a/test-parse-options.c b/test-parse-options.c
index 2a79e72..76db37e 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -42,6 +42,9 @@ int main(int argc, const char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_SET_PTR(0, "default-string", &string,
 			"set string to default", (unsigned long)"default"),
+		{ OPTION_STRING, 0, "optional-string", &string,
+			"string", "set string to optional if none given",
+			PARSE_OPT_OPTARG, NULL, (unsigned long)"optional" },
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
 		OPT_GROUP("Standard options"),
-- 
1.6.0.rc0.16.gb169.dirty
