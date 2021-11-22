Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B1FC433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 09:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbhKVJNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 04:13:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50127 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhKVJNh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 04:13:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F57616D111;
        Mon, 22 Nov 2021 04:10:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Ggs44KLIIufMNTY2nz8wtk0H1pDbafsuGCcksfwXYho=; b=KGlm
        jUDcGsWERPgkqtIKyRDnGg8KVipxluOw59Ad4LxICdNWbcndGFrG2V/qxvjnv0L0
        h4tKSM3MgYiUQx8W3Z5xwmlYI1cGfRG5eP7q7w6Ng8T9MDRGUp812yQ2piOSRzca
        6fhn6J1uWlvWFyYnXmzTxYKKQmXqViRul8eRXRQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97A4B16D110;
        Mon, 22 Nov 2021 04:10:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0695716D10F;
        Mon, 22 Nov 2021 04:10:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
        <20211116033542.3247094-2-sandals@crustytoothpaste.net>
        <xmqq1r3f5izn.fsf@gitster.g>
        <YZWJy16Emrkr6qVL@camp.crustytoothpaste.net>
        <xmqqv90qx76b.fsf@gitster.g>
        <YZbQu3fwfRsdEeXR@camp.crustytoothpaste.net>
Date:   Mon, 22 Nov 2021 01:10:26 -0800
Message-ID: <xmqq5yskk131.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08F822CA-4B74-11EC-9721-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-11-18 at 07:19:08, Junio C Hamano wrote:
>> Presumably csprn_bytes() grabs bytes from underlying mechanism in
>> smaller chunk, but would not return until it fills the buffer---ah,
>> your "make sure our buffer handling is correct" is primarily about
>> the check that we get full 1k bytes in the loop?  We ask 1k chunk 64
>> times and we must get full 1k chunk every time?
>
> Yes, that's what we'd expect to happen.
>
>> What I was wondering about was the other half of the check, ensuring
>> all buckets[] are painted that gave us the cute 10^-100 math.
>
> Say the buffer handling is incorrect and we read only a few bytes
> instead of the full 1 KiB.  Then we'll end up filling only some of the
> buckets, and the check will fail much of the time, because we won't get
> sufficient number of random bytes to fill all the buckets.

... meaning (64 * a few bytes) is small enough such that some slots
in buckets[] will be left untouched (and the remainder of 1kB is
untouched --- but the buffer[] is not initialized in any way, so
it's not like such an "oops, we only fed a few bytes" bug would
leave the rest to NUL or anything)?

> The check is that we got enough data that looks like random bytes over
> the course of our requests.

If the check were doing so, yes, I would have understood (whether I
agreed with it or not), but the check is "if we taint each and every
bucket[] even once, we are OK", not "bucket[] should be more or less
evenly touched", and that is why I do/did not understand the test.
