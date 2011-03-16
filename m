From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/3] Name make_*_path functions more accurately
Date: Wed, 16 Mar 2011 17:06:18 +0100
Message-ID: <1300291579-25852-3-git-send-email-cmn@elego.de>
References: <1300291579-25852-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 17:06:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PztFC-0005La-0Y
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab1CPQG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:06:26 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:42458 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab1CPQGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 12:06:22 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 24D9F46102;
	Wed, 16 Mar 2011 17:06:15 +0100 (CET)
Received: (nullmailer pid 25895 invoked by uid 1000);
	Wed, 16 Mar 2011 16:06:20 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1300291579-25852-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169166>

Rename the make_*_path functions so it's clearer what they do, in
particlar make clear what the differnce between make_absolute_path and
make_nonrelative_path is by renaming them real_path and absolute_path
respectively. make_relative_path has an understandable name and is
renamed to relative_path to maintain the name convention.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 abspath.c         |   22 +++++++++++++++++++---
 cache.h           |    6 +++---
 path.c            |    2 +-
 t/t0000-basic.sh  |   10 +++++-----
 test-path-utils.c |    4 ++--
 5 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/abspath.c b/abspath.c
index ff14068..47bc73e 100644
--- a/abspath.c
+++ b/abspath.c
@@ -14,7 +14,14 @@ int is_directory(const char *path)
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #define MAXDEPTH 5
=20
-const char *make_absolute_path(const char *path)
+/*
+ * Use this to get the real path, i.e. resolve links. If you want an
+ * absolute path but don't mind links, use absolute_path.
+ *
+ * If path is our buffer, then return path, as it's already what the
+ * user wants.
+ */
+const char *real_path(const char *path)
 {
 	static char bufs[2][PATH_MAX + 1], *buf =3D bufs[0], *next_buf =3D bu=
fs[1];
 	char cwd[1024] =3D "";
@@ -104,13 +111,22 @@ static const char *get_pwd_cwd(void)
 	return cwd;
 }
=20
-const char *make_nonrelative_path(const char *path)
+/*
+ * Use this to get an absolute path from a relative one. If you want
+ * to resolve links, you should use real_path.
+ *
+ * If the path is already absolute, then return path. As the user is
+ * never meant to free the return value, we're safe.
+ */
+const char *absolute_path(const char *path)
 {
 	static char buf[PATH_MAX + 1];
=20
 	if (is_absolute_path(path)) {
-		if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
+		if (strlen(path) >=3D PATH_MAX)
 			die("Too long path: %.*s", 60, path);
+		else
+			return path;
 	} else {
 		size_t len;
 		const char *fmt;
diff --git a/cache.h b/cache.h
index c7b0a28..dbc87be 100644
--- a/cache.h
+++ b/cache.h
@@ -716,9 +716,9 @@ static inline int is_absolute_path(const char *path=
)
 	return path[0] =3D=3D '/' || has_dos_drive_prefix(path);
 }
 int is_directory(const char *);
-const char *make_absolute_path(const char *path);
-const char *make_nonrelative_path(const char *path);
-const char *make_relative_path(const char *abs, const char *base);
+const char *real_path(const char *path);
+const char *absolute_path(const char *path);
+const char *relative_path(const char *abs, const char *base);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, const char *prefix_list)=
;
 char *strip_path_suffix(const char *path, const char *suffix);
diff --git a/path.c b/path.c
index 8951333..4d73cc9 100644
--- a/path.c
+++ b/path.c
@@ -397,7 +397,7 @@ int set_shared_perm(const char *path, int mode)
 	return 0;
 }
=20
-const char *make_relative_path(const char *abs, const char *base)
+const char *relative_path(const char *abs, const char *base)
 {
 	static char buf[PATH_MAX + 1];
 	int i =3D 0, j =3D 0;
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 8deec75..f4e8f43 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -435,7 +435,7 @@ test_expect_success 'update-index D/F conflict' '
 	test $numpath0 =3D 1
 '
=20
-test_expect_success SYMLINKS 'absolute path works as expected' '
+test_expect_success SYMLINKS 'real path works as expected' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
 	mkdir second &&
@@ -443,14 +443,14 @@ test_expect_success SYMLINKS 'absolute path works=
 as expected' '
 	mkdir third &&
 	dir=3D"$(cd .git; pwd -P)" &&
 	dir2=3Dthird/../second/other/.git &&
-	test "$dir" =3D "$(test-path-utils make_absolute_path $dir2)" &&
+	test "$dir" =3D "$(test-path-utils real_path $dir2)" &&
 	file=3D"$dir"/index &&
-	test "$file" =3D "$(test-path-utils make_absolute_path $dir2/index)" =
&&
+	test "$file" =3D "$(test-path-utils real_path $dir2/index)" &&
 	basename=3Dblub &&
-	test "$dir/$basename" =3D "$(cd .git && test-path-utils make_absolute=
_path "$basename")" &&
+	test "$dir/$basename" =3D "$(cd .git && test-path-utils real_path "$b=
asename")" &&
 	ln -s ../first/file .git/syml &&
 	sym=3D"$(cd first; pwd -P)"/file &&
-	test "$sym" =3D "$(test-path-utils make_absolute_path "$dir2/syml")"
+	test "$sym" =3D "$(test-path-utils real_path "$dir2/syml")"
 '
=20
 test_expect_success 'very long name in the index handled sanely' '
diff --git a/test-path-utils.c b/test-path-utils.c
index d261398..e767159 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -11,9 +11,9 @@ int main(int argc, char **argv)
 		return 0;
 	}
=20
-	if (argc >=3D 2 && !strcmp(argv[1], "make_absolute_path")) {
+	if (argc >=3D 2 && !strcmp(argv[1], "real_path")) {
 		while (argc > 2) {
-			puts(make_absolute_path(argv[2]));
+			puts(real_path(argv[2]));
 			argc--;
 			argv++;
 		}
--=20
1.7.4.1
