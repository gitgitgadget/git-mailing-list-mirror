Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9902C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 22:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhLQWcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 17:32:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54440 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhLQWcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 17:32:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B4B2F85F4;
        Fri, 17 Dec 2021 17:32:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JPnsRsIqrpThQ7c2QIn4Igq5FQ2IerVI0KDm95
        k3liE=; b=FfdInwlMikWghN873r+B04yKIz1pMwxhXljhX9YiR/VO/hA0RaJsFT
        +QCBCcigbvDlisRYXs11mFIT7aTHbN7jsUTFeFTzyW2G3h1T9RRtAv2Y/0g5LY0f
        aZ9zSdyn2hwlEJa1yAw4EF11398KwwRd011sX3wDwuD6Xz4miZWVA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44059F85F3;
        Fri, 17 Dec 2021 17:32:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CAA2F85F2;
        Fri, 17 Dec 2021 17:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V5 2/2] git-apply: add --allow-empty flag
References: <20211213220327.16042-1-jerry@skydio.com>
        <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
        <211217.86wnk395bz.gmgdl@evledraar.gmail.com>
        <xmqqr1ab2c0v.fsf@gitster.g>
Date:   Fri, 17 Dec 2021 14:32:07 -0800
In-Reply-To: <xmqqr1ab2c0v.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        17 Dec 2021 12:48:32 -0800")
Message-ID: <xmqqee6a3lso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B7FB866-5F89-11EC-A9A2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Surely, I am sympathetic to the intent.  If you are updating "git
> frotz" that is sanitizer-clean, and if you write a new test in a
> test script that happens to be sanitizer-clean, if you introduced a
> new leak to "git frotz", you would appreciate if the CI notices it
> and blocks you.
> ...
> The only time we can sensibly do the "now these are leak-free, and
> we will catch and yell at you when you add a new leak" is when we
> know _all_ git commands are sanitize clean...

There is another scenario where the TEST_PASSES_SANITIZE_LEAK=true
may make sense, actually.  If we declare that from the time we
commit to the approach, until we can mark all the test scripts with
the mark, we will put it the sole priority to squash any and all
leaks, without doing anything else so that we can finish it the
soonest possible.

Then it is probably OK to start at 230 and cover all 940 as fast as
we can.  Because we are effectively closing the tree for anything
but plug-leak changes and adding TEST_PASSES_SANITIZE_LEAK=true line
to more tests, we wouldn't have to worry about introducing new leaks
to existing tests that are marked as already clean---because of the
tree closure, they are more likely to stay clean.  t4126 wouldn't
have gained a new use of format-patch to break it.

But of course, such an approach is not feasible in this project,
where people do not work in lock-step.  That leads to the question I
asked at the end of my previous message.

> Having said that, what would be the next step to help developers to
> avoid introducing new leaks while yelling at them for existing leaks
> they did not introduce and not forbidding them to use git subccommands
> with existing leaks in their tests?
>
> I would prefer an approach that does not force the project to make
> it the highest priority to plug leaks over everything else.

Thanks.
