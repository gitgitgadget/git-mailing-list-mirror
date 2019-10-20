Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF8C1F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 11:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfJTL0G (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 07:26:06 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13129 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfJTL0G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 07:26:06 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iM9LW-0006a1-3c; Sun, 20 Oct 2019 12:26:04 +0100
Subject: Re: [PATCH v2 9/9] pack-objects: improve partial packfile reuse
To:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
 <20191019103531.23274-10-chriscool@tuxfamily.org>
 <6e4ad9bb-20d7-4ae5-8768-326f5c455c3c@iee.email>
 <CAP8UFD2rsZj3=KoPCEWw2sTXFhNkynrJLeAGWK2vEbD5GU8chA@mail.gmail.com>
 <20191019232322.GB32408@sigill.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <ac89d8ed-5a57-6297-5fc2-cf562c8da812@iee.email>
Date:   Sun, 20 Oct 2019 12:26:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191019232322.GB32408@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/2019 00:23, Jeff King wrote:
> On Sat, Oct 19, 2019 at 09:20:11PM +0200, Christian Couder wrote:
>
>>>> +static void write_reused_pack_one(size_t pos, struct hashfile *out,
>>>> +                               struct pack_window **w_curs)
>>>> +{
>>>> +     off_t offset, next, cur;
>>>> +     enum object_type type;
>>>> +     unsigned long size;
>>> Is this a mem_sized size or a counter for less that 4GiB items?
>> What I can see is that `&size` is passed as the last argument to
>> unpack_object_header() below. And unpack_object_header() is defined in
>> packfile.h like this:
>>
>> int unpack_object_header(struct packed_git *, struct pack_window **,
>> off_t *, unsigned long *);
>>
>> since at least 336226c259 (packfile.h: drop extern from function
>> declarations, 2019-04-05)
>>
>> So fixing this, if it needs to be fixed, should probably be part of a
>> separate topic fixing unpack_object_header().
> Yeah, this one definitely should be moved to whatever we used to
> represent object sizes in the future (size_t, or I guess off_t if we
> really want to handle huge objects on 32-bit systems too). But
> definitely it shouldn't happen in this series, and I don't think anybody
> interested in the other topic (converting the integer type for object
> sizes) needs to keep tabs on it. When they convert
> unpack_object_header(), the compiler will complain because of passing
> it as a pointer (the more insidious ones will be where we return an
> unsigned long to represent an object type, and somebody will have to
> look into every caller).
>
Thanks, I'll add that one to my list of size values that I should check 
when rebasing my current series.

If I understand correctly gcc is no longer detecting those size 
conversions, but clang has -Wshorten-64-to-32 but I've still to check if 
it catches some of these conversion issues (esp when int (32) is 
extended to 64 bit size_t, rather than being 64 bit in the first place)

Philip
