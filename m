Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66917C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 23:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050920787
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 23:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IJDG9SBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbgDBXZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:25:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55542 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBXZX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 19:25:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B6B8CE35E;
        Thu,  2 Apr 2020 19:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vPxbQBQY5t7RUmr8KxAs6IFYIcM=; b=IJDG9S
        Bp2HKhdi5OZgjYkNawVG5MqzJyjczfKJfY0pDJHR7Z1AoZkX/osaeIjwQo+df9E8
        MMxTAoOrgipwA5kQM/SYMslEX1rKaCBLH3sxrZNk51pjPPGJkcTtLZdXUB1zpWeS
        MprGkdoRvT1hbCPqn9UAyJV6JuXOU+5gvdb0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tisBQP3yGV9v9fh4GSW5JgLC2YuUIJ89
        mUof6rS0ZR90GFmeKUXnHcVJN0J4wjgu+2MZg0xqk1zohFY4hrUqNi6EtjfN1duq
        9z1YDVRCdS3y6a5aFOMi/RdaXl/TUFwEJyErGi5yXfjDNVW41Ly/9HD5KjY0wQfY
        nDZFhrLuiAA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 030CDCE35D;
        Thu,  2 Apr 2020 19:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 480BECE35C;
        Thu,  2 Apr 2020 19:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 2/2] diff: restrict when prefetching occurs
References: <xmqq7dyx3b1o.fsf@gitster.c.googlers.com>
        <20200402230937.47323-1-jonathantanmy@google.com>
Date:   Thu, 02 Apr 2020 16:25:16 -0700
In-Reply-To: <20200402230937.47323-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 2 Apr 2020 16:09:37 -0700")
Message-ID: <xmqqy2rd1ndv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36E9B314-7539-11EA-B34A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> This comment makes me wonder if it would be even better to
>> 
>>  - prepare an empty to_fetch OID array in the caller,
>> 
>>  - if the output format is one of the ones that wants prefetch, add
>>    object names to to_fetch in the caller, BUT not fetch there.
>> 
>>  - pass &to_fetch by the caller to this function, and this code here
>>    may add even more objects,
>> 
>>  - then do the prefetch here (so a single promisor interaction will
>>    grab objects the caller would have fetched before calling us and
>>    the ones we want here), and then clear the to_fetch array.
>> 
>>  - the caller, after seeing this function returns, checks to_fetch
>>    and if it is not empty, fetches (i.e. the caller prepared list of
>>    objects based on the output type, we ended up not calling this
>>    helper, and then finally the caller does the prefetch).
>> 
>> That way, the "unless we have already prefetched" logic can go, and
>> we can lose one indentation level, no?
>
> This means that the only prefetch occurs in diffcore_rename()?

No, but I phrased the last bullet item incorrectly.  "after seeing
this function returns" is wrong, but what is in parentheses (i.e. if
we didn't call diffcore_rename) is correct.

> I don't
> think this will work for 2 reasons:
>
>  - diffcore_std() calls diffcore_break() (which also reads blobs) before
>    diffcore_rename()

Ahh, I missed that part.

>  - (more importantly) there's a code path in diffcore_std() that does
>    not call diffcore_rename(), so we would still need some prefetching
>    logic in diffcore_std() in case diffcore_rename() is not called

That one I think is already covered.
