From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] setup: support setting GIT_DIR=.git file
Date: Wed, 27 Oct 2010 21:58:10 +0700
Message-ID: <1288191496-31176-1-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7SX-0002wu-C3
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761078Ab0J0O6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:58:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48504 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761067Ab0J0O6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:58:21 -0400
Received: by gxk23 with SMTP id 23so433771gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=YPPIYpjxiokY8dx6NBJSE+AKEywH4hPnEKLBk3RXf1Q=;
        b=nW8ghTP12pP1uxqGNgN8ssGK2CHXgsSt714i2hAsHg1zfeLXnTc/6d/rjzXy2c23uq
         RDBdVyhgxCLzg/wXwgP0OBLlzu4Kwyxtv2vMuKLupjdigrqvWI+GkcIJDqAVLgpW5tAn
         3PeoB+WHJp1ksRhw9E2pk035c5JOGKy+7pweo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hbxX+KZmHU3SE/va/ufFMrWmL3jZ+ikSaUUHAIAY1pBEBC57jY2hpgchNHfEIrxlTc
         LNxChlgBwk6RlNk/3lpE+OrmC6YAhv0on+R+pz/ZbplE5N6hGz47zFminTVNhZqw7ND2
         yWQ0PZN/tMcvBc/p3HqKf1MMt/JS5qijzAdo4=
Received: by 10.150.182.11 with SMTP id e11mr9908468ybf.210.1288191501155;
        Wed, 27 Oct 2010 07:58:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id f46sm7721825yhc.17.2010.10.27.07.58.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:58:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:58:18 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160076>

---
 setup.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index a3b76de..2e7387d 100644
--- a/setup.c
+++ b/setup.c
@@ -317,17 +317,20 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 				const char *work_tree_env, int *nongit_ok)
 {
 	static char buffer[1024 + 1];
-	const char *retval;
+	const char *retval, *gitfile;
 
 	if (PATH_MAX - 40 < strlen(gitdirenv))
 		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-	if (!is_git_directory(gitdirenv)) {
+	gitfile = read_gitfile_gently(gitdirenv);
+	if (!gitfile && !is_git_directory(gitdirenv)) {
 		if (nongit_ok) {
 			*nongit_ok = 1;
 			return NULL;
 		}
 		die("Not a git repository: '%s'", gitdirenv);
 	}
+	if (gitfile)
+		set_git_dir(gitfile);
 	if (!work_tree_env) {
 		retval = set_work_tree(gitdirenv);
 		/* config may override worktree */
@@ -341,7 +344,8 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 			get_git_work_tree());
 	if (!retval || !*retval)
 		return NULL;
-	set_git_dir(make_absolute_path(gitdirenv));
+	if (!gitfile)
+		set_git_dir(make_absolute_path(gitdirenv));
 	if (chdir(work_tree_env) < 0)
 		die_errno ("Could not chdir to '%s'", work_tree_env);
 	strcat(buffer, "/");
-- 
1.7.0.2.445.gcbdb3
