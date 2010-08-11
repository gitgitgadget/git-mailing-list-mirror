From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 02/17] parse-options: add two helper functions
Date: Wed, 11 Aug 2010 23:03:27 +0800
Message-ID: <1281539022-31616-3-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:04:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCr8-0004pF-Ux
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab0HKPEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:04:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56122 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab0HKPE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:04:29 -0400
Received: by pzk26 with SMTP id 26so73597pzk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DejSW2DRaVDpAS7idqRobmbBPECsgo0WcIf6hT5fY6I=;
        b=Fphuca8WL415+7FOLFL8BXagxwBQLeAdRwpYfpwEWG11C2FLU2TTyeH/Z+Cz/T0EMY
         fvEHpOPRMncto+qQpOMAYRtw+knxm7RpWedkZdIAoqbXEw8QXM7lzdyVaxMjJkJODS12
         XCB7SIV7n5Ynd2ySeojjFOBKnWulckZWFQEVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L3TOflD9w0IToO5IU7Bm2R2nA08ZKHhHnbOXCQPdvfcaVYWW23jdVBEMcx2Eg97bbw
         ZUq+UlaHLuBCNjLenh5Wh18saZjzjYrVo57fwsmw9hh+rtv0Ph5n1mQMxX2OJ8fSthMO
         UKztaQT1Xv0T2jYKiA6vS5joeUa8bTqcWJq9I=
Received: by 10.114.112.18 with SMTP id k18mr22072238wac.133.1281539069454;
        Wed, 11 Aug 2010 08:04:29 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.04.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:04:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153241>

1. parse_options_current: get the current option/argument the API
   is dealing with;
2. parse_options_next: skip the current argument, moving to the
   next one. Unless 'keep' is set, discard the skipped argument
   from the final argument list.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 parse-options.c |   19 +++++++++++++++++++
 parse-options.h |    4 ++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cbb49d3..e0c3641 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -439,6 +439,25 @@ unknown:
 	return PARSE_OPT_DONE;
 }
 
+const char *parse_options_current(struct parse_opt_ctx_t *ctx)
+{
+	return ctx->argv[0];
+}
+
+int parse_options_next(struct parse_opt_ctx_t *ctx, int keep)
+{
+	if (ctx->argc <= 0)
+		return -1;
+
+	if (keep)
+		ctx->out[ctx->cpidx++] = ctx->argv[0];
+
+	ctx->argc--;
+	ctx->argv++;
+
+	return 0;
+}
+
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
 	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
diff --git a/parse-options.h b/parse-options.h
index 407697a..d3b1932 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -187,6 +187,10 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 			      const struct option *options,
 			      const char * const usagestr[]);
 
+extern const char *parse_options_current(struct parse_opt_ctx_t *ctx);
+
+extern int parse_options_next(struct parse_opt_ctx_t *ctx, int keep);
+
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
 extern int parse_options_concat(struct option *dst, size_t, struct option *src);
-- 
1.7.2.19.g79e5d
