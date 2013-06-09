From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/45] check-ignore: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:55 +0700
Message-ID: <1370759178-1709-23-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:27:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ5y-0000nW-Q0
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab3FIG1O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:27:14 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40779 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab3FIG1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:27:12 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so2416512pde.18
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xrTsKUfnPHAV509tw71lKBOlFltPh+LFnZ4WZyUXO9s=;
        b=NWhIWQ1np0cIiVDGjL4Zaki7kKFveffd3l30oloJcqTfyJJ3ja1BkGWC6ctU1zPFf3
         E8QUh5JeYenW4h491EQleYGyseXvOVyxkwl886iTO+PnXVVebC4P8L47Y9usPgq9WE5f
         epEjoDIeIWSQxsa7N6CjZ5KxVoJ8vFDnyqV6XZRfB092Lnk+0CxNUzCKSh2J8thcoSKx
         yeiFY3CwIpEYOTi/za4AhB63UVt/ldezYFetA/4d9+zj8/fnTjNUMtPuUhK5BNZyRMDh
         DOIT3Nb2U37cx5ClggFBehj/bKN3VjLm1OpdviLc+0BHgVZoQqRQIQt0uNPO6W2f89BU
         x+0A==
X-Received: by 10.68.245.170 with SMTP id xp10mr5216808pbc.41.1370759232265;
        Sat, 08 Jun 2013 23:27:12 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id eq5sm5541056pbc.15.2013.06.08.23.27.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:27:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:43 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226914>

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
index ba0a41d..152f9b5 100644
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
index 7068f7d..4f144fd 100644
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
