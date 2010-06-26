From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 01/12] parse-options: stop when encounter a non-option
Date: Sat, 26 Jun 2010 06:27:26 -0700
Message-ID: <1277558857-23103-2-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:27:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVQI-0007cV-GC
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621Ab0FZN1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:27:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58519 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab0FZN1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:27:50 -0400
Received: by pvg2 with SMTP id 2so1277102pvg.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EpSoNAAf+9xE9sb4GZAEQWOx3oHi/EkOjqVXUz/tT1g=;
        b=vGi9w18pYvjTEllcRk+q2h1BGIdo/B8vc31WJVqm5awKdVRqfjOmfOHOKZ69fnHf+z
         agl4ilTBIwAgNLaWVV6PX1fROeU5GCYprOWlPve/MDztLEb+JbGdr/DYQjThMujnPQl1
         nuH8I9ZTp1ZiefJkXsaw4uIlcJpTqeBIeihRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Njhyah4w5eLwN27bjdElqLB32yZUySfvQZx9z02ToHJu+Cj69r+4paqDllNVLKgJ0X
         sUvqEP0kIYG30NK/Vm8evkNia38eTSFXsJtIoFTyLMIiDjU0avXN2vGT0+6ZvqvplKSB
         B/L2Ci7b4hcABisLetRWJht7chy1Sou/6Ubtc=
Received: by 10.143.178.10 with SMTP id f10mr2101255wfp.104.1277558868252;
        Sat, 26 Jun 2010 06:27:48 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.27.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:27:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149744>

Since we need to support the syntax like:
-L n1,m1 path1 -L n2,m2 path2.

So, make the parse-options API not stop with a
non-option, but report the status and go on parsing
the following.

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
1.7.1.577.g36cf0.dirty
