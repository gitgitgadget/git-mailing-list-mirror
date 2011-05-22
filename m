From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/3] git: Remove handling for GIT_PREFIX
Date: Sun, 22 May 2011 02:57:08 -0700
Message-ID: <1306058229-93800-2-git-send-email-davvid@gmail.com>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
 <1306058229-93800-1-git-send-email-davvid@gmail.com>
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 11:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO5Pg-0000m7-RO
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 11:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab1EVJ5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 05:57:20 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:62411 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1EVJ5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 05:57:17 -0400
Received: by pxi16 with SMTP id 16so3354377pxi.4
        for <git@vger.kernel.org>; Sun, 22 May 2011 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hR5ST9fxwa9RbjaB2Ra8nrO2zyx5886aAqBFMBeDREc=;
        b=iFfJEUN2ySa4xcOZGxGFn2Og2rXo+Xv4mrOJaL//EyDfDj/VDETz1R4aceGMzZ1Bpy
         1ta4BS3ueaegaYLjcogg4jB6+tXReegq84VpsgywyhUXN4prFD9AQCcjFTGrw27JD55d
         fiUgMiAQXHChfSS2snqFwhk7oq8pW0UWHRcs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pjVH94khln7nY/VE1t5qPjUc3oe2aSpdpayvlEtbGg0vY23Ys0zO7NNX7luDaGKMVp
         0mQXtV7BEWfHgIcq8cDEtyT8HvaWY63pdJu/lIrpcbiXVpNMT19nPN1l63LI5jZCF090
         kEp31WPfwGgfwWfnCqpt+QL9F+wjA1wvi3NE4=
Received: by 10.142.56.3 with SMTP id e3mr612263wfa.392.1306058237308;
        Sun, 22 May 2011 02:57:17 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 25sm4866325wfb.22.2011.05.22.02.57.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 May 2011 02:57:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.317.g391b14
In-Reply-To: <1306058229-93800-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174188>

handle_alias() no longer needs to set GIT_PREFIX since it is defined
in setup_git_directory_gently().  Remove the duplicated effort and use
run_command_v_opt() since there is no need to setup the environment.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/git.c b/git.c
index a5ef3c6..60a9403 100644
--- a/git.c
+++ b/git.c
@@ -185,8 +185,6 @@ static int handle_alias(int *argcp, const char ***argv)
 		if (alias_string[0] == '!') {
 			const char **alias_argv;
 			int argc = *argcp, i;
-			struct strbuf sb = STRBUF_INIT;
-			const char *env[2];
 
 			commit_pager_choice();
 
@@ -197,13 +195,7 @@ static int handle_alias(int *argcp, const char ***argv)
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
1.7.5.2.317.g391b14
