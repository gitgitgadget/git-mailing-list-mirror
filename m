From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] setup: do not allow core.{bare,worktree} set at the same time
Date: Wed, 27 Oct 2010 21:58:12 +0700
Message-ID: <1288191496-31176-3-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:59:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Sv-000382-KI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760951Ab0J0O6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:58:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58367 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761057Ab0J0O6g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:58:36 -0400
Received: by yxk8 with SMTP id 8so73668yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=zpg4BTzmV3AojMnYlXIPmKPWACCV4+M1AJih7iZfX20=;
        b=ZjpouyUJuDpD4rT1fa76kZONryDh8+AZp75BLja0iSKlvBZjlqtzXRei4dNhnGsIBQ
         RQRtTtxl4rgexLpX+dZxtrzsyuiO8k+l+D1MSnX3XFn9WmTh+q0VP7dbr4kJs0DFP6O4
         K8NwWK2lYbFRYQk7ZJFZjDYarGAU6AcQ3/MDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pN2ooZdlyyDtm8JPVsKhGaSRC8H2FSuJXF/Mmpxgx6R+Ju8T4pWDDqONyjQ7Rt6Dkg
         30r8gYdYqcgCLXkEfVUl6DV4xWbz1WHJaJzottocmS/GHDiMirb1gJUyTrJ18KMT27J5
         CV27vd3vArkNozWHygH2uYu0ivp6sg2MNphws=
Received: by 10.100.9.3 with SMTP id 3mr7984469ani.49.1288191515527;
        Wed, 27 Oct 2010 07:58:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id t23sm11926830ano.27.2010.10.27.07.58.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:58:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:58:33 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160079>

---
 setup.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 992a944..bbb430a 100644
--- a/setup.c
+++ b/setup.c
@@ -4,6 +4,8 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
+static int has_core_worktree, has_core_bare;
+
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
@@ -245,6 +247,7 @@ void setup_work_tree(void)
 
 static int check_repository_format_gently(int *nongit_ok)
 {
+	has_core_worktree = has_core_bare = 0;
 	git_config(check_repository_format_version, NULL);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
@@ -256,6 +259,12 @@ static int check_repository_format_gently(int *nongit_ok)
 		*nongit_ok = -1;
 		return -1;
 	}
+	if (has_core_worktree && has_core_bare) {
+		if (!nongit_ok)
+			die("core.bare and core.worktree do not make sense");
+		*nongit_ok = -1;
+		return -1;
+	}
 	return 0;
 }
 
@@ -579,14 +588,20 @@ int check_repository_format_version(const char *var, const char *value, void *cb
 		shared_repository = git_config_perm(var, value);
 	else if (strcmp(var, "core.bare") == 0) {
 		is_bare_repository_cfg = git_config_bool(var, value);
-		if (is_bare_repository_cfg == 1)
+		if (is_bare_repository_cfg == 1) {
 			inside_work_tree = -1;
+			has_core_bare = 1;
+		}
 	} else if (strcmp(var, "core.worktree") == 0) {
 		if (!value)
 			return config_error_nonbool(var);
 		free(git_work_tree_cfg);
 		git_work_tree_cfg = xstrdup(value);
 		inside_work_tree = -1;
+
+		/* GIT_WORK_TREE overrides core.worktree */
+		if (!getenv(GIT_WORK_TREE_ENVIRONMENT))
+			has_core_worktree = 1;
 	}
 	return 0;
 }
-- 
1.7.0.2.445.gcbdb3
