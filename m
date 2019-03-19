Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485BC20248
	for <e@80x24.org>; Tue, 19 Mar 2019 14:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfCSOAg (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 10:00:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:34735 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfCSOAg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 10:00:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F302B3F4015;
        Tue, 19 Mar 2019 10:00:33 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:7813:62b2:fade:96a7] (unknown [IPv6:2001:4898:8010:0:6149:62b2:fade:96a7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8323C3F4013;
        Tue, 19 Mar 2019 10:00:33 -0400 (EDT)
Subject: Re: [PATCH 2/3] midx: verify: group objects by packfile to speed up
 object verification
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.166.git.gitgitgadget@gmail.com>
 <86f6b0325821a9e1742a28895f9c9b712a1fdec4.1552919394.git.gitgitgadget@gmail.com>
 <87pnqodvr9.fsf@evledraar.gmail.com>
 <9c4da72d-6066-8d05-f181-a93c3926705f@jeffhostetler.com>
 <87lg1bet9d.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d3f119b1-22f6-e34a-a68f-883aca3d8013@jeffhostetler.com>
Date:   Tue, 19 Mar 2019 10:00:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <87lg1bet9d.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/18/2019 6:02 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 18 2019, Jeff Hostetler wrote:
> 
>> On 3/18/2019 11:53 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Mon, Mar 18 2019, Jeff Hostetler via GitGitGadget wrote:
>>>
[...]
>>>> +	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
>>>> +
>>>> +	for (k = 0; k < m->num_objects; k++) {
>>>> [...]
>>>
>>> I have not tested this (or midx in general), but isn't this new QSORT()
>>> introducing the same sort of progress stalling that I fixed for
>>> commit-graph in 890226ccb57 ("commit-graph write: add itermediate
>>> progress", 2019-01-19)? I.e. something you can work around with a
>>> "display_progress(progress, 0)" before the QSORT().
>>>
>>
>> I wasn't tracking your commit-graph changes, but yes, I think it is.
>>
[...]
>>
>> There is the dead time while the sort() itself is running, but at least
>> there is isn't a 5+ second frozen at 0% message on screen.
> 
> Yeah, the same with the commit-graph with my hack. I.e. it'll sit there,
> but at least it sits like this:
> 
>      What I was doing before 100% (X/Y)
>      What I'm about to start doing 0% (0/Z) [hanging]
> 
> Instead of:
> 
>      What I was doing before 100% (X/Y)
>      [hanging]
> 
> So that's an improvement, i.e. you know it's started that next phase at
> least instead of just having a non-descriptive hang.
> 
> Ideally there would be some way to reach into the QSORT() and display
> progress there, but that's all sorts of nasty, so as the TODO comment in
> commit-graph.c notes I punted it.

Perhaps I'm confused or this is a Windows issue, but when I do:

	progress = start_delayed_progress("sorting", n);
	display_progress(progress, 0);
	QSORT(...);
	stop_progress(&progress);

I never see the 0% message.  It always does the hang with the cursor in
column 0 on a blank line.  If I make this a regular start_progress(),
I do see the 0% message for the duration of the qsort hang.

I did some similar testing around your QSORT() in commit-graph.c
and got the same result.  It looks like start_delayed_processing()
wants to wait at least 2 seconds before displaying anything and has
an interval timer to notify it that another message should be printed,
but the display_progress(0) prior to the QSORT() arrives before the 2
seconds are up and so nothing is printed.  It's not until we get into
the loop below the QSORT that one of the display_progress(i+1) calls
could cause a message to appear.

Right?
Jeff






