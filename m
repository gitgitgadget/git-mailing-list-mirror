Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD88C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 16:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiJYQJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 12:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiJYQI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 12:08:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A81418498F
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 09:08:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFFD9158AF7;
        Tue, 25 Oct 2022 12:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k0fkDsbaqLU2Ko5t7nh8OvNv7QuNQcQfnxJrbn
        JtDWU=; b=VoHgo0N9fK4SxPt8FSohPBtpXX+9S5iRnGncYhTLdD2wbpufzA+LZ8
        83urwKW/vvn1m07R69BU1WGXapokZMPZ9jKbDJQiCKb+aoem64WZtdLH4k0E8o7G
        inxfhBBjNPGDeg3/cBFYvvCWvNPEtoJ6HrDnLxoL1c6Igf8LvN6Zo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5CD7158AF6;
        Tue, 25 Oct 2022 12:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C74E158AF5;
        Tue, 25 Oct 2022 12:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] config: require at least one digit when parsing
 numbers
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
        <xmqqwn8tjazb.fsf@gitster.g>
        <cb034574-8753-d641-c166-ae2c34b1c589@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 09:08:55 -0700
In-Reply-To: <cb034574-8753-d641-c166-ae2c34b1c589@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 25 Oct 2022 10:54:24 +0100")
Message-ID: <xmqqh6zropgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53CF11D6-547F-11ED-8040-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/10/2022 19:19, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> @@ -1167,6 +1167,10 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>>>   		val = strtoimax(value, &end, 0);
>>>   		if (errno == ERANGE)
>>>   			return 0;
>>> +		if (end == value) {
>>> +			errno = EINVAL;
>>> +			return 0;
>>> +		}
>> This means well, but doesn't strto*() family of functions silently
>> ignore leading blanks, e.g.
>>      l = strtol("  432k", &end, 0);
>> 	... l == 432, *end = k ...
>> If you really want to reject a string with no number before the
>> optional unit, end at this point may not match value.  With " k" as
>> input, value would point at the space at the beginning, and end
>> would point at 'k'.
>
> It only skips the space if it sees a digit, if it does not find
> anything to convert it sets *end = start.

Yeah, thanks.  Yes, my earlier observation was based on a faulty
experiments, and the code posted as-is would be OK.

