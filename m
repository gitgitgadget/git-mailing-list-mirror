Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B0CC433E0
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1094764F04
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 12:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBUMwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 07:52:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64865 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhBUMwI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 07:52:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC6C0A91A3;
        Sun, 21 Feb 2021 07:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=PwdM9WHa5dMFIg+mzG7zDVSRNT8=; b=U9N4DxGZoc3ByFG59G/r
        AmZnxyXT8fpELts0k3PhV2M79Lt07fe7E1qakeyeJnppL2Q0lFEQYPuA9W+D7ip1
        Xpk3umQv3mxsxwVy2NYiDizIvANjryl6djICTGL0MDwwBrmE/U/hC4jF6aOWR/Mo
        3zIBGS5qlLuFOyyAtwnkLAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=N2cml/oiWz7JFkBVJcke8CH+vYwvAw06WS0q9kVjJbl+yR
        AsOry4V2zwDlj0XE0loM8sVQn03iIcuh0krbUkW0g7IIcwuOV0iKXerp9zKfHjXS
        0rJYXfrBDPwiV55hvp5tFjROGWZ8VXa4y6w1qStE867PGWo7hmi77p0XtZGhg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5313A91A2;
        Sun, 21 Feb 2021 07:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 536EFA91A1;
        Sun, 21 Feb 2021 07:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
        <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com>
        <xmqqv9ana05b.fsf@gitster.g>
        <CANQDOdeEd=JjWL4gb5CWHL_HkvJMnFumW74ew4DXJahh4BKvfQ@mail.gmail.com>
Date:   Sun, 21 Feb 2021 04:51:24 -0800
Message-ID: <xmqqo8gd8tyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81C294D2-7443-11EB-8365-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> >>   -#define WRITE_BUFFER_SIZE 8192
>> >> +#define WRITE_BUFFER_SIZE (128 * 1024)
>> >>   static unsigned char write_buffer[WRITE_BUFFER_SIZE];
>> >>   static unsigned long write_buffer_len;
>> >
>> > [...]
>> >
>> > Very nice.
>>
>> I wonder if we gain more by going say 4M buffer size or even larger?
>>
>> Is this something we can make the system auto-tune itself?  This is
>> not about reading but writing, so we already have enough information
>> to estimate how much we would need to write out.
>>
>> Thanks.
>>
>
> Hi Junio,
> At some point the cost of the memcpy into the filesystem cache begins to
> dominate the cost of the system call, so increasing the buffer size
> has diminishing returns.

Yes, I know that kind of "general principle".  

If I recall correctly, we used to pass too large a buffer to a
single write(2) system call (I do not know if it was for the
index---I suspect it was for some other data), and found out that it
made response to ^C take too long, and tuned the buffer size down.

I was asking where the sweet spot for this codepath would be, and if
we can take a measurement to make a better decision than "8k feels
too small and 128k turns out to be better than 8k".  It does not
tell us if 128k would always do better than 64k or 256k, for
example.

I suspect that the sweet spot would be dependent on many parameters
(not just the operating system, but also relative speed among
memory, "disk", and cpu, and also the size of the index) and if we
can devise a way to auto-tune it so that we do not have to worry
about it.

Thanks.
