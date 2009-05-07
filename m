From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/5] parseopt: add PARSE_OPT_NODASH
Date: Thu, 07 May 2009 21:45:42 +0200
Message-ID: <1241725542.4772.9.camel@ubuntu.ubuntu-domain>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 21:46:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29Xp-000350-6f
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbZEGTpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbZEGTpo
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:45:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:37371 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbZEGTpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:45:43 -0400
Received: from [10.0.1.101] (p57B7C554.dip.t-dialin.net [87.183.197.84])
	by india601.server4you.de (Postfix) with ESMTPSA id 20AAD2F8003;
	Thu,  7 May 2009 21:45:43 +0200 (CEST)
In-Reply-To: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118514>

Add support for options that don't start with a dash.  Initially, they
don't accept arguments and can only be short options, i.e. consist of a
single character.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 parse-options.c          |   29 +++++++++++++++++++++++++++--
 parse-options.h          |    8 ++++++--
 t/t0040-parse-options.sh |    7 +++++++
 test-parse-options.c     |    2 ++
 4 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index aaa218d..c52b8cc 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -245,6 +245,25 @@ is_abbreviated:
 	return -2;
 }
 
+static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
+			    const struct option *options)
+{
+	for (; options->type != OPTION_END; options++) {
+		if (!(options->flags & PARSE_OPT_NODASH))
+			continue;
+		if ((options->flags & PARSE_OPT_OPTARG) ||
+		    !(options->flags & PARSE_OPT_NOARG))
+			die("BUG: dashless options don't support arguments");
+		if (!(options->flags & PARSE_OPT_NONEG))
+			die("BUG: dashless options don't support negation");
+		if (options->long_name)
+			die("BUG: dashless options can't be long");
+		if (options->short_name == arg[0] && arg[1] == '\0')
+			return get_value(p, options, OPT_SHORT);
+	}
+	return -2;
+}
+
 static void check_typos(const char *arg, const struct option *options)
 {
 	if (strlen(arg) < 3)
@@ -295,6 +314,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		const char *arg = ctx->argv[0];
 
 		if (*arg != '-' || !arg[1]) {
+			if (parse_nodash_opt(ctx, arg, options) == 0)
+				continue;
 			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
 				break;
 			ctx->out[ctx->cpidx++] = ctx->argv[0];
@@ -427,8 +448,12 @@ int usage_with_options_internal(const char * const *usagestr,
 			continue;
 
 		pos = fprintf(stderr, "    ");
-		if (opts->short_name)
-			pos += fprintf(stderr, "-%c", opts->short_name);
+		if (opts->short_name) {
+			if (opts->flags & PARSE_OPT_NODASH)
+				pos += fprintf(stderr, "%c", opts->short_name);
+			else
+				pos += fprintf(stderr, "-%c", opts->short_name);
+		}
 		if (opts->long_name && opts->short_name)
 			pos += fprintf(stderr, ", ");
 		if (opts->long_name)
diff --git a/parse-options.h b/parse-options.h
index 77919a7..919b9b4 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -33,6 +33,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NONEG   = 4,
 	PARSE_OPT_HIDDEN  = 8,
 	PARSE_OPT_LASTARG_DEFAULT = 16,
+	PARSE_OPT_NODASH = 32,
 };
 
 struct option;
@@ -66,8 +67,11 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
  *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBACKs
  *   PARSE_OPT_NONEG: says that this option cannot be negated
- *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed in
- *                    the long one.
+ *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
+ *                     shown only in the full usage.
+ *   PARSE_OPT_LASTARG_DEFAULT: if no argument is given, the default value
+ *                              is used.
+ *   PARSE_OPT_NODASH: this option doesn't start with a dash.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK.
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 8ca62ef..a40c123 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -31,6 +31,7 @@ String options
 Magic arguments
     --quux                means --quux
     -NUM                  set integer to NUM
+    +                     same as -b
 
 Standard options
     --abbrev[=<n>]        use <n> digits to display SHA-1s
@@ -276,6 +277,12 @@ test_expect_success 'OPT_NEGBIT() works' '
 	test_cmp expect output
 '
 
+test_expect_success 'OPT_BOOLEAN() with PARSE_OPT_NODASH works' '
+	test-parse-options + + + + + + > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
 cat > expect <<EOF
 boolean: 0
 integer: 12345
diff --git a/test-parse-options.c b/test-parse-options.c
index d46eac2..e0669dc 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -54,6 +54,8 @@ int main(int argc, const char **argv)
 		OPT_ARGUMENT("quux", "means --quux"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
 			number_callback),
+		{ OPTION_BOOLEAN, '+', NULL, &boolean, NULL, "same as -b",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH },
 		OPT_GROUP("Standard options"),
 		OPT__ABBREV(&abbrev),
 		OPT__VERBOSE(&verbose),
-- 
1.6.3
