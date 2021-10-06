Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDEC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B105610EA
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 17:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhJFRuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:50:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65485 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbhJFRus (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 13:50:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 611D415AB72;
        Wed,  6 Oct 2021 13:48:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uuBwBwSS3XGN/AWR7cdDmKULIAKXPjGwiTuXsG
        hNsT4=; b=JZlpBZ7W2CfrIXQGe42f1Cz09vJvDq9NnKEUZIs5v3xq8XJv8IhSmP
        eq3yycRu/WiDygOvE7I9HBZCQ+p77DO+4Q8W45OBZiVrhplUa5WXYmUq/LnLsCei
        57/hHklXJRBdKbyQ20nWq2NM6wVbRnxOGTDWmzTIXRSBrzyT4xP4I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5AA8615AB71;
        Wed,  6 Oct 2021 13:48:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B15D215AB70;
        Wed,  6 Oct 2021 13:48:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 4/7] reset: integrate with sparse index
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <49813c8d9ed94fd56f30eb204d346eb5a30473ca.1633440057.git.gitgitgadget@gmail.com>
        <CABPp-BHKjLVpL_U5viVA++hCZmGKBHxnubGCk=1YhTkpFc-E-Q@mail.gmail.com>
Date:   Wed, 06 Oct 2021 10:48:51 -0700
In-Reply-To: <CABPp-BHKjLVpL_U5viVA++hCZmGKBHxnubGCk=1YhTkpFc-E-Q@mail.gmail.com>
        (Elijah Newren's message of "Tue, 5 Oct 2021 19:15:55 -0700")
Message-ID: <xmqqo882rqm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB66BC5E-26CD-11EC-945A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Oct 5, 2021 at 6:21 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> `reset --soft` does not modify the index, so no compatibility changes are
>> needed for it to function without expanding the index. For all other reset
>> modes (`--mixed`, `--hard`, `--keep`, `--merge`), the full index is
>> explicitly expanded with `ensure_full_index` to maintain current behavior.
>
> "to maintain current behavior"?  You are changing code here, which
> suggests some kind of behavior is changing, but that description seems
> to be claiming the opposite.  Is it some kind of preventative change
> to add ensure_full_index calls in an additional place, with a later
> patch in the series intending to remove the other one(s), so you're
> making sure that later changes won't cause unwanted behavioral
> changes?  Or was something else meant here?
>
> If the above wasn't what you meant, but you're adding
> ensure_full_index calls, does that suggest that we had some important
> code paths that were not protected by such calls?

The original called read_cache() before we know which mode we
operate in, near the end of parse_args(), which resulted in an
unconditional call to ensure_full_index() in repo_read_index().

This patch delays the call to read_cache().  If parse_pathspec()
and everything the original called after the point where it called
read_cache() needed to have a populated in-core index, the change
can break things---I didn't check thoroughly, but I am guessing
it is OK.

>> Additionally, the `read_cache()` check verifying an uncorrupted index is
>> moved after argument parsing and preparing the repo settings. The index is
>> not used by the preceding argument handling, but `read_cache()` does need to
>> be run after enabling sparse index for the command and before resetting.
>
> This seems to be discussing what code changes are being made, but not
> why.  I'm guessing at the reasoning, but is it something along the
> lines of:
>
> """
> Also, make sure to read_cache() after setting
> command_requires_full_index = 0, so that we don't unnecessarily expand
> the index as part of our early index-corruption check.
> """

I think it is more like "we used to expand very early for all modes,
but with this change we move the read_cache() call to much later,
and force it not to expand.  The modes that call read_from_tree()
needs in-core index fully expanded, so we do so there, but the soft
reset does not call it and would stop expanding."

