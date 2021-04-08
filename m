Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1DBC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D676161130
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDHNdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:33:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56446 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhDHNdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:33:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0EEB12C863;
        Thu,  8 Apr 2021 09:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=B9V0I09ZEAs5iYDd6fCAUC01KOs=; b=Jjj6kKpgOe3YyKeGHh+6
        XeBSvZlKq8URvTqRoBJUKZpKLrPiV+/60axlVabRVTGEWVnvLpClEmqMu62VorAP
        Ywl05VAY6QdBj7i2TC1bxmZ2588bsoCKwKL2gV8AZvYy/kWkoFVSjS06QfBwNBYV
        vQMGw6lVQRLnk0y8nTKQjaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=JIufmbvcoD6uiOeLeHseQwwSqxFMkl4pv8Wa/tm9OKD4Go
        t9uX9Sn61tE4vjtHcl8ak6b1wG8ah5Qml7ZN2maeUaV2VqFi4++2TS/Ve/AbQBz4
        zXZI1Adn9jEtmGuQ4kg8wbe0ptUCwV92KaclzjvWpk1v2+qR9t5ntVEHoGk+U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B86F512C862;
        Thu,  8 Apr 2021 09:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0821312C861;
        Thu,  8 Apr 2021 09:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, newren@gmail.com, ross@skydio.com,
        abe@skydio.com, brian.kubisiak@skydio.com
Subject: Re: [PATCH v5] git-apply: allow simultaneous --cached and --3way
 options
References: <20210407180349.10173-1-jerry@skydio.com>
        <20210408021344.8053-1-jerry@skydio.com>
Date:   Thu, 08 Apr 2021 06:33:05 -0700
Message-ID: <xmqqh7kgvr3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3E32D7A-986E-11EB-9ABB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

>  Documentation/git-apply.txt |  6 +++--
>  apply.c                     |  9 ++++---
>  t/t4108-apply-threeway.sh   | 50 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 6 deletions(-)

Nicely done.  Will queue.

Elijah, how does this round look to you?

> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index 9144575299c264dd299b542b7b5948eef35f211c..aa1ae56a25e0428cabcfa2539900ef2a09abcb7c 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -87,8 +87,10 @@ OPTIONS
>  	Attempt 3-way merge if the patch records the identity of blobs it is supposed
>  	to apply to and we have those blobs available locally, possibly leaving the
>  	conflict markers in the files in the working tree for the user to
> -	resolve.  This option implies the `--index` option, and is incompatible
> -	with the `--reject` and the `--cached` options.
> +	resolve.  This option implies the `--index` option unless the
> +	`--cached` option is used, and is incompatible with the `--reject` option.
> +	When used with the `--cached` option, any conflicts are left at higher stages
> +	in the cache.
>  
>  --build-fake-ancestor=<file>::
>  	Newer 'git diff' output has embedded 'index information'
> diff --git a/apply.c b/apply.c
> index 9bd4efcbced842d2c5c030a0f2178ddb36114600..dadab80ec967357b031657d4e3d0ae52fac11411 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -133,8 +133,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
>  
>  	if (state->apply_with_reject && state->threeway)
>  		return error(_("--reject and --3way cannot be used together."));
> -	if (state->cached && state->threeway)
> -		return error(_("--cached and --3way cannot be used together."));
>  	if (state->threeway) {
>  		if (is_not_gitdir)
>  			return error(_("--3way outside a repository"));
> @@ -4644,8 +4642,11 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>  				fprintf(stderr, "U %s\n", item->string);
>  		}
>  		string_list_clear(&cpath, 0);
> -
> -		repo_rerere(state->repo, 0);
> +		/* Rerere relies on the partially merged result being in the working tree
> +		 * with conflict markers, but that isn't written with --cached.
> +		 */
> +		if (!state->cached)
> +			repo_rerere(state->repo, 0);
>  	}
>  
>  	return errs;
> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> index 9ff313f976422f9c12dc8032d14567b54cfe3765..65147efdea9a00e30d156e6f4d5d72a3987f230d 100755
> --- a/t/t4108-apply-threeway.sh
> +++ b/t/t4108-apply-threeway.sh
> @@ -180,4 +180,54 @@ test_expect_success 'apply -3 with ambiguous repeating file' '
>  	test_cmp expect one_two_repeat
>  '
>  
> +test_expect_success 'apply with --3way --cached clean apply' '
> +	# Merging side should be similar to applying this patch
> +	git diff ...side >P.diff &&
> +
> +	# The corresponding cleanly applied merge
> +	git reset --hard &&
> +	git checkout main~ &&
> +	git merge --no-commit side &&
> +	git ls-files -s >expect.ls &&
> +
> +	# should succeed
> +	git reset --hard &&
> +	git checkout main~ &&
> +	git apply --cached --3way P.diff &&
> +	git ls-files -s >actual.ls &&
> +	print_sanitized_conflicted_diff >actual.diff &&
> +
> +	# The cache should resemble the corresponding merge
> +	# (both files at stage #0)
> +	test_cmp expect.ls actual.ls &&
> +	# However the working directory should not change
> +	>expect.diff &&
> +	test_cmp expect.diff actual.diff
> +'
> +
> +test_expect_success 'apply with --3way --cached and conflicts' '
> +	# Merging side should be similar to applying this patch
> +	git diff ...side >P.diff &&
> +
> +	# The corresponding conflicted merge
> +	git reset --hard &&
> +	git checkout main^0 &&
> +	test_must_fail git merge --no-commit side &&
> +	git ls-files -s >expect.ls &&
> +
> +	# should fail to apply
> +	git reset --hard &&
> +	git checkout main^0 &&
> +	test_must_fail git apply --cached --3way P.diff &&
> +	git ls-files -s >actual.ls &&
> +	print_sanitized_conflicted_diff >actual.diff &&
> +
> +	# The cache should resemble the corresponding merge
> +	# (one file at stage #0, one file at stages #1 #2 #3)
> +	test_cmp expect.ls actual.ls &&
> +	# However the working directory should not change
> +	>expect.diff &&
> +	test_cmp expect.diff actual.diff
> +'
> +
>  test_done
