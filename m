From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 5/5] rm: delete .gitmodules entry of submodules removed
 from the work tree
Date: Tue, 30 Jul 2013 21:51:51 +0200
Message-ID: <51F81957.1000709@web.de>
References: <51F8187F.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:51:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Fxe-00005A-8G
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455Ab3G3Tvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:51:54 -0400
Received: from mout.web.de ([212.227.17.12]:60306 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756231Ab3G3Tvx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:51:53 -0400
Received: from [192.168.178.41] ([79.193.94.161]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MLP9u-1V4oBp3Gio-000bYK for <git@vger.kernel.org>;
 Tue, 30 Jul 2013 21:51:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F8187F.7040603@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:YmyHYWZZlcoiz9dqhedZMv71hGx9tCjk/ZMSoy508w11tIlJr/Q
 IyMndg+1QsGLp9VIPWRFLkDdA7AsxphGMtpOm4+zjcX/6yaoOg/2l2DjRfmYrE1baA7qqhW
 tU0C0FbUu9sydSCmnVe/0w6oA2e4ivkWHlSny4/clgiz6KUE5c9Npxno7ftsxixrSkJipDc
 Eap97b1CDKm7TKXIZ2uzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231387>

Currently using "git rm" on a submodule removes the submodule's work tree
from that of the superproject and the gitlink from the index. But the
submodule's section in .gitmodules is left untouched, which is a leftover
of the now removed submodule and might irritate users (as opposed to the
setting in .git/config, this must stay as a reminder that the user showed
interest in this submodule so it will be repopulated later when an older
commit is checked out).

Let "git rm" help the user by not only removing the submodule from the
work tree but by also removing the "submodule.<submodule name>" section
from the .gitmodules file and stage both. This doesn't happen when the
"--cached" option is used, as it would modify the work tree. This also
silently does nothing when no .gitmodules file is found and only issues a
warning when it doesn't have a section for this submodule. This is because
the user might just use plain gitlinks without the .gitmodules file or has
already removed the section by hand before issuing the "git rm" command
(in which case the warning reminds him that rm would have done that for
him). Only when .gitmodules is found and contains merge conflicts the rm
command will fail and tell the user to resolve the conflict before trying
again.

Also extend the man page to inform the user about this new feature. While
at it promote the submodule sub-section to a chapter as it made not much
sense under "REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM".

In t7610 three uses of "git rm submod" had to be replaced with "git rm
--cached submod" because that test expects .gitmodules and the work tree
to stay untouched. Also in t7400 the tests for the remaining settings in
the .gitmodules file had to be changed to assert that these settings are
missing.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-rm.txt   |  8 ++--
 builtin/rm.c               | 19 +++++++--
 submodule.c                | 32 +++++++++++++++
 submodule.h                |  1 +
 t/t3600-rm.sh              | 98 +++++++++++++++++++++++++++++++++++++++++++---
 t/t7400-submodule-basic.sh | 14 ++-----
 t/t7610-mergetool.sh       |  6 +--
 7 files changed, 153 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 1d876c2..9d731b4 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -134,14 +134,16 @@ use the following command:
 git diff --name-only --diff-filter=D -z | xargs -0 git rm --cached
 ----------------

-Submodules
-~~~~~~~~~~
+SUBMODULES
+----------
 Only submodules using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will be removed from the work
 tree, as their repository lives inside the .git directory of the
 superproject. If a submodule (or one of those nested inside it)
 still uses a .git directory, `git rm` will fail - no matter if forced
-or not - to protect the submodule's history.
+or not - to protect the submodule's history. If it exists the
+submodule.<name> section in the linkgit:gitmodules[5] file will also
+be removed and that file will be staged (unless --cached or -n are used).

 A submodule is considered up-to-date when the HEAD is the same as
 recorded in the index, no tracked files are modified and no untracked
diff --git a/builtin/rm.c b/builtin/rm.c
index df85f98..a9d45dd 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -283,6 +283,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	char *seen;

+	gitmodules_config();
 	git_config(git_default_config, NULL);

 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
@@ -324,7 +325,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
 		list.entry[list.nr].name = ce->name;
-		list.entry[list.nr++].is_submodule = S_ISGITLINK(ce->ce_mode);
+		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
+		if (list.entry[list.nr++].is_submodule &&
+		    !is_staging_gitmodules_ok())
+			die (_("Please, stage your changes to .gitmodules or stash them to proceed"));
 	}

 	if (pathspec.nr) {
@@ -396,13 +400,15 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * in the middle)
 	 */
 	if (!index_only) {
-		int removed = 0;
+		int removed = 0, gitmodules_modified = 0;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.entry[i].name;
 			if (list.entry[i].is_submodule) {
 				if (is_empty_dir(path)) {
 					if (!rmdir(path)) {
 						removed = 1;
+						if (!remove_path_from_gitmodules(path))
+							gitmodules_modified = 1;
 						continue;
 					}
 				} else {
@@ -410,9 +416,14 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 					strbuf_addstr(&buf, path);
 					if (!remove_dir_recursively(&buf, 0)) {
 						removed = 1;
+						if (!remove_path_from_gitmodules(path))
+							gitmodules_modified = 1;
 						strbuf_release(&buf);
 						continue;
-					}
+					} else if (!file_exists(path))
+						/* Submodule was removed by user */
+						if (!remove_path_from_gitmodules(path))
+							gitmodules_modified = 1;
 					strbuf_release(&buf);
 					/* Fallthrough and let remove_path() fail. */
 				}
@@ -424,6 +435,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			if (!removed)
 				die_errno("git rm: '%s'", path);
 		}
+		if (gitmodules_modified)
+			stage_updated_gitmodules();
 	}

 	if (active_cache_changed) {
diff --git a/submodule.c b/submodule.c
index b210685..5cd8845 100644
--- a/submodule.c
+++ b/submodule.c
@@ -80,6 +80,38 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	return 0;
 }

