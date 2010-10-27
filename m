From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] setup: rework core.worktree
Date: Wed, 27 Oct 2010 21:58:14 +0700
Message-ID: <1288191496-31176-5-git-send-email-pclouds@gmail.com>
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
	id 1PB7Sw-000382-S1
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761105Ab0J0O65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:58:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45214 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760905Ab0J0O6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:58:55 -0400
Received: by gwj21 with SMTP id 21so433090gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=LxvHWMwNePglEjBME4fTYGI2Th4ygEPCZVrUOtE2lEc=;
        b=vNVm9Wh6RNMuq6wyGLdTtPp/IbGBSGqqA9kEyY1BbyY70ep3yjQVn16997nbotoPze
         jf7V8UMldq79/s1CyfdN4JR8RCeFpmQGCXtcqlmL5ACW44ha+tqbKbznp55R1N8mLxyY
         zuQUj5qZjLkpVl/L7yun3xAvUg3YRvoN2w288=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CL80DPkwyojDxZ8SixDOvhg7kGOdbfZHfA3bJO7McEW2z+BW+7ZwT+fR/8/G2qyycQ
         ar3gzb5tsdBoPrmS5BfOdk138g72Im8KmCPIeZDqhcgwVN0t9fJ1p7+b7a2ilYivz5hH
         ZDIxwwfN5U7MmJyTxndg5juQGnkZ24iNMZatA=
Received: by 10.150.219.10 with SMTP id r10mr718596ybg.135.1288191534373;
        Wed, 27 Oct 2010 07:58:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id j64sm7715322yha.24.2010.10.27.07.58.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:58:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:58:47 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160080>

Now that core.worktree can only be effective inside
setup_explicit_git_dir, move the code up from setup_git_directory().
---
 setup.c |   48 +++++++++++++++++-------------------------------
 1 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index e8273c3..1a4765d 100644
--- a/setup.c
+++ b/setup.c
@@ -323,7 +323,9 @@ const char *read_gitfile_gently(const char *path)
 }
 
 static const char *setup_explicit_git_dir(const char *gitdirenv,
-				const char *work_tree_env, int *nongit_ok)
+					  const char *work_tree_env,
+					  char *cwd, int len,
+					  int *nongit_ok)
 {
 	static char buffer[1024 + 1];
 	const char *retval, *gitfile;
@@ -340,23 +342,21 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	}
 	if (gitfile)
 		set_git_dir(gitfile);
-	if (!work_tree_env) {
-		retval = set_work_tree(gitdirenv);
-		/* config may override worktree */
-		if (check_repository_format_gently(nongit_ok))
-			return NULL;
-		return retval;
-	}
+	if (!work_tree_env)
+		set_work_tree(gitdirenv);
+
+	/* config may override worktree */
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
+
 	retval = get_relative_cwd(buffer, sizeof(buffer) - 1,
-			get_git_work_tree());
+				  get_git_work_tree());
 	if (!retval || !*retval)
 		return NULL;
 	if (!gitfile)
 		set_git_dir(make_absolute_path(gitdirenv));
-	if (chdir(work_tree_env) < 0)
-		die_errno ("Could not chdir to '%s'", work_tree_env);
+	if (chdir(get_git_work_tree()) < 0)
+		die_errno ("Could not chdir to '%s'", get_git_work_tree());
 	strcat(buffer, "/");
 	return retval;
 }
@@ -454,6 +454,10 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	if (nongit_ok)
 		*nongit_ok = 0;
 
+	if (!getcwd(cwd, sizeof(cwd)-1))
+		die_errno("Unable to read current working directory");
+	offset = len = strlen(cwd);
+
 	/*
 	 * If GIT_DIR is set explicitly, we're not going
 	 * to do any discovery, but we still do repository
@@ -462,7 +466,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
 		has_git_dir_env = 1;
-		return setup_explicit_git_dir(gitdirenv, work_tree_env, nongit_o, nongit_ok);
+		return setup_explicit_git_dir(gitdirenv, work_tree_env, cwd, len, nongit_ok);
 	}
 	else {
 		/* prevent get_git_work_tree() from using it because GIT_DIR is not set */
@@ -470,9 +474,6 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 			unsetenv(GIT_WORK_TREE_ENVIRONMENT);
 	}
 
-	if (!getcwd(cwd, sizeof(cwd)-1))
-		die_errno("Unable to read current working directory");
-
 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
 	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
 		ceil_offset = 1;
@@ -488,7 +489,6 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	 * - ../../.git/
 	 *   etc.
 	 */
-	offset = len = strlen(cwd);
 	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
 	if (one_filesystem)
 		current_device = get_device_or_die(".", NULL);
@@ -623,19 +623,5 @@ int check_repository_format(void)
  */
 const char *setup_git_directory(void)
 {
-	const char *retval = setup_git_directory_gently(NULL);
-
-	/* If the work tree is not the default one, recompute prefix */
-	if (inside_work_tree < 0) {
-		static char buffer[PATH_MAX + 1];
-		char *rel;
-		if (retval && chdir(retval))
-			die_errno ("Could not jump back into original cwd");
-		rel = get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
-		if (rel && *rel && chdir(get_git_work_tree()))
-			die_errno ("Could not jump to working directory");
-		return rel && *rel ? strcat(rel, "/") : NULL;
-	}
-
-	return retval;
+	return setup_git_directory_gently(NULL);
 }
-- 
1.7.0.2.445.gcbdb3
