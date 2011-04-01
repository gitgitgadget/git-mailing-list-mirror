From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/4] builtin/log.c: separate default and setup of cmd_log_init()
Date: Fri,  1 Apr 2011 11:20:31 +0200
Message-ID: <3872d568e82874257c0bce931ef3051b96914671.1301649372.git.git@drmicha.warpmail.net>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 11:24:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5aam-0001Hg-IK
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab1DAJYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 05:24:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:48431 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754772Ab1DAJYK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:24:10 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6215C208B3;
	Fri,  1 Apr 2011 05:24:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 01 Apr 2011 05:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Mi6RyljfTSqaklD0YTwe3Pf2UE0=; b=IaOd+WV0U48p80mn0ssZfg3gkVtYCBL8aIwjVm+/mEm0a0hZoji9aL2KWV2rvBxnBNtGyV7fyxWd0fAzJTWaMtpVDLrWQxi+xfwMEtQ0OB162TYy/1PzFHLsNklP0xbr67ljokwqXdpwfa+JIAuKZFzzYvuH2EqcaRMvggpH0Vc=
X-Sasl-enc: iZGWS+ZZGCT3MNCVZ39j+3u5a4mQPnIj89FmkGbZc6zf 1301649849
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E98B9444F76;
	Fri,  1 Apr 2011 05:24:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1301649372.git.git@drmicha.warpmail.net>
References: <cover.1301649372.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170567>

cmd_log_init() sets up some default rev options and then calls
setup_revisions(), so that a caller cannot set up own defaults: Either
they get overriden by cmd_log_init() (if set before) or they override
the command line (if set after). We even complain about this in a
comment to cmd_log_reflog().

Therefore, separate the two steps so that one can still call
cmd_log_init() or, alternatively, cmd_log_init_defaults() followed by
cmd_log_init_finish() (and set defaults in between).

No functional change so far.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9db43ed..f585209 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -49,13 +49,8 @@ static int parse_decoration_style(const char *var, const char *value)
 	return -1;
 }
 
-static void cmd_log_init(int argc, const char **argv, const char *prefix,
-			 struct rev_info *rev, struct setup_revision_opt *opt)
+static void cmd_log_init_defaults(struct rev_info *rev)
 {
-	int i;
-	int decoration_given = 0;
-	struct userformat_want w;
-
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	if (fmt_pretty)
@@ -68,7 +63,14 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 
 	if (default_date_mode)
 		rev->date_mode = parse_date_format(default_date_mode);
+}
 
+static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
+			 struct rev_info *rev, struct setup_revision_opt *opt)
+{
+	int i;
+	int decoration_given = 0;
+	struct userformat_want w;
 	/*
 	 * Check for -h before setup_revisions(), or "git log -h" will
 	 * fail when run without a git directory.
@@ -128,6 +130,13 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	setup_pager();
 }
 
+static void cmd_log_init(int argc, const char **argv, const char *prefix,
+			 struct rev_info *rev, struct setup_revision_opt *opt)
+{
+	cmd_log_init_defaults(rev);
+	cmd_log_init_finish(argc, argv, prefix, rev, opt);
+}
+
 /*
  * This gives a rough estimate for how many commits we
  * will print out in the list.
-- 
1.7.4.2.668.gba03a4
