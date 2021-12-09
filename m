Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AC4C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhLITM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:12:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59899 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhLITM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:12:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22ADCF4091;
        Thu,  9 Dec 2021 14:09:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2ul9STnFfCHBUh05U6yZkp05ZGQAdEu3pijy6y
        vZPgA=; b=wCqEaKkzlvdE0i7ScxXzNmAhtri6fP/NHnkDGRKlLMWCQ3rCrt6v+V
        rmzya0dKld0t8m7AbnsGs/l+eWXwt+8cnEZ3LMo3sLrNXkXF3/te4D6Wgm+6QsVh
        oZ6ejATMPFKfRYLhtLqW/Gpa+pk9fpCiJvrSGyfg7+zj0Ej5RnXPk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A1A2F408F;
        Thu,  9 Dec 2021 14:09:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 708AEF408E;
        Thu,  9 Dec 2021 14:09:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 04/14] rebase: do not remove untracked files on checkout
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <2b499704c8f132f173c7328d5f020330481b24dc.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 11:09:20 -0800
In-Reply-To: <2b499704c8f132f173c7328d5f020330481b24dc.1638975482.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 08 Dec 2021 14:57:51
        +0000")
Message-ID: <xmqqwnkdr3xb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83FEDA2E-5923-11EC-A3C1-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If "git rebase [--apply|--merge] <upstream> <branch>" detects that
> <upstream> is an ancestor of <branch> then it will fast-forward and
> checkout <branch>. Normally a checkout or picking a commit during a
> rebase will refuse to overwrite untracked files, however rebase does
> overwrite untracked files when checking <branch>.

"when checking <branch> out", you mean?

> The fix is to only set reset in `unpack_tree_opts` if flags contains
> `RESET_HEAD_HARD`. t5403 may seem like an odd home for the new test
> but it will be extended in the next commit to check that the
> post-checkout hook is not run when the checkout fails.
>
> The test for `!deatch_head` dates back to the

"detach_head"?

> original implementation of reset_head() in
> ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
> 2018-08-07) and was correct until e65123a71d
> ("builtin rebase: support `git rebase <upstream> <switch-to>`",
> 2018-09-04) started using reset_head() to checkout <switch-to> when
> fast-forwarding.

In other words, before e64123a71d, there was only one caller of
reset_head(), and the caller always gave detach_head==1, so we never
had .reset member set to true.  So what this patch fixes was a piece
of dead code that did a wrong thing but hurted nobody only because
nobody called it back then.  e64123a71d started to exercise the code
and immediately got affected by it.

OK, and this fixes it.  Good.

> Note that 480d3d6bf9 ("Change unpack_trees' 'reset' flag into an
> enum", 2021-09-27) also fixes this bug as it changes reset_head() to
> never remove untracked files. I think this fix is still worthwhile as
> it makes it clear that the same settings are used for detached and
> non-detached checkouts.

If detached-ness has nothing to do with PROTECT_UNTRACKED but the
true logic is tied to "are we doing a hard reset?" (e.g. "we are
doing a hard reset so we need not to care about untracked files, we
are allowed to nuke them"), this change makes quite a lot of sense.

> diff --git a/reset.c b/reset.c
> index 315fef91d33..3e7b9e2e131 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -59,7 +59,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>  	unpack_tree_opts.merge = 1;
>  	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
>  	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
> -	if (!detach_head)
> +	if (reset_hard)
>  		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;

The polarity of the check goes against my intuition, though.  If we
are resetting hard, shouldn't we be allowed to nuke untracked paths?
Perhaps it is just the naming of variables that confuses me.  I dunno.

>  	if (repo_read_index_unmerged(r) < 0) {
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index 17ab518f268..fd2817b4068 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -85,6 +85,16 @@ test_rebase () {
>  		test_cmp_rev three $new &&
>  		test $flag = 1
>  	'
> +
> +	test_expect_success "rebase $args checkout does not remove untracked files" '
> +		test_when_finished "test_might_fail git rebase --abort" &&
> +		git update-ref refs/heads/rebase-fast-forward three &&
> +		git checkout two &&
> +		echo untracked >three.t &&
> +		test_when_finished "rm three.t" &&
> +		test_must_fail git rebase $args HEAD rebase-fast-forward 2>err &&
> +		grep "untracked working tree files would be overwritten by checkout" err
> +'
>  }
>  
>  test_rebase --apply &&
