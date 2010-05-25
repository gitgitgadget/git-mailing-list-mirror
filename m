From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: [PATCH v2] Print the usage string on stdout instead of stderr.
Date: Tue, 25 May 2010 10:40:46 +0200
Message-ID: <874ohwwf01.fsf_-_@thor.thematica.it>
References: <878w7ieu4p.fsf@thor.thematica.it>
	<4BF12C96.9030802@drmicha.warpmail.net>
	<87vdamu2es.fsf@thor.thematica.it>
	<4BF14508.8040307@drmicha.warpmail.net>
	<87d3wutt34.fsf@thor.thematica.it>
	<4BF2614E.50003@drmicha.warpmail.net> <87pr0lja5n.fsf@gnu.org>
	<4BFB724A.3020800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 25 10:34:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGpaM-0002IQ-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 10:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab0EYId5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 04:33:57 -0400
Received: from chapters.gnu.org ([91.121.9.110]:51069 "EHLO chapters.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885Ab0EYId4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 04:33:56 -0400
Received: by chapters.gnu.org (Postfix, from userid 111)
	id 03B0546D1EA; Tue, 25 May 2010 10:33:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on chapters.gnu.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=ALL_TRUSTED,BAYES_40
	autolearn=disabled version=3.2.5
X-Spam-Level-GNUchapters: 
Received: from thor.thematica.it (localhost.localdomain [127.0.0.1])
	by chapters.gnu.org (Postfix) with ESMTP id 4B9CD46D1EC;
	Tue, 25 May 2010 10:33:53 +0200 (CEST)
In-Reply-To: <4BFB724A.3020800@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 25 May 2010 08:46:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147685>

Hello,

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I gave you my partial ack'ed-by (see above) and a homework problem to
> answer: Have you checked whether this covers all code paths (all
> help/usage callers)? If yes then it's a good idea to resend v2 of your
> patch as a reply to this thread but with subject "[PATCH v2]..." as it
> is hard to find otherwise, and cc to Junio.

Yes, I have just double-checked it; I hope I am not missing something.

Thanks,
Giuseppe



>From 00100c61db30725011edf62e7e0e7bc6ac685cb0 Mon Sep 17 00:00:00 2001
From: Giuseppe Scrivano <gscrivano@gnu.org>
Date: Mon, 17 May 2010 17:34:41 +0200
Subject: [PATCH] print the usage string on stdout instead of stderr

When -h is used, print usage messages on stdout.  If a command is invoked with
wrong arguments then print the usage messages on stderr.

Signed-off-by: Giuseppe Scrivano <gscrivano@gnu.org>
---
 parse-options.c               |   64 +++++++++++++++++++++--------------------
 t/t0040-parse-options.sh      |    8 +++--
 t/t1502-rev-parse-parseopt.sh |    6 ++--
 3 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8546d85..c8aaf95 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -5,7 +5,7 @@
 #include "color.h"
 
 static int parse_options_usage(const char * const *usagestr,
-			       const struct option *opts);
+			       const struct option *opts, int err);
 
 #define OPT_SHORT 1
 #define OPT_UNSET 2
@@ -352,7 +352,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 }
 
 static int usage_with_options_internal(const char * const *,
-				       const struct option *, int);
+				       const struct option *, int, int);
 
 int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const struct option *options,
@@ -380,10 +380,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
 			if (internal_help && *ctx->opt == 'h')
-				return parse_options_usage(usagestr, options);
+				return parse_options_usage(usagestr, options, 0);
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
-				return parse_options_usage(usagestr, options);
+				return parse_options_usage(usagestr, options, 1);
 			case -2:
 				goto unknown;
 			}
@@ -391,10 +391,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
 				if (internal_help && *ctx->opt == 'h')
