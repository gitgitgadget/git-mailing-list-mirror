From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/19] Use git_config_early() instead of git_config() during repo setup
Date: Sun, 21 Mar 2010 17:30:33 +0700
Message-ID: <1269167446-7799-7-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIUw-0003HC-M4
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0CUKfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:35:06 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51964 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab0CUKfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:35:04 -0400
Received: by gxk9 with SMTP id 9so2777147gxk.8
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oHSvceI77uUq1LukaT2Qoik0jhlNkLHJ99b5p+e8g7I=;
        b=CGKS7MmKIqN033YSSjUs9FEChBg3+u60qu55zNmcviUEADDN3IHb7kU71A41XLEz7q
         QxNulFKKmNL5WF1qWRHbAzl2RaE9UPVvGVSknHfAWw1eAg0KK4vcgl0QVpRLEX5Je53H
         QR/w3hMvsZmnXGW1NLGNQQRFeiPJH/1viaV6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fBu1FieXns+y/B5d9CXgwA8lT/7iSHAUgOFzhcNkyZ7SIK08JNCeJ3of+txFy7UgcU
         JgQOke/iB0BYCYYhl5Twi+Y3YfU7RxShd9UYl0fqu6nEKrqUmYDBckQBXlWEMNuR28n7
         5bPjrh4etIOAJXPPmJ3N84tQjreFz5Xj96Yh8=
Received: by 10.100.76.7 with SMTP id y7mr12867139ana.28.1269167703144;
        Sun, 21 Mar 2010 03:35:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 23sm3324356iwn.10.2010.03.21.03.35.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:31:22 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142801>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.7.0.2.425.gb99f1
