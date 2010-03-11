From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/16] Use git_config_early() instead of git_config() during repo setup
Date: Thu, 11 Mar 2010 20:22:24 +0700
Message-ID: <1268313754-28179-7-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMg-0001K7-0X
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428Ab0CKNXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:17 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40589 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNXM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:12 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so11276pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+/xnPtjyn1HnwXBjhu8ARcT889lYmUiMTFT29L7JnAs=;
        b=EUF6NkH9ThlGKJboG2WMKhgZmgcHO09UAVb0D0VV6hTiPjW/ztUG8afu5bJvg1nakD
         wv5PJollEjyr6aGIFLhK+p+RoeMnvg4ZRh6xGlIZlgozzSzhrcCEhcPM+v/lS/fOWsHF
         X6uWGKtkY0mg3AKYLlLWH1mf0GtIkFwnD/jy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=k7VnIKaehDt93PiEqv5/XgNNOfNW80DsYSQLzKgnibThHDkYwQHnkJOFj520MqDRqH
         qciWX91piGD7LLBKsUz+3i7CtNyC62rCnITA/+iWbH9k2dIbU5XrePauL5n8Hlw1eJSs
         w69rAMpK0CLJgthoOWOYgexJIWCkDDGTztA0g=
Received: by 10.140.247.17 with SMTP id u17mr1748208rvh.246.1268313792642;
        Thu, 11 Mar 2010 05:23:12 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 20sm2779536pzk.11.2010.03.11.05.23.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:11 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:07 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141967>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index 43a8609..b8f88db 100644
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
+			if (check_repository_format_gently(gitfile_dir, nongit_ok))
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
1.7.0.1.384.g6abcaa
