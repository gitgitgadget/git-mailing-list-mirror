From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 01/18] parse-options: enhance STOP_AT_NON_OPTION
Date: Fri,  6 Aug 2010 00:11:40 +0800
Message-ID: <1281024717-7855-2-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh343-0000oB-TR
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758945Ab0HEQMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:12:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758933Ab0HEQMf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:12:35 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so143837pwj.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gyshqiTzpx1SyV4Tr4LqQ+dCR8YaZlNfxGsa2qdD+1o=;
        b=uGtmaXR55svg9GLawFRqF5rT20HJuP3czy6UXvUAJnnZBT7qWXgM/U1KcPlvfPMsj+
         877T31NipAKg7MZYYmOlPi1+KW38wmGMRGelLDj7keQ3pT5E3lJf8bl1mF+ItcZJnRQs
         bYyYdJSM9IiYWkEmmdSVZEFv+XfF9osJ4YtVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F9Ua7sXP/u41nO/ggulKorXXB2K0BxKK3iaGr+j8a1uwZaYT3zp/lQ2RIPJsCBnfMC
         618c5yjva0qZFOkpbI6bZE3Kjh8rDey6qtBNRu0fEwEU9h6//OCdoE8bEtFlFS+kZPhm
         gP+Zrpo0dyUyxeF8FTAMhN+T0LjN7zmqU/5JE=
Received: by 10.142.200.21 with SMTP id x21mr9316637wff.207.1281024754934;
        Thu, 05 Aug 2010 09:12:34 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.12.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:12:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152668>

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
1.7.2.20.g388bbb
