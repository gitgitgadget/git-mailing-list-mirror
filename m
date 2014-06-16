From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] submodules: Add the lib-submodule-update.sh test library
Date: Mon, 16 Jun 2014 15:49:23 -0700
Message-ID: <xmqqwqcgo4gc.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <539DD09A.7010200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:49:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwfii-0001Nm-2t
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 00:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbaFPWtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 18:49:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51514 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbaFPWtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 18:49:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F686218C3;
	Mon, 16 Jun 2014 18:49:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04h0g+3iZ6jsM19wD0uaC89lNtE=; b=mC1zkv
	xy2zjtXTTLSokfsFUhYEbOwz8Zri1V1d2YZNB9BckVeI4O9TR5pcYREFsKpJtmf3
	mVwLsWQaYdgGL88vvXYPxCvxBHa44ry6Wuqaf78JY8bLhbBK3fOGRYuqz5BZoZaY
	FtvI+vKVQ+FzObISxZd4DpLfTxmGEnNRDgSgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V9EthNwM2S8ugZMYznJdzXkmxBWvHG0e
	9iFDTv8UDmN7l8VlMZ71JoZ3TfEndGhR3ObFQ3LJYHUoGOSsDxdb5NjMbuNRpTpF
	wl8rgGrHEMVvfukrqcaR2OozPwcGSzN4CpRbrcz4qfuvw/1fVfg4GwGRjcrgqTfz
	uyntvQoIXTs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24B70218C2;
	Mon, 16 Jun 2014 18:49:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE539218C0;
	Mon, 16 Jun 2014 18:49:22 -0400 (EDT)
