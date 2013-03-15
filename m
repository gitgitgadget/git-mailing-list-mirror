From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 23/45] check-ignore: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:38 +0700
Message-ID: <1363327620-29017-24-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO6g-00068c-7C
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab3COG0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:26:40 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:57513 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab3COG0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:26:38 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so2928558iag.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=nA8pS5ZsidI7Iw7G9tseRwHSeCovUX14VtunxLRpekE=;
        b=GqLNX2+jNDy6skm7e/w1Jgsy4YW365ee6dC8yZUfKp51/wwwQWj5YcwK4hgMdzdvx7
         PKGml23bbpQSWowXOqaQhx87wwn9eWn0abfkEp3tc3R+pmVJjY98w/nYcEWn+x1Bjw94
         8EahQPiuac0p+7YQaX/I39bRp2FDia48+ucCZREBmnm2IZYwSaw3khvnINwERLri4Kb8
         0NvpFATwnuilfi45kAT0EacsGS5Md/ipGErXnukILPgafUqwwUZttCzZL7eHoenU1Ybb
         4wSI+r7spUroIryDENOd9kZbUG8zA3e44UxtJzWFjNWPv9lnM2yHaGDrNmdmke3viJYn
         0OKA==
X-Received: by 10.50.153.232 with SMTP id vj8mr318645igb.2.1363328798357;
        Thu, 14 Mar 2013 23:26:38 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id px9sm1089237igc.0.2013.03.14.23.26.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:26:37 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:09:40 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218210>

check-ignore (at least the test suite) seems to rely on the pattern
order. PATHSPEC_KEEP_ORDER is introduced to explictly express this.
The lack of PATHSPEC_MAXDEPTH_VALID is sufficient because it's the
only flag that reorders pathspecs, but it's less obvious that way.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/check-ignore.c | 34 +++++++++++++++++++++-------------
 pathspec.c             |  6 +++++-
 pathspec.h             |  1 +
 t/t0008-ignores.sh     |  8 ++++----
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 0240f99..6e55f06 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -53,14 +53,14 @@ static void output_exclude(const char *path, struct=
 exclude *exclude)
 	}
 }
