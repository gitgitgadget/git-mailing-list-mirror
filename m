From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 01/11] Introduce "check-attr --excluded" as a replacement for "add --ignore-missing"
Date: Mon, 24 Oct 2011 17:36:06 +1100
Message-ID: <1319438176-7304-2-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEAx-0000Zg-AS
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab1JXGiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:38:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34769 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1JXGiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:38:17 -0400
Received: by gyb13 with SMTP id 13so5420126gyb.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UwxIjqYJvBi0CU4byvLO+YXiUTUUR75gWQy7fXofo6U=;
        b=s7mdY528DPgrVJTmXT0ysG3UdyLcuOdgZ6V4LwGrA13Lv6dB7k/VajpQppBB3Uf6LM
         a8yqUZQtUq17AP792uPd4WTXsJZhBgjYXTrlVMIlbHRsRrrYbn6tjBOwuli8WRgwTmqb
         le9BOl2XZDoXIcoRrbRkCnCfD0ym6H9d8vEdw=
Received: by 10.236.175.130 with SMTP id z2mr32745834yhl.12.1319438296968;
        Sun, 23 Oct 2011 23:38:16 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id d63sm31185544yhl.10.2011.10.23.23.38.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:38:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:36:32 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184154>

--ignore-missing is used by submodule to check if a path may be
ignored by .gitignore files. It does not really fit in git-add (git
add takes pathspec, but --ignore-missing takes only paths)

Google reckons that --ignore-missing is not used anywhere but
git-submodule.sh. Remove --ignore-missing and introduce "check-attr
--excluded" as a replacement.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-check-attr.txt |    4 ++++
 builtin/add.c                    |   14 +++-----------
 builtin/check-attr.c             |   26 ++++++++++++++++++++++++++
 git-submodule.sh                 |    2 +-
 t/t3700-add.sh                   |   19 -------------------
 5 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check=
-attr.txt
index 5abdbaa..94d2068 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git check-attr' [-a | --all | attr...] [--] pathname...
 'git check-attr' --stdin [-z] [-a | --all | attr...] < <list-of-paths>
+'git check-attr' --excluded pathname...
=20
 DESCRIPTION
 -----------
@@ -34,6 +35,9 @@ OPTIONS
 	Only meaningful with `--stdin`; paths are separated with a
 	NUL character instead of a linefeed character.
=20
+--excluded::
+	Check if given paths are excluded by standard .gitignore rules.
+
 \--::
 	Interpret all preceding arguments as attributes and all following
 	arguments as path names.
