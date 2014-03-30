From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v4 3/3] parse-options: remove unused OPT_SET_PTR
Date: Sun, 30 Mar 2014 15:08:23 +0400
Message-ID: <a65dd5e1b030fcbc923752bfcee1c87acd6fb188.1396177208.git.marat@slonopotamus.org>
References: <cover.1396177207.git.marat@slonopotamus.org>
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 13:08:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUDbn-0001wx-6N
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 13:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbaC3LIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 07:08:50 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:47218 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbaC3LIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 07:08:48 -0400
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WUDbW-0000Hw-L3; Sun, 30 Mar 2014 15:08:42 +0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396177207.git.marat@slonopotamus.org>
In-Reply-To: <cover.1396177207.git.marat@slonopotamus.org>
References: <7vtxago359.fsf@alter.siamese.dyndns.org> <cover.1396177207.git.marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245460>

OPT_SET_PTR was never used since its creation in 2007 (commit
db7244bd5be12e389badb9cec621dbbcfa11f59a).
---
 Documentation/technical/api-parse-options.txt | 4 ----
 parse-options.c                               | 5 -----
 parse-options.h                               | 5 +----
 t/t0040-parse-options.sh                      | 7 +++----
 test-parse-options.c                          | 2 --
 5 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index be50cf4..1f2db31 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -160,10 +160,6 @@ There are some macros to easily define options:
 	`int_var` is set to `integer` with `--option`, and
 	reset to zero with `--no-option`.
 
-`OPT_SET_PTR(short, long, &ptr_var, description, ptr)`::
-	Introduce a boolean option.
-	If used, set `ptr_var` to `ptr`.
-
 `OPT_STRING(short, long, &str_var, arg_str, description)`::
 	Introduce an option with string argument.
 	The string argument is put into `str_var`.
diff --git a/parse-options.c b/parse-options.c
index c81d3a0..b536896 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -127,10 +127,6 @@ static int get_value(struct parse_opt_ctx_t *p,
 		*(int *)opt->value = opt->defval;
 		return 0;
 
-	case OPTION_SET_PTR:
-		*(void **)opt->value = unset ? NULL : (void *)opt->defval;
-		return 0;
-
 	case OPTION_STRING:
 		if (unset)
 			*(const char **)opt->value = NULL;
@@ -367,7 +363,6 @@ static void parse_options_check(const struct option *opts)
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
 		case OPTION_SET_INT:
-		case OPTION_SET_PTR:
 		case OPTION_NUMBER:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
diff --git a/parse-options.h b/parse-options.h
index 54099d9..3189676 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -12,7 +12,6 @@ enum parse_opt_type {
 	OPTION_NEGBIT,
 	OPTION_COUNTUP,
 	OPTION_SET_INT,
-	OPTION_SET_PTR,
 	OPTION_CMDMODE,
 	/* options with arguments (usually) */
 	OPTION_STRING,
@@ -96,7 +95,7 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
- *   OPTION_{BIT,SET_INT,SET_PTR} store the {mask,integer,pointer} to put in
+ *   OPTION_{BIT,SET_INT} store the {mask,integer,pointer} to put in
  *   the value when met.
  *   CALLBACKS can use it like they want.
  */
@@ -128,8 +127,6 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (intptr_t)(p) }
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 65606df..4476548 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -30,7 +30,6 @@ String options
     --string2 <str>       get another string
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
-    --default-string      set string to default
     --list <str>          add str to list
 
 Magic arguments
@@ -293,7 +292,7 @@ cat > expect <<EOF
 boolean: 0
 integer: 0
 timestamp: 1
-string: default
+string: (not set)
 abbrev: 7
 verbose: 0
 quiet: yes
@@ -302,8 +301,8 @@ file: (not set)
 arg 00: foo
 EOF
 
-test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
-	test-parse-options -t "1970-01-01 00:00:01 +0000" --default-string \
+test_expect_success 'OPT_DATE() work' '
+	test-parse-options -t "1970-01-01 00:00:01 +0000" \
 		foo -q > output 2> output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
diff --git a/test-parse-options.c b/test-parse-options.c
index 10da63e..5dabce6 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -59,8 +59,6 @@ int main(int argc, char **argv)
 		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
-		OPT_SET_PTR(0, "default-string", &string,
-			"set string to default", "default"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
-- 
1.9.0
