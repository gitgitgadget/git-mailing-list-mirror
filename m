From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 01/13] parse-options: stop when encounter a non-option
Date: Wed, 30 Jun 2010 23:25:14 +0800
Message-ID: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:28:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzCt-0007cS-1M
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673Ab0F3P2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:28:05 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50747 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab0F3P2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:28:03 -0400
Received: by pzk7 with SMTP id 7so138278pzk.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MJ4vqbImFBuwBhrW3KrVUp+oRhV5eb/pVr8pxPsnNBM=;
        b=bLVHxJa4+GaFINiAiMK6pvIv+sQOJfWYMYftbQb9DZ/AR+Rrgr01nOHlxB049t2V9K
         plVPjiGhA812Wg7KfhVXIuEQU4ocGxBB5kBECytnc4iS5SLnLNg2e49oxU3rtZFBYd45
         uXK5f2chOHHcYXhkA42c9IWj5xdwYz/nR1MkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qyOLrXZb5bwhcMDsB6g2jhP/CXyMkVUG+QXUpBeXaB5HjrwusUhZzuodPahNvzb3Qh
         iRmlSEBM6NJ60IkL1nErKM5qdgIIZ00/KbdZlSU3mXLhEc4LPqQ13rDIr1e+XnQI5Xgv
         lkQ6psKHuZEallD4TIN7BiX+KPmFVSAfbkDMY=
Received: by 10.115.114.21 with SMTP id r21mr9979963wam.132.1277911680646;
        Wed, 30 Jun 2010 08:28:00 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.27.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:27:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149964>

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
1.7.0.2.273.gc2413.dirty
