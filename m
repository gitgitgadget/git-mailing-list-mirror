Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA1C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 18:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiHUSFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 14:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiHUSF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 14:05:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B81D0E3
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 11:05:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03C8A14D504;
        Sun, 21 Aug 2022 14:05:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EH+NWlTQJ1hf5+D+IEHlV3isPDnDphBNN4H5Mc
        rJVIg=; b=qX5yU+3YjFSVF9kCMyRd5J4+FnEx3Yv6SpzOeKT6nqyp4nE/NeOBsm
        6rl5Sb3UJ5I7khh85T3TMJn4Y6TbRB63RyfCPeKD6pvTex3OZxNtLp2sLzywz2+S
        hm8YE+SXJZwWGLcguvAczD1x8fAooc5hSKbFRH40JXENt1iFGSjGE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFE6814D503;
        Sun, 21 Aug 2022 14:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F1F714D502;
        Sun, 21 Aug 2022 14:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge: avoid searching for strategies with fewer
 than 0 conflicts
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
        <5657a05e7635ecadbb8d2e41ad97fe19f3633fdd.1661056709.git.gitgitgadget@gmail.com>
Date:   Sun, 21 Aug 2022 11:05:24 -0700
In-Reply-To: <5657a05e7635ecadbb8d2e41ad97fe19f3633fdd.1661056709.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 21 Aug 2022
        04:38:29 +0000")
Message-ID: <xmqqwnb1fp5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4D95A70-217B-11ED-AF25-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> builtin/merge.c has a loop over the specified strategies, where if
> they all fail with conflicts, it picks the one with the least number
> of conflicts.
>
> In the codepath that finds a successful merge, if an automatic commit
> was wanted, the code breaks out of the above loop, which makes sense.
> However, if the user requested there be no automatic commit, the loop
> would continue looking for a "better" strategy.  Since it had just
> found a strategy with 0 conflicts though, and it is not possible to
> have fewer than 0 conflicts, the continuing search is guaranteed to be
> futile.

Let's imagine "git merge -s ours -s ort X", both of which resolve
the merge cleanly but differently.

The "best_cnt" thing tries to find the last strategy with the lowest
score from evaluate_result(), so strictly speaking I think this
changes the behaviour.  Am I mistaken?

When two strategies 'ours' and 'ort' resolved a given merge cleanly
(but differently), we would have taken the result from 'ort' in the
original code, but now we stop at seeing that 'ours' resolved the
merge cleanly and use its result.

>  			cnt = (use_strategies_nr > 1) ? evaluate_result() : 0;
>  			if (best_cnt <= 0 || cnt <= best_cnt) {

While I think "we see one clean merge, so it is OK to quit" is more
intuitive than the current behaviour, we need to update this
comparison to require the new candidate to have strictly better
result to take over the tentative best from the current candidate.
That will make things consistent with this change and makes it
easier to sell.

As the userbase of Git is so wide, it is very plausible that
somebody already invented and publisized that prepending "-s ours"
before the real strategy they want to use as an idiom to say "fall
back to pretend merge cleanly succeeded but did not affect the tree"
in a script that automate rebuilding tentative integration branch to
test, or something.  They can "fix" their "idiom" to append instead
of prepend "-s ours", and that would arguably make the resulting
command line more intuitive and easier to understand, but the fact
that whatever that was working for them to their liking suddenly
changes the behaviour is a regression we have to ask them to accept.

I do not mind writing something like this

    "git merge" with multiple strategies chooses to leave the least
    number of conflicted paths as the result.  Among multiple strategies
    that give the same number of conflicted paths, it used to use the
    last such strategy with the smallest number of conflicted paths.
    The command now prefers the first such strategy instead.

    If you have been using "git merge -s ours -s another X" as a way to
    say "we prefer 'another' strategy to merge, but use 'ours' strategy
    to make progress if it does not", you now have to swap the order of
    strategies you list on the command line.

in the "Backward Incompatibility Notes" section of the release
notes.

Thanks.
