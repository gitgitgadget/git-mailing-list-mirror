From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/3] builtin/grep: introduce --use-index argument
Date: Mon, 11 Jan 2016 18:00:48 +0100
Message-ID: <1452531648-16575-4-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452531648-16575-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 18:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfps-0001Ss-Vh
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326AbcAKRAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2016 12:00:46 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34493 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbcAKRAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:00:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so27205253wmb.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 09:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=H89HQtA12mJ5aHDkag04eu8uTXoBET6gOiPl22TjNds=;
        b=WrkVrRbRPoXetveo6ztugfRt7aZXwaX43T1h/o8sNPu0GmXCqpUY2DefuUAegsx7fK
         XtX1oTsp/W4UpFKEgZLBaVkzdu6P7FnuTDNkJ146SYh0HUqumE2jJEj45KVtr4PBQnpw
         2WkKr7wuWR2vXw5NtMbrsAJsGz7yHH5IJqj1Gi4IKWbWqD17hZbMzWT/vB4oInpUeZom
         ONV+o3+WZ28DAy/o3e9pJ/kU/RyBTR9c9u0oWgBOLB+V3IbxhknHTc5VeX8HSehiq07I
         bAarszG4dvYeWXWJ+8mfEXoaqarqlbMyxD/i2vMdkbPznTbjqa+pOwmjHVcS6wuIi41j
         CyXQ==
X-Received: by 10.194.11.66 with SMTP id o2mr153085461wjb.103.1452531643616;
        Mon, 11 Jan 2016 09:00:43 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id e2sm6068283wma.1.2016.01.11.09.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 09:00:42 -0800 (PST)
X-Mailer: git-send-email 2.6.0.rc0.160.g9ddbed8
In-Reply-To: <1452531648-16575-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283673>

Currently when git grep is used outside of a git repository without the
--no-index option git simply dies.  Introduce a new --use-index command=
 line
argument, which can be set to always, optional, or never.  If it is set
to always, git grep continues to behave as it currently does.  If set t=
o
optional, git grep will work normally if executed inside of a git
repository, and behave like git grep --no-index if used outside of a gi=
t
repository.  If set to never, git grep will behave like git grep
--no-index regardless of whether it is used inside or outside of a git
repository.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-grep.txt | 13 ++++++++
 builtin/grep.c             | 47 +++++++++++++++++++++++---
 t/t7810-grep.sh            | 82 ++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..90ff643 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -25,6 +25,7 @@ SYNOPSIS
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
+	   [--use-index=3D<always|optional|never>]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] =
| <tree>...]
 	   [--] [<pathspec>...]
=20
@@ -66,6 +67,18 @@ OPTIONS
 --no-index::
 	Search files in the current directory that is not managed by Git.
=20
+--use-index::
+	Set the behavior of git grep when used in- or outside of a git
+	repository.  If set to always, the command can only be used
+	inside of a git repository, and will fail if it is used
+	outside of a git repository.  If set to never, it will work
+	both inside and outside of a git repository, but will not use
+	any information in the index if used inside of a repository.
+	If set to optional, it will work both inside and outside of a
+	git repository, using the information available in the index
+	if used inside a repository.  Always and optional can be
+	overridden by `--no-index`.
+
 --untracked::
 	In addition to searching in the tracked files in the working
 	tree, search also in untracked files.
diff --git a/builtin/grep.c b/builtin/grep.c
index 3a27bd5..bb2add9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -19,6 +19,9 @@
 #include "dir.h"
 #include "pathspec.h"
=20
+#define GREP_NO_INDEX_EXPLICIT 1
+#define GREP_NO_INDEX_IMPLICIT 2
+
 static char const * const grep_usage[] =3D {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]")=
,
 	NULL
@@ -626,13 +629,17 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 	int i;
 	int dummy;
 	int no_index =3D 0;
+	const char *use_index =3D NULL;
 	int pattern_type_arg =3D GREP_PATTERN_TYPE_UNSPECIFIED;
