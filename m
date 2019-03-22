Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747AF20248
	for <e@80x24.org>; Fri, 22 Mar 2019 14:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfCVOUF (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 10:20:05 -0400
Received: from siwi.pair.com ([209.68.5.199]:44704 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfCVOUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 10:20:04 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E4C203F400C;
        Fri, 22 Mar 2019 10:20:03 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 563D63F4092;
        Fri, 22 Mar 2019 10:20:03 -0400 (EDT)
Subject: Re: [PATCH v2 1/1] trace2: write to directory targets
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net, Johannes.Schindelin@gmx.de
References: <cover.1552519463.git.steadmon@google.com>
 <cover.1553126984.git.steadmon@google.com>
 <59d8c6511bc8c5fd25473c282768b38c97df9e6b.1553126984.git.steadmon@google.com>
 <xmqqmulpt22e.fsf@gitster-ct.c.googlers.com>
 <51e88650-8667-df1f-13ef-4537f2e70346@jeffhostetler.com>
 <xmqqpnqjr3g0.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b0d5949a-1afa-fcce-646c-d33d51686a2f@jeffhostetler.com>
Date:   Fri, 22 Mar 2019 10:20:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <xmqqpnqjr3g0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/21/2019 11:30 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>>>> +	for (attempt_count = 0; attempt_count < MAX_RANDOM_ATTEMPTS; attempt_count++) {
>>>> +		strbuf_reset(&final_path);
>>>> +		strbuf_addbuf(&final_path, &base_path);
>>>> +		strbuf_addf(&final_path, ".%d", attempt_count);
>>
>> Since the last component of the SID is already very unique and
>> we're unlikely to have collisions, maybe change the above line to:
>>
>> 		if (attempt_count > 0)
>> 			strbuf_addf(&final_path, ".%d", attempt_count);
>>
>> and in reality expect to never have files with the suffix.
> 
> That's a nice property.
> 
>> Unless, that is, they turned on more than one of GIT_TR2,
>> GIT_TR2_PERF, or GIT_TR2_EVENT and pointed them at the same
>> directory, but I'm not sure if I care about that edge case
>> or not.
> 
> That actually makes me wonder if the auto generated filenames want
> to have a common trait (e.g. suffix) that allows the readers to tell
> from which of these environment variables the names came from.  It
> would not be very useful if two files with the same sid component
> had .1 suffix for GIT_TR2 trace for one session, and the same .1
> suffix is used for GIT_TR2_PERF trace for a pair of files from
> another session.

I thought about suggesting that, but didn't think it worth the bother.

> But let's not worry about it for now.  If people do not want them
> get mixed up and become hard to tell apart, they can always specify
> different directories for different traces.

agreed. it should be very rare.  the SID is the built from
	"<microseconds-since-the-epoch><dash><pid>"
so something would have to be seriously wrong with their
system to get collision from 2 different git commands.

and yes, they the advise should be to use different directories
for the different streams.

> 
>>
>>>> +		fd = open(final_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
>> [...]
>>
>> Nice.  Thanks for looking into this.
>> Jeff
