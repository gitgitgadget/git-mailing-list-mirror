From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] setup: skip core.worktree if GIT_DIR is not set
Date: Wed, 27 Oct 2010 21:58:13 +0700
Message-ID: <1288191496-31176-4-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:59:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Sw-000382-4V
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761116Ab0J0O6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:58:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46831 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab0J0O6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:58:43 -0400
Received: by ywk9 with SMTP id 9so451893ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=tJRSXk9XPnyoK4uLFFl+STIcuD4LWHCziXSBSCitkk0=;
        b=X4wLoSrr04LAWTPpBJh+6wRJihiTg/LmQoLJji60rlOFSP3Zsu0y/vfGntkCUaZm9H
         Ef3jYSa5CDNkRBSLb5cxd3YCDCHcJ5EGHW64nxx9ek407/YGcOHmUvGiB2xH7laZa/bM
         hPPNexIWe47wn/Athw9mZeIv3qg5phYGAPDfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U6Hnzz3GAquu7jXUqRYA5ZNz51xjlxSvSwQW2UrH4u1Ot3yAwYIIqspERDgefWMuLr
         3eiOVlDa12GVjSB4b5FBe3hPcwzD+tdOgJxEadp9WPK7IniuocuM/y3luXBMHfmJQzTj
         gEXROOVF+kYpKrkJT3Ea2VxAhol9+XKFoVeo4=
Received: by 10.151.27.12 with SMTP id e12mr4806767ybj.332.1288191522827;
        Wed, 27 Oct 2010 07:58:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id g9sm7704972yha.6.2010.10.27.07.58.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:58:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:58:40 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160078>

---
 setup.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index bbb430a..e8273c3 100644
--- a/setup.c
+++ b/setup.c
@@ -4,7 +4,7 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
-static int has_core_worktree, has_core_bare;
+static int has_core_worktree, has_core_bare, has_git_dir_env;
 
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
@@ -460,8 +460,10 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	 * validation.
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-	if (gitdirenv)
-		return setup_explicit_git_dir(gitdirenv, work_tree_env, nongit_ok);
+	if (gitdirenv) {
+		has_git_dir_env = 1;
+		return setup_explicit_git_dir(gitdirenv, work_tree_env, nongit_o, nongit_ok);
+	}
 	else {
 		/* prevent get_git_work_tree() from using it because GIT_DIR is not set */
 		if (work_tree_env)
@@ -593,6 +595,8 @@ int check_repository_format_version(const char *var, const char *value, void *cb
 			has_core_bare = 1;
 		}
 	} else if (strcmp(var, "core.worktree") == 0) {
+		if (!has_git_dir_env) /* only valid when GIT_DIR is set */
+			return 0;
 		if (!value)
 			return config_error_nonbool(var);
 		free(git_work_tree_cfg);
-- 
1.7.0.2.445.gcbdb3
