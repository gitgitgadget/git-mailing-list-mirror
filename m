From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 02/13] parse-options: add two helper functions
Date: Wed, 30 Jun 2010 23:25:15 +0800
Message-ID: <1277911526-12105-2-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzD5-0007oi-Pe
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab0F3P2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:28:18 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50747 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab0F3P2R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:28:17 -0400
Received: by mail-pz0-f46.google.com with SMTP id 7so138278pzk.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cwV1AQyv2lDtzlT5vjL9TVBrnMcUvIoPW8Is6bvjbl0=;
        b=M3gN1WCCcSO5VsBXk1dqOFysKQQoS6YTup5A7lp3j8T/Bk9ByXnAIY60lE1BOwKEbm
         SWscEXeMKDbXXijR97EmPVfnE33UF/+zVIwC1kIY1zhXBeaeIxHe9Kyvo9KLymopkjwj
         N+UN4eGJq1ygAw+iiSy3Mp0yjxOMX6pchItks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UwSNjoTv3Q3iNGkHrUwSg4PWdh8carYaIMQ0gVHzUKhgKLmhZtFbgzDscZPOgUq8/b
         4t0nV3vbmzF3gelB9C5+fGyywc7pCbqIM95WzMYs9CtfyaFWiGMdqfU9menaL6pCAWY6
         5qxbIJNKIbVTF9O0zPTsiFrxjcNJdCPS6KDMk=
Received: by 10.115.58.4 with SMTP id l4mr9909159wak.11.1277911696825;
        Wed, 30 Jun 2010 08:28:16 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.28.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:28:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149965>

1. parse_options_current: get the current option/argument the API
   now is dealing with;
2. parse_options_next: make the API to deal with the next
   option/argument.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 parse-options.c |   19 +++++++++++++++++++
 parse-options.h |    4 ++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cbb49d3..4266bde 100644
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
+int parse_options_next(struct parse_opt_ctx_t *ctx, int retain)
+{
+	if (ctx->argc <= 0)
+		return -1;
+
+	if (retain == 1)
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
index 407697a..4791baa 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -187,6 +187,10 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 			      const struct option *options,
 			      const char * const usagestr[]);
 
+extern const char *parse_options_current(struct parse_opt_ctx_t *ctx);
+
+extern int parse_options_next(struct parse_opt_ctx_t *ctx, int retain);
+
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
 extern int parse_options_concat(struct option *dst, size_t, struct option *src);
-- 
1.7.0.2.273.gc2413.dirty