diff --git a/builtin/add.c b/builtin/add.c
index c59b0c9..23ad4b8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -310,7 +310,7 @@ static const char ignore_error[] =3D
 N_("The following paths are ignored by one of your .gitignore files:\n=
");
=20
 static int verbose =3D 0, show_only =3D 0, ignored_too =3D 0, refresh_=
only =3D 0;
-static int ignore_add_errors, addremove, intent_to_add, ignore_missing=
 =3D 0;
+static int ignore_add_errors, addremove, intent_to_add;
=20
 static struct option builtin_add_options[] =3D {
 	OPT__DRY_RUN(&show_only, "dry run"),
@@ -325,7 +325,6 @@ static struct option builtin_add_options[] =3D {
 	OPT_BOOLEAN('A', "all", &addremove, "add changes from all tracked and=
 untracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh t=
he index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip file=
s which cannot be added because of errors"),
-	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, "check if - even =
missing - files are ignored in dry run"),
 	OPT_END(),
 };
=20
@@ -387,8 +386,6 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
-	if (!show_only && ignore_missing)
-		die(_("Option --ignore-missing can only be used together with --dry-=
run"));
 	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] =3D { ".", NULL };
 		argc =3D 1;
@@ -446,13 +443,8 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 		for (i =3D 0; pathspec[i]; i++) {
 			if (!seen[i] && pathspec[i][0]
 			    && !file_exists(pathspec[i])) {
-				if (ignore_missing) {
-					int dtype =3D DT_UNKNOWN;
-					if (excluded(&dir, pathspec[i], &dtype))
-						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
-				} else
-					die(_("pathspec '%s' did not match any files"),
-					    pathspec[i]);
+				die(_("pathspec '%s' did not match any files"),
+				    pathspec[i]);
 			}
 		}
 		free(seen);
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 44c421e..4c17ccc 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -2,11 +2,13 @@
 #include "cache.h"
 #include "attr.h"
 #include "quote.h"
+#include "dir.h"
 #include "parse-options.h"
=20
 static int all_attrs;
 static int cached_attrs;
 static int stdin_paths;
+static int exclude;
 static const char * const check_attr_usage[] =3D {
 "git check-attr [-a | --all | attr...] [--] pathname...",
 "git check-attr --stdin [-a | --all | attr...] < <list-of-paths>",
@@ -21,6 +23,7 @@ static const struct option check_attr_options[] =3D {
 	OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
 	OPT_BOOLEAN('z', NULL, &null_term_line,
 		"input paths are terminated by a null character"),
+	OPT_BOOLEAN(0,  "excluded", &exclude, "check exclude patterns"),
 	OPT_END()
 };
=20
@@ -43,6 +46,16 @@ static void output_attr(int cnt, struct git_attr_che=
ck *check,
 	}
 }
=20
+static void check_exclude(struct dir_struct *dir, const char *prefix, =
const char *file)
+{
+	char *full_path =3D
+		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
+	int dtype =3D DT_UNKNOWN;
+	if (excluded(dir, full_path, &dtype))
+		die("%s is ignored by one of your .gitignore files", full_path);
+	free(full_path);
+}
+
 static void check_attr(const char *prefix, int cnt,
 	struct git_attr_check *check, const char *file)
 {
@@ -103,6 +116,19 @@ int cmd_check_attr(int argc, const char **argv, co=
nst char *prefix)
 		die("invalid cache");
 	}
=20
+	if (exclude) {
+		struct dir_struct dir;
+
+		if (stdin_paths)
+			die("--excluded cannot be used with --stdin (yet)");
+
+		memset(&dir, 0, sizeof(dir));
+		setup_standard_excludes(&dir);
+		for (i =3D 0; i < argc; i++)
+			check_exclude(&dir, prefix, argv[i]);
+		return 0;
+	}
+
 	if (cached_attrs)
 		git_attr_set_direction(GIT_ATTR_INDEX, NULL);
=20
diff --git a/git-submodule.sh b/git-submodule.sh
index 928a62f..0bc3762 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -262,7 +262,7 @@ cmd_add()
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "$(eval_gettext "'\$path' already exists in the index")"
=20
-	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
+	if test -z "$force" && ! git check-attr --excluded "$path" > /dev/nul=
l 2>&1
 	then
 		eval_gettextln "The following path is ignored by one of your .gitign=
ore files:
 \$path
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 575d950..23ff998 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -276,23 +276,4 @@ test_expect_success 'git add --dry-run of an exist=
ing file output' "
 	test_i18ncmp expect actual
 "
=20
-cat >expect.err <<\EOF
-The following paths are ignored by one of your .gitignore files:
-ignored-file
-Use -f if you really want to add them.
-fatal: no files added
-EOF
-cat >expect.out <<\EOF
-add 'track-this'
-EOF
-
-test_expect_success 'git add --dry-run --ignore-missing of non-existin=
g file' '
-	test_must_fail git add --dry-run --ignore-missing track-this ignored-=
file >actual.out 2>actual.err
-'
-
-test_expect_success 'git add --dry-run --ignore-missing of non-existin=
g file output' '
-	test_i18ncmp expect.out actual.out &&
-	test_i18ncmp expect.err actual.err
-'
-
 test_done
--=20
1.7.3.1.256.g2539c.dirty
