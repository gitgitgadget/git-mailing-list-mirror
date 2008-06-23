From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-opt: fake short strings for callers to believe in.
Date: Mon, 23 Jun 2008 23:11:22 +0200
Message-ID: <1214255482-2086-5-git-send-email-madcoder@debian.org>
References: <20080623210935.GC13395@artemis.madism.org>
 <1214255482-2086-1-git-send-email-madcoder@debian.org>
 <1214255482-2086-2-git-send-email-madcoder@debian.org>
 <1214255482-2086-3-git-send-email-madcoder@debian.org>
 <1214255482-2086-4-git-send-email-madcoder@debian.org>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 23:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtKx-00069F-W2
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYFWVLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbYFWVL3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:11:29 -0400
Received: from pan.madism.org ([88.191.52.104]:51110 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbYFWVL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:11:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D73A537F3E;
	Mon, 23 Jun 2008 23:11:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DE965E53A0; Mon, 23 Jun 2008 23:11:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.117.g5fe2
In-Reply-To: <1214255482-2086-4-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85924>

If we begin to parse -abc and that the parser knew about -a and -b, it
will fake a -c switch for the caller to deal with.

Of course in the case of -acb (supposing -c is not taking an argument) the
caller will have to be especially clever to do the same thing. We could
think about exposing an API to do so if it's really needed, but oh well...

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   18 ++++++++++++++++--
 parse-options.h |   12 ++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 1a1d4dc..f3fd296 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -248,6 +248,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->argv = argv + 1;
 	ctx->out  = argv;
 	ctx->flags = flags;
+	strbuf_init(&ctx->buf, 0);
 }
 
 static int usage_with_options_internal(const char * const *,
@@ -257,6 +258,9 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
                        const struct option *options,
                        const char * const usagestr[])
 {
+	/* we must reset ->opt, unknown short option leave it dangling */
+	ctx->opt = NULL;
+
 	for (; ctx->argc; ctx->argc--, ctx->argv++) {
 		const char *arg = ctx->argv[0];
 
@@ -275,7 +279,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			  case -1:
 				return parse_options_usage(usagestr, options);
 			  case -2:
-				return PARSE_OPT_UNKNOWN;
+				goto unknown_fixup;
 			}
 			if (ctx->opt)
 				check_typos(arg + 1, options);
@@ -286,10 +290,19 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 				  case -1:
 					return parse_options_usage(usagestr, options);
 				  case -2:
-					return PARSE_OPT_UNKNOWN;
+					goto unknown_fixup;
 				}
 			}
 			continue;
+unknown_fixup:
+			/* fake a short option thing to hide the fact that we may have
+			 * started to parse aggregated stuff
+			 */
+			strbuf_reset(&ctx->buf);
+			strbuf_addch(&ctx->buf, '-');
+			strbuf_addstr(&ctx->buf, ctx->opt);
+			*ctx->argv = ctx->buf.buf;
+			return PARSE_OPT_UNKNOWN;
 		}
 
 		if (!arg[2]) { /* "--" */
@@ -318,6 +331,7 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
 	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
 	ctx->out[ctx->cpidx + ctx->argc] = NULL;
+	strbuf_release(&ctx->buf);
 	return ctx->cpidx + ctx->argc;
 }
 
diff --git a/parse-options.h b/parse-options.h
index 9da5e8c..14447d5 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -1,6 +1,8 @@
 #ifndef PARSE_OPTIONS_H
 #define PARSE_OPTIONS_H
 
+#include "strbuf.h"
+
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
@@ -119,12 +121,18 @@ enum {
 	PARSE_OPT_UNKNOWN,
 };
 
+/*
+ * It's okay for the caller to consume argv/argc in the usual way.
+ * Other fields of that structure are private to parse-options and should not
+ * be modified in any way.
+ */
 struct parse_opt_ctx_t {
 	const char **argv;
 	const char **out;
 	int argc, cpidx;
 	const char *opt;
 	int flags;
+	struct strbuf buf;
 };
 
 extern int parse_options_usage(const char * const *usagestr,
@@ -133,6 +141,10 @@ extern int parse_options_usage(const char * const *usagestr,
 extern void parse_options_start(struct parse_opt_ctx_t *ctx,
                                 int argc, const char **argv, int flags);
 
+/* Warning: you cannot keep pointers to ctx->argv during the parse
+ *          because some "option strings" are faked. It's okay to use
+ *          ctx->argv after a parse_options_end obviously
+ */
 extern int parse_options_step(struct parse_opt_ctx_t *ctx,
                               const struct option *options,
                               const char * const usagestr[]);
-- 
1.5.6.117.g5fe2
