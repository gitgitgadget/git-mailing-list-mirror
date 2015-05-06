From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 6/7] git-config: replace use of home_config_paths()
Date: Wed,  6 May 2015 16:01:03 +0800
Message-ID: <1430899264-18447-5-git-send-email-pyokagan@gmail.com>
References: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 10:02:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpuHd-00083k-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 10:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbbEFICR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 04:02:17 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36072 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbbEFICI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 04:02:08 -0400
Received: by pdea3 with SMTP id a3so2489246pde.3
        for <git@vger.kernel.org>; Wed, 06 May 2015 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pi1RcYI9RgYzCeI7DTI58+f4UI9UTNUEZcMo3nqu7qk=;
        b=wXGs0POFEfmBYDpU+HwZMStz5nr38voqZ3CS0wowOtsUEMknX0IYRdFi8VCB8XFCnE
         eph89838MF+f0ilSOnU/2vhovDVdIVCYrKutihN7nGv99dih6RNYMxUniep3k05buPF4
         gQyYiomDn7l6sBFRV4USPWdOM8mmmD1oi1AGJmv0Mq8WDJt6OeINyoru2C1Ivc+QktTS
         JJG6KPJgFtiRnLc2k7Nd67s57EDczWyeN5e+2F8L2LDVCs9UsZLdia+tMruhqQDDjAuh
         u1qx4XCAh2nLozhGjVlpweI8ErY9vxiF7+t1eZkNVMdFVFFEpwUdSZ3IDPGkgnLKPrqJ
         3ASA==
X-Received: by 10.66.116.132 with SMTP id jw4mr59150991pab.10.1430899327932;
        Wed, 06 May 2015 01:02:07 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id cy5sm1074571pdb.85.2015.05.06.01.02.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 May 2015 01:02:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
In-Reply-To: <20150421040627.GA5415@yoshi.chippynet.com>
References: <20150421040627.GA5415@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268460>

Since home_config_paths() combines distinct functionality already
implemented by expand_user_path() and xdg_config_home(), and hides the
home config file path ~/.gitconfig. Make the code more explicit by
replacing the use of home_config_paths() with expand_user_path() and
xdg_config_home().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Re-sending the patch series. There are no changes.

 builtin/config.c | 6 ++----
 config.c         | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d32c532..5e61f4a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -488,10 +488,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (use_global_config) {
-		char *user_config = NULL;
-		char *xdg_config = NULL;
-
-		home_config_paths(&user_config, &xdg_config, "config");
+		char *user_config = expand_user_path("~/.gitconfig");
+		char *xdg_config = xdg_config_home("config");
 
 		if (!user_config)
 			/*
diff --git a/config.c b/config.c
index 66c0a51..3a619da 100644
--- a/config.c
+++ b/config.c
@@ -1185,10 +1185,8 @@ int git_config_system(void)
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
 	int ret = 0, found = 0;
-	char *xdg_config = NULL;
-	char *user_config = NULL;
-
-	home_config_paths(&user_config, &xdg_config, "config");
+	char *xdg_config = xdg_config_home("config");
+	char *user_config = expand_user_path("~/.gitconfig");
 
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
-- 
2.1.4
