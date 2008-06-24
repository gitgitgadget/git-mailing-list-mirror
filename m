From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 6/7] parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
Date: Tue, 24 Jun 2008 11:12:11 +0200
Message-ID: <1214298732-6247-7-git-send-email-madcoder@debian.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
 <1214298732-6247-1-git-send-email-madcoder@debian.org>
 <1214298732-6247-2-git-send-email-madcoder@debian.org>
 <1214298732-6247-3-git-send-email-madcoder@debian.org>
 <1214298732-6247-4-git-send-email-madcoder@debian.org>
 <1214298732-6247-5-git-send-email-madcoder@debian.org>
 <1214298732-6247-6-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:14:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB4b6-0007pw-3o
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 11:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbYFXJM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 05:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYFXJMZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 05:12:25 -0400
Received: from pan.madism.org ([88.191.52.104]:48598 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbYFXJMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 05:12:16 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 022CF380E6;
	Tue, 24 Jun 2008 11:12:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3290B3D6924; Tue, 24 Jun 2008 11:12:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.110.g736c7.dirty
In-Reply-To: <1214298732-6247-6-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86023>

This way, argv[0] isn't clobbered, to the cost of maybe not having a
resulting NULL terminated argv array.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |    7 ++++---
 parse-options.h |    2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index ee82cf3..a6b5e04 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -246,7 +246,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->argc = argc - 1;
 	ctx->argv = argv + 1;
-	ctx->out  = argv;
+	ctx->out  = argv + ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
 	strbuf_init(&ctx->buf, 0);
 }
@@ -327,10 +327,11 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
+	int res = ctx->cpidx + ctx->argc;
 	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
-	ctx->out[ctx->cpidx + ctx->argc] = NULL;
+	ctx->out[res] = NULL;
 	strbuf_release(&ctx->buf);
-	return ctx->cpidx + ctx->argc;
+	return res + ((ctx->flags & PARSE_OPT_KEEP_ARGV0) != 0);
 }
 
 int parse_options(int argc, const char **argv, const struct option *options,
diff --git a/parse-options.h b/parse-options.h
index 14447d5..6745c7d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -22,6 +22,8 @@ enum parse_opt_type {
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
+	/* using that option, the filtered argv may not be NULL terminated */
+	PARSE_OPT_KEEP_ARGV0 = 4,
 };
 
 enum parse_opt_option_flags {
-- 
1.5.6.110.g736c7.dirty
