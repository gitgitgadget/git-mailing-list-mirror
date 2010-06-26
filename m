From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 02/12] parse-options: add two helper functions
Date: Sat, 26 Jun 2010 06:27:27 -0700
Message-ID: <1277558857-23103-3-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVYK-000268-2M
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab0FZNf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:35:57 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63539 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107Ab0FZNf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:35:56 -0400
Received: by pxi8 with SMTP id 8so1128918pxi.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QiWGwj2dlpQLdP+QJDuKBAcapjc6SgrxZRJfXRrbcZQ=;
        b=A6bbnoujiNnHkGfZYOR63kI9x0qM0gEp4znlW1hSI/OjiDsXDq2sHEmrxAAkErFFIl
         lp6GjrwK7M9cLP5Reep1FDGjqYGY3FAIG3z22Z7T+ojDYeam0EOxfTbaUdM/lC60h/aG
         wRUu6CCR+vXbZmYqZVr/smhImEnLuvO2cnKOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZJ6rsSgmUN8KEcC0xUPjbLyhf39x19Do7IrdQutEWSLAgzNMzHHfCr/VwAkws1rPfA
         bL75ih6vjzuwbQepnTzBmlM1b7bm8/H6DeWsCYHLyeruIwmZ3Zf4JbclG+j+0dGCQJml
         qKCbIU8l5hxtPwLaxJD/U91asfcD8bfJz9BY4=
Received: by 10.143.25.10 with SMTP id c10mr2007411wfj.77.1277558872001;
        Sat, 26 Jun 2010 06:27:52 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.27.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:27:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149755>

1. parse_options_current: get the current option/argument the API
   now is dealing with;
2. parse_options_next: make the API to deal with the next
   option/argument.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 parse-options.c |   21 +++++++++++++++++++++
 parse-options.h |    4 ++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cbb49d3..013dbdb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -439,6 +439,27 @@ unknown:
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
+	{
+		ctx->out[ctx->cpidx++] = ctx->argv[0];
+	}
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
1.7.1.577.g36cf0.dirty
