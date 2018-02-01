Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6971F404
	for <e@80x24.org>; Thu,  1 Feb 2018 19:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeBATJs (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 14:09:48 -0500
Received: from siwi.pair.com ([209.68.5.199]:24120 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752574AbeBATJr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 14:09:47 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8A3EC84585;
        Thu,  1 Feb 2018 14:09:46 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 21AB88457A;
        Thu,  1 Feb 2018 14:09:46 -0500 (EST)
Subject: Re: [PATCH 11/26] serve: introduce git-serve
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-12-bmwill@google.com>
 <d9a15c0a-35f3-8e9c-ddf2-34420ac7555b@jeffhostetler.com>
 <CAGZ79kZpD6m=5YP0dNuM70Yce=PyxLO6qr6aVpHKa_S9iyACww@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <af1e00f7-b91d-4c1e-bc0e-164371feeadc@jeffhostetler.com>
Date:   Thu, 1 Feb 2018 14:09:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZpD6m=5YP0dNuM70Yce=PyxLO6qr6aVpHKa_S9iyACww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/1/2018 1:57 PM, Stefan Beller wrote:
> On Thu, Feb 1, 2018 at 10:48 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>>
>> On 1/2/2018 7:18 PM, Brandon Williams wrote:
>>>
>>> Introduce git-serve, the base server for protocol version 2.
[...]
>>> + Special Packets
>>> +-----------------
>>> +
>>> +In protocol v2 these special packets will have the following semantics:
>>> +
>>> +  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
>>> +  * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
>>
>>
>> Previously, a 0001 pkt-line meant that there was 1 byte of data
>> following, right?
> 
> No, the length was including the length field, so 0005 would indicate that
> there is one byte following, (+4 bytes of "0005" included)

d'oh.  right.  thanks!

>> Should we also consider increasing the pkt-line limit to 5 hex-digits
>> while we're at it ?   That would let us have 1MB buffers if that would
>> help with large packfiles.
> 
> AFAICT there is a static allocation of one pkt-line (of maximum size),
> such that the code can read in a full packet and then process it.
> If we'd increase the packet size we'd need the static buffer to be 1MB,
> which sounds good for my developer machine. But I suspect it may be
> too much for people using git on embedded devices?

I got burned by that static buffer once upon a time when I wanted
to have 2 streams going at the same time.  Hopefully, we can move
that into the new reader structure at some point (if it isn't already).

> 
> pack files larger than 64k are put into multiple pkt-lines, which is
> not a big deal, as the overhead of 4bytes per 64k is negligible.
> (also there is progress information in the side channel, which
> would come in as a special packet in between real packets,
> such that every 64k transmitted you can update your progress
> meter; Not sure I feel strongly on fewer progress updates)
> 
>>   Granted, we're throttled by the network,
>> so it might not matter.  Would it be interesting to have a 5 digit
>> prefix with parts of the high bits of first digit being flags ?
>> Or is this too radical of a change?
> 
> What would the flags be for?
> 
> As an alternative we could put the channel number in one byte,
> such that we can have a side channel not just while streaming the
> pack but all the time. (Again, not sure if that buys a lot for us)
> 

Delimiters like the 0001 and the side channel are a couple of
ideas, but I was just thinking out loud.  And right, I'm not sure
it gets us much right now.

Jeff
