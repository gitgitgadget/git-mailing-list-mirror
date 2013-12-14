From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/21] Make git_path() aware of file relocation in $GIT_DIR
Date: Sat, 14 Dec 2013 17:54:50 +0700
Message-ID: <1387018507-21999-5-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Dec 14 11:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmos-0000qe-I6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918Ab3LNKvg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:51:36 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37184 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab3LNKvd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:33 -0500
Received: by mail-pa0-f49.google.com with SMTP id kx10so1051440pab.22
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6TNq+5pQCnXA/Ab/EdN+iyd6rKXgISimP1VAVzFLURU=;
        b=SEcs26dQBkRpeAjf6sSksby3DLIvtVQht0aAyXsvkai2qw2Da4il6se0IGsoSQUkW1
         t6I/LH/4pyLa2Dr8gMtdw1YN6RnWMr/G5s2hDNOduuVY4L+80hKGVRwWN/MsH0NJbCvU
         DpbLVyf8Ig+VJy+b7rw0z10BImljNwcRhAhFyn67ELsqvJYVLttC2oTlf85v5zs92tlF
         lBFYf4qiAemk2qOdSVRYmgyLd0KwMuhJUy8wQKwltwHXmpzQNQwQZbo0ccryf5gR/Jkr
         FTTcO40RUQ7kKv0/O/L7mf4kACSWfJt/oYe/GQzdFlh/8ROhpcjQZFIKhJM1jXhp+QGj
         1AlA==
X-Received: by 10.66.51.137 with SMTP id k9mr8917753pao.11.1387018293411;
        Sat, 14 Dec 2013 02:51:33 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id jk16sm11404681pbb.34.2013.12.14.02.51.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:25 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239285>

We allow the user to relocate certain paths out of $GIT_DIR via
environment variables, e.g. GIT_OBJECT_DIRECTORY, GIT_INDEX_FILE and
GIT_GRAFT_FILE. All callers are not supposed to use git_path() or
git_pathdup() to get those paths. Instead they must use
get_object_directory(), get_index_file() and get_graft_file()
respectively. This is inconvenient and could be missed in review
(there's git_path("objects/info/alternates") somewhere in
sha1_file.c).

This patch makes git_path() and git_pathdup() understand those
environment variables. So if you set GIT_OBJECT_DIRECTORY to /foo/bar,
git_path("objects/abc") should return /tmp/bar/abc. The same is done
for the two remaining env variables.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h               |  1 +
 environment.c         |  9 ++++++--
 path.c                | 57 +++++++++++++++++++++++++++++++++++++++++++=
+++++---
 t/t0060-path-utils.sh | 54 +++++++++++++++++++++++++++++++++++++++++++=
+++++
 test-path-utils.c     |  7 +++++++
 5 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index ce377e1..cdafbd7 100644
