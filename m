Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094DBC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiBUS4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:56:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiBUS4J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:56:09 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA0D7C
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:55:45 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A97F5109CA1;
        Mon, 21 Feb 2022 13:55:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2cQ2RiSp1v60K9Y4gF4KXWPDyT/82uAtwcxkFL
        g1MzA=; b=IIPaflLWp2k4lv4c6ZBQb7pxbCFU/RYhFnIN5RU0p1LG9X7F7BoGyH
        LtFtyfAZ2ksXr0pmzKqZBm/P4CsQOgvm0+zcdgrtLm3w4bcN2dlS2/FUsxrMSCy5
        r6FLKWGJeNxHGOilpbdgiP0QBY/SAUYYhCUr9L9VQ3itCtz8kKskk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A106F109C9F;
        Mon, 21 Feb 2022 13:55:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0022E109C9D;
        Mon, 21 Feb 2022 13:55:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
        <xmqqy22tx8t1.fsf@gitster.g>
        <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
        <xmqqh79hvsgn.fsf@gitster.g>
        <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
Date:   Mon, 21 Feb 2022 10:55:40 -0800
In-Reply-To: <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Feb 2022 16:18:39 -0800")
Message-ID: <xmqqee3wt5g3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE1F6C18-9347-11EC-A1E6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Adding such an ability to merge-tree would be trivial -- it basically
> involves just two things: (1) accepting one extra argument, and (2)
> calling merge_incore_nonrecursive() instead of
> merge_incore_recursive().
>
> However, I think forking a subprocess for every merge of a series of
> commits is a completely unreasonable overhead, so even if we provide
> such an option to merge-tree, I still want a separate plumbing-ish
> tool that does non-worktree/non-index replaying of commits which is
> not written as a driver of merge-tree.  That other tool should just
> call merge_incore_nonrecursive() directly.  And such a tool, since it
> should handle an arbitrary number of commits, should certainly be able
> to handle just one commit.  From that angle, it feels like adding
> another mode to merge-tree would just be a partial duplication of the
> other tool.

The above does not make much sense to me.

I am hearing that "multi-step cherry-picks and reverts need to be
fast and we need something like sequencer that is all written in C,
and single-step cherry-pick is merely a special case that does not
deserve a plumbing".

But that argument leads to "and the same something-like-sequencer
that is all written in C would need '--rebase-merges' that can pick
multi-step merge sequences, and single-step merge does not deserve a
plumbing", which is an argument against this topic that is utterly
absurd.

So why isn't your objection not equally absurd against having a
single step cherry-pick or revert primitive as a plumbing?

