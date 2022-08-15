Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C53C00140
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 01:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiHPBNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 21:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350748AbiHPBMj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 21:12:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1841B297E
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 13:58:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAAAF153E9F;
        Mon, 15 Aug 2022 16:58:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PePwwYYEmt1OfMU9288rXLaOYFEaGCbcCa8Hwj
        7RH9M=; b=rQaBOCjDwEVtp0fhbIHHh/kwHkRzjQ02ImRAcOpjZCE1XK67oDTGUw
        IrapDnOV86movumIzGWstUhTxDkU/y95R2RpxUPAXJH/2fBNA+F7W7dsI6ieuSLA
        kkdIzy4Z/ZOId623Cr/Z7O9A4NbvSFRT8MWb0Dfv8gsEUZupBBYW0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A281A153E9E;
        Mon, 15 Aug 2022 16:58:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09F0C153E9B;
        Mon, 15 Aug 2022 16:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/5] rebase --keep-base: imply --reapply-cherry-picks
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <9cd4c372ee4b3e5ba45c66a43ad0edaf52f0eed9.1660576283.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 13:58:51 -0700
In-Reply-To: <9cd4c372ee4b3e5ba45c66a43ad0edaf52f0eed9.1660576283.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 15 Aug 2022 15:11:22
        +0000")
Message-ID: <xmqqlerpz0j8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11D149CC-1CDD-11ED-83D1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As --keep-base does not rebase the branch it is confusing if it
> removes commits that have been cherry-picked to the upstream branch.
> As --reapply-cherry-picks is not supported by the "apply" backend this
> commit ensures that cherry-picks are reapplied by forcing the upstream
> commit to match the onto commit unless --no-reapply-cherry-picks is
> given.
>
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-rebase.txt     |  2 +-
>  builtin/rebase.c                 | 15 ++++++++++++++-
>  t/t3416-rebase-onto-threedots.sh | 21 +++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 080658c8710..dc0c6c54e27 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -218,7 +218,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  	merge base of `<upstream>` and `<branch>`. Running
>  	`git rebase --keep-base <upstream> <branch>` is equivalent to
>  	running
> -	`git rebase --onto <upstream>...<branch> <upstream> <branch>`.
> +	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
>  +
>  This option is useful in the case where one is developing a feature on
>  top of an upstream branch. While the feature is being worked on, the
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 86ea731ca3a..b6b3e00e3b1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1181,6 +1181,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	prepare_repo_settings(the_repository);
>  	the_repository->settings.command_requires_full_index = 0;
>  
> +	options.reapply_cherry_picks = -1;
>  	options.allow_empty_message = 1;
>  	git_config(rebase_config, &options);
>  	/* options.gpg_sign_opt will be either "-S" or NULL */
> @@ -1240,6 +1241,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		if (options.root)
>  			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
>  	}
> +	/*
> +	 * --keep-base defaults to --reapply-cherry-picks as it is confusing if
> +	 * commits disappear when using this option.
> +	 */
> +	if (options.reapply_cherry_picks < 0)
> +		options.reapply_cherry_picks = keep_base;

It makes me wonder if an explicit "--no-reapply-cherry-picks" makes
sense in combination with "--keep-base".  If that happens, we do not
take this "By default, reapply is enabled with keep-base".

> @@ -1416,7 +1423,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	if (options.empty != EMPTY_UNSPECIFIED)
>  		imply_merge(&options, "--empty");
>  
> -	if (options.reapply_cherry_picks)
> +	/*
> +	 * --keep-base implements --reapply-cherry-picks by altering upstream so
> +	 * it works with both backends.
> +	 */
> +	if (options.reapply_cherry_picks && !keep_base)
>  		imply_merge(&options, "--reapply-cherry-picks");

Interesting.  The idea is that we shouldn't care how much progress
(which may include cherry-picks) the upstream side made, and it is
no use to compare the commits between the F (fork point) and O (our
tip) against the commits between updated U (upstream) and F (fork
point) to notice that X' is a cherry-pick from our X.

              o---X---o---O (our work)
             /
	----F----o----o----o----X'----U (upstream)

So almost ignoring U (except for obviously figure out F, possibly,
for the purpose of keep-base) is an effective way to keep X on our
history, and when it happens, we do not have to explicitly pass the
"--reapply" option to underlying rebase machinery.  Makes sense.

If an explicit "--no-reapply-cherry-picks" with "--keep-base" is
given, we still skip this and do not call imply_merge() ...

> @@ -1680,6 +1691,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>  	if (keep_base) {
>  		oidcpy(&merge_base, &options.onto->object.oid);
> +		if (options.reapply_cherry_picks)
> +			options.upstream = options.onto;

... but this is also skipped in such a case.  I do not offhand know
if the combination makes practical sense, but this should allow the
combination to "work".  OK.

Thanks.
