From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 01/22] parse-options: enhance STOP_AT_NON_OPTION
Date: Sat, 24 Jul 2010 23:13:33 +0800
Message-ID: <1279984434-28933-2-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:14:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgR8-0001aF-St
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab0GXPOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:14:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab0GXPOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:14:33 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so3932862pwi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=raUvEJeS5AXUBTGpLZ1QjKVbWX+fYOWNcbjnyEhqEHo=;
        b=CvUq1HZa2vC9HQIpyjss38wdk/Ia2HACOdATrddf/AywBC4xab681QS5/URX9/Pyte
         bTqOGKU/Xv37S+CFm61q/oJV47rgcX4SzAzKzd94iToorwTGiUh3jdLuHE7symHQvGsD
         SbhnwWwmEyMvAf2ureQ2FZAQpOVosRjwBPc+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fVYgMNRrmv4GtsvBymaDkWBLRd3IiwzsBfhHhPDvCHEzm+hBgzJ5l+hWb7WoirfWs4
         yEeMLtJbJe/RA927PJ0tFPyDSV4pNekFBWF+ZvEJJAMPVG1k17IftneaKWV2JhkAffm+
         fpBjppBE0fvoKWDs/A3kPrLP4vfLaU5O1N2vg=
Received: by 10.142.192.4 with SMTP id p4mr5951279wff.340.1279984472738;
        Sat, 24 Jul 2010 08:14:32 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.14.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:14:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151634>

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
1.7.0.2.273.gc2413.dirty
