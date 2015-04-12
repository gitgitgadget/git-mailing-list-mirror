From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 6/7] git-config: replace use of home_config_paths()
Date: Sun, 12 Apr 2015 15:46:11 +0800
Message-ID: <1428824772-8736-6-git-send-email-pyokagan@gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 09:47:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhCbw-0004qZ-GP
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 09:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbbDLHrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 03:47:18 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35765 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbDLHrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 03:47:15 -0400
Received: by pddn5 with SMTP id n5so71683968pdd.2
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hsar5tG96IW7shPPcbvSRADad3+0YfkpIjAPhy3y1Us=;
        b=UoYEYXI43zVN+pv4dF6z0/Nl772n+gwg7nI3d6htzvoj2tKXHhK1g5te4cwtKV3tBQ
         KHSGKgJySVwv7X1uKMF48CqCo4nWLNijd7mrleOcvo3/m/L+tLmteqDJz/8mPoXuhG5N
         qXRSMV1RKIBYWQNd/QIl/PsMDlqR5CPbabFEOMnboUcMF2mfKCkOZOUbKAmX+O2HNNpF
         YxZHu/p1zqD4Vx9Igq/cWMLydLFI0wbkabQtB105CRrpSqm30nwOt/8v5ds1qXW9l12f
         svyZP6KOFqErzQPMUQCDMPFRtWvuIpwMesPSMUDyANuijVpClpmYbHyU/n38n3+Eba5k
         ECww==
X-Received: by 10.70.47.138 with SMTP id d10mr16216655pdn.137.1428824835156;
        Sun, 12 Apr 2015 00:47:15 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id ei17sm3783153pac.20.2015.04.12.00.47.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Apr 2015 00:47:14 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267047>

Since home_config_paths() combines distinct functionality already
implemented by expand_user_path() and xdg_config_home(), and hides the
home config file path ~/.gitconfig. Make the code more explicit by
replacing the use of home_config_paths() with expand_user_path() and
xdg_config_home().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
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
