Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F1CC4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E44206DD
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 18:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WEp/8siJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgJDSDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 14:03:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62578 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgJDSDB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 14:03:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1B99F3FFD;
        Sun,  4 Oct 2020 14:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BGKMfavwBteOyKeKs9OxrO9S/1w=; b=WEp/8s
        iJUCWEhk7S+5UzMDZhF1N4ASYvSej4Wg8b8NAdgyB3mk3xVe+lGqUI0G7f9N+VC0
        aJpOI3l9tSiphav+DOMc4vGE1gI/NgVmQkexAyGUIEDinwMccbRAmyulrU7hiolw
        PSrIRITxTCOg1oEvZlbG08p013xZSYtXLo2xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VQJFNdgeG0TsqyiFKdgaDDJZu/QJOrO9
        ZR4J1QBkjiqbB5S6eja6h06hvwfeYlh4xpoyfDopGeRoCMk+j0K0MaFQ5STZM4Ft
        cJ20YxlvLba0xgsYkYwclPhZtKyLzkKlyR2Y3ffvH7glTvtzrUMkoLV7g/atYY/p
        O9Pi31fJwV0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B23EF3FFC;
        Sun,  4 Oct 2020 14:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E80CEF3FFB;
        Sun,  4 Oct 2020 14:02:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] builtin/checkout: fix `git checkout -p HEAD...` bug
References: <cover.1601814601.git.liu.denton@gmail.com>
        <54f221411f4ec60a88521c376a1c77fa0a3e7553.1601814601.git.liu.denton@gmail.com>
Date:   Sun, 04 Oct 2020 11:02:52 -0700
In-Reply-To: <54f221411f4ec60a88521c376a1c77fa0a3e7553.1601814601.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sun, 4 Oct 2020 05:30:33 -0700")
Message-ID: <xmqqsgat7ttf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3346854-066B-11EB-9899-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Fix this by using the hex of the found commit instead of the given name.
> Note that "HEAD" is handled specially in run_add_interactive() so it's
> explicitly not changed.
> ...
> +		const char *rev = new_branch_info->name;
> +		char rev_oid[GIT_MAX_HEXSZ + 1];
> +
> +		/*
> +		 * Since rev can be in the form of `<a>...<b>`, we must replace
> +		 * the name with the hex of the commit for the
> +		 * run_add_interactive() machinery to work properly. However,
> +		 * there is special logic for the HEAD case so we mustn't
> +		 * replace that.
> +		 */
> +		if (rev && strcmp(rev, "HEAD"))
> +			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);

What the comment explains and the if condition special cases are
different.  Surely, HEAD is treated differently, but the natural
implementation of what the comment wants to achieve would be to not
just make sure it is not HEAD, but to make sure that it is of <a>...<b>
form, e.g.

		if (rev && strstr(rev, "..."))

Having said that, I do like how your version looks like in two ways,
i.e. it makes it clear HEAD is special, and it does not limit the
special case to only the three-dot "merge-base" magic, which might
be more futureproof.  On the other hand, your version would give the
hexadecimal commit object name even when a plain-vanilla branch name
is given and the above comment does not say if and why it is a safe
thing to do.  We used to give "new_branch_info->name" to the helper
that invokes "add -p".  Now we always give a hexadecimal or "HEAD".

Come to think of it, perhaps "add -p" that special cases HEAD is a
mistake.  If a plain vanilla branch name can be safely replaced by
the hexadecimal commit object name, perhaps the code should be
prepared to special case not just string "HEAD" but any other way to
express the commit object referred to with "HEAD" the same way.  But
that is not a suggestion for this patch---it may be a good idea to
add NEEDSWORK: comment here to encourage our future selves to see if
"add -p" needs to be fixed.

>  		if (opts->checkout_index && opts->checkout_worktree)
>  			patch_mode = "--patch=checkout";
> @@ -481,7 +493,7 @@ static int checkout_paths(const struct checkout_opts *opts,
>  		else
>  			BUG("either flag must have been set, worktree=%d, index=%d",
>  			    opts->checkout_worktree, opts->checkout_index);
> -		return run_add_interactive(new_branch_info->name, patch_mode, &opts->pathspec);
> +		return run_add_interactive(rev, patch_mode, &opts->pathspec);
>  	}
>  
>  	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> index 47aeb0b167..999620e507 100755
> --- a/t/t2016-checkout-patch.sh
> +++ b/t/t2016-checkout-patch.sh
> @@ -59,6 +59,13 @@ test_expect_success PERL 'git checkout -p HEAD with change already staged' '
>  	verify_state dir/foo head head
>  '
>  
> +test_expect_success PERL 'git checkout -p HEAD^...' '
> +	# the third n is to get out in case it mistakenly does not apply
> +	test_write_lines n y n | git checkout -p HEAD^... &&
> +	verify_saved_state bar &&
> +	verify_state dir/foo parent parent
> +'
> +
>  test_expect_success PERL 'git checkout -p HEAD^' '
>  	# the third n is to get out in case it mistakenly does not apply
>  	test_write_lines n y n | git checkout -p HEAD^ &&
> diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
> index 98b2476e7c..b5c5c0ff7e 100755
> --- a/t/t2071-restore-patch.sh
> +++ b/t/t2071-restore-patch.sh
> @@ -60,6 +60,14 @@ test_expect_success PERL 'git restore -p --source=HEAD^' '
>  	verify_state dir/foo parent index
>  '
>  
> +test_expect_success PERL 'git restore -p --source=HEAD^...' '
> +	set_state dir/foo work index &&
> +	# the third n is to get out in case it mistakenly does not apply
> +	test_write_lines n y n | git restore -p --source=HEAD^... &&
> +	verify_saved_state bar &&
> +	verify_state dir/foo parent index
> +'
> +
>  test_expect_success PERL 'git restore -p handles deletion' '
>  	set_state dir/foo work index &&
>  	rm dir/foo &&

You are just mimicking what is already there, but I thought "add -p"
can use built-in replacement when GIT_TEST_ADD_I_USE_BUILTIN is
given these days.  Perhaps we need to replace these PERL
prerequisite with a new one, say ADD_I, which requires PERL if and
only if GIT_TEST_ADD_I_USE_BUILTIN is not set, or something.  Again,
that is not in the scope of this patch, but leaving NEEDSWORK:
comment in these test scripts where they first use PERL prerequisite
but they would use ADD_I prerequisite if available.

