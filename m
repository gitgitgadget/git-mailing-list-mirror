From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC/PATCH 2/4] Submodules: Add the lib-submodule-update.sh test
 library
Date: Tue, 25 Mar 2014 18:05:05 +0100
Message-ID: <5331B741.6000606@web.de>
References: <5331B6F6.60501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:05:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSUmz-0001Ks-9V
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbaCYRFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 13:05:15 -0400
Received: from mout.web.de ([212.227.17.11]:58770 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbaCYRFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 13:05:11 -0400
Received: from [192.168.178.41] ([84.132.146.250]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LgHLE-1WpOx43y7g-00ngLp; Tue, 25 Mar 2014 18:05:07
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5331B6F6.60501@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:zYlOf2eYi0Mu8pVia0Xhv/1rI5V9PIKQEwrJbH+Bu6FRYJ8YW0g
 8Dkyy02lE+XBfSPS+upo8v6Y8W+xb7n8czbnTMMvT9NFLwjCJL6P965Cx7+sjNbLyOGUL/2
 RhycfHFobPHDE8LeTrFJ6jkGJjg3DQVF4lVKwlCbGq6lWxjXDxqc8x9S2Aq32SYQFOiqw0u
 1i4Gm2JeWBStO30RZbshg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245046>

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
   simply removed.

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

I think the first bug really needs to be fixed, as that behavior is extremely
nasty. We should always protect work tree modifications (unless forced) and
*never* remove a .git directory (even when forced).

I'm not so sure about the second one. Even though I believe the current
behavior is not correct (switching commits should never mess around in a
submodule directory) it may be that people who committed a directory =>
submodule transition (or vice versa) are depending on the current
behavior. Fixing the bug would forbid to repeat the submodule => directory
transition and only allow that after the user removed the submodule directory
manually. And as the potential fallout of this bug is not as disastrous as
for the first bug, I might be convinced we should not fix it.

 t/lib-submodule-update.sh | 627 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 627 insertions(+)
 create mode 100755 t/lib-submodule-update.sh

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
new file mode 100755
index 0000000..de5d54e
--- /dev/null
+++ b/t/lib-submodule-update.sh
@@ -0,0 +1,627 @@
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
+		cp -a "$git_dir" .git &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	)
+}
+
+# Test that the .git directory in the submodule is unchanged (except for the
+# core.worktree setting)
+test_git_directory_is_unchanged () {
+	(
+		cd "$1" &&
+		git config core.worktree "../../../$1"
+	) &&
+	git diff -r ".git/modules/$1" "$1/.git" &&
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
+		sha1=$(git ls-tree HEAD "sub1" 2>/dev/null | grep 160000 | tr '\t' ' ' | cut -d ' ' -f3) &&
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
+	sha1=$(git ls-tree "$commit" "$submodule" 2>/dev/null | tr '\t' ' ' | cut -d ' ' -f3) &&
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
+			test_submodule_content sub1 origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1
+		)
+	'
+	# Replacing a submodule with files in a directory must fail as the
+	# submodule work tree isn't removed ...
+	test_expect_success "$command: replace submodule with a directory fails" '
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
+	test_expect_success "$command: replace submodule containing a .git directory with a directory fails" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			replace_gitfile_with_git_dir sub1 &&
+			test_must_fail $command replace_sub1_with_directory &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1
+		)
+	'
+	# Replacing it with a file must fail as it could throw away any local
+	# work tree changes ...
+	test_expect_failure "$command: replace submodule directory with a file must fail" '
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
+	test_expect_failure "$command: replace submodule directory with a file must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			replace_gitfile_with_git_dir sub1 &&
+			test_must_fail $command replace_sub1_with_file &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1
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
+			test_submodule_content sub1 origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1
+		)
+	'
+	# Replacing a submodule with files in a directory must fail as the
+	# submodule work tree isn't removed ...
+	test_expect_failure "$command: replace submodule with a directory fails" '
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
+	test_expect_failure "$command: replace submodule containing a .git directory with a directory fails" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			replace_gitfile_with_git_dir sub1 &&
+			test_must_fail $command replace_sub1_with_directory &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1
+		)
+	'
+	# Replacing it with a file must fail as it could throw away any local
+	# work tree changes ...
+	test_expect_failure "$command: replace submodule directory with a file must fail" '
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
+	test_expect_failure "$command: replace submodule directory with a file must fail" '
+		prolog &&
+		reset_work_tree_to add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			replace_gitfile_with_git_dir sub1 &&
+			test_must_fail $command replace_sub1_with_file &&
+			test_superproject_content origin/add_sub1 &&
+			test_submodule_content sub1 origin/add_sub1 &&
+			test_git_directory_is_unchanged sub1
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
1.9.1.327.g3d8d896
