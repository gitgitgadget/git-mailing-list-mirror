From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/POC 1/7] Make git_path() beware of file relocation in $GIT_DIR
Date: Wed, 11 Dec 2013 21:15:27 +0700
Message-ID: <1386771333-32574-2-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:11:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqkV9-0007Uh-T8
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab3LKOKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 09:10:53 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33323 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3LKOKw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:10:52 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so9546235pdi.24
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RY741V1tyDiU67rgHzwdxewdw1osYNQ54Kx0OBkfqFU=;
        b=QSNDORxRpnJZikrVb/YxYrNd/Q752nKidZsA+YPLpjX7m7qCACl5j0/JOqEcAKzVlc
         YEYiTZpoXko25x2J4MbUUa+VbvMGB+OhCWZB3n+4VGxQWtlslY0v4cEP2h2S5d0Jr6hC
         GjbgpHGcftzsDsQWef2gfKyFHyDVO0Ss4kk0YwsTMkhjCiwcBgpEijAaMxAct9muuSHH
         HPnhq0n+L/W/eQmi5Z3dWi859dQ0mG87IeTuasVpd3snrQbW5jFUvBbdNTB2cJZ+g7iH
         FldDXBmw259hcy5tWGq4lQEpyD6fvyd51Ep6T/BiSI16NpfFub3pvFqERnBi1s6ekZpH
         sZ4g==
X-Received: by 10.66.160.40 with SMTP id xh8mr1863301pab.150.1386771052191;
        Wed, 11 Dec 2013 06:10:52 -0800 (PST)
Received: from lanh ([115.73.201.231])
        by mx.google.com with ESMTPSA id b3sm13115595pbu.38.2013.12.11.06.10.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 06:10:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Dec 2013 21:15:41 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239195>

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

XXX trim consecutive slashes

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h               |  1 +
 environment.c         |  9 +++++++--
 path.c                | 35 ++++++++++++++++++++++++++++++++---
 t/t0060-path-utils.sh | 48 +++++++++++++++++++++++++++++++++++++++++++=
+++++
 test-path-utils.c     |  7 +++++++
 5 files changed, 95 insertions(+), 5 deletions(-)

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
index 24594c4..eda9176 100644
--- a/path.c
+++ b/path.c
@@ -49,10 +49,38 @@ char *mksnpath(char *buf, size_t n, const char *fmt=
, ...)
 	return cleanup_path(buf);
 }
=20
+static int dir_prefix(const char *buf, const char *dir)
+{
+	int len =3D strlen(dir);
+	return !strncmp(buf, dir, len) &&
+		(is_dir_sep(buf[len]) || buf[len] =3D=3D '\0');
+}
+
+static void replace_dir(char *buf, int len, const char *newdir)
+{
+	int newlen =3D strlen(newdir);
+	int buflen =3D strlen(buf);
+	memmove(buf + newlen + 1, buf + len, buflen - len + 1);
+	memcpy(buf, newdir, newlen);
+	buf[newlen] =3D '/';
+}
+
+static void adjust_git_path(char *buf, int git_dir_len)
+{
+	/* XXX buffer overflow */
+	char *base =3D buf + git_dir_len;
+	if (git_graft_env && !strcmp(base, "info/grafts"))
+		strcpy(buf, get_graft_file());
+	else if (git_index_env && !strcmp(base, "index"))
+		strcpy(buf, get_index_file());
+	else if (git_db_env && dir_prefix(base, "objects"))
+		replace_dir(buf, git_dir_len + 7, get_object_directory());
+}
+
 static char *vsnpath(char *buf, size_t n, const char *fmt, va_list arg=
s)
 {
 	const char *git_dir =3D get_git_dir();
-	size_t len;
+	size_t len, total_len;
=20
 	len =3D strlen(git_dir);
 	if (n < len + 1)
@@ -60,9 +88,10 @@ static char *vsnpath(char *buf, size_t n, const char=
 *fmt, va_list args)
 	memcpy(buf, git_dir, len);
 	if (len && !is_dir_sep(git_dir[len-1]))
 		buf[len++] =3D '/';
-	len +=3D vsnprintf(buf + len, n - len, fmt, args);
-	if (len >=3D n)
+	total_len =3D len + vsnprintf(buf + len, n - len, fmt, args);
+	if (total_len >=3D n)
 		goto bad;
+	adjust_git_path(buf, len);
 	return cleanup_path(buf);
 bad:
 	strlcpy(buf, bad_path, n);
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 07c10c8..7ad2730 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -223,4 +223,52 @@ relative_path "<null>"		"<empty>"	./
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
