From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 02/26] setup_git_directory*: Explicitly set git dir
Date: Tue, 16 Feb 2010 23:04:53 +0700
Message-ID: <1266336317-607-3-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:15:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ5H-0005aD-6i
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165Ab0BPQP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:15:28 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:36915 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148Ab0BPQP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:15:27 -0500
Received: by gxk27 with SMTP id 27so89623gxk.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TTiFQAIC03uv8NOoCwn6xc88EOQlw4HcCZ5jSYnim2I=;
        b=YRTlZSCoLqkRou4CzTglTG8V4WYItNEzVUnug5PY4RHWBQjXGHL9nzOJ5yf1GgeYfP
         9lg2m5YcDwbsCLc3IYExn4s5sLXDeyxtwgBuF3mA3P+JNMe+ykF7j+oKLikJ4RcmeDwS
         nEsJxm9KKNIl28QkRJ17cnMi+FQpnuhLTJfpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Aif+MM06/B7yoYSs4A78ARh79UKbbPeW2jJrkUaEluYUyIas38ZgMHnsmg9/qq8oH5
         mfjCRrHMTNT1zXljPHwQEh6WqPlDrTfxK4aSf+frOrXDIhWGQiXrUyO6IlwbLvbgpmse
         URoRk1jB/E9NaqoEG6iQpq2s9N/X+oC0nIFlo=
Received: by 10.151.21.3 with SMTP id y3mr9234052ybi.107.1266336493655;
        Tue, 16 Feb 2010 08:08:13 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 8sm2864528ywg.34.2010.02.16.08.08.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:05:31 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140118>

If setup_git_directory_gently() and its callers do not set gitdir
now, it will be eventually set by setup_git_env(), through obscure
call chain. One of the indirect call site is git_config().

My goal is to remove gitdir auto detection in setup_git_env(). So
the first step is not depend on that behavior.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index b38cbee..183bcf6 100644
--- a/setup.c
+++ b/setup.c
@@ -313,8 +313,12 @@ const char *read_gitfile_gently(const char *path)
 /*
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
+ *
+ * After this function is finished, set_git_dir() must be called if a
+ * a repository is found. Repo format will be checked later by
+ * setup_git_directory_gently()
  */
-const char *setup_git_directory_gently(int *nongit_ok)
+static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
@@ -345,18 +349,17 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
 			const char *retval;
=20
 			if (!work_tree_env) {
+				/* core.worktree may override worktree */
 				retval =3D set_work_tree(gitdirenv);
-				/* config may override worktree */
-				if (check_repository_format_gently(nongit_ok))
-					return NULL;
+				set_git_dir(gitdirenv);
 				return retval;
 			}
-			if (check_repository_format_gently(nongit_ok))
-				return NULL;
 			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
 					get_git_work_tree());
-			if (!retval || !*retval)
+			if (!retval || !*retval) {
+				set_git_dir(gitdirenv);
 				return NULL;
+			}
 			set_git_dir(make_absolute_path(gitdirenv));
 			if (chdir(work_tree_env) < 0)
 				die_errno ("Could not chdir to '%s'", work_tree_env);
@@ -396,8 +399,10 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 				die("Repository setup failed");
 			break;
 		}
-		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) {
+			set_git_dir(DEFAULT_GIT_DIR_ENVIRONMENT);
 			break;
+		}
 		if (is_git_directory(".")) {
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
@@ -407,7 +412,6 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 				set_git_dir(cwd);
 			} else
 				set_git_dir(".");
-			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
 		while (--offset > ceil_offset && cwd[offset] !=3D '/');
@@ -428,8 +432,6 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
 	git_work_tree_cfg =3D xstrndup(cwd, offset);
-	if (check_repository_format_gently(nongit_ok))
-		return NULL;
 	if (offset =3D=3D len)
 		return NULL;
=20
@@ -440,6 +442,16 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	return cwd + offset;
 }
=20
+const char *setup_git_directory_gently(int *nongit_ok)
+{
+	const char *prefix;
+
+	prefix =3D setup_git_directory_gently_1(nongit_ok);
+	if (!nongit_ok || (!*nongit_ok && check_repository_format_gently(nong=
it_ok)))
+		prefix =3D NULL;
+	return prefix;
+}
+
 int git_config_perm(const char *var, const char *value)
 {
 	int i;
--=20
1.7.0.195.g637a2
