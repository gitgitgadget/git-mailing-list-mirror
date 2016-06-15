From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/25] Make git_path() aware of file relocation in $GIT_DIR
Date: Tue, 18 Feb 2014 20:39:54 +0700
Message-ID: <1392730814-19656-6-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkuo-0006NW-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbaBRNkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:40:46 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35039 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbaBRNko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:40:44 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so16775456pab.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L/wREBqjMC+fpj3Pt6ounKwBvs7HGD+Uvcrfo3aL928=;
        b=Vk1xb9/y45tPrXiDwxrUefJRXcd5DHNevUeG4R4Vg3kAd8Oi0niHbh9jmsx7QhpQTE
         ym2m0T1YD5aRvlAvOAzqBnxd9Uio9NbFaBP4l2TbIv58JK3+gG/6bAFDwNeZ4NyXcH/D
         ZUjC8upf6v1tkikIewLJ4ZJznavKiW9oWfGkgYWsynvT7Vcpx/Zt2DQYZdnor84/10GR
         Vz+FcXR+6v49Lg8TqIHhugX0wDuGe4YX8RDe4kRpuMt6jlxkqByki3+M/syQm47Deyfk
         IAZUJkQjPP7nghhQxxDgtmKyZxjvTdY0LDlaMlIVEg3//TK3rrTSpwCuJ3bOBrsQX3Zt
         0kIg==
X-Received: by 10.67.5.131 with SMTP id cm3mr33033850pad.92.1392730843790;
        Tue, 18 Feb 2014 05:40:43 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id ja8sm56110481pbd.3.2014.02.18.05.40.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:40:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:40:57 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242305>

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

"git rev-parse --git-path" is the wrapper for script use.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-rev-parse.txt |  5 +++++
 builtin/rev-parse.c             |  7 +++++++
 cache.h                         |  1 +
 environment.c                   |  9 ++++++--
 path.c                          | 46 +++++++++++++++++++++++++++++++++=
++++++++
 t/t0060-path-utils.sh           | 19 +++++++++++++++++
 6 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 0d2cdcd..33e4e90 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -232,6 +232,11 @@ print a message to stderr and exit with nonzero st=
atus.
 	repository.  If <path> is a gitfile then the resolved path
 	to the real repository is printed.
=20
+--git-path <path>::
+	Resolve "$GIT_DIR/<path>" and takes other path relocation
+	variables such as $GIT_OBJECT_DIRECTORY,
+	$GIT_INDEX_FILE... into account.
+
 --show-cdup::
 	When the command is invoked from a subdirectory, show the
 	path of the top-level directory relative to the current
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index aaeb611..e50bc65 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -518,6 +518,13 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
+		if (!strcmp(arg, "--git-path")) {
+			if (!argv[i + 1])
+				die("--git-path requires an argument");
+			puts(git_path("%s", argv[i + 1]));
+			i++;
+			continue;
+		}
 		if (as_is) {
 			if (show_file(arg, output_prefix) && as_is < 2)
 				verify_filename(prefix, arg, 0);
diff --git a/cache.h b/cache.h
index 8d3697e..6c08e4a 100644
--- a/cache.h
+++ b/cache.h
@@ -585,6 +585,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern int git_db_env, git_index_env, git_graft_env;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/environment.c b/environment.c
index 4a3437d..f513479 100644
--- a/environment.c
+++ b/environment.c
@@ -82,6 +82,7 @@ static size_t namespace_len;
=20
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
+int git_db_env, git_index_env, git_graft_env;
=20
 /*
  * Repository-local GIT_* environment variables; see cache.h for detai=
ls.
@@ -137,15 +138,19 @@ static void setup_git_env(void)
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
index e088c40..0f8c3dc 100644
--- a/path.c
+++ b/path.c
@@ -60,13 +60,59 @@ char *mksnpath(char *buf, size_t n, const char *fmt=
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
+static void replace_dir(struct strbuf *buf, int len, const char *newdi=
r)
+{
+	int newlen =3D strlen(newdir);
+	int need_sep =3D (buf->buf[len] && !is_dir_sep(buf->buf[len])) &&
+		!is_dir_sep(newdir[newlen - 1]);
+	if (need_sep)
+		len--;	 /* keep one char, to be replaced with '/'  */
+	strbuf_splice(buf, 0, len, newdir, newlen);
+	if (need_sep)
+		buf->buf[newlen] =3D '/';
+}
+
+static void adjust_git_path(struct strbuf *buf, int git_dir_len)
+{
+	const char *base =3D buf->buf + git_dir_len;
+	if (git_graft_env && is_dir_file(base, "info", "grafts"))
+		strbuf_splice(buf, 0, buf->len,
+			      get_graft_file(), strlen(get_graft_file()));
+	else if (git_index_env && !strcmp(base, "index"))
+		strbuf_splice(buf, 0, buf->len,
+			      get_index_file(), strlen(get_index_file()));
+	else if (git_db_env && dir_prefix(base, "objects"))
+		replace_dir(buf, git_dir_len + 7, get_object_directory());
+}
+
 static void do_git_path(struct strbuf *buf, const char *fmt, va_list a=
rgs)
 {
 	const char *git_dir =3D get_git_dir();
+	int gitdir_len;
 	strbuf_addstr(buf, git_dir);
 	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
 		strbuf_addch(buf, '/');
+	gitdir_len =3D buf->len;
 	strbuf_vaddf(buf, fmt, args);
+	adjust_git_path(buf, gitdir_len);
 	strbuf_cleanup_path(buf);
 }
=20
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 07c10c8..1d29901 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -19,6 +19,14 @@ relative_path() {
 	"test \"\$(test-path-utils relative_path '$1' '$2')\" =3D '$expected'=
"
 }
=20
+test_git_path() {
+	test_expect_success "git-path $1 $2 =3D> $3" "
+		$1 git rev-parse --git-path $2 >actual &&
+		echo $3 >expect &&
+		test_cmp expect actual
+	"
+}
+
 # On Windows, we are using MSYS's bash, which mangles the paths.
 # Absolute paths are anchored at the MSYS installation directory,
 # which means that the path / accounts for this many characters:
@@ -223,4 +231,15 @@ relative_path "<null>"		"<empty>"	./
 relative_path "<null>"		"<null>"	./
 relative_path "<null>"		/foo/a/b	./
=20
+test_git_path A=3DB                info/grafts .git/info/grafts
+test_git_path GIT_GRAFT_FILE=3Dfoo info/grafts foo
+test_git_path GIT_GRAFT_FILE=3Dfoo info/////grafts foo
+test_git_path GIT_INDEX_FILE=3Dfoo index foo
+test_git_path GIT_INDEX_FILE=3Dfoo index/foo .git/index/foo
+test_git_path GIT_INDEX_FILE=3Dfoo index2 .git/index2
+test_expect_success 'setup fake objects directory foo' 'mkdir foo'
+test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects foo
+test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects/foo foo/foo
+test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects2 .git/objects2
+
 test_done
--=20
1.8.5.2.240.g8478abd
