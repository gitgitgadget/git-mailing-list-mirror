From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Thu,  3 Mar 2011 19:43:21 +0700
Message-ID: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 13:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv7u9-0007Mc-31
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 13:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab1CCMpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 07:45:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54648 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354Ab1CCMpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 07:45:06 -0500
Received: by iyb26 with SMTP id 26so879167iyb.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 04:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=WEJNNI2z10/T4OvDKP7cT+mhS1Te4XydfSb4uU2fM+Y=;
        b=KJpngjj8OiGxpFukU9DGdSfEBCzvFV4jCVMkXHQ9W+/4rPNNTpY8CsVowZyR1xaGHm
         WrfmYKtGAfDdeMcWP5rC1sb6oAu+kPHTw8sUuV8+Iq/U9v7jOZurGJXEr4SsAgTlgzdK
         +3OCGYNLLAGGMW23cUvIwJodhAJqLiFdHFhsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=RbH280rOrbF1NFJgkYr2YAs8nHwJBsmxF1yN16mNRU9w7ANpLSYa20JY2BGd33+WjS
         /fQE4wE2t3M/1hZbNQhgf3VxL3VBoz138utslHskRCE3VGUlEDqMV8AhMpXu9r4ON7BV
         lKIAguw/a2nAGzRTaEZBy33Ate5GoU/YwRprA=
Received: by 10.42.73.72 with SMTP id r8mr1668901icj.251.1299156306092;
        Thu, 03 Mar 2011 04:45:06 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.241.141])
        by mx.google.com with ESMTPS id jv9sm794448icb.1.2011.03.03.04.44.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 04:44:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Mar 2011 19:43:22 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168391>

Instead of creating the repository at $GIT_DIR, --real-git-dir will
tell git to put the repository there, then make $GIT_DIR a .git file
that points to --real-git-dir.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This makes '.git symbolic link' (what's its official name?) more
 convenient to use. Previously whenever I need to create a .git link,
 I need to open docs to see its format. Now all I need to do is

  git init --real-git-dir=3D/where/real/git/is
  git clone --real-git-dir=3D/where/real/git/is something

 I intend to make 'git init --real-git-dir' move current repo to
 somewhere else if called on existing repo.

 Long term I'd like to see a init/clone hook, where I can tell git
 "when I ask you to create a repo/worktree at foo, put the real repo
 at ~/git/foo"

 I could use a better option name too, any suggestions?

 builtin/clone.c   |    7 ++++++-
 builtin/init-db.c |   38 +++++++++++++++++++++++++++++++++++++-
 cache.h           |    1 +
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 60d9a64..74e487a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -42,6 +42,7 @@ static int option_local, option_no_hardlinks, option_=
shared, option_recursive;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
+static const char *real_git_dir;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
 static int option_progress;
@@ -80,6 +81,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING(0, "real-git-dir", &real_git_dir, "git-dir",
+		   "directory where real repository is cloned to"),
=20
 	OPT_END()
 };
@@ -466,7 +469,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die("could not create leading directories of '%s'", git_dir);
-	set_git_dir(make_absolute_path(git_dir));
+	set_git_dir_init(git_dir, real_git_dir);
+	if (real_git_dir)
+		git_dir =3D real_git_dir;
=20
 	if (0 <=3D option_verbosity)
 		printf("Cloning into %s%s...\n",
diff --git a/builtin/init-db.c b/builtin/init-db.c
index fbeb380..7a0fb50 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -21,6 +21,7 @@
 static int init_is_bare_repository =3D 0;
 static int init_shared_repository =3D -1;
 static const char *init_db_template_dir;
+static const char *git_link;
=20
 static void safe_create_dir(const char *dir, int share)
 {
@@ -311,10 +312,42 @@ static void create_object_directory(void)
 	free(path);
 }
=20
+int set_git_dir_init(const char *git_dir, const char *real_git_dir)
+{
+	if (real_git_dir) {
+		struct stat st;
+
+		if (!stat(git_dir, &st))
+			die("%s already exists", git_dir);
+		git_link =3D git_dir;
+	}
+	else {
+		real_git_dir =3D git_dir;
+		git_link =3D NULL;
+	}
+	set_git_dir(make_absolute_path(real_git_dir));
+	return 0;
+}
+
 int init_db(const char *template_dir, unsigned int flags)
 {
 	int reinit;
=20
+	if (git_link) {
+		struct stat st;
+		FILE *fp;
+
+		/* TODO: allow --real-git-dir to move repo elsewhere */
+		if (!lstat(git_link, &st))
+			die("%s already exists", git_link);
+
+		fp =3D fopen(git_link, "w");
+		if (!fp)
+			die("Could not create git link %s", git_link);
+		fprintf(fp, "gitdir: %s\n", get_git_dir());
+		fclose(fp);
+	}
+
 	safe_create_dir(get_git_dir(), 0);
=20
 	init_is_bare_repository =3D is_bare_repository();
@@ -414,6 +447,7 @@ static const char *const init_db_usage[] =3D {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *real_git_dir =3D NULL;
 	const char *work_tree;
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
@@ -427,6 +461,8 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 			"specify that the git repository is to be shared amongst several us=
ers",
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
 		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
+		OPT_STRING(0, "real-git-dir", &real_git_dir, "git-dir",
+			   "directory where real .git is initialized"),
 		OPT_END()
 	};
=20
@@ -522,7 +558,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 			set_git_work_tree(make_absolute_path(work_tree));
 	}
=20
-	set_git_dir(make_absolute_path(git_dir));
+	set_git_dir_init(git_dir, real_git_dir);
=20
 	return init_db(template_dir, flags);
 }
diff --git a/cache.h b/cache.h
index 08a9022..0b006b8 100644
--- a/cache.h
+++ b/cache.h
@@ -436,6 +436,7 @@ extern void verify_non_filename(const char *prefix,=
 const char *name);
=20
 #define INIT_DB_QUIET 0x0001
=20
+extern int set_git_dir_init(const char *git_dir, const char *real_git_=
dir);
 extern int init_db(const char *template_dir, unsigned int flags);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
--=20
1.7.4.74.g639db
