From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 02/18] parse-options: add two helper functions
Date: Fri,  6 Aug 2010 00:11:41 +0800
Message-ID: <1281024717-7855-3-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:13:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh345-0000oB-Hw
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758951Ab0HEQMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:12:40 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758933Ab0HEQMj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:12:39 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so143837pwj.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DFEQmpZE9DXUWGFHXa6+UqjVeE5yr8Nl5AkBbjP9KV8=;
        b=d+TfRwNZPb780cRZNzZYSgN1kFlREGXmE8eY4NMxBkBiaueM5BKDK9ek846u71HM48
         kw6T6JAgu3RJnUQEwsVz5NF8Sqwszym3kwUV/F7W4CrY1k8v+EBXxnoe9NKZj8vpXJhc
         /vC+mwd8zRgxJEllh8tGARkUee1KbUIEtcRos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ifgruFXRz+B4BfOnpKZUYil8kCILLJVvUgaNAR3kxc8Yt6sk3yeUnFMpJhZJfdltod
         oc7JJ32zKPyJV++BKktTLA66uhwnt3o128jta8sdnXNxsbqwmpnOYMT1v0bZD4F+LFul
         Q1WyiHuRv7+sgQX6baOZcXUS3YrdOLTvbeqN4=
Received: by 10.142.73.3 with SMTP id v3mr447916wfa.255.1281024758859;
        Thu, 05 Aug 2010 09:12:38 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.12.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:12:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152671>

1. parse_options_current: get the current option/argument the API
   is dealing with;
2. parse_options_next: make the API to deal with the next
   option/argument.

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
1.7.2.20.g388bbb
