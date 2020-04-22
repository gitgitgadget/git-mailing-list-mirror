Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94053C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3330020706
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n5jUFP/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDVPd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:33:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51930 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgDVPd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 11:33:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E958C2057;
        Wed, 22 Apr 2020 11:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dJKUaJS2jSMB+vAw9Xl6PtV81IQ=; b=n5jUFP
        /trKjv1waoVqAubj/grxzKkfgPjJTXDkY5xMQM7jffJPBlclgbV5hGguGm4kwfhv
        d9Mnccj4Ba0U3WkPyJbyOBdyofPAtk4wza+qwRuaMNYBjMmnypHGLgHCABk55ZIA
        tIeVOWp8sVIehtsE2Q2Zu1xF5V5XnoDSEMPjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PelFprtRbnjZ2p8rWOQ47xuwqbJ5W1pE
        HxF40moVigAhIdZoPJe1MHR7MRFWiBOxUsEoHQkjKyM5Z4OuRBQAi/WNjGcbuB6T
        IlFLgB2dq+tYnVhEFYHt3WdtK04Bcl/+hqbc8q/MkosSmUZzXr1viIBMPeg7g5Pu
        r8LcWj5e+e4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56678C2056;
        Wed, 22 Apr 2020 11:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 67ED2C2055;
        Wed, 22 Apr 2020 11:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting gigabytes
References: <20200422084254.GA27502@furthur.local>
        <20200422095702.GA475060@coredump.intra.peff.net>
        <20200422103011.GA545254@coredump.intra.peff.net>
        <20200422104000.GA551233@coredump.intra.peff.net>
Date:   Wed, 22 Apr 2020 08:33:48 -0700
In-Reply-To: <20200422104000.GA551233@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 22 Apr 2020 06:40:00 -0400")
Message-ID: <xmqqwo67k00z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA4A99C0-84AE-11EA-A6E1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 22, 2020 at 06:30:11AM -0400, Jeff King wrote:
>
>> So it really just seems like v2 does not try hard enough. I think the
>> culprit is the MAX_IN_VAIN setting. If I do this:
>> 
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 1734a573b0..016a413d49 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -46,7 +46,7 @@ static struct strbuf fsck_msg_types = STRBUF_INIT;
>>   * After sending this many "have"s if we do not get any new ACK , we
>>   * give up traversing our history.
>>   */
>> -#define MAX_IN_VAIN 256
>> +#define MAX_IN_VAIN 20000
>>  
>>  static int multi_ack, use_sideband;
>>  /* Allow specifying sha1 if it is a ref tip. */
>> 
>> then I get that same 48k objects, 23MB fetch that v0 does.
>
> I don't quite think that's the solution, though. Both old and new are
> supposed to be respecting MAX_IN_VAIN. So it's not at all clear to me
> why it restricts the number of haves we'll send in v2, but not in v0.

Thanks for digging.  I tend to agree with your assessment that the
setting should not make a difference, if v0 find the common out of
the exchange within the same number of "have"s.

I am guilty of introducing the hardcoded "give up after this many
naks", which I admit I was never fond of, back in the days there was
only one original protocol.  In retrospect, I probably should have
done "after this many naks, stop sending each and every commit but
start skipping exponentially (or fibonacci)" instead.  After all,
this was meant to prevent walking all the way down to a different
root commit when you have more of them than the repository you are
fetching from---but (1) skipping exponentially down to root is way
less expensive, even if it is a bit more expensive than not walking
at all, and (2) if we find a common tree, even if it is distant, it
is way better than not having any common tree at all.

If we had such a code, however, it would probably have swept the
real cause of the issue people are reporting under the rug, though.

