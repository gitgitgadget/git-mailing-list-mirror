Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617C7C4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3115206B6
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 17:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p/GNSsFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgJDRq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 13:46:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52383 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgJDRq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 13:46:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80630F3F1A;
        Sun,  4 Oct 2020 13:46:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tL+Rm2YrH85z3EYBWAGPhpqSiEk=; b=p/GNSs
        Fh2qDrOPuAd0BlMLfAsJFE0Pf6+wix3pDn2Q/gCsdX6wkj7G3aGOdYe3ey2/evNq
        +fKgFl1PUOR5/FD0Po6vf+O5EdroAKNjynd0gzKcwHiTMiEUZ1JuKdMfMH+xey7I
        HCg2nSRmgPX4a9Tmvp2RVSAQeD5Y3Fj39RA8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NNtwmsDl798tlw90ENTRgxicUKS7DNO1
        oTfWRk3Sl7N0D2c2r/a9jdsz4ooAnkIpWLSrJVOcg50vP6ar4ET5zgAWeHzb7UGN
        o6B66gFYcsVVEdqHAY6qyeOHL6ikSaccolGYmgkSZQ/pXzPXQkyzikN9DsijhbqQ
        7mrW0eW+jMY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78E89F3F19;
        Sun,  4 Oct 2020 13:46:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BEB03F3F17;
        Sun,  4 Oct 2020 13:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] checkout: learn to respect checkout.guess
References: <cover.1601810233.git.liu.denton@gmail.com>
        <8172602f6f1bbdfe39c8a1219dd3b9a222eb65fa.1601810233.git.liu.denton@gmail.com>
Date:   Sun, 04 Oct 2020 10:46:14 -0700
In-Reply-To: <8172602f6f1bbdfe39c8a1219dd3b9a222eb65fa.1601810233.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sun, 4 Oct 2020 04:18:24 -0700")
Message-ID: <xmqqwo057ul5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80D8AC02-0669-11EB-B96C-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The current behavior of git checkout/switch is that --guess is currently
> enabled by default. However, some users may not wish for this to happen
> automatically. Instead of forcing users to specify --no-guess manually
> each time, teach these commands the checkout.guess configuration
> variable that gives users the option to set a default behavior.
>
> Teach the completion script to recognize the new config variable and
> disable DWIM logic if it is set to false.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---

Asking for input from Dscho on how to futureproof the tests along
the same line as js/default-branch-name-part-2 topic.