-					return parse_options_usage(usagestr, options);
+					return parse_options_usage(usagestr, options, 0);
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
-					return parse_options_usage(usagestr, options);
+					return parse_options_usage(usagestr, options, 1);
 				case -2:
 					/* fake a short option thing to hide the fact that we may have
 					 * started to parse aggregated stuff
@@ -418,12 +418,12 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 
 		if (internal_help && !strcmp(arg + 2, "help-all"))
-			return usage_with_options_internal(usagestr, options, 1);
+			return usage_with_options_internal(usagestr, options, 1, 0);
 		if (internal_help && !strcmp(arg + 2, "help"))
-			return parse_options_usage(usagestr, options);
+			return parse_options_usage(usagestr, options, 0);
 		switch (parse_long_opt(ctx, arg + 2, options)) {
 		case -1:
-			return parse_options_usage(usagestr, options);
+			return parse_options_usage(usagestr, options, 1);
 		case -2:
 			goto unknown;
 		}
@@ -468,7 +468,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	return parse_options_end(&ctx);
 }
 
-static int usage_argh(const struct option *opts)
+static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
 	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
@@ -479,72 +479,74 @@ static int usage_argh(const struct option *opts)
 			s = literal ? "[%s]" : "[<%s>]";
 	else
 		s = literal ? " %s" : " <%s>";
-	return fprintf(stderr, s, opts->argh ? opts->argh : "...");
+	return fprintf(outfile, s, opts->argh ? opts->argh : "...");
 }
 
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
 static int usage_with_options_internal(const char * const *usagestr,
-				const struct option *opts, int full)
+				const struct option *opts, int full, int err)
 {
+	FILE *outfile = err ? stderr : stdout;
+
 	if (!usagestr)
 		return PARSE_OPT_HELP;
 
-	fprintf(stderr, "usage: %s\n", *usagestr++);
+	fprintf(outfile, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
-		fprintf(stderr, "   or: %s\n", *usagestr++);
+		fprintf(outfile, "   or: %s\n", *usagestr++);
 	while (*usagestr) {
-		fprintf(stderr, "%s%s\n",
+		fprintf(outfile, "%s%s\n",
 				**usagestr ? "    " : "",
 				*usagestr);
 		usagestr++;
 	}
 
 	if (opts->type != OPTION_GROUP)
-		fputc('\n', stderr);
+		fputc('\n', outfile);
 
 	for (; opts->type != OPTION_END; opts++) {
 		size_t pos;
 		int pad;
 
 		if (opts->type == OPTION_GROUP) {
-			fputc('\n', stderr);
+			fputc('\n', outfile);
 			if (*opts->help)
-				fprintf(stderr, "%s\n", opts->help);
+				fprintf(outfile, "%s\n", opts->help);
 			continue;
 		}
 		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
 			continue;
 
-		pos = fprintf(stderr, "    ");
+		pos = fprintf(outfile, "    ");
 		if (opts->short_name && !(opts->flags & PARSE_OPT_NEGHELP)) {
 			if (opts->flags & PARSE_OPT_NODASH)
-				pos += fprintf(stderr, "%c", opts->short_name);
+				pos += fprintf(outfile, "%c", opts->short_name);
 			else
-				pos += fprintf(stderr, "-%c", opts->short_name);
+				pos += fprintf(outfile, "-%c", opts->short_name);
 		}
 		if (opts->long_name && opts->short_name)
-			pos += fprintf(stderr, ", ");
+			pos += fprintf(outfile, ", ");
 		if (opts->long_name)
-			pos += fprintf(stderr, "--%s%s",
+			pos += fprintf(outfile, "--%s%s",
 				(opts->flags & PARSE_OPT_NEGHELP) ?  "no-" : "",
 				opts->long_name);
 		if (opts->type == OPTION_NUMBER)
-			pos += fprintf(stderr, "-NUM");
+			pos += fprintf(outfile, "-NUM");
 
 		if (!(opts->flags & PARSE_OPT_NOARG))
-			pos += usage_argh(opts);
+			pos += usage_argh(opts, outfile);
 
 		if (pos <= USAGE_OPTS_WIDTH)
 			pad = USAGE_OPTS_WIDTH - pos;
 		else {
-			fputc('\n', stderr);
+			fputc('\n', outfile);
 			pad = USAGE_OPTS_WIDTH;
 		}
-		fprintf(stderr, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
+		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
 	}
-	fputc('\n', stderr);
+	fputc('\n', outfile);
 
 	return PARSE_OPT_HELP;
 }
@@ -552,7 +554,7 @@ static int usage_with_options_internal(const char * const *usagestr,
 void usage_with_options(const char * const *usagestr,
 			const struct option *opts)
 {
-	usage_with_options_internal(usagestr, opts, 0);
+	usage_with_options_internal(usagestr, opts, 0, 1);
 	exit(129);
 }
 
@@ -565,9 +567,9 @@ void usage_msg_opt(const char *msg,
 }
 
 static int parse_options_usage(const char * const *usagestr,
-			       const struct option *opts)
+			       const struct option *opts, int err)
 {
-	return usage_with_options_internal(usagestr, opts, 0);
+	return usage_with_options_internal(usagestr, opts, 0, err);
 }
 
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 3d450ed..2092450 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,7 +7,7 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat > expect.err << EOF
+cat > expect << EOF
 usage: test-parse-options <options>
 
     -b, --boolean         get a boolean
@@ -46,10 +46,12 @@ EOF
 
 test_expect_success 'test help' '
 	test_must_fail test-parse-options -h > output 2> output.err &&
-	test ! -s output &&
-	test_cmp expect.err output.err
+	test ! -s output.err &&
+	test_cmp expect output
 '
 
+mv expect expect.err
+
 cat > expect << EOF
 boolean: 2
 integer: 1729
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index e504058..660487d 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -3,7 +3,7 @@
 test_description='test git rev-parse --parseopt'
 . ./test-lib.sh
 
-cat > expect.err <<EOF
+cat > expect <<EOF
 usage: some-command [options] <args>...
 
     some-command does foo and bar!
@@ -38,8 +38,8 @@ extra1    line above used to cause a segfault but no longer does
 EOF
 
 test_expect_success 'test --parseopt help output' '
-	git rev-parse --parseopt -- -h 2> output.err < optionspec
-	test_cmp expect.err output.err
+	git rev-parse --parseopt -- -h > output < optionspec
+	test_cmp expect output
 '
 
 cat > expect <<EOF
-- 
1.7.1
