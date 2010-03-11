From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/16] worktree setup: restore original state when things go wrong
Date: Thu, 11 Mar 2010 20:22:25 +0700
Message-ID: <1268313754-28179-8-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMg-0001K7-J5
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440Ab0CKNXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:23 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40589 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:19 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so11276pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RYN1d6Cl0lyKPKiXEsEZBz2wFPcNTiPNWmwkRt+Wor4=;
        b=q+IC/5QZ+wxulqHjYshIc+nYWoPK1Ey9Fv2OuJQSoZG/d9CAi+Smf2INznnWlUu7LN
         USdOXGA4pP151EDrSauBZTLMUzssn4mzz3jgxjamH5W/DSO9ZPPC3js4jsEkFhj2ejpX
         EJRvr2RkwtB0ngfk218WzscG+VaFoFG3bFl/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KgtN0MZQ5wXXqBNUJQGMZK8sUwXulP2fWZsnPJ8TbYs0lZFS8h4pl+MIEnc3RsoGRB
         Pn2yATonQIN2yV0iyFE+VihXe9rWWdGNHnA/ZX6ZoqlzvAtwAQARBNHcbNfKx2XOGAr/
         tGM6nOsH329TsXjQ0Xn2cxuFKhSxMVRA9RNGY=
Received: by 10.114.19.16 with SMTP id 16mr1330732was.196.1268313798995;
        Thu, 11 Mar 2010 05:23:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8863124pzk.14.2010.03.11.05.23.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:12 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141969>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    1 +
 setup.c |   39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 3bd219c..8e9d818 100644
--- a/cache.h
+++ b/cache.h
@@ -418,6 +418,7 @@ extern const char **get_pathspec(const char *prefix=
, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
+extern void unset_git_directory(const char *prefix);
 extern const char *prefix_path(const char *prefix, int len, const char=
 *path);
 extern const char *prefix_filename(const char *prefix, int len, const =
char *path);
 extern int check_filename(const char *prefix, const char *name);
diff --git a/setup.c b/setup.c
index b8f88db..2f850ab 100644
--- a/setup.c
+++ b/setup.c
@@ -323,6 +323,26 @@ const char *read_gitfile_gently(const char *path)
 	return path;
 }
=20
+void unset_git_directory(const char *prefix)
+{
+	if (prefix && chdir(prefix))
+		die("Cannot change to '%s'", prefix);
+
+	if (startup_info) {
+		startup_info->prefix =3D NULL;
+		startup_info->have_repository =3D 0;
+	}
+
+	/* Initialized in setup_git_directory_gently_1() */
+	inside_work_tree =3D -1;
+	inside_git_dir =3D -1;
+
+	/* Initialized in check_repository_format_version() */
+	repository_format_version =3D 0xFF;
+	shared_repository =3D PERM_UMASK;
+	is_bare_repository_cfg =3D -1;
+	git_work_tree_cfg =3D NULL;
+}
 /*
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
@@ -403,6 +423,13 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 	 * - ../ (bare)
 	 * - ../../.git/
 	 *   etc.
+	 *
+	 * When a repository is found:
+	 * - inside_git_dir/inside_work_tree are set
+	 * - check_repository_format_gently() is called
+	 *   if repo version is not supported, restore cwd
+	 * - set_git_dir
+	 * - calculate and return prefix
 	 */
 	offset =3D len =3D strlen(cwd);
 	for (;;) {
@@ -410,13 +437,15 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 		if (!gitfile_dir && is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 			gitfile_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 		if (gitfile_dir) {
-			if (set_git_dir(gitfile_dir))
-				die("Repository setup failed");
 			inside_git_dir =3D 0;
 			if (!work_tree_env)
 				inside_work_tree =3D 1;
-			if (check_repository_format_gently(gitfile_dir, nongit_ok))
+			if (check_repository_format_gently(gitfile_dir, nongit_ok)) {
+				unset_git_directory(offset !=3D len ? cwd + offset + 1: NULL);
 				return NULL;
+			}
+			if (set_git_dir(gitfile_dir))
+				die("Repository setup failed");
 			root_len =3D offset_1st_component(cwd);
 			git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : ro=
ot_len);
 			break;
@@ -425,8 +454,10 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
-			if (check_repository_format_gently(gitfile_dir, nongit_ok))
+			if (check_repository_format_gently(gitfile_dir, nongit_ok)) {
+				unset_git_directory(offset !=3D len ? cwd + offset + 1: NULL);
 				return NULL;
+			}
 			if (offset !=3D len) {
 				root_len =3D offset_1st_component(cwd);
 				cwd[offset > root_len ? offset : root_len] =3D '\0';
--=20
1.7.0.1.384.g6abcaa