+/*
+ * Try to remove the "submodule.<name>" section from .gitmodules where the given
+ * path is configured. Return 0 only if a .gitmodules file was found, a section
+ * with the correct path=<path> setting was found and we could remove it.
+ */
+int remove_path_from_gitmodules(const char *path)
+{
+	struct strbuf sect = STRBUF_INIT;
+	struct string_list_item *path_option;
+
+	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
+		return -1;
+
+	if (gitmodules_is_unmerged)
+		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
+
+	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (!path_option) {
+		warning(_("Could not find section in .gitmodules where path=%s"), path);
+		return -1;
+	}
+	strbuf_addstr(&sect, "submodule.");
+	strbuf_addstr(&sect, path_option->util);
+	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
+		/* Maybe the user already did that, don't error out here */
+		warning(_("Could not remove .gitmodules entry for %s"), path);
+		return -1;
+	}
+	strbuf_release(&sect);
+	return 0;
+}
+
 void stage_updated_gitmodules(void)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/submodule.h b/submodule.h
index 570d4d0..eca1d11 100644
--- a/submodule.h
+++ b/submodule.h
@@ -13,6 +13,7 @@ enum {

 int is_staging_gitmodules_ok();
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
+int remove_path_from_gitmodules(const char *path);
 void stage_updated_gitmodules(void);
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5c87b55..639cb70 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -263,6 +263,7 @@ test_expect_success 'rm removes subdirectories recursively' '
 '

 cat >expect <<EOF
+M  .gitmodules
 D  submod
 EOF

@@ -270,6 +271,15 @@ cat >expect.modified <<EOF
  M submod
 EOF

+cat >expect.cached <<EOF
+D  submod
+EOF
+
+cat >expect.both_deleted<<EOF
+D  .gitmodules
+D  submod
+EOF
+
 test_expect_success 'rm removes empty submodules from work tree' '
 	mkdir submod &&
 	git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) submod &&
@@ -281,16 +291,20 @@ test_expect_success 'rm removes empty submodules from work tree' '
 	git rm submod &&
 	test ! -e submod &&
 	git status -s -uno --ignore-submodules=none > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

-test_expect_success 'rm removes removed submodule from index' '
+test_expect_success 'rm removes removed submodule from index and .gitmodules' '
 	git reset --hard &&
 	git submodule update &&
 	rm -rf submod &&
 	git rm submod &&
 	git status -s -uno --ignore-submodules=none > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

 test_expect_success 'rm removes work tree of unmodified submodules' '
@@ -299,7 +313,9 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	git rm submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

 test_expect_success 'rm removes a submodule with a trailing /' '
