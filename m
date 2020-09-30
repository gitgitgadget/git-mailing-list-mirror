Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD0EC4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DFC20674
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgI3Myl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:54:41 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:24485 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbgI3Myl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:54:41 -0400
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kNbcz-000Afd-Cl; Wed, 30 Sep 2020 13:54:38 +0100
Subject: Re: [PATCH v8 3/3] t, doc: update tests, reference for
 "--force-if-includes"
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
 <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <20200927141747.78047-4-shrinidhi.kaushik@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1377ee27-3f71-a12f-41f6-613e5a00695a@iee.email>
Date:   Wed, 30 Sep 2020 13:54:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200927141747.78047-4-shrinidhi.kaushik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, spelling nit.

On 27/09/2020 15:17, Srinidhi Kaushik wrote:
> Update test cases for the new option, and document its usage
> and update related references.
>
> Update test cases for the new option, and document its usage
> and update related references.
>
>  - t/t5533-push-cas.sh:
>    Update test cases for "compare-and-swap" when used along with
>    "--force-if-includes" helps mitigate overwrites when remote
>    refs are updated in the background; allows forced updates when
>    changes from remote are integrated locally.
>
>  - Documentation:
>    Add reference for the new option, configuration setting
>    ("push.useForceIfIncludes") and advise messages.
>
> Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
> ---
>  Documentation/config/advice.txt |   9 +-
>  Documentation/config/push.txt   |   6 ++
>  Documentation/git-push.txt      |  26 +++++-
>  t/t5533-push-cas.sh             | 140 ++++++++++++++++++++++++++++++++
>  4 files changed, 177 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index bdd37c3eaa..acbd0c09aa 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -10,9 +10,8 @@ advice.*::
>  		that the check is disabled.
>  	pushUpdateRejected::
>  		Set this variable to 'false' if you want to disable
> -		'pushNonFFCurrent',
> -		'pushNonFFMatching', 'pushAlreadyExists',
> -		'pushFetchFirst', and 'pushNeedsForce'
> +		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
> +		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
>  		simultaneously.
>  	pushNonFFCurrent::
>  		Advice shown when linkgit:git-push[1] fails due to a
> @@ -41,6 +40,10 @@ advice.*::
>  		we can still suggest that the user push to either
>  		refs/heads/* or refs/tags/* based on the type of the
>  		source object.
> +	pushRefNeedsUpdate::
> +		Shown when linkgit:git-push[1] rejects a forced update of
> +		a branch when its remote-tracking ref has updates that we
> +		do not have locally.
>  	statusAheadBehind::
>  		Shown when linkgit:git-status[1] computes the ahead/behind
>  		counts for a local ref compared to its remote tracking ref,
> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index f5e5b38c68..21b256e0a4 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -114,3 +114,9 @@ push.recurseSubmodules::
>  	specifying '--recurse-submodules=check|on-demand|no'.
>  	If not set, 'no' is used by default, unless 'submodule.recurse' is
>  	set (in which case a 'true' value means 'on-demand').
> +
> +push.useForceIfIncludes::
> +	If set to "true", it is equivalent to specifying
> +	`--force-if-includes` as an option to linkgit:git-push[1]
> +	in the command line. Adding `--no-force-if-includes` at the
> +	time of push overrides this configuration setting.
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 3b8053447e..fb3a220386 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
>  	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
>  	   [--[no-]signed|--signed=(true|false|if-asked)]
> -	   [--force-with-lease[=<refname>[:<expect>]]]
> +	   [--force-with-lease[=<refname>[:<expect>]] [--force-if-includes]]
>  	   [--no-verify] [<repository> [<refspec>...]]
>  
>  DESCRIPTION
> @@ -320,6 +320,14 @@ seen and are willing to overwrite, then rewrite history, and finally
>  force push changes to `master` if the remote version is still at
>  `base`, regardless of what your local `remotes/origin/master` has been
>  updated to in the background.
> ++
> +Alternatively, specifying `--force-if-includes` an an ancillary option

s/ an an / as an /

> +along with `--force-with-lease[=<refname>]` (i.e., without saying what
> +exact commit the ref on the remote side must be pointing at, or which
> +refs on the remote side are being protected) at the time of "push" will
> +verify if updates from the remote-tracking refs that may have been
> +implicitly updated in the background are integrated locally before
> +allowing a forced update.
>  
>  -f::
>  --force::
> @@ -341,6 +349,22 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
>  origin +master` to force a push to the `master` branch). See the
>  `<refspec>...` section above for details.
>  
> +--[no-]force-if-includes::
> +	Force an update only if the tip of the remote-tracking ref
> +	has been integrated locally.
> ++
> +This option enables a check that verifies if the tip of the
> +remote-tracking ref is reachable from one of the "reflog" entries of
> +the local branch based in it for a rewrite. The check ensures that any
> +updates from the remote have been incorporated locally by rejecting the
> +forced update if that is not the case.
> ++
> +If the option is passed without specifying `--force-with-lease`, or
> +specified along with `--force-with-lease=<refname>:<expect>`, it is
> +a "no-op".
> ++
> +Specifying `--no-force-if-includes` disables this behavior.
> +
>  --repo=<repository>::
>  	This option is equivalent to the <repository> argument. If both
>  	are specified, the command-line argument takes precedence.
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index 0b0eb1d025..a36b371aeb 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -13,6 +13,46 @@ setup_srcdst_basic () {
>  	)
>  }
>  
> +# For tests with "--force-if-includes".
> +setup_src_dup_dst () {
> +	rm -fr src dup dst &&
> +	git init --bare dst &&
> +	git clone --no-local dst src &&
> +	git clone --no-local dst dup
> +	(
> +		cd src &&
> +		test_commit A &&
> +		test_commit B &&
> +		test_commit C &&
> +		git push
> +	) &&
> +	(
> +		cd dup &&
> +		git fetch &&
> +		git merge origin/master &&
> +		git switch -c branch master~2 &&
> +		test_commit D &&
> +		test_commit E &&
> +		git push --all
> +	) &&
> +	(
> +		cd src &&
> +		git switch master &&
> +		git fetch --all &&
> +		git branch branch --track origin/branch &&
> +		git rebase origin/master
> +	) &&
> +	(
> +		cd dup &&
> +		git switch master &&
> +		test_commit F &&
> +		test_commit G &&
> +		git switch branch &&
> +		test_commit H &&
> +		git push origin --all
> +	)
> +}
> +
>  test_expect_success setup '
>  	# create template repository
>  	test_commit A &&
> @@ -256,4 +296,104 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
>  	)
>  '
>  
> +test_expect_success 'background updates to remote can be mitigated with "--force-if-includes"' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	git ls-remote dst refs/heads/master >expect.master &&
> +	git ls-remote dst refs/heads/master >expect.branch &&
> +	(
> +		cd src &&
> +		git switch branch &&
> +		test_commit I &&
> +		git switch master &&
> +		test_commit J &&
> +		git fetch --all &&
> +		test_must_fail git push --force-with-lease --force-if-includes --all
> +	) &&
> +	git ls-remote dst refs/heads/master >actual.master &&
> +	git ls-remote dst refs/heads/master >actual.branch &&
> +	test_cmp expect.master actual.master &&
> +	test_cmp expect.branch actual.branch
> +'
> +
> +test_expect_success 'background updates to remote can be mitigated with "push.useForceIfIncludes"' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	git ls-remote dst refs/heads/master >expect.master &&
> +	(
> +		cd src &&
> +		git switch branch &&
> +		test_commit I &&
> +		git switch master &&
> +		test_commit J &&
> +		git fetch --all &&
> +		git config --local push.useForceIfIncludes true &&
> +		test_must_fail git push --force-with-lease=master origin master
> +	) &&
> +	git ls-remote dst refs/heads/master >actual.master &&
> +	test_cmp expect.master actual.master
> +'
> +
> +test_expect_success '"--force-if-includes" should be disabled for --force-with-lease="<refname>:<expect>"' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	git ls-remote dst refs/heads/master >expect.master &&
> +	git ls-remote dst refs/heads/master >expect.branch &&
> +	(
> +		cd src &&
> +		git switch branch &&
> +		test_commit I &&
> +		git switch master &&
> +		test_commit J &&
> +		remote_head="$(git rev-parse refs/remotes/origin/master)" &&
> +		git fetch --all &&
> +		test_must_fail git push --force-if-includes --force-with-lease="master:$remote_head" 2>err &&
> +		grep "stale info" err
> +	) &&
> +	git ls-remote dst refs/heads/master >actual.master &&
> +	git ls-remote dst refs/heads/master >actual.branch &&
> +	test_cmp expect.master actual.master &&
> +	test_cmp expect.branch actual.branch
> +'
> +
> +test_expect_success '"--force-if-includes" should allow forced update after a rebase ("pull --rebase")' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git switch branch &&
> +		test_commit I &&
> +		git switch master &&
> +		test_commit J &&
> +		git pull --rebase origin master &&
> +		git push --force-if-includes --force-with-lease="master"
> +	)
> +'
> +
> +test_expect_success '"--force-if-includes" should allow forced update after a rebase ("pull --rebase", local rebase)' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git switch branch &&
> +		test_commit I &&
> +		git switch master &&
> +		test_commit J &&
> +		git pull --rebase origin master &&
> +		git rebase --onto HEAD~4 HEAD~1 &&
> +		git push --force-if-includes --force-with-lease="master"
> +	)
> +'
> +
> +test_expect_success '"--force-if-includes" should allow deletes ' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git switch branch &&
> +		git pull --rebase origin branch &&
> +		git push --force-if-includes --force-with-lease=branch origin :branch
> +	)
> +'
> +
>  test_done

