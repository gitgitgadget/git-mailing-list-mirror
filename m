Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C10C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 08:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8936115C
	for <git@archiver.kernel.org>; Sat, 22 May 2021 08:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhEVI6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 04:58:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61802 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhEVI56 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 04:57:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6383B4F4A;
        Sat, 22 May 2021 04:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zwC5gZQ6XNPznyFD3JE80IqYZ1slnWdQK4EB6O
        cMghA=; b=u0bi2xLq1duyLlWPQ9Qo1JXXP4OaH7Ezr/5zOMBH1lrlbMbSY5XT+t
        QXFFtplwPn0kdSqfn9ftAOm6Ut81orfAqEk9567OmPVBITO+mQZuvKCT7gupGw30
        cgSmVnRQxtYSkd3goGG0z6hhohQkg/tz64hKaGxBZ5wNx7t3WOlLg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB6BDB4F48;
        Sat, 22 May 2021 04:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61749B4F46;
        Sat, 22 May 2021 04:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] stash show: use stash.showIncludeUntracked even when
 diff options given
References: <e2e3574b25099a627d03447f5ace64b0e56c2ad1.1621593333.git.liu.denton@gmail.com>
Date:   Sat, 22 May 2021 17:56:30 +0900
In-Reply-To: <e2e3574b25099a627d03447f5ace64b0e56c2ad1.1621593333.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 21 May 2021 03:37:47 -0700")
Message-ID: <xmqqbl93qh8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A4B1C7A-BADB-11EB-B3C3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> If options pertaining to how the diff is displayed is provided to
> `git stash show`, the command will ignore the stash.showIncludeUntracked
> configuration variable, defaulting to not showing any untracked files.
> This is unintuitive behaviour since the format of the diff output and
> whether or not to display untracked files are orthogonal.
>
> Use stash.showIncludeUntracked even when diff options are given. Of
> course, this is still overridable via the command-line options.
>
> Update the documentation to explicitly say which configuration variables
> will be overridden when a diff options are given.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> This patch is a follow-up to [0]. This patch is based on top of
> 'dl/stash-show-untracked-fixup'.

It does make sense to keep "what to show" and "how to show them"
orthogonal.  It seems that not enough thoguht went into the topic
before it got merged to 'next', which is quite sad.

> diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
> index 413f907cba..9ed775281f 100644
> --- a/Documentation/config/stash.txt
> +++ b/Documentation/config/stash.txt
> @@ -6,9 +6,9 @@ stash.useBuiltin::
>  	remaining users that setting this now does nothing.
>  
>  stash.showIncludeUntracked::
> -	If this is set to true, the `git stash show` command without an
> -	option will show the untracked files of a stash entry.  Defaults to
> -	false. See description of 'show' command in linkgit:git-stash[1].
> +	If this is set to true, the `git stash show` command will show
> +	the untracked files of a stash entry.  Defaults to false. See
> +	description of 'show' command in linkgit:git-stash[1].

OK.

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index a8c8c32f1e..be6084ccef 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -91,8 +91,10 @@ show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
>  	By default, the command shows the diffstat, but it will accept any
>  	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
>  	to view the second most recent entry in patch form).
> +	If no `<diff-option>` is provided, the default behavior will be given
> +	by the `stash.showStat`, and `stash.showPatch` config variables. You
> +	can also use `stash.showIncludeUntracked` to set whether
> +	`--include-untracked` is enabled by default.

OK.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 82e4829d44..864b6c1416 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -831,7 +831,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>  		UNTRACKED_NONE,
>  		UNTRACKED_INCLUDE,
>  		UNTRACKED_ONLY
> -	} show_untracked = UNTRACKED_NONE;
> +	} show_untracked = show_include_untracked ? UNTRACKED_INCLUDE : UNTRACKED_NONE;

OK.  We initialize this to what the config said...

>  	struct option options[] = {
>  		OPT_SET_INT('u', "include-untracked", &show_untracked,
>  			    N_("include untracked files in the stash"),
> @@ -874,9 +874,6 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>  		if (show_patch)
>  			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
>  
> -		if (show_include_untracked)
> -			show_untracked = UNTRACKED_INCLUDE;
> -

... without limiting the defaulting only to the case where
revision_args.nr==1 (no options are given).

>  		if (!show_stat && !show_patch) {
>  			free_stash_info(&info);
>  			return 0;

As this is a fix to a part of a new feature that was broken from day
one, let's take it and fast-track.

Thanks.

> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index 1c9765928d..f7fafcd447 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -333,6 +333,8 @@ test_expect_success 'stash show --include-untracked shows untracked files' '
>  	git stash show -p --include-untracked >actual &&
>  	test_cmp expect actual &&
>  	git stash show --include-untracked -p >actual &&
> +	test_cmp expect actual &&
> +	git -c stash.showIncludeUntracked=true stash show -p >actual &&
>  	test_cmp expect actual
>  '
