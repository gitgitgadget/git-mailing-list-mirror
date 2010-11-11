From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] Remove all logic from get_git_work_tree()
Date: Thu, 11 Nov 2010 21:20:45 +0700
Message-ID: <1289485248-8966-5-git-send-email-pclouds@gmail.com>
References: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 15:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGY3w-0000mO-0i
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580Ab0KKOXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:23:34 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55257 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab0KKOXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:23:33 -0500
Received: by pzk28 with SMTP id 28so397549pzk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hTEKBGQdBC8utk7NVdWVOwY0FNJgCOiaZEZVV5BTaY4=;
        b=dHm2A41zgQa9IKJc/X6Gi+BC0OkFurmzZ2FQyqQwuKjF2WBhURC+UIQFSf7v3wlh70
         19IGpGwITSKaDpUZns0SlhyQ4gKp2+KPoZfp1gb5+TLpzFWiLxMhryqMcWhnUEMmNaG1
         ugeGjTjtf4rcHWvbUwk+qKbLltbgsRMgL9yOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pV7uebtCIYNy1u2QVbuAKJ5TVqn9zKZ5W+Rk3IFaDzgtw52m9U1J5Vu2hFoaVzbFwl
         /CH0tFpP7gDjIVey0Na1jzxdPNXi9sDQkQv1Gq3R3VDte+Bej4oEGUpN2MlDOA628x5F
         oqrCz/MJIlPToWJnvfRhgblwt867wn1FFjcr0=
Received: by 10.142.139.8 with SMTP id m8mr633547wfd.208.1289485413310;
        Thu, 11 Nov 2010 06:23:33 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id w3sm2422815wfd.14.2010.11.11.06.23.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:23:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:22:13 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161258>

This logic is now only used by cmd_init_db(). setup_* functions do not
rely on it any more. Move all the logic to cmd_init_db() and turn
get_git_work_tree() into a simple function.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/init-db.c |   14 +++++++++++---
 cache.h           |    1 -
 environment.c     |   32 ++++++++------------------------
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index ea06478..e3af9ea 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -414,6 +414,7 @@ static const char *const init_db_usage[] =3D {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *work_tree;
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
 	const struct option init_db_options[] =3D {
@@ -480,8 +481,8 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	 * without --bare.  Catch the error early.
 	 */
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
-	if ((!git_dir || is_bare_repository_cfg =3D=3D 1)
-	    && getenv(GIT_WORK_TREE_ENVIRONMENT))
+	work_tree =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
+	if ((!git_dir || is_bare_repository_cfg =3D=3D 1) && work_tree)
 		die("%s (or --work-tree=3D<directory>) not allowed without "
 		    "specifying %s (or --git-dir=3D<directory>)",
 		    GIT_WORK_TREE_ENVIRONMENT,
@@ -496,7 +497,6 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	if (is_bare_repository_cfg < 0)
 		is_bare_repository_cfg =3D guess_repository_type(git_dir);
=20
-	startup_info->setup_explicit =3D 1;
 	if (!is_bare_repository_cfg) {
 		if (git_dir) {
 			const char *git_dir_parent =3D strrchr(git_dir, '/');
@@ -511,10 +511,18 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 			if (!getcwd(git_work_tree_cfg, PATH_MAX))
 				die_errno ("Cannot access current working directory");
 		}
+		if (work_tree)
+			set_git_work_tree(make_absolute_path(work_tree));
+		else
+			set_git_work_tree(git_work_tree_cfg);
 		if (access(get_git_work_tree(), X_OK))
 			die_errno ("Cannot access work tree '%s'",
 				   get_git_work_tree());
 	}
+	else {
+		if (work_tree)
+			set_git_work_tree(make_absolute_path(work_tree));
+	}
=20
 	set_git_dir(make_absolute_path(git_dir));
=20
diff --git a/cache.h b/cache.h
index b2cdda7..123dd4b 100644
--- a/cache.h
+++ b/cache.h
@@ -1119,7 +1119,6 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
-	int setup_explicit;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/environment.c b/environment.c
index d811049..149c132 100644
--- a/environment.c
+++ b/environment.c
@@ -137,36 +137,20 @@ static int git_work_tree_initialized;
  */
 void set_git_work_tree(const char *new_work_tree)
 {
+	if (git_work_tree_initialized) {
+		new_work_tree =3D make_absolute_path(new_work_tree);
+		if (strcmp(new_work_tree, work_tree))
+			die("internal error: work tree has already been set\n"
+			    "Current worktree: %s\nNew worktree: %s",
+			    work_tree, new_work_tree);
+		return;
+	}
 	git_work_tree_initialized =3D 1;
-	free(work_tree);
 	work_tree =3D xstrdup(make_absolute_path(new_work_tree));
-	is_bare_repository_cfg =3D 0;
 }
=20
 const char *get_git_work_tree(void)
 {
-	if (startup_info && !startup_info->setup_explicit) {
-		if (is_bare_repository_cfg =3D=3D 1)
-			return NULL;
-		if (work_tree)
-			is_bare_repository_cfg =3D 0;
-		return work_tree;
-	}
-
-	if (!git_work_tree_initialized) {
-		work_tree =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
-		/* core.bare =3D true overrides implicit and config work tree */
-		if (!work_tree && is_bare_repository_cfg < 1) {
-			work_tree =3D git_work_tree_cfg;
-			/* make_absolute_path also normalizes the path */
-			if (work_tree && !is_absolute_path(work_tree))
-				work_tree =3D xstrdup(make_absolute_path(git_path("%s", work_tree)=
));
-		} else if (work_tree)
-			work_tree =3D xstrdup(make_absolute_path(work_tree));
-		git_work_tree_initialized =3D 1;
-		if (work_tree)
-			is_bare_repository_cfg =3D 0;
-	}
 	return work_tree;
 }
=20
--=20
1.7.3.2.210.g045198
