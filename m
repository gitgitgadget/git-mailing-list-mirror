Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB923C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03A061A39
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 19:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCYTAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 15:00:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50591 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCYTAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 15:00:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6CE810D877;
        Thu, 25 Mar 2021 14:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pOrgndoe3Cqv3hMKXhoO4hdvVDY=; b=B1vr1i
        v3Fbznwj6XetuB7PTxB/OGlDuL4FC+EgHhrlh8HGaGEJv8o18cW41H1/vX6ZBJT9
        dbfYjfYqMDbmX6syi2hoOnAettS6pyZvOHEfEEvT202vLJ4GOIYM2WKKPqnFB28G
        A2byefdLAqzR5Ia2sDSYqBOY6V0lP1utPJBdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c1e7fPEj1YoReMHKFR/8w6CB6Bkn2j+0
        NKRtParSjZl1OjsD22QjC9oR9sIDZrqFzeN4OSKIHYIePh6a+GSHaFVFiAzeRexY
        F1+hX+TUhxOt6LIZOmPfcWLjiQteLNOMowkBUUsUOHz3sEqgXNTWxjTfSnSxEwLv
        qvV9aJiqgoQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BED3C10D876;
        Thu, 25 Mar 2021 14:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12D3410D870;
        Thu, 25 Mar 2021 14:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/7] Optimization batch 11: avoid repeatedly detecting
 same renames
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <xmqqv99gw6n3.fsf@gitster.g>
        <CABPp-BGMhyn1ricXzx539n-09+BYRHPeruNd4MG2PyQzWaRKow@mail.gmail.com>
Date:   Thu, 25 Mar 2021 11:59:55 -0700
In-Reply-To: <CABPp-BGMhyn1ricXzx539n-09+BYRHPeruNd4MG2PyQzWaRKow@mail.gmail.com>
        (Elijah Newren's message of "Wed, 24 Mar 2021 16:25:48 -0700")
Message-ID: <xmqqzgyrukic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A998124-8D9C-11EB-B289-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> And each step in this "rebase" is a 3-way merge of commits A, B and
>> C onto HEAD, using the parent of the commit being cherrk-picked as a
>> virtual common ancestor.  Which means
>
> You generated nearly the same description and diagram I used in the
> commit message (the one in 3/7) describing this.  :-)
>
>>  - To transplant A (i.e. the first step), we'd compare the diff of
>>    A^..O (i.e. what our side did, including the renames done at X)
>>    and diff of A^..A (i.e. what the first commit did in the range),
>>    and the former does quite a lot of rename detection.
>>
>>  - After transplanting B (i.e. the second step), then we'd compare
>>    the diff of A^..A' (where A' is A cherry-picked on O, i.e. the
>
> Close, but for transplanting B we do the diff of B^..A', not A^...A'.
> (And in this diagram, B^ is A.)  That's critical below...

Yes, I upfront said "pretend that the parent of the commit being
picked is the common ancestor and run 3-way merge", but then got
confused by the ancestry graph myself, forgetting that the reason
why A^ is used in the first "pick" is *not* because the it is the
fork point of our history and the side branch, but it is because it
is A's parent.

And if the renames in B^..A' and A^..A' are different that must have
come only from the difference between A..B (which is B^..B), but
that comparison is what we do when cherry-picking B on top of A',
so it is easy to take into account to reuse the renames precisely
without "assuming they are the same".

Thanks.

