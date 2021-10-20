Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D1C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA47D60F93
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhJTUr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:47:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:43070 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJTUr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 16:47:26 -0400
Received: (qmail 10562 invoked by uid 109); 20 Oct 2021 20:45:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Oct 2021 20:45:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29379 invoked by uid 111); 20 Oct 2021 20:45:10 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Oct 2021 16:45:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Oct 2021 16:45:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kenneth Arnold <ka37@calvin.edu>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH v2] pull: --ff-only should make it a noop when
 already-up-to-date
Message-ID: <YXB/1S2fid7MUmvu@coredump.intra.peff.net>
References: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
 <YW83JG9t2JaX92xV@coredump.intra.peff.net>
 <xmqqzgr3pso7.fsf@gitster.g>
 <xmqqh7dbplji.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7dbplji.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 12:02:09PM -0700, Junio C Hamano wrote:

> Earlier, we made sure that "git pull --ff-only" (and "git -c
> pull.ff=only pull") errors out when our current HEAD is not an
> ancestor of the tip of the history we are merging, but the condition
> to trigger the error was implemented incorrectly.
> 
> Imagine you forked from a remote branch, built your history on top
> of it, and then attempted to pull from them again.  If they have not
> made any update in the meantime, our current HEAD is obviously not
> their ancestor, and this new error triggers.
> 
> Without the --ff-only option, we just report that there is no need
> to pull; we did the same historically with --ff-only, too.

Thanks, this looks good to me overall, and I agree this is a regression
we should try to fix promptly (so thank you for jumping on it).

> Make sure we do not fail with the recently added check to restore
> the historycal behaviour.

Not sure if "historycal" is a typo or some clever pun. :)

> +/*
> + * Is orig_head is a descendant of _all_ merge_heads?

s/is a/a/

> +static int already_up_to_date(struct object_id *orig_head,
> +			      struct oid_array *merge_heads)
> +{
> +	int i;
> +	struct commit *ours;
> +
> +	ours = lookup_commit_reference(the_repository, orig_head);
> +	for (i = 0; i < merge_heads->nr; i++) {
> +		struct commit_list *list = NULL;
> +		struct commit *theirs;
> +		int ok;
> +
> +		theirs = lookup_commit_reference(the_repository, &merge_heads->oid[i]);
> +		commit_list_insert(theirs, &list);
> +		ok = repo_is_descendant_of(the_repository, ours, list);
> +		free_commit_list(list);
> +		if (!ok)
> +			return 0;
> +	}
> +	return 1;
> +}

You answered all of my "what about..." questions from before elsewhere
in the thread, so this looks correct.

> +test_expect_success 'already-up-to-date pull succeeds with "only" in pull.ff' '
> +	git reset --hard c1 &&
> +	test_config pull.ff only &&
> +	git pull . c0 &&
> +	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
> +'
> +
> +test_expect_success 'already-up-to-date pull/rebase succeeds with "only" in pull.ff' '
> +	git reset --hard c1 &&
> +	test_config pull.ff only &&
> +	git -c pull.rebase=true pull . c0 &&
> +	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
> +'

And these tests cover the cases I'd expect. The use of "test" with
process substitution looks a bit funny to me these days, but it does
match the surrounding code (and losing the exit codes isn't a big deal
here, as we are not testing rev-parse).

The combo of "test_config" and "git -c" is unusual, but I don't see
anything wrong with it.

-Peff
