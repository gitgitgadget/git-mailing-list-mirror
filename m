From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/4] parseopt: add PARSE_OPT_KEEP_UNKNOWN
Date: Sun, 08 Mar 2009 19:12:47 +0100
Message-ID: <49B40A9F.7050408@lsrfire.ath.cx>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org> <49B2C784.90800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 19:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgNW2-0002sT-Ga
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 19:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZCHSMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 14:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbZCHSMy
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 14:12:54 -0400
Received: from india601.server4you.de ([85.25.151.105]:36960 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbZCHSMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 14:12:54 -0400
Received: from [10.0.1.101] (p57B7C244.dip.t-dialin.net [87.183.194.68])
	by india601.server4you.de (Postfix) with ESMTPSA id DE6852F8063;
	Sun,  8 Mar 2009 19:12:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49B2C784.90800@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112625>

Add a parseopt flag, PARSE_OPT_KEEP_UNKNOWN, that can be used to keep
unknown options in argv, similar to the existing KEEP flags.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 parse-options.c |   12 +++++++++---
 parse-options.h |    1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4c5d09d..39808ae 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -274,7 +274,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			case -1:
 				return parse_options_usage(usagestr, options);
 			case -2:
-				return PARSE_OPT_UNKNOWN;
+				goto unknown;
 			}
 			if (ctx->opt)
 				check_typos(arg + 1, options);
@@ -292,7 +292,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 					 */
 					ctx->argv[0] = xstrdup(ctx->opt - 1);
 					*(char *)ctx->argv[0] = '-';
-					return PARSE_OPT_UNKNOWN;
+					goto unknown;
 				}
 			}
 			continue;
@@ -314,8 +314,14 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		case -1:
 			return parse_options_usage(usagestr, options);
 		case -2:
-			return PARSE_OPT_UNKNOWN;
+			goto unknown;
 		}
+		continue;
+unknown:
+		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN))
+			return PARSE_OPT_UNKNOWN;
+		ctx->out[ctx->cpidx++] = ctx->argv[0];
+		ctx->opt = NULL;
 	}
 	return PARSE_OPT_DONE;
 }
diff --git a/parse-options.h b/parse-options.h
index 9122905..b7d08b1 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -21,6 +21,7 @@ enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
 	PARSE_OPT_KEEP_ARGV0 = 4,
+	PARSE_OPT_KEEP_UNKNOWN = 8,
 };
 
 enum parse_opt_option_flags {
-- 
1.6.2
