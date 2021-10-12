Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53AFC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 12:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE2660BD3
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 12:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhJLMgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 08:36:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53637 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbhJLMgU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 08:36:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E6101482F8;
        Tue, 12 Oct 2021 08:34:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=G/xs7og/0orV1u+uQJebbe0siHAnz+bbVN7PfosgHH8=; b=UP4m
        dK0C6Aqh8veWfIF2cya89p/IAoHZ9aev2rgpV5AfVZ9nk7j3/zFzLhizfUfWQhOu
        D6auKf1RRxxj5jKOn/kEXpu4czPdWY47+kL/E1yN+15fP0GY/vgV9Fv3VHAW7SbW
        cq0mM6DtlNlIwNw4tMJSIjTR3pijU6eTRh6THuk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 762A31482F6;
        Tue, 12 Oct 2021 08:34:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E73741482F2;
        Tue, 12 Oct 2021 08:34:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        <87fst7z0oa.fsf@osv.gnss.ru> <87y26yk35r.fsf@evledraar.gmail.com>
        <xmqqa6je8n5c.fsf@gitster.g>
Date:   Tue, 12 Oct 2021 05:34:14 -0700
Message-ID: <xmqqo87u777d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B670D3DE-2B58-11EC-87BA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> More importantly...
>
> Whenever I think about a new "feature", I try to come up with a
> story in which the feature effectively improves the end-user's life,
> how it fits in the larger picture, and enables something that is
> hard to do by combining other tools.
>
> The kind of "story" I would aim for is like this.  Suppose we were
> selling not "git stash -S" but "git stash -k". ...

To answer my previous "question", I guess this is usable in the same
scenario where "git stash -k" is useful.  After creating a bunch of
stash entries created by "git stash -S", if you want to test any of
them (because what is in these stash entries did not exist without
other working tree changes, and couldn't have been tested in the
working tree standalone by definition), you can "git stash pop" such
a stash entry created by "git stash -S" and then "git stash -k" to
materialize what was in the stash alone in the working tree to test
_later_ (as opposed to testing _first_; in the "git stash -k"
workflow, you'd collect "good bits" in the index with "add -p"
first, then "clear the remaining cruft" with "git stash -k" to test
it first, and take the cruft back with "git stash pop").

So in short, I do not think I am strongly opposed to "git stash -S"
existing, since I did find one use case story that it could be used,
but I do think it is redundant and unnecessary.

IOW, "git stash -k" followed by "git stash" and "git stash pop" the
one created with "git stash -k" would be an equivalent operation to
this new "git stash -S".  But the price of being able to combine
these three operations into one is that the user cannot have the
state after "stash -k" in the working tree to inspect, and I cannot
shake the feeling that this new "feature" is like a tail wagging a
dog.  If the "goal" is to "create a stash entry out of what is in
the index", then "stash -S" is a one-step handy tool that directly
achieves that "goal", but that "goal" does not smell like a useful
"goal" in the first place.  To "create a commit by sifting mixed
changes in the working tree with 'add -p' and then gaining a chance
to do a clean and final testing" would be the "goal" of "stash -k",
and that I can see a clear benefit.  Contrasting to that, I am not
so sure about "stash -S".  It would be another way to eventually do
the same thing but along a more roundabout route.

So, I dunno.
