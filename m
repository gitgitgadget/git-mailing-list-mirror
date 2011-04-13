From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] handle_alias: provide GIT_CWD to !alias
Date: Wed, 13 Apr 2011 15:05:20 +0200
Message-ID: <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net>
References: <4DA59B27.50506@ge.infn.it>
Cc: Matej Batic <matej.batic@ge.infn.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9zlD-0003iS-Hr
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 15:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922Ab1DMNF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 09:05:26 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56693 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707Ab1DMNFZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 09:05:25 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 423AF20DEB;
	Wed, 13 Apr 2011 09:05:25 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 13 Apr 2011 09:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=XaRebxbC0CvAhH3Xggfjaoed4gs=; b=cu+PvVK7aDJEKBYSux9JiUURZt/CIcAKeTrPDgVJFZav0MzBzp48EhecAU/S/H3Z575gmM0XI/ru4wU1dw9YBaSB22erDB7lbbKF/iUulPre9qihd0U97zIJXnMROC7weRTul5BxUBTGUMjVF+IY+TnDLx5i2Kcst3ajmUWlM3o=
X-Sasl-enc: XvBs85zpYBbR5NEBu1ipecZWLiqUq0PM4A76E8xhZudS 1302699924
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BA4C3446EB8;
	Wed, 13 Apr 2011 09:05:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc0.365.g23929a
In-Reply-To: <4DA59B27.50506@ge.infn.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171452>

Provide an environment variable GIT_CWD which contains the subdirectory
from which a !alias was called since these cd to the to level directory
before they are executed.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
RFC for lack of tests and doc.

I would say this is something realistic and useful which can be done now, no
matter how our efforts with !(top) and the like go.

 git.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index ef598c3..c8b9189 100644
--- a/git.c
+++ b/git.c
@@ -179,6 +179,8 @@ static int handle_alias(int *argcp, const char ***argv)
 		if (alias_string[0] == '!') {
 			const char **alias_argv;
 			int argc = *argcp, i;
+			struct strbuf sb = STRBUF_INIT;
+			const char *env[2];
 
 			commit_pager_choice();
 
@@ -189,7 +191,13 @@ static int handle_alias(int *argcp, const char ***argv)
 				alias_argv[i] = (*argv)[i];
 			alias_argv[argc] = NULL;
 
-			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
+			strbuf_addstr(&sb, "GIT_CWD=");
+			if (subdir)
+				strbuf_addstr(&sb, subdir);
+			env[0] = sb.buf;
+			env[1] = NULL;
+			ret = run_command_v_opt_cd_env(alias_argv, RUN_USING_SHELL, NULL, env);
+			strbuf_release(&sb);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
-- 
1.7.5.rc0.365.g23929a
