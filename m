From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/4] parseopt: add PARSE_OPT_NO_INTERNAL_HELP
Date: Sun, 08 Mar 2009 19:15:08 +0100
Message-ID: <49B40B2C.1070008@lsrfire.ath.cx>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org> <49B2C784.90800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 19:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgNYG-0003cf-9u
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 19:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbZCHSPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 14:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbZCHSPM
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 14:15:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:36971 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbZCHSPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 14:15:11 -0400
Received: from [10.0.1.101] (p57B7C244.dip.t-dialin.net [87.183.194.68])
	by india601.server4you.de (Postfix) with ESMTPSA id AB2C02F8063;
	Sun,  8 Mar 2009 19:15:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49B2C784.90800@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112626>

Add a parseopt flag, PARSE_OPT_NO_INTERNAL_HELP, that turns off internal
handling of -h, --help and --help-all.  This allows the implementation
of custom help option handlers or incremental parsers.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 parse-options.c |   10 ++++++----
 parse-options.h |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 39808ae..8b21dea 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -253,6 +253,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const struct option *options,
 		       const char * const usagestr[])
 {
+	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
+
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;
 
@@ -268,7 +270,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
-			if (*ctx->opt == 'h')
+			if (internal_help && *ctx->opt == 'h')
 				return parse_options_usage(usagestr, options);
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
@@ -279,7 +281,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			if (ctx->opt)
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
-				if (*ctx->opt == 'h')
+				if (internal_help && *ctx->opt == 'h')
 					return parse_options_usage(usagestr, options);
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
@@ -306,9 +308,9 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			break;
 		}
 
-		if (!strcmp(arg + 2, "help-all"))
+		if (internal_help && !strcmp(arg + 2, "help-all"))
 			return usage_with_options_internal(usagestr, options, 1);
-		if (!strcmp(arg + 2, "help"))
+		if (internal_help && !strcmp(arg + 2, "help"))
 			return parse_options_usage(usagestr, options);
 		switch (parse_long_opt(ctx, arg + 2, options)) {
 		case -1:
diff --git a/parse-options.h b/parse-options.h
index b7d08b1..f8ef1db 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -22,6 +22,7 @@ enum parse_opt_flags {
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
 	PARSE_OPT_KEEP_ARGV0 = 4,
 	PARSE_OPT_KEEP_UNKNOWN = 8,
+	PARSE_OPT_NO_INTERNAL_HELP = 16,
 };
 
 enum parse_opt_option_flags {
-- 
1.6.2
