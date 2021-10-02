Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB370C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 04:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD0F61AAA
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 04:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhJBE7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 00:59:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58694 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhJBE7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 00:59:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D32DD626D;
        Sat,  2 Oct 2021 00:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z6LBSsfO2Vc1mYXgI+B2dG3l+vDXrybSkZfr9B
        JYz3o=; b=qYF4C2sYJbgtSGPDXpGhdf1GtDNisnBxWgrbKT4Sjlzoy5FiTQPq6u
        /7OjLob4nAOjAQE0hEUuVHYMP2EA0ApxPpYIR2CsM49+z8DrwtMWVx3L8mdor82S
        4KICqGRqDLaipIqrk9ippXc1AfSrsmkIznq2jNh3zDSbhKk0YxRqo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64234D626C;
        Sat,  2 Oct 2021 00:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44847D626A;
        Sat,  2 Oct 2021 00:58:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 00/11] rebase: reset_head() related fixes and improvements
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <xmqqbl482rby.fsf@gitster.g>
Date:   Fri, 01 Oct 2021 21:58:03 -0700
In-Reply-To: <xmqqbl482rby.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        01 Oct 2021 17:38:57 -0700")
Message-ID: <xmqq4ka02fc4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54464FE0-233D-11EC-9E82-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> When merged with other topics in flight in 'seen', this seems to
> fail the t1092 test (most likely, ds/add-rm-with-sparse-index is
> what this interacts badly with).

There are Two CI runs at GitHub:

 - https://github.com/git/git/actions/runs/1297117791 (d3a1c4e)
 - https://github.com/git/git/actions/runs/1297232973 (a1108c2)

The difference between the former (which passes all the tests) and
he latter (which fails) are only two topics:

    $ git log --first-parent --oneline d3a1c4e..a1108c2
    a1108c2b1b Merge branch 'hn/reftable' into seen
    e575f29006 Merge branch 'pw/fix-some-issues-in-reset-head' into seen

I think the following is the same failure I saw earlier

   https://github.com/git/git/runs/3773780195?check_suite_focus=true#step:6:5033

that the write-tree codepath hits assertion failure by detecting a
corruption in the cache-tree data structure.

e575f29006 (i.e. without the reftable topic) fails t1092.  If you
revert e575f29006^2 (i.e. the "do not fork 'git checkout'") from
that merge, all tests pass including t1092.

The reftable topic is queued near the tip of 'seen' not necessarily
because it _breaks_ CI (I do not think it does), but it needed a
handful of fixup commits on top.  The topic needs rerolling with the
fixes squashed in.

Thanks.

