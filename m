Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6863AC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 21:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhLIVH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:07:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65063 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhLIVHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 16:07:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39C1FFBE88;
        Thu,  9 Dec 2021 16:04:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=TahRbrxNzTZEWYbOnZu5yEy1i5YOQB0X97+Skl5UP2U=; b=LDfc
        bZbVR4gRr6VYTnTMBMv8Qe4TvNjefdIoJ1yAiutfZ9qTvitScA/Nx+Q7YiXHQQ08
        N/T6sirQwdi90m4ZDoBo1jAdpLVGEMpbkaoCT7WP6GvqtyqvT9CHtaRKnA8pvGiu
        AFEwVyKRme8xvCRqPKDOaPpigXurByHwtk2ZGjE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30E8EFBE87;
        Thu,  9 Dec 2021 16:04:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9109EFBE86;
        Thu,  9 Dec 2021 16:04:18 -0500 (EST)
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
Subject: Re: [PATCH v2 00/14] rebase: reset_head() related fixes and
 improvements
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 13:04:17 -0800
Message-ID: <xmqqtufhpk1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93010EBA-5933-11EC-A735-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Thanks for the comments on V1. I have tried to improve the commit messages
> to explain better the motivation and implications of the changes in this
> series and I have added some more tests. I have rebased onto v2.34.0 to
> avoid some merges conflicts.

Thanks.

It still is not clear in the cover letter what the overall theme of
the topic is, and the original cover letter was deliberately vague
by saying "Fix *some* issues".  Random assortment of changes to
various code paths, the only common trait among them being they are
somehow related to reset_head()?

> Cover letter for V1: Fix some issues with the implementation and use of
> reset_head(). The last patch was previously posted as [1], I have updated
> the commit message and rebased it onto the fixes in this series. There are a
> couple of small conflicts merging this into seen, I think they should be
> easy to resolve (in rebase.c take both sides in reset.c take the changed
> lines from each side). These patches are based on pw/rebase-of-a-tag-fix

I've read the patches through.  It does revolve around the use of
reset_head().  I would have appreciated if the cover letter said
something along this line:

    reset.c::reset_head() started its life at ac7f467f
    (builtin/rebase: support running "git rebase <upstream>",
    2018-08-07) as a way to detach the HEAD to replay the commits
    during "git rebase", but over time it learned to do many things,
    like switching the tip of the branch to another commit,
    recording the old value of HEAD in ORIG_HEAD while it does so,
    recording reflog entries for both HEAD and for the branch.

    The API into the function got clunky and it is harder than
    necessary for the callers to use the function correctly, which
    led to a handful of bugs that this series is going to fix.

       ... list of bugs here ...

    Later steps of this series revamps the API so that it is harder
    to use it incorrectly to prevent future bugs.

Anyway, I think the series is more or less in a very good shape,
even though a few comments I threw at this round may result in a
further improvement.

Thanks for working on this.
