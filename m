From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] t7410: 210 tests for various 'git submodule update' scenarios
Date: Thu, 17 Apr 2014 18:04:42 +0200
Message-ID: <534FFB9A.3010701@web.de>
References: <1397609688-25634-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@tremily.us>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 18:06:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waop7-0004GM-91
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 18:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbaDQQEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 12:04:55 -0400
Received: from mout.web.de ([212.227.15.4]:59977 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbaDQQEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 12:04:50 -0400
Received: from [192.168.178.41] ([79.193.68.183]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MINAx-1WWgbM44TP-004AmT; Thu, 17 Apr 2014 18:04:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1397609688-25634-1-git-send-email-johan@herland.net>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:u6KhW39AKon/aKHls8HAVgI37sJIB5vyxurntusLkB2P4v/r2Yx
 w4EarrA95ZPgD3/ZdCxT9xaD86UcLC1v4BjQATUWw2y17BuaMCHQEWvFXGTA78jiKhsa1JX
 XfwmVRiKzKmtk13cy8MdpAWL5XHcmnlJFVz2kVC52MoGyz2YtXypftL2mkTZfJLoQHUxu6c
 hTrR/eo89U6+84ZaHdjmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246420>

Am 16.04.2014 02:54, schrieb Johan Herland:
> This is a work-in-progress to flesh out (and promote discussion about)
> the expected behaviors for all possible scenarios in which
> 'git submodule update' might be run.

Thanks a lot, this is a very good idea. After fixing the hidden
staged ignored submodules I'm back working on a very similar topic
I posted an RFC for some time ago. The focus there lies on how git
commands currently handle all possible types of submodule changes
together with "submodule update", which shows some inconsistencies
we currently have:

   http://article.gmane.org/gmane.comp.version-control.git/245046

This is in preparation of the recursive update series, where I
intend to extend these tests to also cover how checkout update
mode handles submodules.

I think it makes lots of sense to nail down our current behavior
first and then talk about what is inconsistent there and how we
should change it. Will try to read this discussion when I find
some time, maybe we can join our efforts to cover all combinations
of configurations and command line options.

> More details in the top of t/t7410-submodule-update-scenarios.sh
> 
> Cc: W. Trevor King <wking@tremily.us>
> Cc: Jens Lehmann <Jens.Lehmann@web.de>
> Cc: Heiko Voigt <hvoigt@hvoigt.net>
> Cc: Junio C Hamano <gitster@pobox.com>
> 
> ---
> 
> Hi,
> 
> This started as an exercise for myself to figure out all the various
> corner cases under which "git submodule update" may be run. Then, as I
> found some cases where the current behavior was not immediately obvious
> to me, and some other cases where the current behaviour is likely buggy
> and/or Wrong(tm), I figured these tests might serve as a backdrop for a
> closer discussion of those cases.
> 
> I've attempted to include all variables/axes that combine to directly
> affect the behavior of 'submodule update'. I've excluded some variables
> whose effect on 'submodule update' is completely orthogonal/independent
> (i.e. how 'submodule update' is affected by unstaged/uncommitted
> changes in the submodule). That said, there might be more variables
> that I have missed in my analysis...
> 
> I've attempted to split the areas to be discussed into 3 todo items and
> 7 discussion items (labeled T1 - T3. and D1 - D7, respectively), and
> I've cross-referenced them to the specific test cases that are affected
> by each todo/discussion item.
> 
> I'll leave it up to Jens and Junio to determine whether this patch
> is worth applying or not. There is certainly considerable overlap
> between these tests and existing tests for 'submodule update'. There's
> also plenty of room for refactoring and deduplication in this file,
> itself, although I hope the current format of the tests makes it fairly
> easy to see what is being tested, and what is the expected behavior.
> 
> Have fun! :)
> 
> ...Johan
> 
> 
>  t/t7410-submodule-update-scenarios.sh | 2859 +++++++++++++++++++++++++++++++++
>  1 file changed, 2859 insertions(+)
>  create mode 100755 t/t7410-submodule-update-scenarios.sh
> 
> diff --git a/t/t7410-submodule-update-scenarios.sh b/t/t7410-submodule-update-scenarios.sh
> new file mode 100755
> index 0000000..22056cc
> --- /dev/null
> +++ b/t/t7410-submodule-update-scenarios.sh
> @@ -0,0 +1,2859 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Johan Herland
> +#
> +
> +test_description='Test "git submodule update" in a variety of scenarios
> +
> +This test attempts to map out the various scenarios in which submodule update
> +is run, and verify their expected behaviour (according to the git submodule
> +documentation).
> +'
> +
> +. ./test-lib.sh
> +
> +# First a textual representation of the various cases we are testing:
> +#
> +# The factors/variables being explored are:
> +#  - submodule.sub.branch
> +#     1.* - unset
> +#     2.* - == foo (exists upstream)
> +#     3.* - == bar (MISSING upstream)
> +#  - submodule.sub.update
> +#     ?.1.* - none
> +#     ?.2.* - checkout
> +#     ?.3.* - merge
> +#     ?.4.* - rebase
> +#     ?.5.* - !command
> +#  - remote mode (whether or not --remote is given on command-line)
> +#     ?.?.1.* - disabled
> +#     ?.?.2.* - enabled
> +#  - current state of submodule:
> +#     ?.?.?.1 - not yet cloned
> +#     ?.?.?.2 - cloned, detached, HEAD == gitlink
> +#     ?.?.?.3 - cloned, detached, HEAD != gitlink
> +#     ?.?.?.4 - cloned, on branch foo (exists upstream), HEAD == gitlink
> +#     ?.?.?.5 - cloned, on branch foo (exists upstream), HEAD != gitlink
> +#     ?.?.?.6 - cloned, on branch bar (MISSING upstream), HEAD == gitlink
> +#     ?.?.?.7 - cloned, on branch bar (MISSING upstream), HEAD != gitlink
> +#
> +# The above variables are combined to enumerate all possible cases, from
> +# 1.1.1.1 to 3.5.2.7 (yes, that's 210 separate test cases). Each test case is
> +# named with its number followed by a short description of its expected outcome.
> +
> +# TODO ITEMS:
> +#
> +# T1: Rename "master" branch to "default" to test correct behaviour when
> +#     submodule's upstream has no master branch.
> +#     Affects: pre, 1.3.1.1, 1.3.2.1, 1.4.1.1, 1.4.2.1
> +#
> +# T2: Test with submodule.<name>.url != submodule's remote.origin.url. Does
> +#     "submodule update --remote" sync with submodule.<name>.url, or with the
> +#     submodule's origin? (or with the submodule's current branch's upstream)?
> +#
> +# T3: Fix uninitialized submodule state after attempting to clone from upstream
> +#     where .branch is missing.
> +#     Affects: pre, 3.2.2.1, 3.3.2.1, 3.4.2.1, 3.5.2.1
> +
> +# DISCUSSION ITEMS:
> +#
> +# D1: When submodule is already at right commit, checkout-mode currently does
> +#     nothing. Should it instead detach, even when no update is needed?
> +#     Affects: 1.2.1.4, 1.2.1.6, 2.2.1.4, 2.2.1.6, 3.2.1.4, 3.2.1.6
> +#
> +# D2: Should all/some of 1.3.*/1.4.* abort/error because we don't know what to
> +#     merge/rebase with (because .branch is unset)? Or is the current default
> +#     to origin/HEAD OK?
> +#     Affects: 1.3.*, 1.4.*
> +#
> +# D3: When submodule is already at right commit, merge/rebase-mode currently
> +#     does nothing. Should it do something else (e.g. not leave submodule
> +#     detached, or checked out on the "wrong" branch (i.e. != .branch))?
> +#     (This discussion point is related to D1, D5 and D6)
> +#     Affects: 1.3.1.2, 1.3.1.4, 1.3.1.6,
> +#              1.4.1.2, 1.4.1.4, 1.4.1.6,
> +#              2.3.1.2, 2.3.1.4, 2.3.1.6, 2.3.2.3, 2.3.2.5, 2.3.2.7,
> +#              2.4.1.2, 2.4.1.4, 2.4.1.6, 2.4.2.3, 2.4.2.5, 2.4.2.7,
> +#              3.3.1.2, 3.3.1.4, 3.3.1.6
> +#              3.4.1.2, 3.4.1.4, 3.4.1.6
> +#
> +# D4: When 'submodule update' performs a clone to populate a submodule, it
> +#     currently also creates a default branch (named after origin/HEAD) in
> +#     that submodule, EVEN WHEN THAT BRANCH WILL NEVER BE USED (e.g. because
> +#     we're in checkout-mode and submodule will always be detached). Is this
> +#     good, or should the clone performed by 'submodule update' skip the
> +#     automatic local branch creation?
> +#     Affects: 1.2.*.1, 1.3.*.1, 1.4.*.1, 1.5.*.1,
> +#              2.2.*.1, 2.3.*.1, 2.4.*.1, 2.5.*.1,
> +#              3.2.1.1, 3.3.1.1, 3.4.1.1, 3.5.1.1
> +#
> +# D5: When in merge/rebase-mode, and 'submodule update' actually ends up doing
> +#     a merge/rebase, that will happen on the current branch (or detached HEAD)
> +#     and NOT on the configured (or default) .branch. Is this OK? Should we
> +#     abort (or at least warn) instead? (In general, .branch seems only to
> +#     affect the submodule's HEAD when the submodule is first cloned.)
> +#     (This discussion point is related to D3 and D6)
> +#     Affects: 1.3.1.3, 1.3.1.5, 1.3.1.7, 1.3.2.>=2,
> +#              1.4.1.3, 1.4.1.5, 1.4.1.7, 1.4.2.>=2,
> +#              2.3.1.3, 2.3.1.5, 2.3.1.7, 2.3.2.2, 2.3.2.4, 2.3.2.6,
> +#              2.4.1.3, 2.4.1.5, 2.4.1.7, 2.4.2.2, 2.4.2.4, 2.4.2.6
> +#              3.3.1.3, 3.3.1.5, 3.3.1.7
> +#              3.4.1.3, 3.4.1.5, 3.4.1.7
> +#
> +# D6: The meaning of submodule.<name>.branch is initially confusing, as it does
> +#     not really concern the submodule's local branch (except as a naming hint
> +#     when the submodule is first cloned). Instead, submodule.<name>.branch is
> +#     really about which branch in the _upstream_ submodule (as defined by
> +#     submodule.<name>.url, or by the submodule's remote.origin.url?) that we
> +#     want to integrate with. This is probably the more useful setting, and it
> +#     becomes obviously correct after (re-)reading gitmodules(5) and
> +#     git-config(1). However, from just reading the "update" section in
> +#     git-submodule(1) (or not even that), things are not so clear-cut. Would
> +#     submodule.<name>.upstream (or .remote-branch, or similar) be a better
> +#     name for this?
> +#
> +# D7: What to do when .branch refers to a branch that is missing from upstream?
> +#     Currently, when trying to clone, the clone fails (which causes 'git
> +#     submodule update --remote' to fail), but leaves the submodule in an
> +#     uninitialized state (there is a .git, but the work tree is missing).
> +#     This is probably not the behavior we want...
> +#     Affects: pre, 3.2.2.1, 3.3.2.1, 3.4.2.1, 3.5.2.1
> +
> +# First, we need to setup the environment in which the test cases are run.
> +# This consists of an upstream super-repo containing a single submodule.
> +# The submodule commit graph looks like this:
> +#
> +#   $root_commit --->  $old_commit ---> $new_commit  <- master (HEAD) # T1
> +#                \          ^- (superproject's gitlink points here)
> +#                 --> $foo_commit  <- foo
> +#
> +# Each test case then starts by cloning upstream_super -> super and setting up
> +# its submodule + configuration according to the current test case. It then
> +# runs "git submodule update" (with or without --remote) and verifies the
> +# expected results.
> +
> +test_expect_success 'preliminaries: setup upstream super and sub' '
> +	git init upstream_sub &&
> +	(cd upstream_sub &&
> +	 test_commit root_commit &&
> +	 test_commit foo_commit &&
> +	 git branch foo &&
> +	 git reset --hard HEAD^ &&
> +#	 git branch -m default &&  # T1
> +	 test_commit old_commit
> +	) &&
> +	git init upstream_super &&
> +	(cd upstream_super &&
> +	 git submodule add ../upstream_sub sub &&
> +	 test_tick &&
> +	 git commit -m "Add sub"
> +	) &&
> +	(cd upstream_sub &&
> +	 test_commit new_commit
> +	)
> +'
> +
> +# The following commit IDs are used in various test cases
> +root_commit=$(git -C upstream_sub rev-parse --verify -q root_commit)
> +foo_commit=$(git -C upstream_sub rev-parse --verify -q foo_commit)
> +old_commit=$(git -C upstream_sub rev-parse --verify -q old_commit)
> +new_commit=$(git -C upstream_sub rev-parse --verify -q new_commit)
> +
> +fail()
> +{
> +	echo "$@"
> +	false
> +}
> +
> +# Verify that the path in $1 contains a cloned git repo
> +verify_is_cloned()
> +{
> +	test -e "$1/.git" ||
> +		fail "Failed to find cloned repo at '$1'"
> +}
> +
> +# Verify that commit $2 in repo $1 has parents $3, $4, ... (in the given order).
> +verify_parents()
> +{
> +	repo=$1; shift
> +	commit=$1; shift
> +	expect_p=$@
> +	actual_p=$(git --git-dir="$repo/.git" log --format=%P -1 "$commit")
> +	test "$expect_p" = "$actual_p" ||
> +		fail "Expected $commit parents '$expect_p' != '$actual_p'"
> +}
> +
> +# Verify that HEAD in repo $1 points to commit $2.
> +# If $2 is of the form 'parents.<SHA1>[.<SHA1>...]', then check that HEAD
> +# currently points to a commit whose parents are the given SHA1s (in order).
> +verify_head()
> +{
> +	head=$(git --git-dir="$1/.git" rev-parse -q HEAD)
> +	case "$2" in
> +	parents.*)
> +		parents=$(echo "$2" | sed -e 's/^parents\.//' -e 's/\./ /g')
> +		verify_parents "$1" "$head" $parents ||
> +			fail "Failed to verify parents of HEAD in '$1'"
> +		;;
> +	*)
> +		test "$2" = "$head" ||
> +			fail "Expected HEAD in '$1' to be '$2', but is '$head'"
> +	esac
> +}
> +
> +# Verify that the repo in $1 is currently checked out on branch $2.
> +# If $2 is "detached", verify that $1'a HEAD is in fact detached.
> +verify_branch()
> +{
> +	expect=$2
> +	if test "$expect" = "detached"
> +	then
> +		expect=
> +	fi
> +	actual=$(git --git-dir="$1/.git" symbolic-ref --short -q HEAD)
> +	test "$expect" = "$actual" ||
> +		fail "Expected branch in '$1' to be '$expect', but is '$actual'"
> +}
> +
> +# Clone upstream_super to super, and run "git submodule init"
> +setup_super()
> +{
> +	rm -rf super &&
> +	git clone upstream_super super &&
> +	(cd super &&
> +	 git submodule init &&
> +	 test_must_fail verify_is_cloned sub &&
> +	 test "$(git rev-parse -q HEAD:sub)" = "$old_commit"
> +	)
> +}
> +
> +# Setup submodule.sub.branch == $1
> +# If $1 == "unset", ensure submodule.sub.branch is unset
> +setup_sub_branch()
> +{
> +	if test "$1" = "unset"
> +	then
> +		git config --unset-all "submodule.sub.branch"
> +		test_must_fail git config "submodule.sub.branch" ||
> +			error "Failed to unset submodule.sub.branch"
> +	else
> +		git config "submodule.sub.branch" "$1"
> +		actual=$(git config "submodule.sub.branch")
> +		test "$actual" = "$1" ||
> +			error "Failed to set submodule.sub.branch to '$1'"
> +	fi
> +}
> +
> +# Setup submodule.sub.update == $1
> +setup_sub_update()
> +{
> +	git config "submodule.sub.update" "$1"
> +	actual=$(git config "submodule.sub.update")
> +	test "$actual" = "$1" ||
> +		error "Failed to set submodule.sub.update to '$1'"
> +}
> +
> +# Setup the state of the sub submodule according to $1, which is one of:
> +#  - "uncloned" - sub is an empty dir.
> +#  - "detach" - sub is detached at the commit in $2.
> +#  - * - sub is checked out on branch named in $1, at the commit in $2.
> +setup_sub_state()
> +{
> +	case "$1" in
> +	uncloned)
> +		test_must_fail verify_is_cloned sub ||
> +			error "Failed to verify uncloned sub"
> +		;;
> +	detach)
> +		git submodule update --checkout sub &&
> +		(cd sub &&
> +		 git checkout "$2"
> +		) &&
> +		verify_is_cloned sub &&
> +		verify_branch sub detached &&
> +		verify_head sub "$2" ||
> +			error "Failed to detach sub at '$2'"
> +		;;
> +	*)
> +		git submodule update --checkout sub &&
> +		(cd sub &&
> +		 git checkout -b "$1" "$2"
> +		) &&
> +		verify_is_cloned sub &&
> +		verify_branch sub "$1" &&
> +		verify_head sub "$2" ||
> +			error "Failed to attach sub to '$1' at '$2'"
> +	esac
> +}
> +
> +# Verify the state of the sub submodule according to $1, which is one of:
> +#  - "uncloned" - sub is an empty dir.
> +#  - "detach" - sub is detached at the commit in $2.
> +#  - * - sub is checked out on branch named in $1, at the commit in $2.
> +# If $2 is of the form 'parents.<SHA1>[.<SHA1>...]', then check that HEAD
> +# currently points to a commit whose parents are the given SHA1s (in order).
> +verify_sub_state()
> +{
> +	case "$1" in
> +	uncloned)
> +		test_must_fail verify_is_cloned sub ||
> +			fail "Failed to verify uncloned sub"
> +		;;
> +	detach)
> +		verify_is_cloned sub &&
> +		verify_branch sub detached &&
> +		verify_head sub "$2" ||
> +			fail "Failed to verify detached sub at '$2'"
> +		;;
> +	*)
> +		verify_is_cloned sub &&
> +		verify_branch sub "$1" &&
> +		verify_head sub "$2" ||
> +			fail "Failed to verify attached sub at '$1' -> '$2'"
> +	esac
> +}
> +
> +verify_sub_patch_id()
> +{
> +	p1=$(git --git-dir=sub/.git show $1 | git patch-id | cut -d' ' -f1)
> +	p2=$(git --git-dir=sub/.git show $2 | git patch-id | cut -d' ' -f1)
> +	test "$p1" = "$p2" ||
> +		fail "'$1' and '$2' has different patch-ids ('$p1' != '$p2')"
> +}
> +
> +# 1.1.* - .branch is unset, .update == none
> +
> +test_expect_success '1.1.1.1 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '1.1.1.2 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '1.1.1.3 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.1.1.4 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '1.1.1.5 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.1.1.6 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '1.1.1.7 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.1.2.1 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '1.1.2.2 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '1.1.2.3 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.1.2.4 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '1.1.2.5 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.1.2.6 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '1.1.2.7 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 1.2.* - .branch is unset, .update == checkout
> +
> +test_expect_success '1.2.1.1 - clone, detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # D4
> +	)
> +'
> +
> +test_expect_success '1.2.1.2 - already @ $old_commit -> keep detached' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '1.2.1.3 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '1.2.1.4 - already @ $old_commit -> keep attached' ' # D1
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '1.2.1.5 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '1.2.1.6 - already @ $old_commit -> keep attached' ' # D1
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '1.2.1.7 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '1.2.2.1 - clone, detach @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit # D4
> +	)
> +'
> +
> +test_expect_success '1.2.2.2 - detach @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit
> +	)
> +'
> +
> +test_expect_success '1.2.2.3 - detach @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit
> +	)
> +'
> +
> +test_expect_success '1.2.2.4 - detach @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit
> +	)
> +'
> +
> +test_expect_success '1.2.2.5 - detach @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit
> +	)
> +'
> +
> +test_expect_success '1.2.2.6 - detach @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit
> +	)
> +'
> +
> +test_expect_success '1.2.2.7 - detach @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit
> +	)
> +'
> +
> +# 1.3.* - .branch is unset, .update == merge # D2
> +
> +test_expect_success '1.3.1.1 - clone, create branch named from origin/HEAD @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # T1, D4, FIXME: s/detach/master/?
> +	)
> +'
> +
> +test_expect_success '1.3.1.2 - already at $old_commit, remain detached' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '1.3.1.3 - merge $old_commit -> $foo_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_success '1.3.1.4 - already at $old_commit, remain attached to foo' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '1.3.1.5 - merge $old_commit -> $foo_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state foo parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_success '1.3.1.6 - already at $old_commit, remain attached to bar' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '1.3.1.7 - merge $old_commit -> $foo_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state bar parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_success '1.3.2.1 - clone, create branch from origin/HEAD @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit # T1, D4, FIXME: s/detach/master/?
> +	)
> +'
> +
> +test_expect_success '1.3.2.2 - ffwd $old_commit -> $new_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit
> +	)
> +'
> +
> +test_expect_success '1.3.2.3 - merge $new_commit -> $foo_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach parents.$foo_commit.$new_commit
> +	)
> +'
> +
> +test_expect_success '1.3.2.4 - ffwd $old_commit -> $new_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $new_commit
> +	)
> +'
> +
> +test_expect_success '1.3.2.5 - merge $new_commit -> $foo_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo parents.$foo_commit.$new_commit
> +	)
> +'
> +
> +test_expect_success '1.3.2.6 - ffwd $old_commit -> $new_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $new_commit
> +	)
> +'
> +
> +test_expect_success '1.3.2.7 - merge $new_commit -> $foo_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar parents.$foo_commit.$new_commit
> +	)
> +'
> +
> +# 1.4.* - .branch is unset, .update == rebase # D2
> +
> +test_expect_success '1.4.1.1 - clone, create branch named from origin/HEAD @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # T1, D4, FIXME: s/detach/master/?
> +	)
> +'
> +
> +test_expect_success '1.4.1.2 - already at $old_commit, remain detached' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '1.4.1.3 - rebase $foo_commit onto $old_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state detach parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.4.1.4 - already at $old_commit, remain attached to foo' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '1.4.1.5 - rebase $foo_commit onto $old_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state foo parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.4.1.6 - already at $old_commit, remain attached to bar' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '1.4.1.7 - rebase $foo_commit onto $old_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state bar parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.4.2.1 - clone, create branch from origin/HEAD @ $new_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit # T1, D4, FIXME: s/detach/master/?
> +	)
> +'
> +
> +test_expect_success '1.4.2.2 - ffwd $old_commit -> $new_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit
> +	)
> +'
> +
> +test_expect_success '1.4.2.3 - rebase $foo_commit onto $new_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach parents.$new_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.4.2.4 - ffwd $old_commit -> $new_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $new_commit
> +	)
> +'
> +
> +test_expect_success '1.4.2.5 - rebase $foo_commit onto $new_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo parents.$new_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '1.4.2.6 - ffwd $old_commit -> $new_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $new_commit
> +	)
> +'
> +
> +test_expect_success '1.4.2.7 - rebase $foo_commit onto $new_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar parents.$new_commit
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +# 1.5.* - .branch is unset, .update == !command
> +
> +test_expect_success '1.5.1.1 - clone, create branch named from origin/HEAD @ $old_commit. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch unset &&
> +	 git submodule update && # should not invoke "false"
> +	 verify_sub_state detach $old_commit # T1, D4, FIXME: s/detach/master/?
> +	)
> +'
> +
> +test_expect_success '1.5.1.2 - already at $old_commit, remain detached. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch unset &&
> +	 git submodule update && # should not invoke "false"
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: detached @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.1.3 - !command invoked to integrate $old_commit -> $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '1.5.1.4 - already at $old_commit, remain attached to foo. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to foo @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "foo" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.1.5 - !command invoked to integrate $old_commit -> foo/$foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '1.5.1.6 - already at $old_commit, remain attached to bar. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to bar @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "bar" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.1.7 - !command invoked to integrate $old_commit -> bar/$foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '1.5.2.1 - clone, create branch from origin/HEAD @ $new_commit. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $new_commit # T1, D4, FIXME: s/detach/master/?
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: detached @ $old_commit, and asked to integrate $new_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$old_commit" &&
> +test "\$1" = "$new_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.2.2 - !command invoked to integrate $new_commit -> $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: detached @ $foo_commit, and asked to integrate $new_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$new_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.2.3 - !command invoked to integrate $new_commit -> $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to foo @ $old_commit, and asked to integrate $new_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "foo" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$old_commit" &&
> +test "\$1" = "$new_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.2.4 - !command invoked to integrate $new_commit -> foo/$old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to foo @ $foo_commit, and asked to integrate $new_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "foo" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$new_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.2.5 - !command invoked to integrate $new_commit -> foo/$foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to bar @ $old_commit, and asked to integrate $new_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "bar" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$old_commit" &&
> +test "\$1" = "$new_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.2.6 - !command invoked to integrate $new_commit -> bar/$old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to bar @ $foo_commit, and asked to integrate $new_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "bar" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$new_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '1.5.2.7 - !command invoked to integrate $new_commit -> bar/$foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch unset &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +# 2.1.* - .branch == foo (exists upstream), .update == none
> +
> +test_expect_success '2.1.1.1 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '2.1.1.2 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '2.1.1.3 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.1.1.4 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '2.1.1.5 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.1.1.6 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '2.1.1.7 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.1.2.1 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '2.1.2.2 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '2.1.2.3 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.1.2.4 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '2.1.2.5 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.1.2.6 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '2.1.2.7 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 2.2.* - .branch == foo (exists upstream), .update == checkout
> +
> +test_expect_success '2.2.1.1 - clone, detach @ $old_commit (.branch is ignored)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # D4
> +	)
> +'
> +
> +test_expect_success '2.2.1.2 - already @ $old_commit -> keep detached' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '2.2.1.3 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '2.2.1.4 - already @ $old_commit -> keep attached' ' # D1
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '2.2.1.5 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '2.2.1.6 - already @ $old_commit -> keep attached' ' # D1
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '2.2.1.7 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '2.2.2.1 - clone, detach @ $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit # D4
> +	)
> +'
> +
> +test_expect_success '2.2.2.2 - detach @ $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.2.2.3 - already @ $foo_commit, remain detached' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.2.2.4 - detach @ $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.2.2.5 - already @ $foo_commit, remain attached to foo' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.2.2.6 - detach @ $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.2.2.7 - already @ $foo_commit, remain attached to bar' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 2.3.* - .branch == foo (exists upstream), .update == merge
> +
> +test_expect_success '2.3.1.1 - clone, create branch called foo @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # D4, FIXME: s/detach/foo/?
> +	)
> +'
> +
> +test_expect_success '2.3.1.2 - already at $old_commit, remain detached' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '2.3.1.3 - merge $old_commit -> $foo_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_success '2.3.1.4 - already at $old_commit, remain attached to foo' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '2.3.1.5 - merge $old_commit -> $foo_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state foo parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_success '2.3.1.6 - already at $old_commit, remain attached to bar' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '2.3.1.7 - merge $old_commit -> $foo_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state bar parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_success '2.3.2.1 - clone, create branch from origin/foo @ $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit # D4, FIXME: s/detach/foo/?
> +	)
> +'
> +
> +test_expect_success '2.3.2.2 - merge $foo_commit -> $old_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach parents.$old_commit.$foo_commit
> +	)
> +'
> +
> +test_expect_success '2.3.2.3 - already @ $foo_commit, remain detached' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.3.2.4 - merge $foo_commit -> $old_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo parents.$old_commit.$foo_commit
> +	)
> +'
> +
> +test_expect_success '2.3.2.5 - already @ $foo_commit, remain attached to foo' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.3.2.6 - merge $foo_commit -> $old_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar parents.$old_commit.$foo_commit
> +	)
> +'
> +
> +test_expect_success '2.3.2.7 - already @ $foo_commit, remain attached to bar' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 2.4.* - .branch == foo (exists upstream), .update == rebase
> +
> +test_expect_success '2.4.1.1 - clone, create branch called foo @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # D4, FIXME: s/detach/foo/?
> +	)
> +'
> +
> +test_expect_success '2.4.1.2 - already at $old_commit, remain detached' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '2.4.1.3 - rebase $foo_commit onto $old_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state detach parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.4.1.4 - already at $old_commit, remain attached to foo' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '2.4.1.5 - rebase $foo_commit onto $old_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state foo parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.4.1.6 - already at $old_commit, remain attached to bar' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '2.4.1.7 - rebase $foo_commit onto $old_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state bar parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.4.2.1 - clone, create branch from origin/foo @ $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit # D4, FIXME: s/detach/foo/?
> +	)
> +'
> +
> +test_expect_success '2.4.2.2 - rebase $old_commit onto $foo_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach parents.$foo_commit &&
> +	 verify_sub_patch_id HEAD $old_commit
> +	)
> +'
> +
> +test_expect_success '2.4.2.3 - already @ $foo_commit, remain detached' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.4.2.4 - rebase $old_commit onto $foo_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo parents.$foo_commit &&
> +	 verify_sub_patch_id HEAD $old_commit
> +	)
> +'
> +
> +test_expect_success '2.4.2.5 - already @ $foo_commit, remain attached to foo' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '2.4.2.6 - rebase $old_commit onto $foo_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar parents.$foo_commit &&
> +	 verify_sub_patch_id HEAD $old_commit
> +	)
> +'
> +
> +test_expect_success '2.4.2.7 - already @ $foo_commit, remain attached to bar' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 2.5.* - .branch == foo (exists upstream), .update == !command
> +
> +test_expect_success '2.5.1.1 - clone, create branch called foo @ $old_commit. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch foo &&
> +	 git submodule update && # should not invoke "false"
> +	 verify_sub_state detach $old_commit # D4, FIXME: s/detach/foo/?
> +	)
> +'
> +
> +test_expect_success '2.5.1.2 - already at $old_commit, remain detached. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch foo &&
> +	 git submodule update && # should not invoke "false"
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: detached @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '2.5.1.3 - !command invoked to integrate $old_commit -> $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '2.5.1.4 - already at $old_commit, remain attached to foo. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to foo @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "foo" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '2.5.1.5 - !command invoked to integrate $old_commit -> foo/$foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '2.5.1.6 - already at $old_commit, remain attached to bar. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to bar @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "bar" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '2.5.1.7 - !command invoked to integrate $old_commit -> bar/$foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch foo &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '2.5.2.1 - clone, create branch from origin/foo @ $foo_commit. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit # D4, FIXME: s/detach/foo/?
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: detached @ $old_commit, and asked to integrate $foo_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$old_commit" &&
> +test "\$1" = "$foo_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '2.5.2.2 - !command invoked to integrate $foo_commit -> $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '2.5.2.3 - already at $foo_commit, remain detached. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to foo @ $old_commit, and asked to integrate $foo_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "foo" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$old_commit" &&
> +test "\$1" = "$foo_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '2.5.2.4 - !command invoked to integrate $foo_commit -> foo/$old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '2.5.2.5 - already at $foo_commit, remain attached to foo. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to bar @ $old_commit, and asked to integrate $foo_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "bar" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$old_commit" &&
> +test "\$1" = "$foo_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '2.5.2.6 - !command invoked to integrate $foo_commit -> bar/$old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '2.5.2.7 - already at $foo_commit, remain attached to bar. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch foo &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 3.1.* - .branch == bar (MISSING upstream), .update == none
> +
> +test_expect_success '3.1.1.1 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '3.1.1.2 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.1.1.3 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.1.1.4 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.1.1.5 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.1.1.6 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.1.1.7 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.1.2.1 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update --remote &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '3.1.2.2 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.1.2.3 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.1.2.4 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.1.2.5 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.1.2.6 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.1.2.7 - do nothing (.update == none)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update none &&
> +	 setup_sub_branch bar &&
> +	 git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 3.2.* - .branch == bar (MISSING upstream), .update == checkout
> +
> +test_expect_success '3.2.1.1 - clone, detach @ $old_commit (.branch is ignored)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # D4
> +	)
> +'
> +
> +test_expect_success '3.2.1.2 - already @ $old_commit -> keep detached' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.2.1.3 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.2.1.4 - already @ $old_commit -> keep attached' ' # D1
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.2.1.5 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.2.1.6 - already @ $old_commit -> keep attached' ' # D1
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.2.1.7 - detach @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_failure '3.2.2.1 - fail to clone (remote branch bar missing), leave uncloned' ' # T3, D7
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '3.2.2.2 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.2.2.3 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.2.2.4 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.2.2.5 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.2.2.6 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.2.2.7 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update checkout &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 3.3.* - .branch == bar (MISSING upstream), .update == merge
> +
> +test_expect_success '3.3.1.1 - clone, create branch called bar @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # D4, FIXME: s/detach/bar/?
> +	)
> +'
> +
> +test_expect_success '3.3.1.2 - already at $old_commit, remain detached' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.3.1.3 - merge $old_commit -> $foo_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_success '3.3.1.4 - already at $old_commit, remain attached to foo' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.3.1.5 - merge $old_commit -> $foo_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state foo parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_success '3.3.1.6 - already at $old_commit, remain attached to bar' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.3.1.7 - merge $old_commit -> $foo_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state bar parents.$foo_commit.$old_commit
> +	)
> +'
> +
> +test_expect_failure '3.3.2.1 - fail to clone (remote branch bar missing), leave uncloned' ' # T3, D7
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '3.3.2.2 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.3.2.3 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.3.2.4 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.3.2.5 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.3.2.6 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.3.2.7 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update merge &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 3.4.* - .branch == bar (MISSING upstream), .update == rebase
> +
> +test_expect_success '3.4.1.1 - clone, create branch called bar @ $old_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit # D4, FIXME: s/detach/bar/?
> +	)
> +'
> +
> +test_expect_success '3.4.1.2 - already at $old_commit, remain detached' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.4.1.3 - rebase $foo_commit onto $old_commit, remain detached' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state detach parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.4.1.4 - already at $old_commit, remain attached to foo' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.4.1.5 - rebase $foo_commit onto $old_commit, remain attached to foo' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state foo parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.4.1.6 - already at $old_commit, remain attached to bar' ' # D3
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.4.1.7 - rebase $foo_commit onto $old_commit, remain attached to bar' ' # D5
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state bar parents.$old_commit &&
> +	 verify_sub_patch_id HEAD $foo_commit
> +	)
> +'
> +
> +test_expect_failure '3.4.2.1 - fail to clone (remote branch bar missing), leave uncloned' ' # T3, D7
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '3.4.2.2 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.4.2.3 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.4.2.4 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.4.2.5 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.4.2.6 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.4.2.7 - fail (remote branch bar missing)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update rebase &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +# 3.5.* - .branch == bar (MISSING upstream), .update == !command
> +
> +test_expect_success '3.5.1.1 - clone, create branch called bat @ $old_commit. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 git submodule update && # should not invoke "false"
> +	 verify_sub_state detach $old_commit # D4, FIXME: s/detach/bar/?
> +	)
> +'
> +
> +test_expect_success '3.5.1.2 - already at $old_commit, remain detached. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 git submodule update && # should not invoke "false"
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: detached @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '3.5.1.3 - !command invoked to integrate $old_commit -> $foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '3.5.1.4 - already at $old_commit, remain attached to foo. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to foo @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "foo" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '3.5.1.5 - !command invoked to integrate $old_commit -> foo/$foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_success '3.5.1.6 - already at $old_commit, remain attached to bar. !command is NOT invoked' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +cat > test_command.sh <<EOF
> +#!/bin/sh
> +# Verify: attached to bar @ $foo_commit, and asked to integrate $old_commit
> +test "\$(git symbolic-ref --short -q HEAD)" = "bar" &&
> +test "\$(git rev-parse -q --verify HEAD)" = "$foo_commit" &&
> +test "\$1" = "$old_commit" &&
> +git checkout -b success $root_commit
> +EOF
> +chmod +x test_command.sh
> +
> +test_expect_success '3.5.1.7 - !command invoked to integrate $old_commit -> bar/$foo_commit' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update !../../test_command.sh &&
> +	 setup_sub_branch bar &&
> +	 git submodule update &&
> +	 verify_sub_state success $root_commit # test_command.sh is happy
> +	)
> +'
> +
> +test_expect_failure '3.5.2.1 - fail to clone (remote branch bar missing), leave uncloned' ' # T3, D7
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state uncloned &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state uncloned
> +	)
> +'
> +
> +test_expect_success '3.5.2.2 - fail (remote branch bar missing, !command not invoked)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state detach $old_commit
> +	)
> +'
> +
> +test_expect_success '3.5.2.3 - fail (remote branch bar missing, !command not invoked)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state detach $foo_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state detach $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.5.2.4 - fail (remote branch bar missing, !command not invoked)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state foo $old_commit
> +	)
> +'
> +
> +test_expect_success '3.5.2.5 - fail (remote branch bar missing, !command not invoked)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state foo $foo_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state foo $foo_commit
> +	)
> +'
> +
> +test_expect_success '3.5.2.6 - fail (remote branch bar missing, !command not invoked)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $old_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state bar $old_commit
> +	)
> +'
> +
> +test_expect_success '3.5.2.7 - fail (remote branch bar missing, !command not invoked)' '
> +	setup_super &&
> +	(cd super &&
> +	 setup_sub_state bar $foo_commit &&
> +	 setup_sub_update !false &&
> +	 setup_sub_branch bar &&
> +	 test_must_fail git submodule update --remote &&
> +	 verify_sub_state bar $foo_commit
> +	)
> +'
> +
> +test_done
> 