=20
 	struct option options[] =3D {
 		OPT_BOOL(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
 		OPT_BIT(0, "no-index", &no_index,
-			N_("find in contents not managed by git"), 1),
+			N_("find in contents not managed by git"),
+			GREP_NO_INDEX_EXPLICIT),
+		OPT_STRING(0, "use-index", &use_index, N_("always|optional|never"),
+			   N_("options for using the index")),
 		OPT_BOOL(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
@@ -755,6 +762,25 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
=20
+	if (use_index) {
+		if (!strcmp(use_index, "always")) {
+			/* same as git grep without --use-index */
+		} else if (!strcmp(use_index, "optional")) {
+			if (!no_index && !startup_info->have_repository) {
+				int nongit =3D 0;
+
+				setup_git_directory_gently(&nongit);
+				if (nongit)
+					no_index =3D GREP_NO_INDEX_IMPLICIT;
+			}
+		} else if (!strcmp(use_index, "never")) {
+			no_index =3D GREP_NO_INDEX_EXPLICIT;
+		} else {
+			die(_("invalid option \"%s\" for --use-index, expecting"
+			      " always, optional or never"), use_index);
+		}
+	}
+
 	if (!no_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
 		setup_git_directory();
@@ -873,13 +899,24 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
=20
-	if (no_index && (untracked || cached))
-		die(_("--cached or --untracked cannot be used with --no-index."));
+	if (no_index && (untracked || cached)) {
+		if (no_index =3D=3D GREP_NO_INDEX_IMPLICIT)
+			die(_("--cached or --untracked cannot be used outside "
+			      "of a git repository."));
+		else
+			die(_("--cached or --untracked cannot be used with "
+			      "--no-index or --no-index=3Dnever."));
+	}
=20
 	if (no_index || untracked) {
 		int use_exclude =3D (opt_exclude < 0) ? !no_index : !!opt_exclude;
-		if (list.nr)
-			die(_("--no-index or --untracked cannot be used with revs."));
+		if (list.nr) {
+			if (no_index =3D=3D GREP_NO_INDEX_IMPLICIT)
+				die(_("cannot use revs outside of a git repository."));
+			else
+				die(_("--no-index, --use-index=3Dnever or "
+				      "--untracked cannot be used with revs."));
+		}
 		hit =3D grep_directory(&opt, &pathspec, use_exclude);
 	} else if (0 <=3D opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."=
));
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index cc4b97d..9776f15 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -821,6 +821,88 @@ test_expect_success 'outside of git repository' '
 	)
 '
=20
+test_expect_success 'outside of git repository with --use-index=3Dopti=
onal' '
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	echo hello >non/git/file1 &&
+	echo world >non/git/sub/file2 &&
+	cat <<-\EOF >non/expect.full &&
+	file1:hello
+	sub/file2:world
+	EOF
+	echo file2:world >non/expect.sub &&
+	(
+		GIT_CEILING_DIRECTORIES=3D"$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep --use-index=3Dalways o &&
+		git grep --use-index=3Doptional o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git grep --use-index=3Dalways o &&
+		git grep --use-index=3Doptional o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	) &&
+
+	echo ".*o*" >non/git/.gitignore &&
+	(
+		GIT_CEILING_DIRECTORIES=3D"$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep --use-index=3Dalways o &&
+		git grep --use-index=3Doptional --exclude-standard o >../actual.full=
 &&
+		test_cmp ../expect.full ../actual.full &&
+
+		{
+			echo ".gitignore:.*o*" &&
+			cat ../expect.full
+		} >../expect.with.ignored &&
+		git grep --use-index=3Doptional --no-exclude o >../actual.full &&
+		test_cmp ../expect.with.ignored ../actual.full
+	)
+'
+
+test_expect_success 'outside of git repository with --use-index=3Dneve=
r' '
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	echo hello >non/git/file1 &&
+	echo world >non/git/sub/file2 &&
+	cat <<-\EOF >non/expect.full &&
+	file1:hello
+	sub/file2:world
+	EOF
+	echo file2:world >non/expect.sub &&
+	(
+		GIT_CEILING_DIRECTORIES=3D"$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep --use-index=3Dalways o &&
+		git grep --use-index=3Dnever o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git grep --use-index=3Dalways o &&
+		git grep --use-index=3Dnever o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	) &&
+
+	echo ".*o*" >non/git/.gitignore &&
+	(
+		GIT_CEILING_DIRECTORIES=3D"$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep --use-index=3Dalways o &&
+		git grep --use-index=3Dnever --exclude-standard o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+
+		{
+			echo ".gitignore:.*o*" &&
+			cat ../expect.full
+		} >../expect.with.ignored &&
+		git grep --use-index=3Dnever --no-exclude o >../actual.full &&
+		test_cmp ../expect.with.ignored ../actual.full
+	)
+'
+
 test_expect_success 'inside git repository but with --no-index' '
 	rm -fr is &&
 	mkdir -p is/git/sub &&
--=20
2.7.0.3.g214d8d0.dirty
