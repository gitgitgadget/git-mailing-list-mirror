Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD28C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E236160FBF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhIPUnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:43:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63805 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhIPUnt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 16:43:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 410DA150025;
        Thu, 16 Sep 2021 16:42:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zlwgF80ohENM13rU+/lt7dWFfGqYaIVa4sz2Jz
        HlXTM=; b=L/SDGx8TU/4bm3dqf2gb6r8Yp6p20RW6+Z16ZUgHs36eU+I+xI3Ijd
        ITeQDH4zHlsNX9hU33vUSE0DncRaGJvSDtA+rYqIlvtYQ6FUcIeCm4NvRQHPKmgV
        u5md+6gbDYQdiKwk8kS4iKXyUVo9WRzoGJ/XvyuRLTJ9ffXMellL8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39AEE150024;
        Thu, 16 Sep 2021 16:42:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 71A5F150023;
        Thu, 16 Sep 2021 16:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rolf Eike Beer <eb@emlix.com>,
        Git List Mailing <git@vger.kernel.org>,
        Tobias Ulmer <tu@emlix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: data loss when doing ls-remote and piped to command
References: <6786526.72e2EbofS7@devpool47> <2279155.Qy0YqsFniq@devpool47>
        <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com>
        <2677927.DK6gFqPMyL@devpool47>
        <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com>
Date:   Thu, 16 Sep 2021 13:42:22 -0700
In-Reply-To: <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 16 Sep 2021 10:11:22 -0700")
Message-ID: <xmqq7dfgtfpt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9904F25A-172E-11EC-9C9A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Sep 16, 2021 at 5:17 AM Rolf Eike Beer <eb@emlix.com> wrote:
>>
>> Am Donnerstag, 16. September 2021, 12:12:48 CEST schrieb Tobias Ulmer:
>> > > The redirection seems to be an important part of it. I now did:
>> > >
>> > > git ... 2>&1 | sha256sum
>> >
>> > I've tried to reproduce this since yesterday, but couldn't until now:
>> >
>> > 2>&1 made all the difference, took less than a minute.
> 
> So if that redirection is what matters, and what causes problems, I
> can almost guarantee that the reason is very simple:
> ...
> Anyway. That was a long email just to tell people it's almost
> certainly user error, not the kernel.

Yes, 2>&1 will mix messages from the standard error stream at random
places in the output, which explains the checksum quite well.

I am not sure if it explains the initial report where

	ls-remote 2>&1 | less

produced

    > 6f38b5d6cfd43dde3058a10c68baae9cf17af912        refs/tags/v5.0-rc2
    > 1c7fc5cbc33980acd13ae83d0b416db002fe95601e7f97f64b59514d936     refs/tags/v5.7-rc2^{}
    > d0709bb6da2ab6d49b11643e98abdf79b1a2817f        refs/tags/v5.7-rc3

    What we see on the second line is the beginning of peeled
    v5.0-rc2^{} up to the "acd13" (that is, the first 19 bytes of the
    line), followed by the full line for peeled v5.7-rc2^{} (which
    begins with "ae83d").  12407 bytes in between are missing, which
    is even more puzzling as it is not a nice round number.

I can sort of guess that the progress display during transfer, which
comes out on the standard error stream and uses terminal control
sequences like "go back to the end of the line without feeding a new
line", "erase to the end of the line", etc., would be contributing,
but because it is piped to "less", which would make it "visible"
(i.e. you do not get the raw escape but see three capital letters
ESC in reverse), it does not quite explain how the display was
broken.

In any case, I do not think the kernel is involved, or more
generally I do not think any "loss of output bytes" is happening
here.  It's just "| less" that failed to show a range about 12k
bytes long is mystery to me ;-).


