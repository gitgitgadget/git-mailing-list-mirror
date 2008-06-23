From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-opt: have parse_options_{start,end}.
Date: Mon, 23 Jun 2008 23:11:18 +0200
Message-ID: <1214255482-2086-1-git-send-email-madcoder@debian.org>
References: <20080623210935.GC13395@artemis.madism.org>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 23:12:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtKw-00069F-NQ
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbYFWVL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbYFWVL0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:11:26 -0400
Received: from pan.madism.org ([88.191.52.104]:51105 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347AbYFWVLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:11:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5894E37DCA;
	Mon, 23 Jun 2008 23:11:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C81A45F019; Mon, 23 Jun 2008 23:11:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.117.g5fe2
In-Reply-To: <20080623210935.GC13395@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85927>

Make the struct optparse_t public under the better name parse_opt_ctx_t.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   69 +++++++++++++++++++++++++++++++------------------------
 parse-options.h |   16 ++++++++++++
 2 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b8bde2b..774e647 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -4,14 +4,7 @@
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-struct optparse_t {
-	const char **argv;
-	const char **out;
-	int argc, cpidx;
-	const char *opt;
-};
-
-static inline const char *get_arg(struct optparse_t *p)
+static inline const char *get_arg(struct parse_opt_ctx_t *p)
 {
 	if (p->opt) {
 		const char *res = p->opt;
@@ -37,7 +30,7 @@ static int opterror(const struct option *opt, const char *reason, int flags)
 	return error("option `%s' %s", opt->long_name, reason);
 }
 
-static int get_value(struct optparse_t *p,
+static int get_value(struct parse_opt_ctx_t *p,
                      const struct option *opt, int flags)
 {
 	const char *s, *arg;
@@ -131,7 +124,7 @@ static int get_value(struct optparse_t *p,
 	}
 }
 
-static int parse_short_opt(struct optparse_t *p, const struct option *options)
+static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *options)
 {
 	for (; options->type != OPTION_END; options++) {
 		if (options->short_name == *p->opt) {
@@ -142,7 +135,7 @@ static int parse_short_opt(struct optparse_t *p, const struct option *options)
 	return error("unknown switch `%c'", *p->opt);
 }
 
-static int parse_long_opt(struct optparse_t *p, const char *arg,
+static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
                           const struct option *options)
 {
 	const char *arg_end = strchr(arg, '=');
@@ -247,45 +240,63 @@ void check_typos(const char *arg, const struct option *options)
 	}
 }
 
+void parse_options_start(struct parse_opt_ctx_t *ctx,
+                         int argc, const char **argv, int flags)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->argc = argc - 1;
+	ctx->argv = argv + 1;
+	ctx->out  = argv;
+	ctx->flags = flags;
+}
+
+int parse_options_end(struct parse_opt_ctx_t *ctx)
+{
+	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
+	ctx->out[ctx->cpidx + ctx->argc] = NULL;
+	return ctx->cpidx + ctx->argc;
+}
+
 static NORETURN void usage_with_options_internal(const char * const *,
                                                  const struct option *, int);
 
 int parse_options(int argc, const char **argv, const struct option *options,
                   const char * const usagestr[], int flags)
 {
-	struct optparse_t args = { argv + 1, argv, argc - 1, 0, NULL };
+	struct parse_opt_ctx_t ctx;
 
-	for (; args.argc; args.argc--, args.argv++) {
-		const char *arg = args.argv[0];
+	parse_options_start(&ctx, argc, argv, flags);
+	for (; ctx.argc; ctx.argc--, ctx.argv++) {
+		const char *arg = ctx.argv[0];
 
 		if (*arg != '-' || !arg[1]) {
-			if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
+			if (ctx.flags & PARSE_OPT_STOP_AT_NON_OPTION)
 				break;
-			args.out[args.cpidx++] = args.argv[0];
+			ctx.out[ctx.cpidx++] = ctx.argv[0];
 			continue;
 		}
 
 		if (arg[1] != '-') {
-			args.opt = arg + 1;
-			if (*args.opt == 'h')
+			ctx.opt = arg + 1;
+			if (*ctx.opt == 'h')
 				usage_with_options(usagestr, options);
-			if (parse_short_opt(&args, options) < 0)
+			if (parse_short_opt(&ctx, options) < 0)
 				usage_with_options(usagestr, options);
-			if (args.opt)
+			if (ctx.opt)
 				check_typos(arg + 1, options);
-			while (args.opt) {
-				if (*args.opt == 'h')
+			while (ctx.opt) {
+				if (*ctx.opt == 'h')
 					usage_with_options(usagestr, options);
-				if (parse_short_opt(&args, options) < 0)
+				if (parse_short_opt(&ctx, options) < 0)
 					usage_with_options(usagestr, options);
 			}
 			continue;
 		}
 
 		if (!arg[2]) { /* "--" */
-			if (!(flags & PARSE_OPT_KEEP_DASHDASH)) {
-				args.argc--;
-				args.argv++;
+			if (!(ctx.flags & PARSE_OPT_KEEP_DASHDASH)) {
+				ctx.argc--;
+				ctx.argv++;
 			}
 			break;
 		}
@@ -294,13 +305,11 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			usage_with_options_internal(usagestr, options, 1);
 		if (!strcmp(arg + 2, "help"))
 			usage_with_options(usagestr, options);
-		if (parse_long_opt(&args, arg + 2, options))
+		if (parse_long_opt(&ctx, arg + 2, options))
 			usage_with_options(usagestr, options);
 	}
 
-	memmove(args.out + args.cpidx, args.argv, args.argc * sizeof(*args.out));
-	args.out[args.cpidx + args.argc] = NULL;
-	return args.cpidx + args.argc;
+	return parse_options_end(&ctx);
 }
 
 #define USAGE_OPTS_WIDTH 24
diff --git a/parse-options.h b/parse-options.h
index 4ee443d..db6c986 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -111,6 +111,22 @@ extern int parse_options(int argc, const char **argv,
 extern NORETURN void usage_with_options(const char * const *usagestr,
                                         const struct option *options);
 
+/*----- incremantal advanced APIs -----*/
+
+struct parse_opt_ctx_t {
+	const char **argv;
+	const char **out;
+	int argc, cpidx;
+	const char *opt;
+	int flags;
+};
+
+extern void parse_options_start(struct parse_opt_ctx_t *ctx,
+                                int argc, const char **argv, int flags);
+
+extern int parse_options_end(struct parse_opt_ctx_t *ctx);
+
+
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
-- 
1.5.6.117.g5fe2
