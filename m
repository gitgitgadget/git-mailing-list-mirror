From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git add: Add the "--ignore-missing" option for the dry run
Date: Sat, 10 Jul 2010 00:18:38 +0200
Message-ID: <4C37A03E.7030801@web.de>
References: <1278098521-5321-1-git-send-email-avarab@gmail.com>	<1278351183-18734-1-git-send-email-avarab@gmail.com>	<7vmxu572w5.fsf@alter.siamese.dyndns.org>	<4C33A552.5060008@web.de> <AANLkTinn_Vz6I619Do4AOCVMUgfpyy84L1wh3lkuCP7R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 00:18:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXLuA-0002AD-5j
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 00:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab0GIWSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 18:18:41 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59310 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab0GIWSk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 18:18:40 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id EEC53163616D7;
	Sat, 10 Jul 2010 00:18:38 +0200 (CEST)
Received: from [80.128.127.7] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OXLu2-0002Yn-00; Sat, 10 Jul 2010 00:18:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <AANLkTinn_Vz6I619Do4AOCVMUgfpyy84L1wh3lkuCP7R@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX192T4JqidU+OGt6fqug5fTjRWoyESRYP8PWmm5w
	dzPi4UF6/W8XDG1GEhvJiiSxAYXB41pVHcycJ1geas1w+fP+7u
	CfPNW9PhmCEK+ePi7u2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150692>

Sometimes it is useful to know if a file or directory will be ignored
before it is added to the work tree. An example is "git submodule add",
where it would be really nice to be able to fail with an appropriate
error message before the submodule is cloned and checked out.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 07.07.2010 00:33, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Option b) is more consistent with git-add, but I can't find a way to
> ask any git tool whether a non-existing path is ignored without
> actually adding something. git add --dry-run will die on "pathspec
> 'foo' did not match any files" unless the file exists already.

Right, and as IMHO creating a directory with the same name of the
submodule and then deleting it again after the "git add --dry-run"
is way too hackish, what about adding a "--ignore-missing" option to
"git add", which ignores any missing files when used with the option
"--dry-run"?

(And to add some bikeshedding-fodder: I also thought about naming
that option "--dry-run=3Dignore-missing" or "--only-ignored". I really
don't have any strong feelings about the particular naming, so if
anyone has a better idea, please speak up!)

With this patch it should be easy to have "git submodule add" return
an error /before/ adding a submodule path and its contents when it
is found in .gitignore.

Opinions?


 Documentation/git-add.txt |    9 ++++++++-
 builtin/add.c             |   16 ++++++++++++----
 dir.c                     |    2 +-
 dir.h                     |    1 +
 t/t3700-add.sh            |   25 +++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 74741a4..bfea2c2 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -57,7 +57,8 @@ OPTIONS

 -n::
 --dry-run::
-        Don't actually add the file(s), just show if they exist.
+	Don't actually add the file(s), just show if they exist and/or will
+	be ignored.

 -v::
 --verbose::
@@ -131,6 +132,12 @@ subdirectories.
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.

+--ignore-missing::
+	This option can only be used together with --dry-run. By using
+	this option the user can check if any of the given files would
+	be ignored, no matter if they are already present in the work
+	tree or not.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin/add.c b/builtin/add.c
index 17149cf..56a4e0a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -310,7 +310,7 @@ static const char ignore_error[] =3D
 "The following paths are ignored by one of your .gitignore files:\n";

 static int verbose =3D 0, show_only =3D 0, ignored_too =3D 0, refresh_=
only =3D 0;
-static int ignore_add_errors, addremove, intent_to_add;
+static int ignore_add_errors, addremove, intent_to_add, ignore_missing=
 =3D 0;

 static struct option builtin_add_options[] =3D {
 	OPT__DRY_RUN(&show_only),
@@ -325,6 +325,7 @@ static struct option builtin_add_options[] =3D {
 	OPT_BOOLEAN('A', "all", &addremove, "add all, noticing removal of tra=
cked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh t=
he index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip file=
s which cannot be added because of errors"),
+	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, "check if - even =
missing - files are ignored in dry run"),
 	OPT_END(),
 };

@@ -385,6 +386,8 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)

 	if (addremove && take_worktree_changes)
 		die("-A and -u are mutually incompatible");
+	if (!show_only && ignore_missing)
+		die("Option --ignore-missing can only be used together with --dry-ru=
n");
 	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] =3D { ".", NULL };
 		argc =3D 1;
@@ -441,9 +444,14 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 			seen =3D find_used_pathspec(pathspec);
 		for (i =3D 0; pathspec[i]; i++) {
 			if (!seen[i] && pathspec[i][0]
-			    && !file_exists(pathspec[i]))
-				die("pathspec '%s' did not match any files",
-				    pathspec[i]);
+			    && !file_exists(pathspec[i])) {
+				if (ignore_missing) {
+					if (excluded(&dir, pathspec[i], DT_UNKNOWN))
+						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
+				} else
+					die("pathspec '%s' did not match any files",
+					    pathspec[i]);
+			}
 		}
 		free(seen);
 	}
diff --git a/dir.c b/dir.c
index 151ea67..133f472 100644
--- a/dir.c
+++ b/dir.c
@@ -453,7 +453,7 @@ static struct dir_entry *dir_add_name(struct dir_st=
ruct *dir, const char *pathna
 	return dir->entries[dir->nr++] =3D dir_entry_new(pathname, len);
 }

-static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const=
 char *pathname, int len)
+struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len)
 {
 	if (!cache_name_is_other(pathname, len))
 		return NULL;
diff --git a/dir.h b/dir.h
index 3bead5f..278d84c 100644
--- a/dir.h
+++ b/dir.h
@@ -72,6 +72,7 @@ extern int read_directory(struct dir_struct *, const =
char *path, int len, const
 extern int excluded_from_list(const char *pathname, int pathlen, const=
 char *basename,
 			      int *dtype, struct exclude_list *el);
 extern int excluded(struct dir_struct *, const char *, int *);
+struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len);
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  char **buf_p, struct exclude_list *which, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 6f031af..47fbf53 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -260,4 +260,29 @@ test_expect_success '"add non-existent" should fai=
l' '
 	! (git ls-files | grep "non-existent")
 '

+test_expect_success 'git add --dry-run of existing changed file' "
+	echo new >>track-this &&
+	git add --dry-run track-this >actual 2>&1 &&
+	echo \"add 'track-this'\" | test_cmp - actual
+"
+
+test_expect_success 'git add --dry-run of non-existing file' "
+	echo ignored-file >>.gitignore &&
+	! (git add --dry-run track-this ignored-file >actual 2>&1) &&
+	echo \"fatal: pathspec 'ignored-file' did not match any files\" | tes=
t_cmp - actual
+"
+
+cat >expect <<EOF
+The following paths are ignored by one of your .gitignore files:
+ignored-file
+Use -f if you really want to add them.
+fatal: no files added
+add 'track-this'
+EOF
+
+test_expect_success 'git add --dry-run --ignore-missing of non-existin=
g file' '
+	!(git add --dry-run --ignore-missing track-this ignored-file >actual =
2>&1) &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.2.rc1.218.gca56a.dirty
