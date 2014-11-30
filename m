From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/34] git_path(): be aware of file relocation in $GIT_DIR
Date: Sun, 30 Nov 2014 15:24:31 +0700
Message-ID: <1417335899-27307-7-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:26:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzpt-0007Rv-TI
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbaK3I00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:26:26 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47584 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaK3I0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:26:25 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so9166563pad.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ATxlQgr9vSshNRvi4wAUEVJJ3BEphhXVVPKGlDOR4ok=;
        b=qqJNkZUdi5lNbvgM1MSqzCdlEZEennzua+o8GRWXxBt+FHr/d3UTkA9/kwQMeXvtmz
         Mxf6kcELuXcGXV7xBuwcHs9G/mGAecg92WExlzIc+7JHyD33y+ew78je1OdVLx9Qq04i
         DKhbLsYRpIE2G9E1/cc6J4TaIXePA9WG6bLvVKSxWmoU7NeH93f/3qWWnADd3vfQnjHq
         kOAbbEU7tUScvt5csrrZeQ6+VSsOT7Dv28KppzDdpgl8qBaVgM8g1QwJO3nJ/QCpyIS7
         XHlOYIL3mToE4fyHXI5U2ClfEz7EzhPjY4OXPSdItCBb1ug81JNAI7kimNrN27iNGuX2
         hvWw==
X-Received: by 10.70.96.145 with SMTP id ds17mr11295041pdb.88.1417335985223;
        Sun, 30 Nov 2014 00:26:25 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id va2sm14389004pac.15.2014.11.30.00.26.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:26:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:26:07 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260393>

We allow the user to relocate certain paths out of $GIT_DIR via
environment variables, e.g. GIT_OBJECT_DIRECTORY, GIT_INDEX_FILE and
GIT_GRAFT_FILE. Callers are not supposed to use git_path() or
git_pathdup() to get those paths. Instead they must use
get_object_directory(), get_index_file() and get_graft_file()
respectively. This is inconvenient and could be missed in review (for
example, there's git_path("objects/info/alternates") somewhere in
sha1_file.c).

This patch makes git_path() and git_pathdup() understand those
environment variables. So if you set GIT_OBJECT_DIRECTORY to /foo/bar,
git_path("objects/abc") should return /foo/bar/abc. The same is done
for the two remaining env variables.

"git rev-parse --git-path" is the wrapper for script use.

This patch kinda reverts a0279e1 (setup_git_env: use git_pathdup
instead of xmalloc + sprintf - 2014-06-19) because using git_pathdup
here would result in infinite recursion:

  setup_git_env() -> git_pathdup("objects") -> .. -> adjust_git_path()
  -> get_object_directory() -> oops, git_object_directory is NOT set
  yet -> setup_git_env()

I wanted to make git_pathdup_literal() that skips adjust_git_path().
But that won't work because later on when $GIT_COMMON_DIR is
introduced, git_pathdup_literal("objects") needs adjust_git_path() to
replace $GIT_DIR with $GIT_COMMON_DIR.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-rev-parse.txt |  7 ++++++
 builtin/rev-parse.c             |  7 ++++++
 cache.h                         |  1 +
 environment.c                   | 19 +++++++++++-----
 path.c                          | 49 +++++++++++++++++++++++++++++++++=
++++++--
 t/t0060-path-utils.sh           | 19 ++++++++++++++++
 6 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index d6de42f..2103bbf 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -233,6 +233,13 @@ print a message to stderr and exit with nonzero st=
atus.
 	repository.  If <path> is a gitfile then the resolved path
 	to the real repository is printed.
=20
+--git-path <path>::
+	Resolve "$GIT_DIR/<path>" and takes other path relocation
+	variables such as $GIT_OBJECT_DIRECTORY,
+	$GIT_INDEX_FILE... into account. For example, if
+	$GIT_OBJECT_DIRECTORY is set to /foo/bar then "git rev-parse
+	--git-path objects/abc" returns /foo/bar/abc.
+
 --show-cdup::
 	When the command is invoked from a subdirectory, show the
 	path of the top-level directory relative to the current
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 35d3c43..4cd44aa 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -533,6 +533,13 @@ int cmd_rev_parse(int argc, const char **argv, con=
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
index 56643cf..7da2ffb 100644
--- a/cache.h
+++ b/cache.h
@@ -617,6 +617,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern int git_db_env, git_index_env, git_graft_env;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/environment.c b/environment.c
index 565f652..fee12a6 100644
--- a/environment.c
+++ b/environment.c
@@ -83,6 +83,7 @@ static size_t namespace_len;
=20
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
+int git_db_env, git_index_env, git_graft_env;
=20
 /*
  * Repository-local GIT_* environment variables; see cache.h for detai=
ls.
@@ -124,10 +125,18 @@ static char *expand_namespace(const char *raw_nam=
espace)
 	return strbuf_detach(&buf, NULL);
 }
=20
-static char *git_path_from_env(const char *envvar, const char *path)
+static char *git_path_from_env(const char *envvar, const char *path,
+			       int *fromenv)
 {
 	const char *value =3D getenv(envvar);
-	return value ? xstrdup(value) : git_pathdup("%s", path);
+	if (!value) {
+		char *buf =3D xmalloc(strlen(git_dir) + strlen(path) + 2);
+		sprintf(buf, "%s/%s", git_dir, path);
+		return buf;
+	}
+	if (fromenv)
+		*fromenv =3D 1;
+	return xstrdup(value);
 }
=20
 static void setup_git_env(void)
@@ -140,9 +149,9 @@ static void setup_git_env(void)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile =3D read_gitfile(git_dir);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
-	git_object_dir =3D git_path_from_env(DB_ENVIRONMENT, "objects");
-	git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, "index");
-	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, "info/grafts"=
);
+	git_object_dir =3D git_path_from_env(DB_ENVIRONMENT, "objects", &git_=
db_env);
+	git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, "index", &git=
_index_env);
+	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, "info/grafts"=
, &git_graft_env);
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs =3D 0;
 	namespace =3D expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
diff --git a/path.c b/path.c
index df0f75b..4910783 100644
--- a/path.c
+++ b/path.c
@@ -60,13 +60,58 @@ char *mksnpath(char *buf, size_t n, const char *fmt=
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
-	const char *git_dir =3D get_git_dir();
-	strbuf_addstr(buf, git_dir);
+	int gitdir_len;
+	strbuf_addstr(buf, get_git_dir());
 	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
 		strbuf_addch(buf, '/');
+	gitdir_len =3D buf->len;
 	strbuf_vaddf(buf, fmt, args);
+	adjust_git_path(buf, gitdir_len);
 	strbuf_cleanup_path(buf);
 }
=20
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index c0143a0..33d2818 100755
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
@@ -244,4 +252,15 @@ relative_path "<null>"		"<empty>"	./
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
2.1.0.rc0.78.gc0d8480
