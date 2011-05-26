From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/3] git: Remove handling for GIT_PREFIX
Date: Wed, 25 May 2011 20:37:13 -0700
Message-ID: <1306381034-44190-2-git-send-email-davvid@gmail.com>
References: <1306381034-44190-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 05:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPRO5-0003ma-UI
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 05:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327Ab1EZDhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 23:37:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51014 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab1EZDhW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 23:37:22 -0400
Received: by pvg12 with SMTP id 12so128905pvg.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 20:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=R0Wjksg7lIhHk1nIKgVo/YJo6kYvLa51qcHTQ19cla0=;
        b=d2JPIfW8HnStJ9CkSIHuwKFuwvifeiOxqSSV7dUEkn83pSviLRGw8AVLxAYwUYznY3
         /3V46fJIGdeDbwojLyU5ARW/TNAOxvmPN9wMclBfPjY5DnIs0caZHZr0z7Vs6HXvD1V0
         mQkxO1PzjQs6/nDAqKE4/5IDl2cLC6NXNahtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s+ekQbRuEauFapZgTCRTlXjnM29foJl+GysMjdA3SmNFZwLyV9Vg6AkvQ8oEP2bprj
         ugJijbgw5vFkXOxujrVVO2nOFuMsHG4zbf7930jE9jLU/2x/zfGh13KbZ8oIAeEXsSgA
         SQU4F18UnUqfshZnJIuerVk5Ia8FRcBbB1O+Y=
Received: by 10.68.6.229 with SMTP id e5mr138330pba.21.1306381042548;
        Wed, 25 May 2011 20:37:22 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id y3sm577909pbg.16.2011.05.25.20.37.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 20:37:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.660.g9f46
In-Reply-To: <1306381034-44190-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174491>

handle_alias() no longer needs to set GIT_PREFIX since it is defined
in setup_git_directory_gently().  Remove the duplicated effort and use
run_command_v_opt() since there is no need to setup the environment.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This patch is unchanged.

 git.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/git.c b/git.c
index 89721d4..8828c18 100644
--- a/git.c
+++ b/git.c
@@ -183,8 +183,6 @@ static int handle_alias(int *argcp, const char ***argv)
 		if (alias_string[0] == '!') {
 			const char **alias_argv;
 			int argc = *argcp, i;
-			struct strbuf sb = STRBUF_INIT;
-			const char *env[2];
 
 			commit_pager_choice();
 
@@ -195,13 +193,7 @@ static int handle_alias(int *argcp, const char ***argv)
 				alias_argv[i] = (*argv)[i];
 			alias_argv[argc] = NULL;
 
-			strbuf_addstr(&sb, "GIT_PREFIX=");
-			if (subdir)
-				strbuf_addstr(&sb, subdir);
-			env[0] = sb.buf;
-			env[1] = NULL;
-			ret = run_command_v_opt_cd_env(alias_argv, RUN_USING_SHELL, NULL, env);
-			strbuf_release(&sb);
+			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
-- 
1.7.5.2.660.g9f46
