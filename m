Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F08C63798
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 13:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9901220758
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 13:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgKWMuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:50:03 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:11296 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732217AbgKWMts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 07:49:48 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1khBHm-0002sa-5G; Mon, 23 Nov 2020 12:49:39 +0000
Subject: Re: [PATCH 3/3] init: provide useful advice about init.defaultBranch
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
 <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b7df1e27-9ffc-5ca5-3c9a-77dbcff48d19@iee.email>
Date:   Mon, 23 Nov 2020 12:49:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi dscho,

On 22/11/2020 23:23, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> To give ample warning in case we decide to change the fall-back for an
> unconfigured `init.defaultBranch`, let's introduce some advice that is
> shown upon `git init` when that value is not set.
>
> Note: three test cases in Git's test suite want to verify that the
> `stderr` output of `git init` is empty. With this patch, that is only
> true if `init.defaultBranch` is configured, so let's do exactly that in
> those test cases. The same reasoning applies to `test_create_repo()`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  refs.c                        | 13 ++++++++++++-
>  t/t0001-init.sh               |  9 ++++++++-
>  t/t1510-repo-setup.sh         |  2 +-
>  t/t7414-submodule-mistakes.sh |  2 +-
>  t/test-lib-functions.sh       |  3 ++-
>  5 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 8df03122d6..61d712ca05 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -562,6 +562,14 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
>  		strvec_pushf(prefixes, *p, len, prefix);
>  }
>  
> +static const char default_branch_name_advice[] = N_(
> +"Using '%s' as the name for the initial branch. This name is subject\n"
> +"to change. 
This sounds like Git will change the branch name within the user's repo,
rather than "The default" being subject to change.  So maybe
s/This/The default/   ?

Philip

> To configure the name to use as the initial branch name in\n"
> +"new repositories, or to silence this warning, run:\n"
> +"\n"
> +"\tgit config --global init.defaultBranch <name>\n"
> +);
> +
>  char *repo_default_branch_name(struct repository *r, int quiet)
>  {
>  	const char *config_key = "init.defaultbranch";
> @@ -574,8 +582,11 @@ char *repo_default_branch_name(struct repository *r, int quiet)
>  	else if (repo_config_get_string(r, config_key, &ret) < 0)
>  		die(_("could not retrieve `%s`"), config_display_key);
>  
> -	if (!ret)
> +	if (!ret) {
>  		ret = xstrdup("master");
> +		if (!quiet)
> +			advise(_(default_branch_name_advice), ret);
> +	}
>  
>  	full_ref = xstrfmt("refs/heads/%s", ret);
>  	if (check_refname_format(full_ref, 0))
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 69a320489f..754dab3bab 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -163,7 +163,7 @@ test_expect_success 'reinit' '
>  	(
>  		mkdir again &&
>  		cd again &&
> -		git init >out1 2>err1 &&
> +		git -c init.defaultBranch=initial init >out1 2>err1 &&
>  		git init >out2 2>err2
>  	) &&
>  	test_i18ngrep "Initialized empty" again/out1 &&
> @@ -558,6 +558,13 @@ test_expect_success 'overridden default initial branch name (config)' '
>  	grep nmb actual
>  '
>  
> +test_expect_success 'advice on unconfigured init.defaultBranch' '
> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
> +		init unconfigured-default-branch-name 2>err &&
> +	test_decode_color <err >decoded &&
> +	test_i18ngrep "<YELLOW>hint: " decoded
> +'
> +
>  test_expect_success 'overridden default main branch name (env)' '
>  	test_config_global init.defaultBranch nmb &&
>  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
> diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
> index 9974457f56..5189a520a2 100755
> --- a/t/t1510-repo-setup.sh
> +++ b/t/t1510-repo-setup.sh
> @@ -79,7 +79,7 @@ setup_repo () {
>  	name=$1 worktreecfg=$2 gitfile=$3 barecfg=$4 &&
>  	sane_unset GIT_DIR GIT_WORK_TREE &&
>  
> -	git init "$name" &&
> +	git -c init.defaultBranch=repo init "$name" &&
>  	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
>  	maybe_config "$name/.git/config" core.bare "$barecfg" &&
>  	mkdir -p "$name/sub/sub" &&
> diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
> index f2e7df59cf..0ed02938f9 100755
> --- a/t/t7414-submodule-mistakes.sh
> +++ b/t/t7414-submodule-mistakes.sh
> @@ -30,7 +30,7 @@ test_expect_success 'no warning when updating entry' '
>  
>  test_expect_success 'submodule add does not warn' '
>  	test_when_finished "git rm -rf submodule .gitmodules" &&
> -	git submodule add ./embed submodule 2>stderr &&
> +	git -c init.defaultBranch=x submodule add ./embed submodule 2>stderr &&
>  	test_i18ngrep ! warning stderr
>  '
>  
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 59bbf75e83..772152320a 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1202,7 +1202,8 @@ test_create_repo () {
>  	mkdir -p "$repo"
>  	(
>  		cd "$repo" || error "Cannot setup test environment"
> -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
> +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
> +			-c init.defaultBranch=master init \
>  			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
>  		error "cannot run git init -- have you built things yet?"
>  		mv .git/hooks .git/hooks-disabled

