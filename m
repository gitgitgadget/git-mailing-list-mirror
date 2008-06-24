From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/7] parse-opt: do not pring errors on unknown options, return -2 intead.
Date: Tue, 24 Jun 2008 11:12:09 +0200
Message-ID: <1214298732-6247-5-git-send-email-madcoder@debian.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
 <1214298732-6247-1-git-send-email-madcoder@debian.org>
 <1214298732-6247-2-git-send-email-madcoder@debian.org>
 <1214298732-6247-3-git-send-email-madcoder@debian.org>
 <1214298732-6247-4-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:13:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB4aR-0007aq-Jo
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 11:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbYFXJMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 05:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYFXJMV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 05:12:21 -0400
Received: from pan.madism.org ([88.191.52.104]:48582 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbYFXJMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 05:12:16 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 83551380E3;
	Tue, 24 Jun 2008 11:12:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 280623D6922; Tue, 24 Jun 2008 11:12:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.110.g736c7.dirty
In-Reply-To: <1214298732-6247-4-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86022>

This way we can catch "unknown" options more easily.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   43 ++++++++++++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 71b3476..90935f3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -94,14 +94,14 @@ static int get_value(struct parse_opt_ctx_t *p,
 
 	case OPTION_CALLBACK:
 		if (unset)
-			return (*opt->callback)(opt, NULL, 1);
+			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
 		if (opt->flags & PARSE_OPT_NOARG)
-			return (*opt->callback)(opt, NULL, 0);
+			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
 		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
-			return (*opt->callback)(opt, NULL, 0);
+			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
 		if (!arg)
 			return opterror(opt, "requires a value", flags);
-		return (*opt->callback)(opt, get_arg(p), 0);
+		return (*opt->callback)(opt, get_arg(p), 0) ? (-1) : 0;
 
 	case OPTION_INTEGER:
 		if (unset) {
@@ -132,7 +132,7 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
 			return get_value(p, options, OPT_SHORT);
 		}
 	}
-	return error("unknown switch `%c'", *p->opt);
+	return -2;
 }
 
 static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
@@ -217,7 +217,7 @@ is_abbreviated:
 			abbrev_option->long_name);
 	if (abbrev_option)
 		return get_value(p, abbrev_option, abbrev_flags);
-	return error("unknown option `%s'", arg);
+	return -2;
 }
 
 void check_typos(const char *arg, const struct option *options)
@@ -271,15 +271,23 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			ctx->opt = arg + 1;
 			if (*ctx->opt == 'h')
 				return parse_options_usage(usagestr, options);
-			if (parse_short_opt(ctx, options) < 0)
-				usage_with_options(usagestr, options);
+			switch (parse_short_opt(ctx, options)) {
+			case -1:
+				return parse_options_usage(usagestr, options);
+			case -2:
+				return PARSE_OPT_UNKNOWN;
+			}
 			if (ctx->opt)
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
 				if (*ctx->opt == 'h')
 					return parse_options_usage(usagestr, options);
-				if (parse_short_opt(ctx, options) < 0)
-					usage_with_options(usagestr, options);
+				switch (parse_short_opt(ctx, options)) {
+				case -1:
+					return parse_options_usage(usagestr, options);
+				case -2:
+					return PARSE_OPT_UNKNOWN;
+				}
 			}
 			continue;
 		}
@@ -296,8 +304,12 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			return usage_with_options_internal(usagestr, options, 1);
 		if (!strcmp(arg + 2, "help"))
 			return parse_options_usage(usagestr, options);
-		if (parse_long_opt(ctx, arg + 2, options))
-			usage_with_options(usagestr, options);
+		switch (parse_long_opt(ctx, arg + 2, options)) {
+		case -1:
+			return parse_options_usage(usagestr, options);
+		case -2:
+			return PARSE_OPT_UNKNOWN;
+		}
 	}
 	return PARSE_OPT_DONE;
 }
@@ -321,7 +333,12 @@ int parse_options(int argc, const char **argv, const struct option *options,
 	case PARSE_OPT_DONE:
 		break;
 	default: /* PARSE_OPT_UNKNOWN */
-		abort(); /* unreached yet */
+		if (ctx.argv[0][1] == '-') {
+			error("unknown option `%s'", ctx.argv[0] + 2);
+		} else {
+			error("unknown switch `%c'", *ctx.opt);
+		}
+		usage_with_options(usagestr, options);
 	}
 
 	return parse_options_end(&ctx);
-- 
1.5.6.110.g736c7.dirty
