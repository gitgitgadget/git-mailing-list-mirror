From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 22/46] check-ignore: convert to use parse_pathspec
Date: Sun, 14 Jul 2013 15:35:45 +0700
Message-ID: <1373790969-13000-23-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:38:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHpB-0002Oz-5i
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab3GNIi3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:38:29 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:38274 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:38:28 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so10296490pbc.35
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aHVStcX4ANZGgVVy+1VLAtb2cr6GUpoyeatFgbwy7cY=;
        b=NADU4j6VhaWLBsZ9+Q5KoNHqLidFhuuTTMREMptFS8nqL5EVex7CLqgabyplHzg7QM
         nUU9KdXediv8whkfJY2qPuObqLJbnWoW36eqh+5Ugzc+oOIIFIzRd9jym5nRdISQwwEp
         Czy/dqCnvdTpUBj6eAY0bGTayhVOeubyIvJk+PnhGmLJk54vGQ8qaKgGuliCG9HtE5do
         ncmJDOmdNhq+HdZonn0e69um4OKJPIl3DmHJcPqm9G9Dnd+MIdwQdsBtbGFEuG/KyaGb
         +WyFl3podnPnk9Lhq7n36Dt1F13bX6KTyT4pj7dTkwjPQ6HOhZeoUEchcdoDAR/SuAmB
         mWZw==
X-Received: by 10.66.224.237 with SMTP id rf13mr51057466pac.26.1373791107950;
        Sun, 14 Jul 2013 01:38:27 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id il4sm22342536pbb.36.2013.07.14.01.38.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:38:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:38:39 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230334>

check-ignore (at least the test suite) seems to rely on the pattern
order. PATHSPEC_KEEP_ORDER is introduced to explictly express this.
The lack of PATHSPEC_MAXDEPTH_VALID is sufficient because it's the
only flag that reorders pathspecs, but it's less obvious that way.

Cc: Adam Spiers <git@adamspiers.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/check-ignore.c | 35 ++++++++++++++++++++++-------------
 pathspec.c             |  6 +++++-
 pathspec.h             |  1 +
 t/t0008-ignores.sh     |  8 ++++----
 4 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 4a8fc70..d49c083 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -64,37 +64,45 @@ static void output_exclude(const char *path, struct=
 exclude *exclude)
 }
=20
 static int check_ignore(struct dir_struct *dir,
-			const char *prefix, const char **pathspec)
+			const char *prefix, int argc, const char **argv)
 {
-	const char *path, *full_path;
+	const char *full_path;
 	char *seen;
 	int num_ignored =3D 0, dtype =3D DT_UNKNOWN, i;
 	struct exclude *exclude;
+	struct pathspec pathspec;
=20
-	if (!pathspec || !*pathspec) {
+	if (!argc) {
 		if (!quiet)
 			fprintf(stderr, "no pathspec given.\n");
 		return 0;
 	}
=20
 	/*
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
+	/*
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
+		full_path =3D pathspec.raw[i];
 		exclude =3D NULL;
 		if (!seen[i]) {
 			exclude =3D last_exclude_matching(dir, full_path, &dtype);
 		}
 		if (!quiet && (exclude || show_non_matching))
-			output_exclude(path, exclude);
+			output_exclude(pathspec.items[i].original, exclude);
 		if (exclude)
 			num_ignored++;
 	}
@@ -120,7 +128,8 @@ static int check_ignore_stdin_paths(struct dir_stru=
ct *dir, const char *prefix)
 			strbuf_swap(&buf, &nbuf);
 		}
 		pathspec[0] =3D buf.buf;
-		num_ignored +=3D check_ignore(dir, prefix, (const char **)pathspec);
+		num_ignored +=3D check_ignore(dir, prefix,
+					    1, (const char **)pathspec);
 		maybe_flush_or_die(stdout, "check-ignore to stdout");
 	}
 	strbuf_release(&buf);
@@ -166,7 +175,7 @@ int cmd_check_ignore(int argc, const char **argv, c=
onst char *prefix)
 	if (stdin_paths) {
 		num_ignored =3D check_ignore_stdin_paths(&dir, prefix);
 	} else {
-		num_ignored =3D check_ignore(&dir, prefix, argv);
+		num_ignored =3D check_ignore(&dir, prefix, argc, argv);
 		maybe_flush_or_die(stdout, "ignore to stdout");
 	}
=20
diff --git a/pathspec.c b/pathspec.c
index ba6408a..5c9631a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -370,9 +370,13 @@ void parse_pathspec(struct pathspec *pathspec,
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
index 6baf205..02dded3 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -51,6 +51,7 @@ struct pathspec {
  */
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
 #define PATHSPEC_PREFIX_ORIGIN (1<<6)
+#define PATHSPEC_KEEP_ORDER (1<<7)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index a56db80..2ced8e9 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -432,7 +432,7 @@ test_expect_success_multi SYMLINKS 'symlink' '::	a/=
symlink' '
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
@@ -440,7 +440,7 @@ test_expect_success_multi SYMLINKS 'beyond a symlin=
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
@@ -449,7 +449,7 @@ test_expect_success_multi SYMLINKS 'beyond a symlin=
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
@@ -457,7 +457,7 @@ test_expect_success_multi 'submodule from subdirect=
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
1.8.2.83.gc99314b
