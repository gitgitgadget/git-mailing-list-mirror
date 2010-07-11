From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v3 01/13] parse-options: stop when encounter a non-option
Date: Sun, 11 Jul 2010 14:18:49 +0800
Message-ID: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXpue-0001wM-Tj
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121Ab0GKGVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:21:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40135 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0GKGVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:21:10 -0400
Received: by pwi5 with SMTP id 5so1399328pwi.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pv2WfZH0AY8YKh0LbJPiDgRRvKQ56K8A/kC94V2vokw=;
        b=e4DpVrLEqyQVXfCLBHoJeVJH9AeFnox6/Pm9FaNLqV1ykWykxJOgmvCOo0qGDCNM2N
         J/6ppdHtbuaILYO2CovaQkgiqDl54NmnFY6SS788R6K3BFiffl5gKypqHEWdujwWD73p
         i0H2/Gb2twITkWBut3HGbn+cojDNBcPyu1f+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wOM0tGUih08xUtXd/tWK/iizEPPgansC82/tpAFBXFO61anO59XoE8bU8sTJ9htVZ/
         NF4BEHlEvsXQAYqr7FxbSPhgSJZc9lrgc6gzAC617g4lN2j7EWv6hTpAJKltZRUzcqm+
         LvmCYnqNv5+maIT5/3mQQgy8UNb6tnwDWj29g=
Received: by 10.142.172.15 with SMTP id u15mr14257097wfe.324.1278829269759;
        Sat, 10 Jul 2010 23:21:09 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id c15sm2927911rvi.11.2010.07.10.23.21.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:21:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150744>

We support the syntax like:
-L n1,m1 pathspec1 -L n2,m2 pathspec2.

Make the parse-options API not stop when encounter a
non-option argument, report the status and go on parsing
the remain options.

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
