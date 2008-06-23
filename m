From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-opt: create parse_options_step.
Date: Mon, 23 Jun 2008 23:11:20 +0200
Message-ID: <1214255482-2086-3-git-send-email-madcoder@debian.org>
References: <20080623210935.GC13395@artemis.madism.org>
 <1214255482-2086-1-git-send-email-madcoder@debian.org>
 <1214255482-2086-2-git-send-email-madcoder@debian.org>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 23:12:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtKz-00069F-8Y
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756761AbYFWVLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754395AbYFWVLd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:11:33 -0400
Received: from pan.madism.org ([88.191.52.104]:51119 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037AbYFWVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:11:29 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DD51537F3F;
	Mon, 23 Jun 2008 23:11:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D383B99B6D; Mon, 23 Jun 2008 23:11:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.117.g5fe2
In-Reply-To: <1214255482-2086-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85925>

For now it's unable to stop at unknown options, this commit merely
reorganize some code around.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   89 +++++++++++++++++++++++++++++++-----------------------
 parse-options.h |    4 ++
 2 files changed, 55 insertions(+), 38 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4e9e675..71b3476 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -250,64 +250,79 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->flags = flags;
 }
 
-int parse_options_end(struct parse_opt_ctx_t *ctx)
-{
-	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
-	ctx->out[ctx->cpidx + ctx->argc] = NULL;
-	return ctx->cpidx + ctx->argc;
-}
-
 static int usage_with_options_internal(const char * const *,
-                                       const struct option *, int, int);
+                                       const struct option *, int);
 
-int parse_options(int argc, const char **argv, const struct option *options,
-                  const char * const usagestr[], int flags)
+int parse_options_step(struct parse_opt_ctx_t *ctx,
+                       const struct option *options,
+                       const char * const usagestr[])
 {
-	struct parse_opt_ctx_t ctx;
-
-	parse_options_start(&ctx, argc, argv, flags);
-	for (; ctx.argc; ctx.argc--, ctx.argv++) {
-		const char *arg = ctx.argv[0];
+	for (; ctx->argc; ctx->argc--, ctx->argv++) {
+		const char *arg = ctx->argv[0];
 
 		if (*arg != '-' || !arg[1]) {
-			if (ctx.flags & PARSE_OPT_STOP_AT_NON_OPTION)
+			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
 				break;
-			ctx.out[ctx.cpidx++] = ctx.argv[0];
+			ctx->out[ctx->cpidx++] = ctx->argv[0];
 			continue;
 		}
 
 		if (arg[1] != '-') {
-			ctx.opt = arg + 1;
-			if (*ctx.opt == 'h')
-				usage_with_options(usagestr, options);
-			if (parse_short_opt(&ctx, options) < 0)
+			ctx->opt = arg + 1;
+			if (*ctx->opt == 'h')
+				return parse_options_usage(usagestr, options);
+			if (parse_short_opt(ctx, options) < 0)
 				usage_with_options(usagestr, options);
-			if (ctx.opt)
+			if (ctx->opt)
 				check_typos(arg + 1, options);
-			while (ctx.opt) {
-				if (*ctx.opt == 'h')
-					usage_with_options(usagestr, options);
-				if (parse_short_opt(&ctx, options) < 0)
+			while (ctx->opt) {
+				if (*ctx->opt == 'h')
+					return parse_options_usage(usagestr, options);
+				if (parse_short_opt(ctx, options) < 0)
 					usage_with_options(usagestr, options);
 			}
 			continue;
 		}
 
 		if (!arg[2]) { /* "--" */
-			if (!(ctx.flags & PARSE_OPT_KEEP_DASHDASH)) {
-				ctx.argc--;
-				ctx.argv++;
+			if (!(ctx->flags & PARSE_OPT_KEEP_DASHDASH)) {
+				ctx->argc--;
+				ctx->argv++;
 			}
 			break;
 		}
 
 		if (!strcmp(arg + 2, "help-all"))
-			usage_with_options_internal(usagestr, options, 1, 1);
+			return usage_with_options_internal(usagestr, options, 1);
 		if (!strcmp(arg + 2, "help"))
-			usage_with_options(usagestr, options);
-		if (parse_long_opt(&ctx, arg + 2, options))
+			return parse_options_usage(usagestr, options);
+		if (parse_long_opt(ctx, arg + 2, options))
 			usage_with_options(usagestr, options);
 	}
+	return PARSE_OPT_DONE;
+}
+
+int parse_options_end(struct parse_opt_ctx_t *ctx)
+{
+	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
+	ctx->out[ctx->cpidx + ctx->argc] = NULL;
+	return ctx->cpidx + ctx->argc;
+}
+
+int parse_options(int argc, const char **argv, const struct option *options,
+                  const char * const usagestr[], int flags)
+{
+	struct parse_opt_ctx_t ctx;
+
+	parse_options_start(&ctx, argc, argv, flags);
+	switch (parse_options_step(&ctx, options, usagestr)) {
+	case PARSE_OPT_HELP:
+		exit(129);
+	case PARSE_OPT_DONE:
+		break;
+	default: /* PARSE_OPT_UNKNOWN */
+		abort(); /* unreached yet */
+	}
 
 	return parse_options_end(&ctx);
 }
@@ -316,7 +331,7 @@ int parse_options(int argc, const char **argv, const struct option *options,
 #define USAGE_GAP         2
 
 int usage_with_options_internal(const char * const *usagestr,
-                                const struct option *opts, int full, int do_exit)
+                                const struct option *opts, int full)
 {
 	fprintf(stderr, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
@@ -401,22 +416,20 @@ int usage_with_options_internal(const char * const *usagestr,
 	}
 	fputc('\n', stderr);
 
-	if (do_exit)
-		exit(129);
 	return PARSE_OPT_HELP;
 }
 
 void usage_with_options(const char * const *usagestr,
                         const struct option *opts)
 {
-	usage_with_options_internal(usagestr, opts, 0, 1);
-	exit(129); /* make gcc happy */
+	usage_with_options_internal(usagestr, opts, 0);
+	exit(129);
 }
 
 int parse_options_usage(const char * const *usagestr,
                         const struct option *opts)
 {
-	return usage_with_options_internal(usagestr, opts, 0, 0);
+	return usage_with_options_internal(usagestr, opts, 0);
 }
 
 
diff --git a/parse-options.h b/parse-options.h
index 424ea46..9da5e8c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -133,6 +133,10 @@ extern int parse_options_usage(const char * const *usagestr,
 extern void parse_options_start(struct parse_opt_ctx_t *ctx,
                                 int argc, const char **argv, int flags);
 
+extern int parse_options_step(struct parse_opt_ctx_t *ctx,
+                              const struct option *options,
+                              const char * const usagestr[]);
+
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
 
-- 
1.5.6.117.g5fe2
