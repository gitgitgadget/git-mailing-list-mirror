Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4171C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD60961177
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 12:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhJFMqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 08:46:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62290 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJFMqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 08:46:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B317EE75C6;
        Wed,  6 Oct 2021 08:44:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=JfIFXrdQdLlx81Rwttnkzg/CGM/YIGUcjtrF/penQEg=; b=TM54
        snk6w1aCElSaIVgjGKN7XlGb/OoWod0nhp/LP3LiG1NpcbbQNxV0bqLV5uurIeoa
        kfkNARxyfQDo6xm1lA8oR2eAh8rQxANtF81RdLFKd/bFteRsGzKfONbEIiwf2/qF
        FTHMiv3BeiXDOwf2V2xI9JdhrCJcWXTvIIxueoo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA6DEE75C5;
        Wed,  6 Oct 2021 08:44:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10140E75C4;
        Wed,  6 Oct 2021 08:44:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/7] reset: behave correctly with sparse-checkout
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
        <xmqqfstftgk6.fsf@gitster.g>
        <9b99e856-24cc-03fd-7871-de92dc6e39b6@github.com>
Date:   Wed, 06 Oct 2021 05:44:14 -0700
Message-ID: <xmqq4k9utja9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DAA0E0E-26A3-11EC-9ED6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Thanks for the thorough explanation, I'm on-board with your approach (and
> will re-roll the series with that implemented). A lot of my thought process
> (and confusion) came from a comment in e5ca291076 (t1092: document bad
> sparse-checkout behavior, 2021-07-14) suggesting that full and sparse
> checkouts should have the same result in scenarios like the one you
> outlined above.

Thanks for bringing this up.  I agree that it is crucial to clarify
what use case we are aiming for.  If the objective were to make a
sparse checkout behave just like full checkout, the desired
behaviour would be very different from a system whose objective is
to allow users to pretend as if the hidden parts of sparse checkout
do not even exist, which was the model my example was after.  I
agree with you that the "comment" in an earlier commit may have been
unhelpful in that they stopped at "should behave the same but they
shouldn't" without saying "why they should behave the same".

If the goal were to make sparse behave like full, continuing with
the previous example, after a

    $ git reset --mixed HEAD^

the user should be able to say

    $ git commit -a --amend

to replace the original two-commit history with a single commit
history that records the same resulting tree.  If the path "skip"
were to be reset to the blob from the first commit, just like the
path "no-skip" is, for such a "commit -a --amend" to work, we would
need to have a working tree file for "skip" magically materialized
with the contents from the *second* commit.  After all, the whole
point of mixed (and soft) reset is that they do not (logically)
change the files in the working tree, so if you are resetting from
the second commit to the first, if you were to have a working tree
file, it should come from the second commit, so that both "skip"
and "no-skip" should show "changed in the working tree relative to
the index", i.e.

    $ git reset --mixed HEAD^
    $ git ls-files -t
    M no-skip
    M skip

While such a "make sparse behave the same way as full" can be made
internally consistent, however, as the above example shows, it would
make the resulting "sparse checkout" practically unusable.

By stepping back a bit and realizing that the reason why the user
wanted to mark some path as "skip-worktree" was because the user had
no intention to make any change to them, we can make it usable again,
by not insisting that sparse should behave the same way as full.

When we redesign these patches, I would like to see what we failed
short the last time gets improved.  Instead of saying "skip-worktree
entries should stay so" and stopping there, we should leave a note
for later readers to explain why they should.

Thanks.


