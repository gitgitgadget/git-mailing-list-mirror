From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/10] parse-options: make resuming easier after
 PARSE_OPT_STOP_AT_NON_OPTION
Date: Wed, 1 Dec 2010 17:32:55 -0600
Message-ID: <20101201233255.GI31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNwAl-0002U6-Go
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281Ab0LAXdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:33:07 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58996 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab0LAXdG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:33:06 -0500
Received: by qyk11 with SMTP id 11so3203373qyk.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bvCpGRRuIJak8k7rLrXu663mFw39xWnCVYh+yLw2ra0=;
        b=SUx157xsxLhxMskPTenuL/+it3sKGFIdD2XF5EXHnFS7irILgBYLtJObvEFaRl7EUC
         E4DknEuGxgOH9a/0YvNNzHieRKrEQViT8pPD8eSxa+8PJqNlWWapZClqbNtch4o7lKx+
         NwVGPfI7//q4KXt9pR1kfZi62D/EDqoUe8YoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BJy5MNqzK4exWVft0rClEg7ie0zlrpjmKT2rOhe1mdxL9SNEXw4EJWjzrM0/26YqbY
         1qSzj03GHWC3ihTACZISWw1kBMlCDDVIj2ZmzVnduw4rPTS2T65WsrJ5ejswC4ZuBWjC
         Z1+8WlyIS6jPRIx+dAGyEnOutbUlhf8BcpIbU=
Received: by 10.229.91.194 with SMTP id o2mr7787617qcm.250.1291246384653;
        Wed, 01 Dec 2010 15:33:04 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id s28sm349740qcp.45.2010.12.01.15.33.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:33:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162646>

Introduce a PARSE_OPT_NON_OPTION state, so parse_option_step()
callers can easily distinguish between non-options and other
reasons for option parsing termination (like "--").

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |    3 ++-
 parse-options.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4c58e7f..4b000e6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -369,7 +369,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
 			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
-				break;
+				return PARSE_OPT_NON_OPTION;
 			ctx->out[ctx->cpidx++] = ctx->argv[0];
 			continue;
 		}
@@ -451,6 +451,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
+	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
 	default: /* PARSE_OPT_UNKNOWN */
diff --git a/parse-options.h b/parse-options.h
index ab1bdf0..b897d6b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -167,6 +167,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
 enum {
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
+	PARSE_OPT_NON_OPTION,
 	PARSE_OPT_UNKNOWN
 };
 
-- 
1.7.2.3
