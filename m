From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 01/17] parse-options: enhance STOP_AT_NON_OPTION
Date: Wed, 11 Aug 2010 23:03:26 +0800
Message-ID: <1281539022-31616-2-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:04:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCr7-0004pF-UT
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab0HKPEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:04:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46611 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab0HKPEY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:04:24 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so75091pxi.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eetMruI4UMbxwNmg8DGx504yvH8tp0B5DbJdboGbBH8=;
        b=Tr1PA3wIJOt5EJ2vwdGjKgtyGtEzjTEeeRjb1wRQgvTAYBK4ZRSfoVINgAh4HSXcqh
         DXe7cfS7qAoAymKHsRfTefKN2ltZKbp6OM4jB21Ixnd4V6gA9p3Ns5bgv4CMIoVwXUWe
         nuth2wwpvODbolX3/gPiuHn1HdovF3WivkYi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jBWhqXGd9DYtPUfL6a2giGWMJuoOcRgqfHlW6XBZqLmkdvOJHs/5QUu51gju8ubZLx
         U8lMZ2NRZaC5nbDxy68RrmSl/rGJl8lJXfxb56gYVQBdpfZ9WwNZcP3MDPlG132ydE6F
         pXFs1bsjNv8Y8mle8Hw1Zpe8rWHILO5di1pQU=
Received: by 10.115.16.2 with SMTP id t2mr10463326wai.211.1281539063882;
        Wed, 11 Aug 2010 08:04:23 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.04.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:04:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153240>

Make parse_options_step() report PARSE_OPT_NON_OPTION instead
of PARSE_OPT_DONE to the caller, when it sees a non-option argument.

This will help implementing a nonstandard option syntax that
takes more than one parameters to an option, e.g.

  -L n1,m1 pathspec1 -L n2,m2 pathspec2

by directly calling parse_options_step(). The parse_options() API
only calls parse_options_step() once, and its callers are not affected
by this change.

Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 parse-options.c |    3 ++-
 parse-options.h |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 0fa79bc..cbb49d3 100644
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
index 7435cdb..407697a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -161,7 +161,8 @@ extern NORETURN void usage_msg_opt(const char *msg,
 enum {
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
-	PARSE_OPT_UNKNOWN
+	PARSE_OPT_NON_OPTION,
+	PARSE_OPT_UNKNOWN,
 };
 
 /*
-- 
1.7.2.19.g79e5d