>  Documentation/config/checkout.txt      |  5 +++
>  Documentation/git-checkout.txt         |  3 ++
>  Documentation/git-switch.txt           |  3 ++
>  builtin/checkout.c                     |  7 +++-
>  contrib/completion/git-completion.bash | 15 ++++++--
>  t/t2024-checkout-dwim.sh               | 11 ++++++
>  t/t2060-switch.sh                      |  5 ++-
>  t/t9902-completion.sh                  | 52 ++++++++++++++++++++++++++
>  8 files changed, 95 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
> index e3684a5459..2cddf7b4b4 100644
> --- a/Documentation/config/checkout.txt
> +++ b/Documentation/config/checkout.txt
> @@ -16,3 +16,8 @@ will checkout the `<something>` branch on another remote,
>  and by linkgit:git-worktree[1] when `git worktree add` refers to a
>  remote branch. This setting might be used for other checkout-like
>  commands or functionality in the future.
> +
> +checkout.guess::
> +	Provides the default value for the `--guess` or `--no-guess`
> +	option in `git checkout` and `git switch`. See
> +	linkgit:git-switch[1] and linkgit:git-checkout[1].
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index afa5c11fd3..28f656d04e 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -193,6 +193,9 @@ branches from there if `<branch>` is ambiguous but exists on the
>  linkgit:git-config[1].
>  +
>  Use `--no-guess` to disable this.
> ++
> +The default behavior can be set via the `checkout.guess` configuration
> +variable.
>  
>  -l::
>  	Create the new branch's reflog; see linkgit:git-branch[1] for
> diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
> index 3759c3a265..5c438cd505 100644
> --- a/Documentation/git-switch.txt
> +++ b/Documentation/git-switch.txt
> @@ -103,6 +103,9 @@ ambiguous but exists on the 'origin' remote. See also
>  `checkout.defaultRemote` in linkgit:git-config[1].
>  +
>  `--guess` is the default behavior. Use `--no-guess` to disable it.
> ++
> +The default behavior can be set via the `checkout.guess` configuration
> +variable.
>  
>  -f::
>  --force::
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 0951f8fee5..0c0394a0d6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1093,11 +1093,16 @@ static int switch_branches(const struct checkout_opts *opts,
>  
>  static int git_checkout_config(const char *var, const char *value, void *cb)
>  {
> +	struct checkout_opts *opts = cb;
> +
>  	if (!strcmp(var, "diff.ignoresubmodules")) {
> -		struct checkout_opts *opts = cb;

This change does make sense even without a new configuration
variable, as 'cb' given by the caller applies to everything this
function handles, not just for a particular configuration variable
(not a suggestion to split this out as a separate clean-up patch; it
is too small for it to be worth).

>  		handle_ignore_submodules_arg(&opts->diff_options, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "checkout.guess")) {
> +		opts->dwim_new_local_branch = git_config_bool(var, value);
> +		return 0;
> +	}
>  
>  	if (starts_with(var, "submodule."))
>  		return git_default_submodule_config(var, value, NULL);

OK.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8be4a0316e..45ecbb9849 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1470,11 +1470,12 @@ _git_bundle ()
>  # To decide between the following rules in priority order
>  # 1) the last provided of "--guess" or "--no-guess" explicitly enable or
>  #    disable completion of DWIM logic respectively.
> -# 2) If the --no-track option is provided, take this as a hint to disable the
> +# 2) If checkout.guess is false, disable completion of DWIM logic.
> +# 3) If the --no-track option is provided, take this as a hint to disable the
>  #    DWIM completion logic
> -# 3) If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
> +# 4) If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
>  #    logic, as requested by the user.
> -# 4) Enable DWIM logic otherwise.
> +# 5) Enable DWIM logic otherwise.
>  #

We may went to consider dropping numbers from these entries, as
nobody refers to another entry with its number (e.g. "contrary to
step 2, if this condition holds, do X"), and we already say "in this
order" upfront.

>  __git_checkout_default_dwim_mode ()
>  {
> @@ -1485,11 +1486,17 @@ __git_checkout_default_dwim_mode ()
>  	fi
>  
>  	# --no-track disables DWIM, but with lower priority than
> -	# --guess/--no-guess
> +	# --guess/--no-guess/checkout.guess
>  	if [ -n "$(__git_find_on_cmdline "--no-track")" ]; then
>  		dwim_opt=""
>  	fi
>  
> +	# checkout.guess = false disables DWIM, but with lower priority than
> +	# --guess/--no-guess
> +	if [ "$(__git config --type=bool checkout.guess)" = "false" ]; then
> +		dwim_opt=""
> +	fi
> +
>  	# Find the last provided --guess or --no-guess
>  	last_option="$(__git_find_last_on_cmdline "--guess --no-guess")"
>  	case "$last_option" in
> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> index accfa9aa4b..a4f8d3a67e 100755
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -166,6 +166,17 @@ test_expect_success '--no-guess suppresses branch auto-vivification' '
>  	test_branch master
>  '
>  
> +test_expect_success 'checkout.guess = false suppresses branch auto-vivification' '
> +	git checkout -B master &&
> +	status_uno_is_clean &&
> +	test_might_fail git branch -D bar &&
> +
> +	test_config checkout.guess false &&
> +	test_must_fail git checkout bar &&
> +	test_must_fail git rev-parse --verify refs/heads/bar &&
> +	test_branch master
> +'
> +
>  test_expect_success 'setup more remotes with unconventional refspecs' '
>  	git checkout -B master &&
>  	status_uno_is_clean &&
> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> index 2c1b8c0d6d..68c9101b02 100755
> --- a/t/t2060-switch.sh
> +++ b/t/t2060-switch.sh
> @@ -85,9 +85,12 @@ test_expect_success 'switching ignores file of same branch name' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'guess and create branch ' '
> +test_expect_success 'guess and create branch' '
>  	test_when_finished git switch master &&
>  	test_must_fail git switch --no-guess foo &&
> +	test_config checkout.guess false &&
> +	test_must_fail git switch foo &&
> +	test_config checkout.guess true &&
>  	git switch foo &&
>  	echo refs/heads/foo >expected &&
>  	git symbolic-ref HEAD >actual &&
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 8425b9a531..2b469a71ca 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1360,6 +1360,58 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
>  	EOF
>  '
>  
> +test_expect_success 'git checkout - with checkout.guess = false, only completes refs' '
> +	test_config checkout.guess false &&
> +	test_completion "git checkout " <<-\EOF
> +	HEAD Z
> +	master Z
> +	matching-branch Z
> +	matching-tag Z
> +	other/branch-in-other Z
> +	other/master-in-other Z
> +	EOF
> +'
> +
> +test_expect_success 'git checkout - with checkout.guess = true, completes refs and unique remote branches for DWIM' '
> +	test_config checkout.guess true &&
> +	test_completion "git checkout " <<-\EOF
> +	HEAD Z
> +	branch-in-other Z
> +	master Z
> +	master-in-other Z
> +	matching-branch Z
> +	matching-tag Z
> +	other/branch-in-other Z
> +	other/master-in-other Z
> +	EOF
> +'
> +
> +test_expect_success 'git checkout - a later --guess overrides previous checkout.guess = false, complete refs and unique remote branches for DWIM' '
> +	test_config checkout.guess false &&
> +	test_completion "git checkout --guess " <<-\EOF
> +	HEAD Z
> +	branch-in-other Z
> +	master Z
> +	master-in-other Z
> +	matching-branch Z
> +	matching-tag Z
> +	other/branch-in-other Z
> +	other/master-in-other Z
> +	EOF
> +'
> +
> +test_expect_success 'git checkout - a later --no-guess overrides previous checkout.guess = true, complete only refs' '
> +	test_config checkout.guess true &&
> +	test_completion "git checkout --no-guess " <<-\EOF
> +	HEAD Z
> +	master Z
> +	matching-branch Z
> +	matching-tag Z
> +	other/branch-in-other Z
> +	other/master-in-other Z
> +	EOF
> +'
> +
>  test_expect_success 'git switch - with --detach, complete all references' '
>  	test_completion "git switch --detach " <<-\EOF
>  	HEAD Z