In-Reply-To: <539DD09A.7010200@web.de> (Jens Lehmann's message of "Sun, 15 Jun
	2014 18:58:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 759F1700-F5A8-11E3-AB39-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251828>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Add this test library to simplify covering all combinations of submodule
> update scenarios without having to add those to a test of each work tree
> manipulating command over and over again.
>
> The functions test_submodule_switch() and test_submodule_forced_switch()
> are intended to be called from a test script with a single argument. This
> argument is either a work tree manipulating command (including any command
> line options) or a function (when more than a single git command is needed
> to switch work trees from the current HEAD to another commit). This
> command (or function) is passed a target branch as argument. The two new
> functions check that each submodule transition is handled as expected,
> which currently means that submodule work trees are not affected until
> "git submodule update" is called. The "forced" variant is for commands
> using their '-f' or '--hard' option and expects them to overwrite local
> modifications as a result. Each of these two functions contains 14
> tests_expect_* calls.
>
> Calling one of these test functions the first time creates a repository
> named "submodule_update_repo". At first it contains two files, then a
> single submodule is added in another commit followed by commits covering
> all relevant submodule modifications. This repository is newly cloned into
> the "submodule_update" for each test_expect_* to avoid interference
> between different parts of the test functions (some to-be-tested commands
> also manipulate refs along with the work tree, e.g. "git reset").
>
> Follow-up commits will then call these two test functions for all work
> tree manipulating commands (with a combination of all their options
> relevant to what they do with the work tree) making sure they work as
> expected. Later this test library will be extended to cover merges
> resulting in conflicts too. Also it is intended to be easily extendable
> for the recursive update functionality, where even more combinations of
> submodule modifications have to be tested for.
>
> This version documents two bugs in current Git with expected failures:
>
> *) When a submodule is replaced with a tracked file of the same name the
>    submodule work tree including any local modifications (and even the
>    whole history if it uses a .git directory instead of a gitfile!) is
>    silently removed.
>
> *) Forced work tree updates happily manipulate files in the directory of a
>    submodule that has just been removed in the superproject (but is of
>    course still present in the work tree due to the way submodules are
>    currently handled). This becomes dangerous when files in the submodule
>    directory are overwritten by files from the new superproject commit, as
>    any modifications to the submodule files will be lost) and is expected
>    to also destroy history in the - admittedly unlikely case - the new
>    commit adds a file named ".git" to the submodule directory.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  t/lib-submodule-update.sh | 630 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 630 insertions(+)
>  create mode 100755 t/lib-submodule-update.sh
>
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> new file mode 100755
> index 0000000..c6c842a
> --- /dev/null
> +++ b/t/lib-submodule-update.sh
> @@ -0,0 +1,630 @@
> +# Create a submodule layout used for all tests below.
> +#
> +# The following use cases are covered:
> +# - New submodule (no_submodule => add_sub1)
> +# - Removed submodule (add_sub1 => remove_sub1)
> +# - Updated submodule (add_sub1 => modify_sub1)
> +# - Submodule updated to invalid commit (add_sub1 => invalid_sub1)
> +# - Submodule updated from invalid commit (invalid_sub1 => valid_sub1)
> +# - Submodule replaced by tracked files in directory (add_sub1 =>
> +#   replace_sub1_with_directory)
> +# - Directory containing tracked files replaced by submodule
> +#   (replace_sub1_with_directory => replace_directory_with_sub1)
> +# - Submodule replaced by tracked file with the same name (add_sub1 =>
> +#   replace_sub1_with_file)
> +# - Tracked file replaced by submodule (replace_sub1_with_file =>
> +#   replace_file_with_sub1)
> +#
> +#                   --O-----O
> +#                  /  ^     replace_directory_with_sub1
> +#                 /   replace_sub1_with_directory
> +#                /----O
> +#               /     ^
> +#              /      modify_sub1
> +#      O------O-------O
> +#      ^      ^\      ^
> +#      |      | \     remove_sub1
> +#      |      |  -----O-----O
> +#      |      |   \   ^     replace_file_with_sub1
> +#      |      |    \  replace_sub1_with_file
> +#      |   add_sub1 --O-----O
> +# no_submodule        ^     valid_sub1
> +#                     invalid_sub1
> +#
> +create_lib_submodule_repo () {
> +	git init submodule_update_repo &&
> +	(
> +		cd submodule_update_repo &&
> +		echo "expect" >>.gitignore &&
> +		echo "actual" >>.gitignore &&
> +		echo "x" >file1 &&
> +		echo "y" >file2 &&
> +		git add .gitignore file1 file2 &&
> +		git commit -m "Base" &&
> +		git branch "no_submodule" &&
> +
> +		git checkout -b "add_sub1" &&
> +		git submodule add ./. sub1 &&

This is not technically wrong per-se, but having the project's
history itself as its own submodule *is* something nobody sane would
do in the real life.  Do we really have to do it this unusual way?

> +		git config -f .gitmodules submodule.sub1.ignore all &&
> +		git config submodule.sub1.ignore all &&
> +		git add .gitmodules &&
> +		git commit -m "Add sub1" &&
> +		git checkout -b remove_sub1 &&
> +		git revert HEAD &&
> +
> +		git checkout -b "modify_sub1" "add_sub1" &&
> +		git submodule update &&
> +		(
> +			cd sub1 &&
> +			git fetch &&
> +			git checkout -b "modifications" &&
> +			echo "z" >file2 &&
> +			echo "x" >file3 &&
> +			git add file2 file3 &&
> +			git commit -m "modified file2 and added file3" &&
> +			git push origin modifications
> +		) &&
> +		git add sub1 &&
> +		git commit -m "Modify sub1" &&
> +
> +		git checkout -b "replace_sub1_with_directory" "add_sub1" &&
> +		git submodule update &&
> +		(
> +			cd sub1 &&
> +			git checkout modifications
> +		) &&
> +		git rm --cached sub1 &&
> +		rm sub1/.git* &&
> +		git config -f .gitmodules --remove-section "submodule.sub1" &&
> +		git add .gitmodules sub1/* &&
> +		git commit -m "Replace sub1 with directory" &&
> +		git checkout -b replace_directory_with_sub1 &&
> +		git revert HEAD &&
> +
> +		git checkout -b "replace_sub1_with_file" "add_sub1" &&
> +		git rm sub1 &&
> +		echo "content" >sub1 &&
> +		git add sub1 &&
> +		git commit -m "Replace sub1 with file" &&
> +		git checkout -b replace_file_with_sub1 &&
> +		git revert HEAD &&
> +
> +		git checkout -b "invalid_sub1" "add_sub1" &&
> +		git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 sub1 &&
> +		git commit -m "Invalid sub1 commit" &&
> +		git checkout -b valid_sub1 &&
> +		git revert HEAD &&
> +		git checkout master
> +	)
> +}
> +
> +# Helper function to replace gitfile with .git directory
> +replace_gitfile_with_git_dir () {
> +	(
> +		cd "$1" &&
> +		git_dir="$(git rev-parse --git-dir)" &&
> +		rm -f .git &&
> +		cp -a "$git_dir" .git &&

We avoid "cp -a" for portability, don't we?

> +		GIT_WORK_TREE=. git config --unset core.worktree

Hmph.  What does GIT_WORK_TREE=. alone without GIT_DIR=<somewhere>
do?  It's not like it is a workaround for "git config" that complains
when you do not have a working tree, right?  Puzzled...

> +	)
> +}
> +
> +# Test that the .git directory in the submodule is unchanged (except for the
> +# core.worktree setting)
> +test_git_directory_is_unchanged () {
> +	(
> +		cd "$1" &&
> +		git config core.worktree "../../../$1"
> +	) &&
> +	git diff -r ".git/modules/$1" "$1/.git" &&

I'd prefer to see "--no-index" spelled out, if that is what is going
on.

> +	(
> +		cd "$1" &&
> +		GIT_WORK_TREE=. git config --unset core.worktree
> +	)
> +}
> +
> +# Helper function to be executed at the start of every test below, it sets up
> +# the submodule repo if it doesn't exist and configures the most problematic
> +# settings for diff.ignoreSubmodules.
> +prolog () {
> +	(test -d submodule_update_repo || create_lib_submodule_repo) &&
> +	test_config_global diff.ignoreSubmodules all &&
> +	test_config diff.ignoreSubmodules all
> +}
> +
> +# Helper function to bring work tree back into the state given by the
> +# commit. This includes trying to populate sub1 accordingly if it exists and
> +# should be updated to an existing commit.
> +reset_work_tree_to () {
> +	rm -rf submodule_update &&
> +	git clone submodule_update_repo submodule_update &&
> +	(
> +		cd submodule_update &&
> +		rm -rf sub1 &&
> +		git checkout -f "$1" &&
> +		git status -u -s >actual &&
> +		test_must_be_empty actual &&
> +		sha1=$(git ls-tree HEAD "sub1" 2>/dev/null | grep 160000 | tr '\t' ' ' | cut -d ' ' -f3) &&

Why discard the standard error stream?

grep|tr|cut looks somewhat stupid.  Can't we do that with a single
sed?

	sha1=$(git ls-tree HEAD sub1 | sed -ne "s/^160000 commit \($_x40\)     .*/\1/p")

or better yet, perhaps

	sha1=$(git rev-parse HEAD:sub1)


> +# Test that the given submodule at path "$1" contains the content according
> +# to the submodule commit recorded in the superproject's commit "$2"
> +test_submodule_content () {
> +	if test $# != 2
> +	then
> +		echo "test_submodule_content needs two arguments"
> +		return 1
> +	fi &&
> +	submodule="$1" &&
> +	commit="$2" &&
> +	test -d "$submodule"/ &&
> +	if ! test -f "$submodule"/.git && ! test -d "$submodule"/.git

I wonder if we can get away with a single "test -e" (we do not
expect us to be creating device nodes or fifos there, do we?).

> +	then
> +		echo "Submodule $submodule is not populated"
> +		return 1
> +	fi &&
> +	sha1=$(git ls-tree "$commit" "$submodule" 2>/dev/null | tr '\t' ' ' | cut -d ' ' -f3) &&

Likewise.
