From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-opt: do not pring errors on unknown options,
 return -2 intead.
Date: Mon, 23 Jun 2008 15:08:04 -0700
Message-ID: <7vd4m7hkjf.fsf@gitster.siamese.dyndns.org>
References: <20080623210935.GC13395@artemis.madism.org>
 <1214255482-2086-1-git-send-email-madcoder@debian.org>
 <1214255482-2086-2-git-send-email-madcoder@debian.org>
 <1214255482-2086-3-git-send-email-madcoder@debian.org>
 <1214255482-2086-4-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuDx-0008VW-Qh
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbYFWWIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbYFWWIQ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:08:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYFWWIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 18:08:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E89D6060;
	Mon, 23 Jun 2008 18:08:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 91047605C; Mon, 23 Jun 2008 18:08:09 -0400 (EDT)
In-Reply-To: <1214255482-2086-4-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Mon, 23 Jun 2008 23:11:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E03A91A4-4170-11DD-AAA7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85941>

You'd need something like this on top.

Documentation/technical/api-parse-options says that non-zero return is
used to signal an error.



 parse-options.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 132d34c..71a8056 100644
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
@@ -276,9 +276,9 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			if (*ctx->opt == 'h')
 				return parse_options_usage(usagestr, options);
 			switch (parse_short_opt(ctx, options)) {
-			  case -1:
+			case -1:
 				return parse_options_usage(usagestr, options);
-			  case -2:
+			case -2:
 				goto unknown_fixup;
 			}
 			if (ctx->opt)
@@ -318,9 +318,9 @@ unknown_fixup:
 		if (!strcmp(arg + 2, "help"))
 			return parse_options_usage(usagestr, options);
 		switch (parse_long_opt(ctx, arg + 2, options)) {
-		  case -1:
+		case -1:
 			return parse_options_usage(usagestr, options);
-		  case -2:
+		case -2:
 			return PARSE_OPT_UNKNOWN;
 		}
 	}
