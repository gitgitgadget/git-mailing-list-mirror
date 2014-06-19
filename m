From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 02/14] submodules: Add the lib-submodule-update.sh test
 library
Date: Thu, 19 Jun 2014 22:12:45 +0200
Message-ID: <53A3443D.9020000@web.de>
References: <539DD029.4030506@web.de> <539DD09A.7010200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:13:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxihc-0006LH-1K
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbaFSUMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:12:52 -0400
Received: from mout.web.de ([212.227.15.4]:52128 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289AbaFSUMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:12:51 -0400
Received: from [192.168.178.41] ([79.193.64.138]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MSJ0V-1X7s7J1oyZ-00TUem; Thu, 19 Jun 2014 22:12:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD09A.7010200@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:q9u/O08OgboraaB0yxW4IXSv1mudxNkpd5MXjAG2uQL6V05wkDO
 GlBQEps0IU0EDDWDMYoTr+vy7iKa8Q5PhKmSrWMtbrTNfZibj28zSiECotcYLGxTdBkHpkZ
 hE9a8EVyXEOzZfQJTt6gDOq5KwOucmO/oZY2un4lSGRNDCXZ03+WKJqwVuFyhlE4J9kUDsE
 XGMLUGpV4N13NQ3zSvdtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252176>

Add this test library to simplify covering all combinations of submodule
update scenarios without having to add those to a test of each work tree
manipulating command over and over again.

The functions test_submodule_switch() and test_submodule_forced_switch()
are intended to be called from a test script with a single argument. This
argument is either a work tree manipulating command (including any command
line options) or a function (when more than a single git command is needed
to switch work trees from the current HEAD to another commit). This
command (or function) is passed a target branch as argument. The two new
functions check that each submodule transition is handled as expected,
which currently means that submodule work trees are not affected until
"git submodule update" is called. The "forced" variant is for commands
using their '-f' or '--hard' option and expects them to overwrite local
modifications as a result. Each of these two functions contains 14
tests_expect_* calls.

Calling one of these test functions the first time creates a repository
named "submodule_update_repo". At first it contains two files, then a
single submodule is added in another commit followed by commits covering
all relevant submodule modifications. This repository is newly cloned into
the "submodule_update" for each test_expect_* to avoid interference
between different parts of the test functions (some to-be-tested commands
also manipulate refs along with the work tree, e.g. "git reset").

Follow-up commits will then call these two test functions for all work
tree manipulating commands (with a combination of all their options
relevant to what they do with the work tree) making sure they work as
expected. Later this test library will be extended to cover merges
resulting in conflicts too. Also it is intended to be easily extendable
for the recursive update functionality, where even more combinations of
submodule modifications have to be tested for.

This version documents two bugs in current Git with expected failures:

*) When a submodule is replaced with a tracked file of the same name the
   submodule work tree including any local modifications (and even the
   whole history if it uses a .git directory instead of a gitfile!) is
   silently removed.

*) Forced work tree updates happily manipulate files in the directory of a
   submodule that has just been removed in the superproject (but is of
   course still present in the work tree due to the way submodules are
   currently handled). This becomes dangerous when files in the submodule
   directory are overwritten by files from the new superproject commit, as
   any modifications to the submodule files will be lost) and is expected
   to also destroy history in the - admittedly unlikely case - the new
   commit adds a file named ".git" to the submodule directory.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Changes to v1:

*) avoid non-portable "cp -a"

*) use "diff -r" without "git " when comparing directory trees

*) simplify retrieving the SHA-1 of sub1