=20
-static int check_ignore(const char *prefix, const char **pathspec)
+static int check_ignore(int argc, const char **argv, const char *prefi=
x)
 {
 	struct dir_struct dir;
-	const char *path, *full_path;
 	char *seen;
 	int num_ignored =3D 0, dtype =3D DT_UNKNOWN, i;
 	struct path_exclude_check check;
 	struct exclude *exclude;
+	struct pathspec pathspec;
=20
 	/* read_cache() is only necessary so we can watch out for submodules.=
 */
 	if (read_cache() < 0)
@@ -70,31 +70,39 @@ static int check_ignore(const char *prefix, const c=
har **pathspec)
 	dir.flags |=3D DIR_COLLECT_IGNORED;
 	setup_standard_excludes(&dir);
=20
-	if (!pathspec || !*pathspec) {
+	if (!argc) {
 		if (!quiet)
 			fprintf(stderr, "no pathspec given.\n");
 		return 0;
 	}
=20
+	/*
+	 * check-ignore just needs paths. Magic beyond :/ is really
+	 * irrelevant.
+	 */
+	parse_pathspec(&pathspec,
+		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+		       PATHSPEC_SYMLINK_LEADING_PATH |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE |
+		       PATHSPEC_KEEP_ORDER,
+		       prefix, argv);
+
 	path_exclude_check_init(&check, &dir);
 	/*
 	 * look for pathspecs matching entries in the index, since these
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen =3D find_pathspecs_matching_against_index(pathspec);
-	for (i =3D 0; pathspec[i]; i++) {
-		path =3D pathspec[i];
-		full_path =3D prefix_path(prefix, prefix
-					? strlen(prefix) : 0, path);
-		full_path =3D check_path_for_gitlink(full_path);
-		die_if_path_beyond_symlink(full_path, prefix);
+	seen =3D find_pathspecs_matching_against_index(pathspec.raw);
+	for (i =3D 0; i < pathspec.nr; i++) {
+		const char *full_path =3D pathspec.raw[i];
 		if (!seen[i]) {
 			exclude =3D last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
 			if (exclude) {
 				if (!quiet)
-					output_exclude(path, exclude);
+					output_exclude(pathspec.items[i].original,
+						       exclude);
 				num_ignored++;
 			}
 		}
@@ -129,7 +137,7 @@ static int check_ignore_stdin_paths(const char *pre=
fix)
 	}
 	ALLOC_GROW(pathspec, nr + 1, alloc);
 	pathspec[nr] =3D NULL;
-	num_ignored =3D check_ignore(prefix, (const char **)pathspec);
+	num_ignored =3D check_ignore(nr, (const char **)pathspec, prefix);
 	maybe_flush_or_die(stdout, "attribute to stdout");
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
@@ -165,7 +173,7 @@ int cmd_check_ignore(int argc, const char **argv, c=
onst char *prefix)
 	if (stdin_paths) {
 		num_ignored =3D check_ignore_stdin_paths(prefix);
 	} else {
-		num_ignored =3D check_ignore(prefix, argv);
+		num_ignored =3D check_ignore(argc, argv, prefix);
 		maybe_flush_or_die(stdout, "ignore to stdout");
 	}
=20
diff --git a/pathspec.c b/pathspec.c
index 9a57c0c..f531038 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -368,9 +368,13 @@ void parse_pathspec(struct pathspec *pathspec,
 		pathspec->magic |=3D item[i].magic;
 	}
=20
-	if (pathspec->magic & PATHSPEC_MAXDEPTH)
+
+	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
+		if (flags & PATHSPEC_KEEP_ORDER)
+			die("BUG: PATHSPEC_MAXDEPTH_VALID and PATHSPEC_KEEP_ORDER are incom=
patible");
 		qsort(pathspec->items, pathspec->nr,
 		      sizeof(struct pathspec_item), pathspec_item_cmp);
+	}
 }
=20
 /*
diff --git a/pathspec.h b/pathspec.h
index ed5d3a6..44253c8 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -42,6 +42,7 @@ struct pathspec {
 #define PATHSPEC_SYMLINK_LEADING_PATH (1<<4)
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
 #define PATHSPEC_PREFIX_ORIGIN (1<<6)
+#define PATHSPEC_KEEP_ORDER (1<<7)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 9c1bde1..c41f60b 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -397,7 +397,7 @@ test_expect_success_multi SYMLINKS 'symlink' '' '
=20
 test_expect_success_multi SYMLINKS 'beyond a symlink' '' '
 	test_check_ignore "a/symlink/foo" 128 &&
-	test_stderr "fatal: '\''a/symlink/foo'\'' is beyond a symbolic link"
+	test_stderr "fatal: pathspec '\''a/symlink/foo'\'' is beyond a symbol=
ic link"
 '
=20
 test_expect_success_multi SYMLINKS 'beyond a symlink from subdirectory=
' '' '
@@ -405,7 +405,7 @@ test_expect_success_multi SYMLINKS 'beyond a symlin=
k from subdirectory' '' '
 		cd a &&
 		test_check_ignore "symlink/foo" 128
 	) &&
-	test_stderr "fatal: '\''symlink/foo'\'' is beyond a symbolic link"
+	test_stderr "fatal: pathspec '\''symlink/foo'\'' is beyond a symbolic=
 link"
 '
=20
 ######################################################################=
######
@@ -414,7 +414,7 @@ test_expect_success_multi SYMLINKS 'beyond a symlin=
k from subdirectory' '' '
=20
 test_expect_success_multi 'submodule' '' '
 	test_check_ignore "a/submodule/one" 128 &&
-	test_stderr "fatal: Path '\''a/submodule/one'\'' is in submodule '\''=
a/submodule'\''"
+	test_stderr "fatal: Pathspec '\''a/submodule/one'\'' is in submodule =
'\''a/submodule'\''"
 '
=20
 test_expect_success_multi 'submodule from subdirectory' '' '
@@ -422,7 +422,7 @@ test_expect_success_multi 'submodule from subdirect=
ory' '' '
 		cd a &&
 		test_check_ignore "submodule/one" 128
 	) &&
-	test_stderr "fatal: Path '\''a/submodule/one'\'' is in submodule '\''=
a/submodule'\''"
+	test_stderr "fatal: Pathspec '\''submodule/one'\'' is in submodule '\=
''a/submodule'\''"
 '
=20
 ######################################################################=
######
--=20
1.8.0.rc0.19.g7bbb31d
