Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B53920248
	for <e@80x24.org>; Thu, 21 Mar 2019 17:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCURnK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 13:43:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:42792 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbfCURnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 13:43:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 997AF3F401D;
        Thu, 21 Mar 2019 13:43:08 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 684083F401C;
        Thu, 21 Mar 2019 13:43:08 -0400 (EDT)
Subject: Re: [PATCH v2 1/1] trace2: write to directory targets
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        Johannes.Schindelin@gmx.de
References: <cover.1552519463.git.steadmon@google.com>
 <cover.1553126984.git.steadmon@google.com>
 <59d8c6511bc8c5fd25473c282768b38c97df9e6b.1553126984.git.steadmon@google.com>
 <xmqqmulpt22e.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <51e88650-8667-df1f-13ef-4537f2e70346@jeffhostetler.com>
Date:   Thu, 21 Mar 2019 13:43:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <xmqqmulpt22e.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/20/2019 10:04 PM, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
[...]
>> +/*
>> + * How many attempts we will make at creating a random trace output path.
>> + */
>> +#define MAX_RANDOM_ATTEMPTS 10
> 
> With the updated design, randomness is no longer the primary
> property of this new feature.  The fact that the names are
> automatically assigned is.  It could be that the source of tr2_sid
> may (or may not) be some randomness, but the point is that the
> caller in this patch does not care how tr2_sid is computed.
> 
> I'd call this max-attempts (or max-autopath-attempts, but that is
> rather long, and I do not think inside the scope of "tr2_dst" that
> is about "destination", there will be anything but the destination
> path we'd "attempt" with a reasonable maximum value to compute, so
> the "-autopath" clarification would not buy us much)....
> 
>>   static int tr2_dst_want_warning(void)
>>   {
>>   	static int tr2env_dst_debug = -1;
>> @@ -36,6 +42,53 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
>>   	dst->need_close = 0;
>>   }
>>   
>> +static int tr2_dst_try_random_path(struct tr2_dst *dst, const char *tgt_prefix)
> 
> .... and I'd call this s/random/auto/ instead, if I were writing
> this patch following the updated design.

I agree with Junio WRT the s/random/auto/ suggestions.

[...]
>> +	for (attempt_count = 0; attempt_count < MAX_RANDOM_ATTEMPTS; attempt_count++) {
>> +		strbuf_reset(&final_path);
>> +		strbuf_addbuf(&final_path, &base_path);
>> +		strbuf_addf(&final_path, ".%d", attempt_count);

Since the last component of the SID is already very unique and
we're unlikely to have collisions, maybe change the above line to:

		if (attempt_count > 0)
			strbuf_addf(&final_path, ".%d", attempt_count);

and in reality expect to never have files with the suffix.

Unless, that is, they turned on more than one of GIT_TR2,
GIT_TR2_PERF, or GIT_TR2_EVENT and pointed them at the same
directory, but I'm not sure if I care about that edge case
or not.

>> +		fd = open(final_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
[...]

Nice.  Thanks for looking into this.
Jeff
