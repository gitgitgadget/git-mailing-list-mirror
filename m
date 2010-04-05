From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/43] Use git_config_early() instead of git_config() during repo setup
Date: Mon,  5 Apr 2010 20:41:12 +0200
Message-ID: <1270492888-26589-28-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH7-0000ps-SA
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab0DESnN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:13 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab0DESnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:08 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gWkOwpoEX7Gzn4RsHTtYlgMbvWYPLFok4kCuVa9Vsec=;
        b=ZlmXtUXcCeayNMFCI/YE4ks/IRyadNYQUskie0VztOQ1oLUPH8IBxFXkeH9tIv/hXW
         g9s7+HTj6vRIxI6y8zZjdqY2TxuqTnmCcXL0q2oVWyqdy/+OWDa6AoqoLTIUHOULecxN
         ZDchD34Cy0V3JcWQl8Mu48yEXV08rP1sKPSyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gbHA8TEL9d4tlxGmUo/+3eE/YErWLesUmzoGn6gDeDN2li0bn8UsH7BVVNfj/t8/62
         Vvc+pO+3kO/IjmGJoPNaXDfmB+JLoPHkHCc4vSJg+ZWNQ3Q1RBklJYn+dwdJ93XWt6Av
         R2C4/QWiqaxV9oy/0AVf3jRN7WGPMwksFh6A0=
Received: by 10.223.7.76 with SMTP id c12mr1863464fac.42.1270492988206;
        Mon, 05 Apr 2010 11:43:08 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 19sm27060481fkr.9.2010.04.05.11.43.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:07 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:05 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144021>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index 43a8609..2c1b64f 100644
--- a/setup.c
+++ b/setup.c
@@ -241,9 +241,21 @@ void setup_work_tree(void)
 	initialized =3D 1;
 }
=20
-static int check_repository_format_gently(int *nongit_ok)
+static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
-	git_config(check_repository_format_version, NULL);
+	char repo_config[PATH_MAX+1];
+
+	/*
+	 * git_config() can't be used here because it calls git_pathdup()
+	 * to get $GIT_CONFIG/config. That call will make setup_git_env()
+	 * set git_dir to ".git".
+	 *
+	 * We are in gitdir setup, no git dir has been found useable yet.
+	 * Use a gentler version of git_config() to check if this repo
+	 * is a good one.
+	 */
+	snprintf(repo_config, PATH_MAX, "%s/config", gitdir);
+	git_config_early(check_repository_format_version, NULL, repo_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
@@ -348,12 +360,12 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 			if (!work_tree_env) {
 				retval =3D set_work_tree(gitdirenv);
 				/* config may override worktree */
-				if (check_repository_format_gently(nongit_ok))
+				if (check_repository_format_gently(gitdirenv, nongit_ok))
 					return NULL;
 				set_git_dir(gitdirenv);
 				return retval;
 			}
-			if (check_repository_format_gently(nongit_ok))
+			if (check_repository_format_gently(gitdirenv, nongit_ok))
 				return NULL;
 			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
 					get_git_work_tree());
@@ -403,6 +415,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 			inside_git_dir =3D 0;
 			if (!work_tree_env)
 				inside_work_tree =3D 1;
+			if (check_repository_format_gently(gitfile_dir, nongit_ok))
+				return NULL;
 			root_len =3D offset_1st_component(cwd);
 			git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : ro=
ot_len);
 			break;
@@ -411,6 +425,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
+			if (check_repository_format_gently(".", nongit_ok))
+				return NULL;
 			if (offset !=3D len) {
 				root_len =3D offset_1st_component(cwd);
 				cwd[offset > root_len ? offset : root_len] =3D '\0';
@@ -433,8 +449,6 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 			die_errno("Cannot change to '%s/..'", cwd);
 	}
=20
-	if (check_repository_format_gently(nongit_ok))
-		return NULL;
 	if (offset =3D=3D len)
 		return NULL;
=20
@@ -542,7 +556,7 @@ char *enter_repo(char *path, int strict)
 	    validate_headref("HEAD") =3D=3D 0) {
 		inside_work_tree =3D 0;
 		inside_git_dir =3D 1;
-		check_repository_format();
+		check_repository_format_gently(".", NULL);
 		set_git_dir(".");
 		if (startup_info) {
 			startup_info->prefix =3D NULL;
@@ -627,7 +641,7 @@ int check_repository_format_version(const char *var=
, const char *value, void *cb
=20
 int check_repository_format(void)
 {
-	return check_repository_format_gently(NULL);
+	return check_repository_format_gently(get_git_dir(), NULL);
 }
=20
 const char *setup_git_directory(void)
--=20
1.7.0.rc1.541.g2da82.dirty
