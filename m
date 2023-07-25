Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7F2C001DE
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGYVlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjGYVlr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:41:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56111FEB
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:41:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A0B71909DC;
        Tue, 25 Jul 2023 17:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0BqWhT1/ZWArMY210gO9dn1ZqbeCNxri5o2p4O
        Mf0YM=; b=nuBxQczDKtreKg5Y17XxDF1tJ42O24Y1vILI4+cEG8mjZLqpi7IzX5
        APmyjb/DBoYkQsDyim8CsPlrAz8A6QoVPFFb0EVL+4tKnAcF6J1o78ZP/5gvMEvV
        O1TTdVVXlNutMNL4Ip8Jl323Max4X6uVWOcM9esSiLg5EgYx7r9Mo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41A1A1909DB;
        Tue, 25 Jul 2023 17:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A87871909DA;
        Tue, 25 Jul 2023 17:41:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 13/15] replay: add --advance or 'cherry-pick' mode
References: <20230509175347.1714141-1-christian.couder@gmail.com>
        <20230602102533.876905-1-christian.couder@gmail.com>
        <20230602102533.876905-14-christian.couder@gmail.com>
Date:   Tue, 25 Jul 2023 14:41:39 -0700
In-Reply-To: <20230602102533.876905-14-christian.couder@gmail.com> (Christian
        Couder's message of "Fri, 2 Jun 2023 12:25:31 +0200")
Message-ID: <xmqq8rb3is8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A5ABB86-2B34-11EE-BC58-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> There is already a 'rebase' mode with `--onto`. Let's add an 'advance' or
> 'cherry-pick' mode with `--advance`. This new mode will make the target
> branch advance as we replay commits onto it.

If I say

	$ git replay --(advance|onto) xyzzy frotz..nitfol yomin

where the topology of the cherry-picked range look like this

                      x---x---Y yomin
                     /
            E---F---x----x----N nitfol
           /  frotz
          /
         X xyzzy     

after transplanting the commits, we would get something like

                      x---x---Y yomin
                     /
            E---F---x----x----N nitfol
           /  frotz
          /
         X---x----x----N'
              \
               x---x---Y'

Now, if this was done with --onto, nitfol and yomin would point at
N' and Y', but with --advance, where would xyzzy go?

Yes, my point is that without --advance, there always is a
reasonable set of branch tips that will be moved, but with
"--advance", you cannot guarantee that you have any reasonable
answer to that question.

The answer could be "when there is no single 'tip of the new
history', the command with '--advance' errors out", but whatever
behaviour we choose, it should be documented.

> @@ -29,9 +29,17 @@ OPTIONS
>  	Starting point at which to create the new commits.  May be any
>  	valid commit, and not just an existing branch name.
>  +
> -The update-ref commands in the output will update the branch(es)
> -in the revision range to point at the new commits (in other
> -words, this mimics a rebase operation).
> +When `--onto` is specified, the update-ref command(s) in the output will
> +update the branch(es) in the revision range to point at the new
> +commits (in other words, this mimics a rebase operation).
> +
> +--advance <branch>::
> +	Starting point at which to create the new commits; must be a
> +	branch name.
> ++
> +When `--advance` is specified, the update-ref command(s) in the output
> +will update the branch passed as an argument to `--advance` to point at
> +the new commits (in other words, this mimics a cherry-pick operation).

This part is not giving much useful information to determine the
answer (which might be fine, as long as the answer can easily be
found in some other parts of this document, but I would have
expected everything necessary would be found here or one item before
this one about --onto).

> @@ -47,7 +55,10 @@ input to `git update-ref --stdin`.  It is basically of the form:
>  	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
>  	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
>  
> -where the number of refs updated depend on the arguments passed.
> +where the number of refs updated depend on the arguments passed.  When
> +using `--advance`, the number of refs updated is always one, but for
> +`--onto`, it can be one or more (rebasing multiple branches
> +simultaneously is supported).

"dependS on the arguments passed" is not incorrect per-se, in the
sense that if you "replay --onto X E..N" (in the above picture), I
think you'll move F and N (two), while "F..N" will only move N
(one).  But the important thing to convey is how many branches had
their tips in the replayed range, no?  "depends on the shape of the
history being replayed" would be a more correct thing to say for the
"--onto" mode.  For "--advance", presumably you would require to
have a single positive endpoint [*], so "depends on the arguments"
is still not wrong per-se, because "when --advance is part of the
arguments, the number becomes one".

	Side note: even then, I suspect that

		git replay --advance X E..F N

        should be allowed, simply because there is only one sensible
        interpretation.  You'll end up with a single strand of
        pearls F--x--x--N transplanted on top of X, and the range
        happens to contain F and N but it is obvious the end result
        should advance xyzzy to N because F fast-forwards to N.

I'd say "where the number of ..." and everything after these sample
"update" lines should be removed, and instead we should add a few
words to the main description of the options, e.g.  for "--onto"

> +When `--onto` is specified, the update-ref command(s) in the output will
> +update the branch(es) in the revision range to point at the new
> +commits (in other words, this mimics a rebase operation).

we could update the above to something like

    ... will update the branches in the revision range to point at the
    new commits, similar to the way how "rebase --update-refs" updates
    multiple branches in the affected range.

