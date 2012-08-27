From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC v2 PATCH] Teach rm to remove submodules unless they contain
 a git directory
Date: Mon, 27 Aug 2012 21:42:09 +0200
Message-ID: <503BCD91.6080107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 21:42:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T65Cd-00020n-Do
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 21:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab2H0TmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 15:42:20 -0400
Received: from mout.web.de ([212.227.15.4]:61989 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602Ab2H0TmT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 15:42:19 -0400
Received: from [192.168.178.41] ([79.193.91.128]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MGRdk-1Ssw3L1RWC-00DlS7; Mon, 27 Aug 2012 21:42:16
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-Provags-ID: V02:K0:AIGtcm16n93a6Sn5gzOF2pv5RplwCnzx6N5+CxWob5x
 5rZd2ZZX7CDmnVb0jHnQ2gztHsfJBCNA0Ulm251yRyWoF/bUWh
 QbCAXzEEREfzAg6yYMVFwKO9G4Jw9Mn9zb0Q6/qwFW//eIH8q/
 RwVidxe9BM4AcJB8d1FtDJ+bH6kmGt9CIA6gs3YJXmTPi8v1W4
 Mhr4TDkUM08XG5v7AW2Qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204368>

Currently using "git rm" on a submodule - populated or not - fails with
this error:
	fatal: git rm: '<submodule path>': Is a directory
This made sense in the past as there was no way to remove a submodule
without possibly removing unpushed parts of the submodule's history
contained in its .git directory too, so erroring out here protected the
user from possible loss of data.

But submodules cloned with a recent git version do not contain the .git
directory anymore, they use a gitfile to point to their git directory
which is safely stored inside the superproject's .git directory. The work
tree of these submodules can safely be removed without loosing history, so
let's teach git to do so.

Using rm on an unpopulated submodule now removes the empty directory from
the work tree and the gitlink from the index. If the submodule's directory
is missing from the work tree, it will still be removed from the index.

Using rm on a populated submodule using a gitfile will apply the usual
checks for work tree modification adapted to submodules (unless forced).
For a submodule that means that the HEAD is the same as recorded in the
index, no tracked files are modified and no untracked files that aren't
ignored are present in the submodules work tree (Ignored files are deemed
expendable and won't stop a submodule's work tree from being removed).
That logic has to be applied in all nested submodules too.

Using rm on a submodule which has its .git directory inside the work trees
top level directory will just error out like it did before, forced or not.
In the future git could either provide a message informing the user to
convert the submodule to use a gitfile or even attempt to do the
conversion itself, but that is not part of this change.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


This is the reroll of the "Teach rm to better handle submodules" series
($gmane/201015). It does not attempt to convert submodules that still
contain their git directory (by moving their git directory into
".git/modules/<name>" and replacing it with a gitfile pointing there).
That will be subject to a future patch, as I'm not sure yet if "git rm"
should do that automagically or rather tell the user to use a (still
to be added) "git submodule to-gitfile <path>" invocation to achieve
that.

In a follow up patch I'll teach "git rm submod/" to not barf about the
trailing '/', as that is added by TAB completion.


 Documentation/git-rm.txt |  15 ++++
 builtin/rm.c             |  95 ++++++++++++++++++---
 submodule.c              |  80 ++++++++++++++++++
 submodule.h              |   2 +
 t/t3600-rm.sh            | 210 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 389 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 5d31860..3c76f9c 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -107,6 +107,21 @@ as well as modifications of existing paths.
 Typically you would first remove all tracked files from the working
 tree using this command:

+Submodules
+~~~~~~~~~~~~~~~~~~~~
+Only submodules using a gitfile (which means they were cloned
+with a git version 1.7.8 or newer) will be removed from the work
+tree, as their repository lives inside the .git directory of the
+superproject. If a submodule (or one of those nested inside it)
+still use a .git directory, `git rm` will fail - no matter if forced
+or not - to protect the submodules history.
+
+A submodule is considered up-to-date when the HEAD is the same as
+recorded in the index, no tracked files are modified and no untracked
+files that aren't ignored are present in the submodules work tree.
+Ignored files are deemed expendable and won't stop a submodule's work
+tree from being removed.
+
 ----------------
 git ls-files -z | xargs -0 rm -f
 ----------------
diff --git a/builtin/rm.c b/builtin/rm.c
index 90c8a50..cb927a8 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "parse-options.h"
+#include "submodule.h"

 static const char * const builtin_rm_usage[] = {
 	"git rm [options] [--] <file>...",
@@ -17,9 +18,43 @@ static const char * const builtin_rm_usage[] = {

 static struct {
 	int nr, alloc;
-	const char **name;
+	struct {
+		const char *name;
+		char is_submodule;
+	} *entry;
 } list;

+static int check_submodules_use_gitfiles()
+{
+	int i;
+	int errs = 0;
+
+	for (i = 0; i < list.nr; i++) {
+		const char *name = list.entry[i].name;
+		int pos;
+		struct cache_entry *ce;
+		struct stat st;
+
+		pos = cache_name_pos(name, strlen(name));
+		if (pos < 0)
+			continue; /* ignore unmerged entry */
+		ce = active_cache[pos];
+
+		if (!S_ISGITLINK(ce->ce_mode) ||
+		    (lstat(ce->name, &st) < 0) ||
+		    is_empty_dir(name))
+			continue;
+
+		if (!submodule_uses_gitfile(name))
+			errs = error(_("submodule '%s' (or one of its nested "
+				     "submodules) uses a .git directory\n"
+				     "(use 'rm -rf' if you really want to remove "
+				     "it including all of its history)"), name);
+	}
+
+	return errs;
+}
+
 static int check_local_mod(unsigned char *head, int index_only)
 {
 	/*
@@ -37,7 +72,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 		struct stat st;
 		int pos;
 		struct cache_entry *ce;
-		const char *name = list.name[i];
+		const char *name = list.entry[i].name;
 		unsigned char sha1[20];
 		unsigned mode;
 		int local_changes = 0;
@@ -58,9 +93,10 @@ static int check_local_mod(unsigned char *head, int index_only)
 			/* if a file was removed and it is now a
 			 * directory, that is the same as ENOENT as
 			 * far as git is concerned; we do not track
-			 * directories.
+			 * directories unless they are submodules.
 			 */
-			continue;
+			if (!S_ISGITLINK(ce->ce_mode))
+				continue;
 		}

 		/*
@@ -80,8 +116,11 @@ static int check_local_mod(unsigned char *head, int index_only)

 		/*
 		 * Is the index different from the file in the work tree?
+		 * If it's a submodule, is its work tree modified?
 		 */
-		if (ce_match_stat(ce, &st, 0))
+		if (ce_match_stat(ce, &st, 0) ||
+		    (S_ISGITLINK(ce->ce_mode) &&
+		     !ok_to_remove_submodule(ce->name)))
 			local_changes = 1;

 		/*
@@ -115,10 +154,18 @@ static int check_local_mod(unsigned char *head, int index_only)
 				errs = error(_("'%s' has changes staged in the index\n"
 					     "(use --cached to keep the file, "
 					     "or -f to force removal)"), name);
-			if (local_changes)
-				errs = error(_("'%s' has local modifications\n"
-					     "(use --cached to keep the file, "
-					     "or -f to force removal)"), name);
+			if (local_changes) {
+				if (S_ISGITLINK(ce->ce_mode) &&
+				    !submodule_uses_gitfile(name)) {
+					errs = error(_("submodule '%s' (or one of its nested "
+						     "submodules) uses a .git directory\n"
+						     "(use 'rm -rf' if you really want to remove "
+						     "it including all of its history)"), name);
+				} else
+					errs = error(_("'%s' has local modifications\n"
+						     "(use --cached to keep the file, "
+						     "or -f to force removal)"), name);
+			}
 		}
 	}
 	return errs;
@@ -173,8 +220,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		struct cache_entry *ce = active_cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
-		ALLOC_GROW(list.name, list.nr + 1, list.alloc);
-		list.name[list.nr++] = ce->name;
+		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
+		list.entry[list.nr].name = ce->name;
+		list.entry[list.nr++].is_submodule = S_ISGITLINK(ce->ce_mode);
 	}

 	if (pathspec) {
@@ -215,6 +263,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			hashclr(sha1);
 		if (check_local_mod(sha1, index_only))
 			exit(1);
+	} else if (!index_only) {
+		if (check_submodules_use_gitfiles())
+			exit(1);
 	}

 	/*
@@ -222,7 +273,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * the index unless all of them succeed.
 	 */
 	for (i = 0; i < list.nr; i++) {
-		const char *path = list.name[i];
+		const char *path = list.entry[i].name;
 		if (!quiet)
 			printf("rm '%s'\n", path);

@@ -244,7 +295,25 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only) {
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
-			const char *path = list.name[i];
+			const char *path = list.entry[i].name;
+			if (list.entry[i].is_submodule) {
+				if (is_empty_dir(path)) {
+					if (!rmdir(path)) {
+						removed = 1;
+						continue;
+					}
+				} else {
+					struct strbuf buf = STRBUF_INIT;
+					strbuf_addstr(&buf, path);
+					if (!remove_dir_recursively(&buf, 0)) {
+						removed = 1;
+						strbuf_release(&buf);
+						continue;
+					}
+					strbuf_release(&buf);
+					/* Fallthrough and let remove_path() fail. */
+				}
+			}
 			if (!remove_path(path)) {
 				removed = 1;
 				continue;
diff --git a/submodule.c b/submodule.c
index 19dc6a6..acb2fe0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -758,6 +758,86 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	return dirty_submodule;
 }

+int submodule_uses_gitfile(const char *path)
+{
+	struct child_process cp;
+	const char *argv[] = {
+		"submodule",
+		"foreach",
+		"--quiet",
+		"--recursive",
+		"test -f .git",
+		NULL,
+	};
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir) {
+		strbuf_release(&buf);
+		return 0;
+	}
+	strbuf_release(&buf);
+
+	/* Now test that all nested submodules use a gitfile too */
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.no_stdout = 1;
+	cp.dir = path;
+	if (run_command(&cp))
+		return 0;
+
+	return 1;
+}
+
+int ok_to_remove_submodule(const char *path)
+{
+	struct stat st;
+	ssize_t len;
+	struct child_process cp;
+	const char *argv[] = {
+		"status",
+		"--porcelain",
+		"-u",
+		"--ignore-submodules=none",
+		NULL,
+	};
+	struct strbuf buf = STRBUF_INIT;
+	int ok_to_remove = 1;
+
+	if ((lstat(path, &st) < 0) || is_empty_dir(path))
+		return 1;
+
+	if (!submodule_uses_gitfile(path))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.out = -1;
+	cp.dir = path;
+	if (start_command(&cp))
+		die("Could not run 'git status --porcelain -uall --ignore-submodules=none' in submodule %s", path);
+
+	len = strbuf_read(&buf, cp.out, 1024);
+	if (len > 2)
+		ok_to_remove = 0;
+	close(cp.out);
+
+	if (finish_command(&cp))
+		die("'git status --porcelain -uall --ignore-submodules=none' failed in submodule %s", path);
+
+	strbuf_release(&buf);
+	return ok_to_remove;
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
diff --git a/submodule.h b/submodule.h
index e105b0e..9c0f6a4 100644
--- a/submodule.h
+++ b/submodule.h
@@ -27,6 +27,8 @@ int fetch_populated_submodules(int num_options, const char **options,
 			       const char *prefix, int command_line_option,
 			       int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
+int submodule_uses_gitfile(const char *path);
+int ok_to_remove_submodule(const char *path);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20], int search);
 int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 9fd28bc..d55f2fb 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -262,4 +262,214 @@ test_expect_success 'rm removes subdirectories recursively' '
 	! test -d dir
 '

+cat >expect <<EOF
+D  submod
+EOF
+
+cat >expect.modified <<EOF
+ M submod
+EOF
+
+test_expect_success 'rm removes empty submodules from work tree' '
+	mkdir submod &&
+	git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) submod &&
+	git config -f .gitmodules submodule.sub.url ./. &&
+	git config -f .gitmodules submodule.sub.path submod &&
+	git submodule init &&
+	git add .gitmodules &&
+	git commit -m "add submodule" &&
+	git rm submod &&
+	test ! -e submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm removes removed submodule from index' '
+	git reset --hard &&
+	git submodule update &&
+	rm -rf submod &&
+	git rm submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm removes work tree of unmodified submodules' '
+	git reset --hard &&
+	git submodule update &&
+	git rm submod &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated submodule with different HEAD fails unless forced' '
+	git reset --hard &&
+	git submodule update &&
+	(cd submod &&
+		git checkout HEAD^
+	) &&
+	test_must_fail git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect.modified actual &&
+	git rm -f submod &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated submodule with modifications fails unless forced' '
+	git reset --hard &&
+	git submodule update &&
+	(cd submod &&
+		echo X >empty
+	) &&
+	test_must_fail git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect.modified actual &&
+	git rm -f submod &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated submodule with untracked files fails unless forced' '
+	git reset --hard &&
+	git submodule update &&
+	(cd submod &&
+		echo X >untracked
+	) &&
+	test_must_fail git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect.modified actual &&
+	git rm -f submod &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated submodule with a .git directory fails even when forced' '
+	git reset --hard &&
+	git submodule update &&
+	(cd submod &&
+		rm .git &&
+		cp -a ../.git/modules/sub .git &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	) &&
+	test_must_fail git rm submod &&
+	test -d submod &&
+	test -d submod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	! test -s actual &&
+	test_must_fail git rm -f submod &&
+	test -d submod &&
+	test -d submod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	! test -s actual &&
+	rm -rf submod
+'
+
+cat >expect.deepmodified <<EOF
+ M submod/subsubmod
+EOF
+
+test_expect_success 'setup subsubmodule' '
+	git reset --hard &&
+	git submodule update &&
+	(cd submod &&
+		git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) subsubmod &&
+		git config -f .gitmodules submodule.sub.url ../. &&
+		git config -f .gitmodules submodule.sub.path subsubmod &&
+		git submodule init &&
+		git add .gitmodules &&
+		git commit -m "add subsubmodule" &&
+		git submodule update subsubmod
+	) &&
+	git commit -a -m "added deep submodule"
+'
+
+test_expect_success 'rm recursively removes work tree of unmodified submodules' '
+	git rm submod &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated nested submodule with different nested HEAD fails unless forced' '
+	git reset --hard &&
+	git submodule update --recursive &&
+	(cd submod/subsubmod &&
+		git checkout HEAD^
+	) &&
+	test_must_fail git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect.modified actual &&
+	git rm -f submod &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated nested submodule with nested modifications fails unless forced' '
+	git reset --hard &&
+	git submodule update --recursive &&
+	(cd submod/subsubmod &&
+		echo X >empty
+	) &&
+	test_must_fail git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect.modified actual &&
+	git rm -f submod &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated nested submodule with nested untracked files fails unless forced' '
+	git reset --hard &&
+	git submodule update --recursive &&
+	(cd submod/subsubmod &&
+		echo X >untracked
+	) &&
+	test_must_fail git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect.modified actual &&
+	git rm -f submod &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated nested submodule with a nested .git directory fails even when forced' '
+	git reset --hard &&
+	git submodule update --recursive &&
+	(cd submod/subsubmod &&
+		rm .git &&
+		cp -a ../../.git/modules/sub/modules/sub .git &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	) &&
+	test_must_fail git rm submod &&
+	test -d submod &&
+	test -d submod/subsubmod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	! test -s actual &&
+	test_must_fail git rm -f submod &&
+	test -d submod &&
+	test -d submod/subsubmod/.git &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	! test -s actual &&
+	rm -rf submod
+'
+
 test_done
-- 
1.7.12.85.g08e971b
