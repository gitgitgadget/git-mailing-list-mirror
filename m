From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] parse-options: make resuming easier after
 PARSE_OPT_STOP_AT_NON_OPTION
Date: Sun, 24 Oct 2010 03:15:32 -0500
Message-ID: <20101024081532.GC29630@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 10:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9vng-0001bb-Ch
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 10:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177Ab0JXIT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 04:19:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56319 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab0JXITY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 04:19:24 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so2938002iwn.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GVarZf+yWlltFzcAmQ1+2N8Vg9Hw4y8xpdTy7/2AXnY=;
        b=ZBHLh0va0ApaMmN3Y6lJX7Vxw5KxFxBVFikDEzuMF1nuvqa/k9jSl6VbtR7qtU1My8
         ATskHpEuRu1aPeV0ez0cszI529FfzK1ca+yyz2+AaeWX+pJjOgGfJwG987j9EO4W0B4v
         LYaeRgYpmM20dR2UU7cH3Me3K4FGLvn9XNk6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UPlzb1CFP+MGt3a2Z62Bq6ZtOJJ+7xiNOGVURGdi7wx1O9nb86bMcFCNiOuUvUhsbZ
         skiCR5015CFVK6sAEXdGOi9sU8dhtgLeq1rzaldPu8Xae4KlCh//3qW4KrOiDPP3jxUo
         /9gx7Gonq+LNRSNJEVSwYtGduqkdSjuFOhTus=
Received: by 10.42.214.70 with SMTP id gz6mr4011084icb.304.1287908364535;
        Sun, 24 Oct 2010 01:19:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u6sm6106307ibd.12.2010.10.24.01.19.23
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 01:19:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101024081316.GA29630@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159840>

Introduce a PARSE_OPT_NON_OPTION state, so parse_option_step()
callers can easily distinguish between non-options and other
reasons for option parsing termination (like "--").

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |    3 ++-
 parse-options.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 7907306..cba982a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -374,7 +374,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
 			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
-				break;
+				return PARSE_OPT_NON_OPTION;
 			ctx->out[ctx->cpidx++] = ctx->argv[0];
 			continue;
 		}
@@ -456,6 +456,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
+	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
 	default: /* PARSE_OPT_UNKNOWN */
diff --git a/parse-options.h b/parse-options.h
index fa400da..07a0543 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -170,6 +170,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
 enum {
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
+	PARSE_OPT_NON_OPTION,
 	PARSE_OPT_UNKNOWN
 };
 
-- 
1.7.2.3
