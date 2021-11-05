Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51225C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E6461053
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhKESHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 14:07:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50351 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhKESHA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 14:07:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35CD114F653;
        Fri,  5 Nov 2021 14:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=08iIY8LzT69/RSH4Ftm+pFFlWRPRtiQS0rDbN/
        gOQMI=; b=iTomk1L9yzhI/IsuGbN+GobfGQHpcvh3yAeHyxTITzPU7sKaARu66V
        WOjyL9i7EnsHnDlnoXb3ARNrpIcRDBoofHzfvjT0ZogmjcwY+aC/sCBFHvTdmDA3
        1cr+sgn39OoWQ0cLDFHiA1ldIlauJU8wrXMbhz9QsWwnzUcWXhWr4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DA7414F650;
        Fri,  5 Nov 2021 14:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D8DFC14F64F;
        Fri,  5 Nov 2021 14:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <xmqq7ddn3dlt.fsf@gitster.g> <20211105112525.GA25887@dinwoodie.org>
        <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
Date:   Fri, 05 Nov 2021 11:04:15 -0700
In-Reply-To: <YYUeKt0xQm/6QT+w@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 5 Nov 2021 08:06:02 -0400")
Message-ID: <xmqqk0hmxyw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAA2E348-3E62-11EC-B730-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 05, 2021 at 11:25:25AM +0000, Adam Dinwoodie wrote:
>
>> > ... I am not quite sure how this explains "tests relating to ssh
>> > signing failing on Cygwin".  After all, this piece of code is
>> > lazy_prereq, which means that ssh-keygen in this block that fails
>> > (due to a less restrictive permissions) would merely mean that tests
>> > that are protected with GPGSSH prerequisite will be skipped without
>> > causing test failures.  After all that is the whole point of
>> > computing prereq on the fly.
>> 
>> The issue is that the prerequisite check isn't _just_ checking a
>> prerequisite: it's also creating an SSH key that's used without further
>> modification by the tests.
>
> This is sort of a side note to your main issue, but I think that relying
> on a lazy_prereq for side effects is an anti-pattern. We make no
> promises about when or how often the prereqs might be run, and we try to
> insulate them from the main tests (by putting them in a subshell and
> switching their cwd).
>
> It does happen to work here because the prereq script writes directly to
> $GNUPGHOME, and we run the lazy prereqs about when you'd expect. So I
> don't think it's really in any danger of breaking, but it is definitely
> not using the feature as it was intended. :)

This merely imitates what GPG lazy-prerequisite started and imitated
by other existing signature backends.

I'd expect that you need some "initialization" for a feature X as
part of asking "is feature X usable in this environment?".  Reusing
the result of the initialization for true tests is probably an
optimization worth making.  As long as the question is answered for
the true tests, that is [*].

    side note: so being able to create a key alone, without
    verifying the resulting key is usable, is a no-no.  That is why
    I said it is a good idea to check if the resulting key is usable
    inside the lazy-prereq.

> Again, that's mostly a tangent to your issue, and maybe not worth
> futzing with at this point in the release cycle. I'm mostly just
> registering my surprise. ;)

My purist side is with you and share the surprise.  But my practical
side says this is probably an optimization worth taking.  If prereq
only checks "if we initialize the keys right way, we can use ssh
signing" and then removes the key and the equivalent to .ssh/
directory, and a real test does "Ok, prereq passes so we know ssh
signing is to be tested.  Now initialize the .ssh/ equivalent and
create key", a fix like Adam came up with must be duplicated in two
(or more) places, one for the prereq that initializes the keys
"right way", and one for each test script that prepares the key used
for it.
