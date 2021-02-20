Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DCAC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10B864EE1
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBTD2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:28:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57510 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBTD2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 22:28:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDA2D116273;
        Fri, 19 Feb 2021 22:28:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iNNQ4oJus5URWYHqFdYBeEgBTQ8=; b=rQlzWS
        LhDaH4fhl/vQ/+fqoqm1IG5ngetArszcNHMfpQRNDEjMaf19wevHNlMs55e19cY1
        ikPU3KGC9PXxAcX6ykzl2kMz5V2lZuYzXR8Atjxk1+BxHUKdEpRn9q/oQ6NgiQ0I
        NZ2XR8lFvmbjLIj/mHsgwmyf9KmaabjFAEdrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FHfyocLF3itZDZxrj/DGGFMml+h9C+6D
        271oOav7fyWARFYLJ9R/WyQm/9pmMO07CR+QQ4IEQHJDsGf3WCcyz7GJbWua6REG
        nWKJCwfIMeX8Lr0Nv0k7kj3YRP+RDGMoacb/Xs8Xh4deq/mIY3BJXcdFLF4Cw+9k
        5mQaxOT1MQk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7108116272;
        Fri, 19 Feb 2021 22:28:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D8A211626F;
        Fri, 19 Feb 2021 22:28:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@ntdev.microsoft.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
        <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com>
Date:   Fri, 19 Feb 2021 19:28:00 -0800
In-Reply-To: <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 19 Feb 2021 14:12:42 -0500")
Message-ID: <xmqqv9ana05b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A322581A-732B-11EB-BAA2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 2/17/21 9:48 PM, Neeraj K. Singh via GitGitGadget wrote:
>> From: Neeraj Singh <neerajsi@ntdev.microsoft.com>
>> Writing an index 8K at a time invokes the OS filesystem and caching
>> code
>> very frequently, introducing noticeable overhead while writing large
>> indexes. When experimenting with different write buffer sizes on Windows
>> writing the Windows OS repo index (260MB), most of the benefit came by
>> bumping the index write buffer size to 64K. I picked 128K to ensure that
>> we're past the knee of the curve.
>> With this change, the time under do_write_index for an index with 3M
>> files goes from ~1.02s to ~0.72s.
>
> [...]
>
>>   -#define WRITE_BUFFER_SIZE 8192
>> +#define WRITE_BUFFER_SIZE (128 * 1024)
>>   static unsigned char write_buffer[WRITE_BUFFER_SIZE];
>>   static unsigned long write_buffer_len;
>
> [...]
>
> Very nice.

I wonder if we gain more by going say 4M buffer size or even larger?

Is this something we can make the system auto-tune itself?  This is
not about reading but writing, so we already have enough information
to estimate how much we would need to write out.

Thanks.
