From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/7] parse-opt: create parse_options_step.
Date: Tue, 24 Jun 2008 11:12:08 +0200
Message-ID: <1214298732-6247-4-git-send-email-madcoder@debian.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
 <1214298732-6247-1-git-send-email-madcoder@debian.org>
 <1214298732-6247-2-git-send-email-madcoder@debian.org>
 <1214298732-6247-3-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB4aQ-0007aq-Ry
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 11:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbYFXJMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 05:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbYFXJMU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 05:12:20 -0400
Received: from pan.madism.org ([88.191.52.104]:48596 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbYFXJMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 05:12:16 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8A580380E4;
	Tue, 24 Jun 2008 11:12:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2234C3D691F; Tue, 24 Jun 2008 11:12:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.110.g736c7.dirty
In-Reply-To: <1214298732-6247-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86019>

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
1.5.6.110.g736c7.dirty