--- a/cache.h
+++ b/cache.h
@@ -584,6 +584,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern int git_db_env, git_index_env, git_graft_env;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/environment.c b/environment.c
index 0a15349..1d74dde 100644
--- a/environment.c
+++ b/environment.c
@@ -81,6 +81,7 @@ static size_t namespace_len;
=20
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
+int git_db_env, git_index_env, git_graft_env;
=20
 /*
  * Repository-local GIT_* environment variables; see cache.h for detai=
ls.
@@ -134,15 +135,19 @@ static void setup_git_env(void)
 	if (!git_object_dir) {
 		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
-	}
+	} else
+		git_db_env =3D 1;
 	git_index_file =3D getenv(INDEX_ENVIRONMENT);
 	if (!git_index_file) {
 		git_index_file =3D xmalloc(strlen(git_dir) + 7);
 		sprintf(git_index_file, "%s/index", git_dir);
-	}
+	} else
+		git_index_env =3D 1;
 	git_graft_file =3D getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file =3D git_pathdup("info/grafts");
+	else
+		git_graft_env =3D 1;
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs =3D 0;
 	namespace =3D expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
diff --git a/path.c b/path.c
index 08aa213..93e3ecc 100644
--- a/path.c
+++ b/path.c
@@ -50,10 +50,60 @@ char *mksnpath(char *buf, size_t n, const char *fmt=
, ...)
 	return cleanup_path(buf);
 }
=20
+static void copy_path(char *dst, size_t n, const char *src)
+{
+	if (strlen(src) < n)
+		strcpy(dst, src);
+	else
+		strlcpy(dst, bad_path, n);
+}
+
+static int dir_prefix(const char *buf, const char *dir)
+{
+	int len =3D strlen(dir);
+	return !strncmp(buf, dir, len) &&
+		(is_dir_sep(buf[len]) || buf[len] =3D=3D '\0');
+}
+
+/* $buf =3D~ m|$dir/+$file| but without regex */
+static int is_dir_file(const char *buf, const char *dir, const char *f=
ile)
+{
+	int len =3D strlen(dir);
+	if (strncmp(buf, dir, len) || !is_dir_sep(buf[len]))
+		return 0;
+	while (is_dir_sep(buf[len]))
+		len++;
+	return !strcmp(buf + len, file);
+}
+
+static void replace_dir(char *buf, size_t n, int len, const char *newd=
ir)
+{
+	int newlen =3D strlen(newdir);
+	int buflen =3D strlen(buf);
+	if (buflen - len + newlen >=3D n) {
+		strlcpy(buf, bad_path, n);
+		return;
+	}
+	memmove(buf + newlen + 1, buf + len, buflen - len + 1);
+	memcpy(buf, newdir, newlen);
+	buf[newlen] =3D '/';
+}
+
+static void adjust_git_path(char *buf, size_t n, int git_dir_len)
+{
+	char *base =3D buf + git_dir_len;
+	if (git_graft_env && is_dir_file(base, "info", "grafts"))
+		copy_path(buf, n, get_graft_file());
+	else if (git_index_env && !strcmp(base, "index"))
+		copy_path(buf, n, get_index_file());
+	else if (git_db_env && dir_prefix(base, "objects"))
+		replace_dir(buf, n, git_dir_len + 7, get_object_directory());
+}
+
 static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_list=
 args)
 {
 	const char *git_dir =3D get_git_dir();
-	size_t len;
+	size_t len, total_len;
=20
 	len =3D strlen(git_dir);
 	if (n < len + 1)
@@ -61,9 +111,10 @@ static char *git_vsnpath(char *buf, size_t n, const=
 char *fmt, va_list args)
 	memcpy(buf, git_dir, len);
 	if (len && !is_dir_sep(git_dir[len-1]))
 		buf[len++] =3D '/';
-	len +=3D vsnprintf(buf + len, n - len, fmt, args);
-	if (len >=3D n)
+	total_len =3D len + vsnprintf(buf + len, n - len, fmt, args);
+	if (total_len >=3D n)
 		goto bad;
+	adjust_git_path(buf, n, len);
 	return cleanup_path(buf);
 bad:
 	strlcpy(buf, bad_path, n);
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 07c10c8..bce16f5 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -223,4 +223,58 @@ relative_path "<null>"		"<empty>"	./
 relative_path "<null>"		"<null>"	./
 relative_path "<null>"		/foo/a/b	./
=20
+test_expect_success 'git_path info/grafts without GIT_GRAFT_FILE' '
+	test-path-utils git_path info/grafts >actual1 &&
+	echo .git/info/grafts >expect1 &&
+	test_cmp expect1 actual1
+'
+
+test_expect_success 'git_path info/grafts with GIT_GRAFT_FILE' '
+	GIT_GRAFT_FILE=3Dfoo test-path-utils git_path info/grafts >actual2 &&
+	echo foo >expect2 &&
+	test_cmp expect2 actual2
+'
+
+test_expect_success 'git_path info/////grafts with GIT_GRAFT_FILE' '
+	GIT_GRAFT_FILE=3Dfoo test-path-utils git_path info/////grafts >actual=
2 &&
+	echo foo >expect2 &&
+	test_cmp expect2 actual2
+'
+
+test_expect_success 'git_path index' '
+	GIT_INDEX_FILE=3Dfoo test-path-utils git_path index >actual &&
+	echo foo >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path index/foo' '
+	GIT_INDEX_FILE=3Dfoo test-path-utils git_path index/foo >actual &&
+	echo .git/index/foo >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path index2' '
+	GIT_INDEX_FILE=3Dfoo test-path-utils git_path index2 >actual &&
+	echo .git/index2 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path objects' '
+	GIT_OBJECT_DIRECTORY=3Dfoo test-path-utils git_path objects >actual &=
&
+	echo foo/ >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path objects/foo' '
+	GIT_OBJECT_DIRECTORY=3Dfoo test-path-utils git_path objects/foo >actu=
al &&
+	echo foo//foo >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git_path objects2' '
+	GIT_OBJECT_DIRECTORY=3Dfoo test-path-utils git_path objects2 >actual =
&&
+	echo .git/objects2 >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-path-utils.c b/test-path-utils.c
index 3dd3744..55e4fe0 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -135,6 +135,13 @@ int main(int argc, char **argv)
 		return 0;
 	}
=20
+	if (argc =3D=3D 3 && !strcmp(argv[1], "git_path")) {
+		int nongit_ok =3D 0;
+		setup_git_directory_gently(&nongit_ok);
+		puts(git_path("%s", argv[2]));
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
--=20
1.8.5.1.77.g42c48fa
