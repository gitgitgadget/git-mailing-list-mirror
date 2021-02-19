Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F6C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 00:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE42964EE7
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 00:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBSAff (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 19:35:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51324 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSAfe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 19:35:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32C5D9BA2C;
        Thu, 18 Feb 2021 19:34:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KkJExLMF31tq+t42MY9qf+FRyng=; b=LyhnwB
        Aqto8TvjD3tQHicVIXOViwjcevdwf83+2nMwXha9/9ROA9fTs53Yuf1dfmNdhRkJ
        3fcVmhiRjY0+tWUlEjzDVUo5/XdGQunKl8+xzi1eWXwk6NrPXhg+ZRKk1tsAQumE
        w1NCUfTus/Kno2V4C1EV48esR5hhhCddD7X1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XPjSwrdurBbjAJM94WxjscqI/W6t6ve9
        7L+nfVyDDlXopK2AdRoibrsZtmeXcG0ba8GOokoQ28C5QgAl9LXsAE9GYH1cf/3Q
        Fkl4NpCWAjM4TiynRLFiEgwvZps7FpOx5WejBI5q6wHwcxWsOcaIKB5pWamjUwWo
        7V/imyDCXDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 292829BA28;
        Thu, 18 Feb 2021 19:34:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB9629BA25;
        Thu, 18 Feb 2021 19:34:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [RFC PATCH 6/7] add: warn when pathspec only matches
 SKIP_WORKTREE entries
References: <cover.1613593946.git.matheus.bernardino@usp.br>
        <8f1bc014ae8a34c0bc43d1a2b8c0ebdbe7e47e02.1613593946.git.matheus.bernardino@usp.br>
Date:   Thu, 18 Feb 2021 16:34:46 -0800
In-Reply-To: <8f1bc014ae8a34c0bc43d1a2b8c0ebdbe7e47e02.1613593946.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 17 Feb 2021 18:02:29 -0300")
Message-ID: <xmqqo8ggc2u1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45170630-724A-11EB-9680-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> `git add` already refrains from updating SKIP_WORKTREE entries, but it
> silently succeeds when a pathspec only matches these entries. Instead,
> let's warn the user and display a hint on how to update these entries.

"Silently succeeds" reads as if it succeeds to update, but that is
not what you meant.

I guess the warning is justified and is desirable because an attempt
to add an ignored path would result in a similar hint, e.g.

    $ echo '*~' >.gitignore
    $ git add x~
    hint: use -f if you really want to...
    $ git add .

It is curious why the latter does not warn (even when there is
nothing yet to be added that is not ignored), but that is what we
have now.  If we are modeling the new behaviour for sparse entries
after the ignored files, we should do the same, I think.

> A warning message was chosen over erroring out right away to reproduce
> the same behavior `add` already exhibits with ignored files. This also
> allow users to continue their workflow without having to invoke `add`
> again with only the matching pathspecs, as the matched files will have
> already been added.

Makes sense.

> Note: refresh_index() was changed to only mark matches with
> no-SKIP-WORKTREE entries in the `seen` output parameter. This is exactly
> the behavior we want for `add`, and only `add` calls this function with
> a non-NULL `seen` pointer. So the change brings no side effect on
> other callers.

And possible new callers that wants to learn from seen[] output
would want the same semantics, presumably?

> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index f7b0ea782e..f66d369bf4 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -32,10 +32,22 @@ test_sparse_entry_unchanged() {
>  	test_cmp expected actual
>  }
>  
> +cat >sparse_entry_error <<-EOF
> +The following pathspecs only matched index entries outside the current
> +sparse checkout:
> +sparse_entry
> +EOF
> +
> +cat >error_and_hint sparse_entry_error - <<-EOF
> +hint: Disable or modify the sparsity rules if you intend to update such entries.
> +hint: Disable this message with "git config advice.updateSparsePath false"
> +EOF
> +
>  test_expect_success "git add does not remove SKIP_WORKTREE entries" '
>  	setup_sparse_entry &&
>  	rm sparse_entry &&
> -	git add sparse_entry &&
> +	test_must_fail git add sparse_entry 2>stderr &&
> +	test_i18ncmp error_and_hint stderr &&

OK, this demonstrates what exactly you meant by "silently succeed".
We are not expecting side effects that are any different from before
(i.e. sparse_entry is not removed from the index), but the command
is taught to error out and hint, which makes sense.

>  	test_sparse_entry_unchanged
>  '
>  
> @@ -56,7 +68,8 @@ do
>  	test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
>  		setup_sparse_entry &&
>  		echo modified >sparse_entry &&
> -		git add $opt sparse_entry &&
> +		test_must_fail git add $opt sparse_entry 2>stderr &&
> +		test_i18ncmp error_and_hint stderr &&
>  		test_sparse_entry_unchanged
>  	'
>  done
> @@ -64,7 +77,8 @@ done
>  test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
>  	setup_sparse_entry &&
>  	test-tool chmtime -60 sparse_entry &&
> -	git add --refresh sparse_entry &&
> +	test_must_fail git add --refresh sparse_entry 2>stderr &&
> +	test_i18ncmp error_and_hint stderr &&
>  
>  	# We must unset the SKIP_WORKTREE bit, otherwise
>  	# git diff-files would skip examining the file
> @@ -77,7 +91,8 @@ test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
>  
>  test_expect_success 'git add --chmod does not update SKIP_WORKTREE entries' '
>  	setup_sparse_entry &&
> -	git add --chmod=+x sparse_entry &&
> +	test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
> +	test_i18ncmp error_and_hint stderr &&
>  	test_sparse_entry_unchanged
>  '
>  
> @@ -85,8 +100,23 @@ test_expect_success 'git add --renormalize does not update SKIP_WORKTREE entries
>  	test_config core.autocrlf false &&
>  	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
>  	echo "sparse_entry text=auto" >.gitattributes &&
> -	git add --renormalize sparse_entry &&
> +	test_must_fail git add --renormalize sparse_entry 2>stderr &&
> +	test_i18ncmp error_and_hint stderr &&
>  	test_sparse_entry_unchanged
>  '
>  
> +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
> +	setup_sparse_entry &&
> +	test_must_fail git add nonexistent sp 2>stderr &&
> +	test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
> +	test_i18ngrep ! "The following pathspecs only matched index entries" stderr

This is because both of the two pathspec elements given do not match
the sparse entries?  It is curious how the command behaves when
given a pathspec that is broader, e.g. "." (aka "everything under
the sun").  We could do "add --dry-run" for the test if we do not
want to set up .gitignore appropriately and do not want to smudge
the index with stderr, expect, actual etc.

> +'
> +
> +test_expect_success 'add obeys advice.updateSparsePath' '
> +	setup_sparse_entry &&
> +	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
> +	test_i18ncmp sparse_entry_error stderr
> +
> +'

OK.

Thanks.
