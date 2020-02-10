Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD170C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 17:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE820842
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 17:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rjB18B9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBJRCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:02:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63004 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJRCP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 12:02:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DCBCBEF93;
        Mon, 10 Feb 2020 12:02:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9DH0NPnwkoHdEmi7P1i0Cipx79g=; b=rjB18B
        9sTMg70+LWT6Qg8CFYTd/ztA/NMrA9vlajdezOBaQpCC74jRw9uuRfX/xNWW2nBC
        k8TYbzaV5Evfbst7ikVLyVK8lXH38kK712aCJsFygwWiihkm6/ndY70oPiuaIjxx
        cZ1NOlILd7+1k6ZOeBj7m8cONNesCsQEsv/K4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SdtuCptG1izHQIV9R1VjHKkFT0TKqb7f
        DpMMp4pWZve0NohuDy3pPpISMOylBnyMl4U/dUHCYN7qx6TSm13UG/we7LN8Spxu
        w5kCbHhg3ymVvx7MB/D9CbUtz+w/d8ZQGQGPtV2C+mDCj8bA0R1ybZ6IADjj7pJx
        ybcSa4eGuok=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 565D7BEF92;
        Mon, 10 Feb 2020 12:02:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D40EBEF91;
        Mon, 10 Feb 2020 12:02:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
Subject: Re: [PATCH] pack-format: correct multi-pack-index description
References: <20200207221640.46876-1-johannes@sipsolutions.net>
        <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com>
Date:   Mon, 10 Feb 2020 09:02:08 -0800
In-Reply-To: <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com> (Derrick
        Stolee's message of "Mon, 10 Feb 2020 09:18:34 -0500")
Message-ID: <xmqqpnem1ilr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13A5E232-4C27-11EA-A086-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/7/2020 5:16 PM, Johannes Berg wrote:
>> The description of the multi-pack-index contains a small bug,
>> if all offsets are < 2^32 then there will be no LOFF chunk,
>> not only if they're all < 2^31 (since the highest bit is only
>> needed as the "LOFF-escape" when that's actually needed.)
>> 
>> Correct this, and clarify that in that case only offsets up
>> to 2^31-1 can be stored in the OOFF chunk.
>> 
>> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
>> ---
>>  Documentation/technical/pack-format.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
>> index cab5bdd2ff0f..d3a142c65202 100644
>> --- a/Documentation/technical/pack-format.txt
>> +++ b/Documentation/technical/pack-format.txt
>> @@ -315,10 +315,11 @@ CHUNK DATA:
>>  	    Stores two 4-byte values for every object.
>>  	    1: The pack-int-id for the pack storing this object.
>>  	    2: The offset within the pack.
>> -		If all offsets are less than 2^31, then the large offset chunk
>> +		If all offsets are less than 2^32, then the large offset chunk
>>  		will not exist and offsets are stored as in IDX v1.
>>  		If there is at least one offset value larger than 2^32-1, then
>> -		the large offset chunk must exist. If the large offset chunk
>> +		the large offset chunk must exist, and offsets larger than
>> +		2^31-1 must be stored in it instead. If the large offset chunk
>>  		exists and the 31st bit is on, then removing that bit reveals
>>  		the row in the large offsets containing the 8-byte offset of
>>  		this object.
>
> Thank you for finding this doc bug. This is a very subtle point,
> and you have described it very clearly.

Thanks, both; queued.