@@ -333,6 +349,72 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
+'
+
+test_expect_success 'rm --cached leaves work tree of populated submodules and .gitmodules alone' '
+	git reset --hard &&
+	git submodule update &&
+	git rm --cached submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno >actual &&
+	test_cmp expect.cached actual &&
+	git config -f .gitmodules submodule.sub.url &&
+	git config -f .gitmodules submodule.sub.path
+'
+
+test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
+	git reset --hard &&
+	git submodule update &&
+	git rm -n submod &&
+	test -f submod/.git &&
+	git diff-index --exit-code HEAD
+'
+
+test_expect_success 'rm does not complain when no .gitmodules file is found' '
+	git reset --hard &&
+	git submodule update &&
+	git rm .gitmodules &&
+	git rm submod >actual 2>actual.err &&
+	! test -s actual.err &&
+	! test -d submod &&
+	! test -f submod/.git &&
+	git status -s -uno >actual &&
+	test_cmp expect.both_deleted actual
+'
+
+test_expect_success 'rm will error out on a modified .gitmodules file unless staged' '
+	git reset --hard &&
+	git submodule update &&
+	git config -f .gitmodules foo.bar true &&
+	test_must_fail git rm submod >actual 2>actual.err &&
+	test -s actual.err &&
+	test -d submod &&
+	test -f submod/.git &&
+	git diff-files --quiet -- submod &&
+	git add .gitmodules &&
+	git rm submod >actual 2>actual.err &&
+	! test -s actual.err &&
+	! test -d submod &&
+	! test -f submod/.git &&
+	git status -s -uno >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm issues a warning when section is not found in .gitmodules' '
+	git reset --hard &&
+	git submodule update &&
+	git config -f .gitmodules --remove-section submodule.sub &&
+	git add .gitmodules &&
+	echo "warning: Could not find section in .gitmodules where path=submod" >expect.err &&
+	git rm submod >actual 2>actual.err &&
+	test_i18ncmp expect.err actual.err &&
+	! test -d submod &&
+	! test -f submod/.git &&
+	git status -s -uno >actual &&
 	test_cmp expect actual
 '

@@ -427,7 +509,9 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

 test_expect_success 'rm of a conflicted populated submodule with modifications fails unless forced' '
@@ -446,7 +530,9 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

 test_expect_success 'rm of a conflicted populated submodule with untracked files fails unless forced' '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5ee97b0..88293e6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -773,13 +773,11 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 			test_cmp expect .git
 		) &&
 		echo "repo" >expect &&
-		git config -f .gitmodules submodule.repo.path >actual &&
-		test_cmp expect actual &&
+		test_must_fail git config -f .gitmodules submodule.repo.path &&
 		git config -f .gitmodules submodule.repo_new.path >actual &&
 		test_cmp expect actual&&
 		echo "$submodurl/repo" >expect &&
-		git config -f .gitmodules submodule.repo.url >actual &&
-		test_cmp expect actual &&
+		test_must_fail git config -f .gitmodules submodule.repo.url &&
 		echo "$submodurl/bare.git" >expect &&
 		git config -f .gitmodules submodule.repo_new.url >actual &&
 		test_cmp expect actual &&
@@ -799,12 +797,8 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
 		git rm repo &&
 		test_must_fail git submodule add -q --name repo_new "$submodurl/repo.git" repo &&
 		test ! -d repo &&
-		echo "repo" >expect &&
-		git config -f .gitmodules submodule.repo_new.path >actual &&
-		test_cmp expect actual&&
-		echo "$submodurl/bare.git" >expect &&
-		git config -f .gitmodules submodule.repo_new.url >actual &&
-		test_cmp expect actual &&
+		test_must_fail git config -f .gitmodules submodule.repo_new.path &&
+		test_must_fail git config -f .gitmodules submodule.repo_new.url &&
 		echo "$submodurl/bare.git" >expect &&
 		git config submodule.repo_new.url >actual &&
 		test_cmp expect actual &&
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index d526b1d..05d9db0 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -253,7 +253,7 @@ test_expect_success 'deleted vs modified submodule' '
     git checkout -b test6 branch1 &&
     git submodule update -N &&
     mv submod submod-movedaside &&
-    git rm submod &&
+    git rm --cached submod &&
     git commit -m "Submodule deleted from branch" &&
     git checkout -b test6.a test6 &&
     test_must_fail git merge master &&
@@ -322,7 +322,7 @@ test_expect_success 'file vs modified submodule' '
     git checkout -b test7 branch1 &&
     git submodule update -N &&
     mv submod submod-movedaside &&
-    git rm submod &&
+    git rm --cached submod &&
     echo not a submodule >submod &&
     git add submod &&
     git commit -m "Submodule path becomes file" &&
@@ -453,7 +453,7 @@ test_expect_success 'submodule in subdirectory' '
 test_expect_success 'directory vs modified submodule' '
     git checkout -b test11 branch1 &&
     mv submod submod-movedaside &&
-    git rm submod &&
+    git rm --cached submod &&
     mkdir submod &&
     echo not a submodule >submod/file16 &&
     git add submod/file16 &&
-- 
1.8.4.rc0.199.g7079aac
