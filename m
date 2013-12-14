From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/21] Add new environment variable $GIT_SUPER_DIR
Date: Sat, 14 Dec 2013 17:54:53 +0700
Message-ID: <1387018507-21999-8-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrmpB-0000xq-Vn
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab3LNKvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:51:54 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54238 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:53 -0500
Received: by mail-pa0-f46.google.com with SMTP id kl14so1052581pab.19
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nl6HGU0j9Gf083SaPS9Ik+tqnQGlsclv4QZZ+eps3zs=;
        b=hL5kzu5t6INDS3Bv/T5A8cDY2h87xQzO/0TPzNISjTfxJpRN1RrXnbCmvIM9T7HDnp
         AhXzJ37nBWc2VjpmxlUr/ffwBLKTvdTLA+KfeCWw8TfzjhWtZ5dUUrNFIrHc9EjKFvY4
         9fG11BJMNKnYWUn+VhV7nVm8mm1D2OwJaUlWuieQXV9hmuOeq5VZyCHJZho9Eu3rpxXe
         lQDBxlbVEyWFIfIHlQmmM22DTrn3Vi2J2xMMVmhWh59P0WokxFUYDNtyaYQXybFvmRK2
         wSSFbAAn1wnrL/NWNxG7iF0dTmh5pWe081Z9H1EC2PBj44SLzUE8sJCTQYAVAiCIp6FQ
         Py0g==
X-Received: by 10.68.29.4 with SMTP id f4mr8694009pbh.85.1387018312797;
        Sat, 14 Dec 2013 02:51:52 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id gg10sm11390912pbc.46.2013.12.14.02.51.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:45 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239289>

If $GIT_SUPER_DIR is defined, the repository is splitted into two
places:

 - HEAD, logs/HEAD, index, other top-level refs and unrecognized files
   are from $GIT_DIR

 - the rest like objects, refs, info, hooks, packed-refs, shallow...
   are from $GIT_SUPER_DIR

The redirection is done by git_path(), git_pathdup() and git_snpath()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt |  8 ++++++
 cache.h               |  2 ++
 environment.c         | 11 +++++--
 path.c                | 28 ++++++++++++++++++
 t/t0060-path-utils.sh | 79 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4448ce2..9f4e9f8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -764,6 +764,14 @@ Git so take care if using Cogito etc.
 	an explicit repository directory set via 'GIT_DIR' or on the
 	command line.
=20
+'GIT_SUPER_DIR'::
+	If this variable is set to a path, non-worktree files that are
+	normally in $GIT_DIR will be taken from this path
+	instead. Worktree-specific files such as HEAD or index are
+	taken from $GIT_DIR. This variable has lower precedence than
+	other path variables such as GIT_INDEX_FILE,
+	GIT_OBJECT_DIRECTORY...
+
 Git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/cache.h b/cache.h
index cdafbd7..823582f 100644
--- a/cache.h
+++ b/cache.h
@@ -347,6 +347,7 @@ static inline enum object_type object_type(unsigned=
 int mode)
=20
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_SUPER_DIR_ENVIRONMENT "GIT_SUPER_DIR"
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
@@ -399,6 +400,7 @@ extern int is_inside_git_dir(void);
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
+extern const char *get_git_super_dir(void);
 extern int is_git_directory(const char *path);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
diff --git a/environment.c b/environment.c
index 1d74dde..d5ae7a3 100644
--- a/environment.c
+++ b/environment.c
@@ -79,7 +79,7 @@ static char *work_tree;
 static const char *namespace;
 static size_t namespace_len;
=20
-static const char *git_dir;
+static const char *git_dir, *git_super_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
 int git_db_env, git_index_env, git_graft_env;
=20
@@ -131,10 +131,12 @@ static void setup_git_env(void)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile =3D read_gitfile(git_dir);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
+	git_super_dir =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
-		sprintf(git_object_dir, "%s/objects", git_dir);
+		sprintf(git_object_dir, "%s/objects",
+			git_super_dir ? git_super_dir : git_dir);
 	} else
 		git_db_env =3D 1;
 	git_index_file =3D getenv(INDEX_ENVIRONMENT);
@@ -167,6 +169,11 @@ const char *get_git_dir(void)
 	return git_dir;
 }
=20
+const char *get_git_super_dir(void)
+{
+	return git_super_dir;
+}
+
 const char *get_git_namespace(void)
 {
 	if (!namespace)
diff --git a/path.c b/path.c
index 93e3ecc..e51fc35 100644
--- a/path.c
+++ b/path.c
@@ -89,8 +89,34 @@ static void replace_dir(char *buf, size_t n, int len=
, const char *newdir)
 	buf[newlen] =3D '/';
 }
=20
+static void update_super_dir(char *buf, size_t n, int git_dir_len)
+{
+	const char *super_dir_list[] =3D {
+		"branches", "hooks", "info", "logs", "modules",
+		"objects", "refs", "remotes", "rr-cache", "svn", NULL
+	};
+	const char *super_top_file_list[] =3D {
+		"config", "packed-refs", "shallow", NULL
+	};
+	char *base =3D buf + git_dir_len;
+	const char **p;
+	if (is_dir_file(base, "logs", "HEAD"))
+		return;	/* keep this in $GIT_DIR */
+	for (p =3D super_dir_list; *p; p++)
+		if (dir_prefix(base, *p)) {
+			replace_dir(buf, n, git_dir_len, get_git_super_dir());
+			return;
+		}
+	for (p =3D super_top_file_list; *p; p++)
+		if (!strcmp(base, *p)) {
+			replace_dir(buf, n, git_dir_len, get_git_super_dir());
+			return;
+		}
+}
+
 static void adjust_git_path(char *buf, size_t n, int git_dir_len)
 {
+
 	char *base =3D buf + git_dir_len;
 	if (git_graft_env && is_dir_file(base, "info", "grafts"))
 		copy_path(buf, n, get_graft_file());
@@ -98,6 +124,8 @@ static void adjust_git_path(char *buf, size_t n, int=
 git_dir_len)
 		copy_path(buf, n, get_index_file());
 	else if (git_db_env && dir_prefix(base, "objects"))
 		replace_dir(buf, n, git_dir_len + 7, get_object_directory());
+	else if (get_git_super_dir())
+		update_super_dir(buf, n, git_dir_len);
 }
=20
 static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_list=
 args)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index bce16f5..5e798c4 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -277,4 +277,83 @@ test_expect_success 'git_path objects2' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'git_path super index' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path index >actual &&
+	echo .git/index >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super HEAD' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path HEAD >actual &&
+	echo .git/HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super objects/*' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path objects/foo >actual &&
+	echo foo/objects/foo >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super info/*' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path info/exclude >actual &&
+	echo foo/info/exclude >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super remotes/*' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path remotes/foo >actual &&
+	echo foo/remotes/foo >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super branches/*' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path branches/foo >actual &&
+	echo foo/branches/foo >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super logs/refs/heads/master' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path logs/refs/heads/master >=
actual &&
+	echo foo/logs/refs/heads/master >expect &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'git_path super refs/heads/master' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path refs/heads/master >actua=
l &&
+	echo foo/refs/heads/master >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super logs/HEAD' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path logs/HEAD >actual &&
+	echo .git/logs/HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super hooks/me' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path hooks/me >actual &&
+	echo foo/hooks/me >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super config' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path config >actual &&
+	echo foo/config >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super packed-refs' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path packed-refs >actual &&
+	echo foo/packed-refs >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path super shallow' '
+	GIT_SUPER_DIR=3Dfoo test-path-utils git_path shallow >actual &&
+	echo foo/shallow >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.8.5.1.77.g42c48fa
