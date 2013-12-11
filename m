From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/POC 2/7] Add new environment variable $GIT_SUPER_DIR
Date: Wed, 11 Dec 2013 21:15:28 +0700
Message-ID: <1386771333-32574-3-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:11:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqkVF-0007WU-2D
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955Ab3LKOK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 09:10:59 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60808 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3LKOK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:10:58 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so9999429pbc.7
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FNT+oMebzB1AZcJvJggtA8tDoSuOk8h5bFph06GVCgI=;
        b=06/M7Iw4fFxVTLcE7iix2/goXdILV3E2TK3UW4HF1QUWY+04oJJOxoHDEjpgcJZou+
         wKk7xy2Wmzkw/LVDfM85j6vRr95uAqDUVqc4kVN1n/bjDHQw9XbiEiCFRzI73jlgLTPd
         rdipQkrR0iiAUZ1G4/ke7mPkTlL8W4TjYcQVM+icdmMZjQFx13pruSmM2nua1QLN9ThZ
         MDglVCVhV1VOzToq0Whl/5tvH/ekOtHL50gbkNcoq+j+cKEmOjq5+uQmEamGFx1s990T
         zyrzLutjU5f93w3hElnlv80zGV9duAeXlEPssxWnOyTugTJBKUkA01bVgXLVq0XYw7gp
         hkqw==
X-Received: by 10.66.102.39 with SMTP id fl7mr1828278pab.43.1386771058097;
        Wed, 11 Dec 2013 06:10:58 -0800 (PST)
Received: from lanh ([115.73.201.231])
        by mx.google.com with ESMTPSA id bh6sm45429373pad.20.2013.12.11.06.10.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 06:10:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Dec 2013 21:15:47 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239196>

This is the base for git-new-workdir integration. The git-new-workdir
script creates a separate worktree that shares everything except
worktree-related stuff. The sharing is eanbled by this new env
variable.

In the new worktree, both variables are set at the same time, GIT_DIR
and GIT_SUPER_DIR. Shared paths are checked at adjust_git_path() and
rewritten to use $GIT_SUPER_DIR instead of $GIT_DIR. Let's call this
"split-repo" setup to distinguish from $GIT_DIR-only one.

The "ln -s" is avoided because Windows probably does not have the
support, and symlinks don't survive operations that delete the old
file, then create a new one.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h               |  2 ++
 environment.c         | 11 +++++++--
 path.c                | 10 ++++++++
 t/t0060-path-utils.sh | 67 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 88 insertions(+), 2 deletions(-)

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
index eda9176..86a7c15 100644
--- a/path.c
+++ b/path.c
@@ -75,6 +75,16 @@ static void adjust_git_path(char *buf, int git_dir_l=
en)
 		strcpy(buf, get_index_file());
 	else if (git_db_env && dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, get_object_directory());
+	else if (get_git_super_dir()) {
+		if (dir_prefix(base, "objects") || dir_prefix(base, "info") ||
+		    dir_prefix(base, "refs") ||
+		    (dir_prefix(base, "logs") && strcmp(base, "logs/HEAD")) ||
+		    dir_prefix(base, "rr-cache") || dir_prefix(base, "hooks") ||
+		    dir_prefix(base, "svn") ||
+		    !strcmp(base, "config") || !strcmp(base, "packed-refs") ||
+		    !strcmp(base, "shallow"))
+			replace_dir(buf, git_dir_len, get_git_super_dir());
+	}
 }
=20
 static char *vsnpath(char *buf, size_t n, const char *fmt, va_list arg=
s)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 7ad2730..45f114c 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -271,4 +271,71 @@ test_expect_success 'git_path objects2' '
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
