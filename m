Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FEBC433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4252664E11
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhAaU2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:28:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51543 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhAaU0d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:26:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 134B01185D8;
        Sun, 31 Jan 2021 15:25:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C6q8bCj9Hw7ySTsXQQvNGLyVeaM=; b=xxw5u1
        owC61eLFQBnAHLchLvMtlxHL+ymnlYSnEdLacJdF1R27zCj4lOhq2yEqFyIztENP
        aSvYiBxfz3LTk74X6kaA3VXl5v/K6B2rvTN0w6cJgklQldHn9R7rSSKf5knpkrNV
        7+pVC/vWehsiDEiIaTKsMZCzteBci1RmND4r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UF0KA74DvKnqfjZTLwKasVYrpJB+h8qg
        s7ui1QNZdTwgAySltEZneJbOHwGMBwFoIPkVZErm/RUtKe6xofmgW5uaLxi5fE2g
        Eftljzrswi7fWqX1D6GQVuRyXVI/3B6eshnVonkQqpSjVtXh3c0J3aNCYfM8Xza1
        sQnZ4xefOjY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B3201185D7;
        Sun, 31 Jan 2021 15:25:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4F00A1185D6;
        Sun, 31 Jan 2021 15:25:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
        <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
        <e5863616-ff74-88f2-3d6a-c8dbe03477fe@gmail.com>
Date:   Sun, 31 Jan 2021 12:25:42 -0800
In-Reply-To: <e5863616-ff74-88f2-3d6a-c8dbe03477fe@gmail.com> (Derrick
        Stolee's message of "Sat, 30 Jan 2021 22:59:08 -0500")
Message-ID: <xmqqft2gonuh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EB5076C-6402-11EB-8F4F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> So, the inner loop makes sure we won't revisit STALE parent, but
>> keep digging parents we haven't seen, and stop when the generation
>> is old enough.  What happens when there is no generation number
>> computed yet, I wonder...  We'll keep getting infinity and dig all
>> the way down to root?
>
> If we are on commits that have no generation number yet, then we
> will walk until reaching commits in the commit-graph file that have
> a computed generation (or in the heuristic case, when we have reached
> all but one of the commits).
>
> In the case of the commit-graph, all commits will have generation
> number "infinity". In such a case, perhaps the old algorithm _is_
> the best we can do, at least for now.

Hmph, I am afraid that such is life X-<.

> One way to ensure we do not regress from the current behavior
> would be to condition the new algorithm with
>
> 	if (generation_numbers_enabled(the_repository))
> 		new_algorithm();
> 	else
> 		old_algorithm();
>
> much like in repo_is_descendant_of().
>
> Is that a good plan?

It would certainly avoid one particular form of regression, so it is
better than nothing.

But at the same time, we'd probably want to encourage people to
enable and maintain generation numbers for the majority of commits
in their repository, but unless you "gc" twice a day or something,
you'd inevitably have a mixture, say, all commits that are more than
two weeks old are covered by commit-graph, but more recent ones are
not yet enumerated, and you have to traverse at runtime.

And the performance characteristics we would care the most in the
longer term is to make sure that we perform well in such a mixed
environment for the parts of the history that are not old enough.

Many things can be sped up by precomputing and storing the result in
the commit-graph file and that is not all that interesting or
surprising part of the story, I would think.  Rather, we want to
ensure that we do not perform on the youngest part of the history
any worse---that way, people will have strong incentive to enable
commit-graph, as things will work superbly for older parts of the
history, while not doing any worse than the original system for the
newest parts of the history.

There was a side thread where somebody wished if they can remove
support for all the codepaths that do not use commit-graph, but
would this be an example of how such a wish is impractical, I have
to wonder?

Thanks.
