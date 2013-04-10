From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC/PATCH] rm: delete .gitmodules entry of submodules removed from
 the work tree
Date: Thu, 11 Apr 2013 00:03:56 +0200
Message-ID: <5165E1CC.7090004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 00:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ3Ck-0005FJ-45
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 00:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763884Ab3DJWJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 18:09:15 -0400
Received: from mout.web.de ([212.227.17.11]:53226 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab3DJWJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 18:09:13 -0400
Received: from [192.168.178.41] ([79.193.81.26]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LlFOY-1UyZ7i3bja-00b36r; Thu, 11 Apr 2013 00:03:58
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:I2FXB0HkW0fXoh0N4nLlGok9pYNYlklGt+qXx/uOKLC
 nkUVtyCe6H6la8G+DM1OsDFn7Azf1tTL1YTMTZwEW8khplJccM
 QprtPWaGKP0U1U1ljdzHOYcwGt2CX4js9F7ZCbvopxLjOjM6DJ
 J7ZLJdCc9DBN9gNh9p1nUDo0a4ha+jW7nHD63vIV48bnRW9HZM
 71Ppp3+CwHsZKnJ9dvWnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220785>

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

In t7610 three uses of "git rm submod" had to be replaced with "git rm
--cached submod" because that test expects .gitmodules and the work tree
to stay untouched. Also in t7400 the tests for the remaining settings in
the .gitmodules file had to be changed to assert that these settings are
missing.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This patch applies on top of my mv-submodules series as it reuses the
stage_updated_gitmodules() function introduced there. This change was
part of my initial "git rm for submodules" series ($gmane/201015), but
was not accepted at that time. Since then "git submodule" learned the
deinit command which allows the user to state he doesn't want a checked
out submodule anymore (which is different from committing the removal
of a submodule now possible using "git rm"). The mv-submodules series
currently in pu doesn't make much sense without changing the config
data in .gitmodules, so maybe it's time to let "git rm" affect the
.gitmodules file accordingly.

The .gitmodules file is the source of the path <=> name mapping needed
to make the submodule's GIT_DIR path independent, which was the point
of moving that to the .git/modules/<name> of the superproject. Other
git-core commands like fetch need that information to be up-to-date so
they're able to fetch commits for renamed submodules too, so I believe
it's time to make git-core not only parse the .gitmodules file, but to
also manipulate it where appropriate.


 builtin/rm.c               | 14 +++++++--
 submodule.c                | 31 ++++++++++++++++++++
 submodule.h                |  1 +
 t/t3600-rm.sh              | 72 ++++++++++++++++++++++++++++++++++++++++++----
 t/t7400-submodule-basic.sh | 14 +++------
 t/t7610-mergetool.sh       |  6 ++--
 6 files changed, 117 insertions(+), 21 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 7b91d52..26265eb 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -219,6 +219,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	const char **pathspec;
 	char *seen;

+	gitmodules_config();
 	git_config(git_default_config, NULL);

 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
@@ -334,13 +335,15 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
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
@@ -348,9 +351,14 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
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
@@ -362,6 +370,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			if (!removed)
 				die_errno("git rm: '%s'", path);
 		}
+		if (gitmodules_modified)
+			stage_updated_gitmodules();
 	}

 	if (active_cache_changed) {
diff --git a/submodule.c b/submodule.c
index 8ce6a7d..6b01a02 100644
--- a/submodule.c
+++ b/submodule.c
@@ -63,6 +63,37 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	return 0;
 }

+/*
+ * Try to remove the "submodule.<name>" section from .gitmodules where the
+ * given path is configured.
+ */
+int remove_path_from_gitmodules(const char *path)
+{
+	struct strbuf sect = STRBUF_INIT;
+	struct string_list_item *path_option;
+
+	if (!file_exists(".gitmodules")) /* Do nothing whithout .gitmodules */
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
index 39c0321..9436d87 100644
--- a/submodule.h
+++ b/submodule.h
@@ -12,6 +12,7 @@ enum {
 };

 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
+int remove_path_from_gitmodules(const char *path);
 void stage_updated_gitmodules(void);
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0c44e9f..6c30997 100755
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
@@ -333,6 +349,46 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
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
+	git status -s -uno > actual &&
+	test_cmp expect.cached actual &&
+	git config -f .gitmodules submodule.sub.url &&
+	git config -f .gitmodules submodule.sub.path
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
+	git status -s -uno > actual &&
+	test_cmp expect.both_deleted actual
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
+	git status -s -uno > actual &&
 	test_cmp expect actual
 '

@@ -427,7 +483,9 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none > actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_fail git config -f .gitmodules submodule.sub.url &&
+	test_must_fail git config -f .gitmodules submodule.sub.path
 '

 test_expect_success 'rm of a conflicted populated submodule with modifications fails unless forced' '
@@ -446,7 +504,9 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
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
index ff26535..4db1dd0 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -708,13 +708,11 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
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
@@ -734,12 +732,8 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
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
index bc38737..68c3dd5 100755
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
1.8.2.1.346.gec071ca
