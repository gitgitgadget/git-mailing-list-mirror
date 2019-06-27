Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F381F461
	for <e@80x24.org>; Thu, 27 Jun 2019 13:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0NYs (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 09:24:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:15059 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0NYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 09:24:48 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7AAAC3F4097;
        Thu, 27 Jun 2019 09:24:47 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:c5bd:5c5b:177e:8a3e] (unknown [IPv6:2001:4898:a800:1010:76f3:5c5b:177e:8a3e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 02FE33F4012;
        Thu, 27 Jun 2019 09:24:46 -0400 (EDT)
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
To:     Duy Nguyen <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-6-pclouds@gmail.com>
 <55f81571-ba45-edcf-49bd-05418cc309c5@jeffhostetler.com>
 <CACsJy8BjhQD-g69dr-yDCycgfrHZ8xJLgjD=LanRUBxAN6=Zrg@mail.gmail.com>
 <98afb501-ef57-9b64-7ffb-f13cea6fd58a@gmail.com>
 <CACsJy8CwWvKNbYvDqWc-zCwEPc_rz-P4y-SvXV-9jL8_XCFjZQ@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <93562f66-07a7-d074-e225-65afd7ced1d4@jeffhostetler.com>
Date:   Thu, 27 Jun 2019 09:24:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACsJy8CwWvKNbYvDqWc-zCwEPc_rz-P4y-SvXV-9jL8_XCFjZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/27/2019 6:48 AM, Duy Nguyen wrote:
> On Tue, Jun 25, 2019 at 7:40 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/25/2019 6:29 AM, Duy Nguyen wrote:
>>> On Tue, Jun 25, 2019 at 3:06 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>>> I'm curious how big these EWAHs will be in practice and
>>>> how useful an array of integers will be (especially as the
>>>> pretty format will be one integer per line).  Perhaps it
>>>> would helpful to have an extended example in one of the
>>>> tests.
>>>
>>> It's one integer per updated entry. So if you have a giant index and
>>> updated every single one of them, the EWAH bitmap contains that many
>>> integers.
>>>
>>> If it was easy to just merge these bitmaps back to the entry (e.g. in
>>> this example, add "replaced": true to entry zero) I would have done
>>> it. But we dump as we stream and it's already too late to do it.
>>>
>>>> Would it be better to have the caller of ewah_each_bit()
>>>> build a hex or bit string in a strbuf and then write it
>>>> as a single string?
>>>
>>> I don't think the current EWAH representation is easy to read in the
>>> first place. You'll probably have to run through some script to update
>>> the main entries part and will have a much better view, but that's
>>> pretty quick. If it's for scripts, then it's probably best to keep as
>>> an array of integers, not a string. Less post processing.
>>
>> I don't think the intent is to dump the EWAH directly, but instead to
>> dump a string of the uncompressed bitmap. Something like:
>>
>>          "delete_bitmap" : "01101101101"
>>
>> instead of
>>
>>          "delete_bitmap" : [ 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1 ]
> 
> I get this part. But the numbers in the array were the position of the
> set bits. It's not showing just the actual bit map.
> 
> The same bitmap would be currently displayed as
> 
>   "delete_bitmap": [ 1, 2, 4, 5, 7, 8, 9, 11 ]
> 
> And that maps back to the entry[1], entry[2], entry[4]... in the index
> being deleted from the base index. So displaying as a real bit map
> actually adds more work for both the reader and the tool because you
> have to calculate the position either way. And it gets harder if the
> bit you're intereted in is on the far right.


Thanks for the clarification.  That helps.

Jeff
