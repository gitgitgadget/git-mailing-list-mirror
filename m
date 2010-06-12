From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next] parseopt: wrap rev-parse --parseopt usage for eval consumption
Date: Sat, 12 Jun 2010 14:57:39 +0200
Message-ID: <49d2c5f5626b22c02d7528e76f9fbb36b7b96155.1276347347.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Giuseppe Scrivano <gscrivano@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 14:58:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONQHw-000494-Nb
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 14:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833Ab0FLM6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 08:58:05 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:5535 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab0FLM6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 08:58:04 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 14:58:00 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 14:57:39 +0200
X-Mailer: git-send-email 1.7.1.556.gfe6ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149006>

9c7304e (print the usage string on stdout instead of stderr,
2010-05-17) broke rev-parse --parseopt: when run with -h, the usage
notice on stdout ended up in the shell eval.

Wrap the usage in a cat <<\EOF ... EOF block when printing to stdout.
I do not expect any usage lines to ever start with EOF so this
shouldn't be an undue burden.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Unfortunately the impact is about half that of 9c7304e.  Maybe there's
a simpler solution that I'm missing.


 builtin/rev-parse.c           |    3 ++-
 parse-options.c               |   38 ++++++++++++++++++++++++--------------
 parse-options.h               |    3 ++-
 t/t1502-rev-parse-parseopt.sh |    4 +++-
 4 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8fbf9d0..b676e29 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -408,7 +408,8 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	memset(opts + onb, 0, sizeof(opts[onb]));
 	argc = parse_options(argc, argv, prefix, opts, usage,
 			keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0 |
-			stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0);
+			stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0 |
+			PARSE_OPT_SHELL_EVAL);
 
 	strbuf_addf(&parsed, " --");
 	sq_quote_argv(&parsed, argv, 0);
diff --git a/parse-options.c b/parse-options.c
index c8aaf95..0fa79bc 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -4,7 +4,8 @@
 #include "commit.h"
 #include "color.h"
 
-static int parse_options_usage(const char * const *usagestr,
+static int parse_options_usage(struct parse_opt_ctx_t *ctx,
+			       const char * const *usagestr,
 			       const struct option *opts, int err);
 
 #define OPT_SHORT 1
@@ -351,7 +352,8 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 }
 
-static int usage_with_options_internal(const char * const *,
+static int usage_with_options_internal(struct parse_opt_ctx_t *,
+				       const char * const *,
 				       const struct option *, int, int);
 
 int parse_options_step(struct parse_opt_ctx_t *ctx,
@@ -380,10 +382,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
 			if (internal_help && *ctx->opt == 'h')
-				return parse_options_usage(usagestr, options, 0);
+				return parse_options_usage(ctx, usagestr, options, 0);
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
-				return parse_options_usage(usagestr, options, 1);
+				return parse_options_usage(ctx, usagestr, options, 1);
 			case -2:
 				goto unknown;
 			}
@@ -391,10 +393,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
 				if (internal_help && *ctx->opt == 'h')
-					return parse_options_usage(usagestr, options, 0);
+					return parse_options_usage(ctx, usagestr, options, 0);
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
-					return parse_options_usage(usagestr, options, 1);
+					return parse_options_usage(ctx, usagestr, options, 1);
 				case -2:
 					/* fake a short option thing to hide the fact that we may have
 					 * started to parse aggregated stuff
@@ -418,12 +420,12 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 
 		if (internal_help && !strcmp(arg + 2, "help-all"))
-			return usage_with_options_internal(usagestr, options, 1, 0);
+			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
 		if (internal_help && !strcmp(arg + 2, "help"))
-			return parse_options_usage(usagestr, options, 0);
+			return parse_options_usage(ctx, usagestr, options, 0);
 		switch (parse_long_opt(ctx, arg + 2, options)) {
 		case -1:
-			return parse_options_usage(usagestr, options, 1);
+			return parse_options_usage(ctx, usagestr, options, 1);
 		case -2:
 			goto unknown;
 		}
@@ -485,14 +487,18 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
-static int usage_with_options_internal(const char * const *usagestr,
-				const struct option *opts, int full, int err)
+static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
+				       const char * const *usagestr,
+				       const struct option *opts, int full, int err)
 {
 	FILE *outfile = err ? stderr : stdout;
 
 	if (!usagestr)
 		return PARSE_OPT_HELP;
 
+	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
+		fprintf(outfile, "cat <<\\EOF\n");
+
 	fprintf(outfile, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
 		fprintf(outfile, "   or: %s\n", *usagestr++);
@@ -548,13 +554,16 @@ static int usage_with_options_internal(const char * const *usagestr,
 	}
 	fputc('\n', outfile);
 
+	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
+		fputs("EOF\n", outfile);
+
 	return PARSE_OPT_HELP;
 }
 
 void usage_with_options(const char * const *usagestr,
 			const struct option *opts)
 {
-	usage_with_options_internal(usagestr, opts, 0, 1);
+	usage_with_options_internal(NULL, usagestr, opts, 0, 1);
 	exit(129);
 }
 
@@ -566,10 +575,11 @@ void usage_msg_opt(const char *msg,
 	usage_with_options(usagestr, options);
 }
 
-static int parse_options_usage(const char * const *usagestr,
+static int parse_options_usage(struct parse_opt_ctx_t *ctx,
+			       const char * const *usagestr,
 			       const struct option *opts, int err)
 {
-	return usage_with_options_internal(usagestr, opts, 0, err);
+	return usage_with_options_internal(ctx, usagestr, opts, 0, err);
 }
 
 
diff --git a/parse-options.h b/parse-options.h
index 678b58d..7435cdb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -36,7 +36,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_NEGHELP = 128
+	PARSE_OPT_NEGHELP = 128,
+	PARSE_OPT_SHELL_EVAL = 256
 };
 
 struct option;
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 660487d..4346795 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -3,7 +3,8 @@
 test_description='test git rev-parse --parseopt'
 . ./test-lib.sh
 
-cat > expect <<EOF
+cat > expect <<\END_EXPECT
+cat <<\EOF
 usage: some-command [options] <args>...
 
     some-command does foo and bar!
@@ -19,6 +20,7 @@ Extras
     --extra1              line above used to cause a segfault but no longer does
 
 EOF
+END_EXPECT
 
 cat > optionspec << EOF
 some-command [options] <args>...
-- 
1.7.1.556.gfe6ec