*) call test_git_directory_is_unchanged before test_submodule_content (this
   was the reason for two test failures after removing the "git " before
   "diff" as test_submodule_content would sometimes modify the index)


 t/lib-submodule-update.sh | 632 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 632 insertions(+)
 create mode 100755 t/lib-submodule-update.sh

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
new file mode 100755
index 0000000..03217b2
--- /dev/null
+++ b/t/lib-submodule-update.sh
@@ -0,0 +1,632 @@
+# Create a submodule layout used for all tests below.
+#
+# The following use cases are covered:
+# - New submodule (no_submodule => add_sub1)
+# - Removed submodule (add_sub1 => remove_sub1)
+# - Updated submodule (add_sub1 => modify_sub1)
+# - Submodule updated to invalid commit (add_sub1 => invalid_sub1)
+# - Submodule updated from invalid commit (invalid_sub1 => valid_sub1)
+# - Submodule replaced by tracked files in directory (add_sub1 =>
+#   replace_sub1_with_directory)
+# - Directory containing tracked files replaced by submodule
+#   (replace_sub1_with_directory => replace_directory_with_sub1)
+# - Submodule replaced by tracked file with the same name (add_sub1 =>
+#   replace_sub1_with_file)
+# - Tracked file replaced by submodule (replace_sub1_with_file =>
+#   replace_file_with_sub1)
+#
+#                   --O-----O
+#                  /  ^     replace_directory_with_sub1
+#                 /   replace_sub1_with_directory
+#                /----O
+#               /     ^
+#              /      modify_sub1
+#      O------O-------O
+#      ^      ^\      ^
+#      |      | \     remove_sub1
+#      |      |  -----O-----O
+#      |      |   \   ^     replace_file_with_sub1
+#      |      |    \  replace_sub1_with_file
+#      |   add_sub1 --O-----O
+# no_submodule        ^     valid_sub1
+#                     invalid_sub1
+#
+create_lib_submodule_repo () {
+	git init submodule_update_repo &&
+	(
+		cd submodule_update_repo &&
+		echo "expect" >>.gitignore &&
+		echo "actual" >>.gitignore &&
+		echo "x" >file1 &&
+		echo "y" >file2 &&
+		git add .gitignore file1 file2 &&
+		git commit -m "Base" &&
+		git branch "no_submodule" &&
+
+		git checkout -b "add_sub1" &&
+		git submodule add ./. sub1 &&
+		git config -f .gitmodules submodule.sub1.ignore all &&
+		git config submodule.sub1.ignore all &&
+		git add .gitmodules &&
+		git commit -m "Add sub1" &&
+		git checkout -b remove_sub1 &&
+		git revert HEAD &&
+
+		git checkout -b "modify_sub1" "add_sub1" &&
+		git submodule update &&
+		(
+			cd sub1 &&
+			git fetch &&
+			git checkout -b "modifications" &&
+			echo "z" >file2 &&
+			echo "x" >file3 &&
+			git add file2 file3 &&
+			git commit -m "modified file2 and added file3" &&
+			git push origin modifications
+		) &&
+		git add sub1 &&
+		git commit -m "Modify sub1" &&
+
+		git checkout -b "replace_sub1_with_directory" "add_sub1" &&
+		git submodule update &&
+		(
+			cd sub1 &&
+			git checkout modifications
+		) &&
+		git rm --cached sub1 &&
+		rm sub1/.git* &&
+		git config -f .gitmodules --remove-section "submodule.sub1" &&
+		git add .gitmodules sub1/* &&
+		git commit -m "Replace sub1 with directory" &&
+		git checkout -b replace_directory_with_sub1 &&
+		git revert HEAD &&
+
+		git checkout -b "replace_sub1_with_file" "add_sub1" &&
+		git rm sub1 &&
+		echo "content" >sub1 &&
+		git add sub1 &&
+		git commit -m "Replace sub1 with file" &&
+		git checkout -b replace_file_with_sub1 &&
+		git revert HEAD &&
+
+		git checkout -b "invalid_sub1" "add_sub1" &&
+		git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 sub1 &&
+		git commit -m "Invalid sub1 commit" &&
+		git checkout -b valid_sub1 &&
+		git revert HEAD &&
+		git checkout master
+	)
+}
+
+# Helper function to replace gitfile with .git directory
+replace_gitfile_with_git_dir () {
+	(
+		cd "$1" &&
+		git_dir="$(git rev-parse --git-dir)" &&
+		rm -f .git &&
+		cp -R "$git_dir" .git &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	)
+}
+
+# Test that the .git directory in the submodule is unchanged (except for the
+# core.worktree setting, which we temporarily restore). Call this function
+# before test_submodule_content as the latter might write the index file
+# leading to false positive index differences.
+test_git_directory_is_unchanged () {
+	(
+		cd "$1" &&
+		git config core.worktree "../../../$1"
+	) &&
+	diff -r ".git/modules/$1" "$1/.git" &&
+	(
+		cd "$1" &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	)
+}
+
+# Helper function to be executed at the start of every test below, it sets up
+# the submodule repo if it doesn't exist and configures the most problematic
+# settings for diff.ignoreSubmodules.
+prolog () {
+	(test -d submodule_update_repo || create_lib_submodule_repo) &&
+	test_config_global diff.ignoreSubmodules all &&
+	test_config diff.ignoreSubmodules all
+}
+
+# Helper function to bring work tree back into the state given by the
+# commit. This includes trying to populate sub1 accordingly if it exists and
+# should be updated to an existing commit.
+reset_work_tree_to () {
+	rm -rf submodule_update &&
+	git clone submodule_update_repo submodule_update &&
+	(
+		cd submodule_update &&
+		rm -rf sub1 &&
+		git checkout -f "$1" &&
+		git status -u -s >actual &&
+		test_must_be_empty actual &&
+		sha1=$(git rev-parse HEAD:sub1 || true) &&
+		if test -n "$sha1" &&
+		   test $(cd "sub1" && git rev-parse --verify "$sha1^{commit}")
+		then
+			git submodule update --init --recursive "sub1"
+		fi
+	)
+}
+
+# Test that the superproject contains the content according to commit "$1"
+# (the work tree must match the index for everything but submodules but the
+# index must exactly match the given commit including any submodule SHA-1s).
+test_superproject_content () {
+	git diff-index --cached "$1" >actual &&
+	test_must_be_empty actual &&
+	git diff-files --ignore-submodules >actual &&
+	test_must_be_empty actual
+}
+
+# Test that the given submodule at path "$1" contains the content according
+# to the submodule commit recorded in the superproject's commit "$2"
+test_submodule_content () {
+	if test $# != 2
+	then
+		echo "test_submodule_content needs two arguments"
+		return 1
+	fi &&
+	submodule="$1" &&
+	commit="$2" &&
+	test -d "$submodule"/ &&
+	if ! test -f "$submodule"/.git && ! test -d "$submodule"/.git
+	then
+		echo "Submodule $submodule is not populated"
+		return 1
+	fi &&
+	sha1=$(git rev-parse "$commit:$submodule") &&
+	if test -z "$sha1"
+	then
+		echo "Couldn't retrieve SHA-1 of $submodule for $commit"
+		return 1
+	fi &&
+	(
+		cd "$submodule" &&
+		git status -u -s >actual &&
+		test_must_be_empty actual &&
+		git diff "$sha1" >actual &&
+		test_must_be_empty actual
+	)
+}
+
+# Test that the following transitions are correctly handled:
+# - Updated submodule
+# - New submodule
+# - Removed submodule
+# - Directory containing tracked files replaced by submodule
+# - Submodule replaced by tracked files in directory
+# - Submodule replaced by tracked file with the same name
+# - tracked file replaced by submodule
+#
+# The default is that submodule contents aren't changed until "git submodule
+# update" is run. And even then that command doesn't delete the work tree of
+# a removed submodule.
+#
+# Removing a submodule containing a .git directory must fail even when forced
+# to protect the history!
+#
+
+# Test that submodule contents are currently not updated when switching
+# between commits that change a submodule.
+test_submodule_switch () {
+	command="$1"
+	######################### Appearing submodule #########################
+	# Switching to a commit letting a submodule appear creates empty dir ...
+	test_expect_success "$command: added submodule creates empty directory" '
+		prolog &&
+		reset_work_tree_to no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... and doesn't care if it already exists ...
+	test_expect_success "$command: added submodule leaves existing empty directory alone" '
+		prolog &&
+		reset_work_tree_to no_submodule &&
+		(
+			cd submodule_update &&
+			mkdir sub1 &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... unless there is an untracked file in its place.
+	test_expect_success "$command: added submodule doesn't remove untracked unignored file with same name" '
+		prolog &&
+		reset_work_tree_to no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			echo -n >sub1 &&
+			test_must_fail $command add_sub1 &&
+			test_superproject_content origin/no_submodule &&
+			test_must_be_empty sub1
+		)
+	'
+	# Replacing a tracked file with a submodule produces an empty
+	# directory ...
+	test_expect_success "$command: replace tracked file with submodule creates empty directory" '
+		prolog &&
+		reset_work_tree_to replace_sub1_with_file &&
+		(
+			cd submodule_update &&
+			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			$command replace_file_with_sub1 &&
+			test_superproject_content origin/replace_file_with_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/replace_file_with_sub1
+		)
+	'
+	# ... as does removing a directory with tracked files with a
+	# submodule.
+	test_expect_success "$command: replace directory with submodule" '
+		prolog &&
+		reset_work_tree_to replace_sub1_with_directory &&
+		(
+			cd submodule_update &&
+			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
+			$command replace_directory_with_sub1 &&
+			test_superproject_content origin/replace_directory_with_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/replace_directory_with_sub1
+		)
+	'
+
+	######################## Disappearing submodule #######################
+	# Removing a submodule doesn't remove its work tree ...
+	test_expect_success "$command: removed submodule leaves submodule directory and its contents in place" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t remove_sub1 origin/remove_sub1 &&
+			$command remove_sub1 &&
+			test_superproject_content origin/remove_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... especially when it contains a .git directory.
+	test_expect_success "$command: removed submodule leaves submodule containing a .git directory alone" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t remove_sub1 origin/remove_sub1 &&
+			replace_gitfile_with_git_dir sub1 &&
+			$command remove_sub1 &&
+			test_superproject_content origin/remove_sub1 &&
+			test_git_directory_is_unchanged sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Replacing a submodule with files in a directory must fail as the
+	# submodule work tree isn't removed ...
+	test_expect_success "$command: replace submodule with a directory must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_must_fail $command replace_sub1_with_directory &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... especially when it contains a .git directory.
+	test_expect_success "$command: replace submodule containing a .git directory with a directory must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			replace_gitfile_with_git_dir sub1 &&
+			test_must_fail $command replace_sub1_with_directory &&
+			test_superproject_content origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Replacing it with a file must fail as it could throw away any local
+	# work tree changes ...
+	test_expect_failure "$command: replace submodule with a file must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_must_fail $command replace_sub1_with_file &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... or even destroy unpushed parts of submodule history if that
+	# still uses a .git directory.
+	test_expect_failure "$command: replace submodule containing a .git directory with a file must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			replace_gitfile_with_git_dir sub1 &&
+			test_must_fail $command replace_sub1_with_file &&
+			test_superproject_content origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+
+	########################## Modified submodule #########################
+	# Updating a submodule sha1 doesn't update the submodule's work tree
+	test_expect_success "$command: modified submodule does not update submodule work tree" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/add_sub1 &&
+			git submodule update &&
+			test_submodule_content sub1 origin/modify_sub1
+		)
+	'
+
+	# Updating a submodule to an invalid sha1 doesn't update the
+	# submodule's work tree, subsequent update will fail
+	test_expect_success "$command: modified submodule does not update submodule work tree to invalid commit" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t invalid_sub1 origin/invalid_sub1 &&
+			$command invalid_sub1 &&
+			test_superproject_content origin/invalid_sub1 &&
+			test_submodule_content sub1 origin/add_sub1 &&
+			test_must_fail git submodule update &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Updating a submodule from an invalid sha1 doesn't update the
+	# submodule's work tree, subsequent update will succeed
+	test_expect_success "$command: modified submodule does not update submodule work tree from invalid commit" '
+		prolog &&
+		reset_work_tree_to invalid_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t valid_sub1 origin/valid_sub1 &&
+			$command valid_sub1 &&
+			test_superproject_content origin/valid_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/valid_sub1
+		)
+	'
+}
+
+# Test that submodule contents are currently not updated when switching
+# between commits that change a submodule, but throwing away local changes in
+# the superproject is allowed.
+test_submodule_forced_switch () {
+	command="$1"
+	######################### Appearing submodule #########################
+	# Switching to a commit letting a submodule appear creates empty dir ...
+	test_expect_success "$command: added submodule creates empty directory" '
+		prolog &&
+		reset_work_tree_to no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... and doesn't care if it already exists ...
+	test_expect_success "$command: added submodule leaves existing empty directory alone" '
+		prolog &&
+		reset_work_tree_to no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			mkdir sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... unless there is an untracked file in its place.
+	test_expect_success "$command: added submodule does remove untracked unignored file with same name when forced" '
+		prolog &&
+		reset_work_tree_to no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t add_sub1 origin/add_sub1 &&
+			echo -n >sub1 &&
+			$command add_sub1 &&
+			test_superproject_content origin/add_sub1 &&
+			test_dir_is_empty sub1
+		)
+	'
+	# Replacing a tracked file with a submodule produces an empty
+	# directory ...
+	test_expect_success "$command: replace tracked file with submodule creates empty directory" '
+		prolog &&
+		reset_work_tree_to replace_sub1_with_file &&
+		(
+			cd submodule_update &&
+			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			$command replace_file_with_sub1 &&
+			test_superproject_content origin/replace_file_with_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/replace_file_with_sub1
+		)
+	'
+	# ... as does removing a directory with tracked files with a
+	# submodule.
+	test_expect_success "$command: replace directory with submodule" '
+		prolog &&
+		reset_work_tree_to replace_sub1_with_directory &&
+		(
+			cd submodule_update &&
+			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
+			$command replace_directory_with_sub1 &&
+			test_superproject_content origin/replace_directory_with_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/replace_directory_with_sub1
+		)
+	'
+
+	######################## Disappearing submodule #######################
+	# Removing a submodule doesn't remove its work tree ...
+	test_expect_success "$command: removed submodule leaves submodule directory and its contents in place" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t remove_sub1 origin/remove_sub1 &&
+			$command remove_sub1 &&
+			test_superproject_content origin/remove_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... especially when it contains a .git directory.
+	test_expect_success "$command: removed submodule leaves submodule containing a .git directory alone" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t remove_sub1 origin/remove_sub1 &&
+			replace_gitfile_with_git_dir sub1 &&
+			$command remove_sub1 &&
+			test_superproject_content origin/remove_sub1 &&
+			test_git_directory_is_unchanged sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Replacing a submodule with files in a directory must fail as the
+	# submodule work tree isn't removed ...
+	test_expect_failure "$command: replace submodule with a directory must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_must_fail $command replace_sub1_with_directory &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... especially when it contains a .git directory.
+	test_expect_failure "$command: replace submodule containing a .git directory with a directory must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			replace_gitfile_with_git_dir sub1 &&
+			test_must_fail $command replace_sub1_with_directory &&
+			test_superproject_content origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Replacing it with a file must fail as it could throw away any local
+	# work tree changes ...
+	test_expect_failure "$command: replace submodule with a file must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_must_fail $command replace_sub1_with_file &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# ... or even destroy unpushed parts of submodule history if that
+	# still uses a .git directory.
+	test_expect_failure "$command: replace submodule containing a .git directory with a file must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			replace_gitfile_with_git_dir sub1 &&
+			test_must_fail $command replace_sub1_with_file &&
+			test_superproject_content origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1 &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+
+	########################## Modified submodule #########################
+	# Updating a submodule sha1 doesn't update the submodule's work tree
+	test_expect_success "$command: modified submodule does not update submodule work tree" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/add_sub1 &&
+			git submodule update &&
+			test_submodule_content sub1 origin/modify_sub1
+		)
+	'
+	# Updating a submodule to an invalid sha1 doesn't update the
+	# submodule's work tree, subsequent update will fail
+	test_expect_success "$command: modified submodule does not update submodule work tree to invalid commit" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t invalid_sub1 origin/invalid_sub1 &&
+			$command invalid_sub1 &&
+			test_superproject_content origin/invalid_sub1 &&
+			test_submodule_content sub1 origin/add_sub1 &&
+			test_must_fail git submodule update &&
+			test_submodule_content sub1 origin/add_sub1
+		)
+	'
+	# Updating a submodule from an invalid sha1 doesn't update the
+	# submodule's work tree, subsequent update will succeed
+	test_expect_success "$command: modified submodule does not update submodule work tree from invalid commit" '
+		prolog &&
+		reset_work_tree_to invalid_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t valid_sub1 origin/valid_sub1 &&
+			$command valid_sub1 &&
+			test_superproject_content origin/valid_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/valid_sub1
+		)
+	'
+}
-- 
2.0.0.406.gf4dce28
