Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C1C1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 15:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeIEUW2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 16:22:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:32445 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbeIEUW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 16:22:28 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 247933F40D8;
        Wed,  5 Sep 2018 11:51:41 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DAC523F40C7;
        Wed,  5 Sep 2018 11:51:40 -0400 (EDT)
Subject: Re: [PATCH 1/8] trace2: create new combined trace facility
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.29.git.gitgitgadget@gmail.com>
 <82885700379efe6d6a83629cac4d943b99b393bf.1535734192.git.gitgitgadget@gmail.com>
 <CAGZ79kbUYDAKi-K2uHpkffPjMxGYtH=QUMhvfq4HTc5+a7-eBA@mail.gmail.com>
 <xmqqzhww6gl8.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <eb77f46b-8d04-a1c7-ae31-7ea5e2456cfd@jeffhostetler.com>
Date:   Wed, 5 Sep 2018 11:51:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhww6gl8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/4/2018 6:30 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
>>> The API defines both fixed-field and printf-style functions.
>>>
>>> The trace2 performance tracing includes thread-specific function
>>> nesting and timings.
>>
>> So this only adds the new API, and we need to merge the TRACE
>> into the TRACE2 later?
> 
> If this is a rhetorical question implying that it would be best if
> the existing trace() were rewritten to be built on top of trace2()
> while building this series, especially before adding new callsites
> that directly use trace2(), I may share that feeling.  I haven't
> studied this new round deeply enough to see how realistic it would
> be, though.
> 
> 

I wanted to come up with a unified API that we liked and was
sufficient to handle the default-key, performance-key,
the new event-key (currently supporting JSON output), and any
other formats/variants that we want (protobufs, syslog, etc).

And hopefully get some agreement on it and see what else we want
from it.

And then look at converting the trace_printf() and trace_performance()
calls to trace2.  Clearly, I could just replace the existing printf
style calls to trace2_printf's, but I thought it would be better to
look at them and promote them to higher-level functions.  For example,
the trace_argv_printf() calls are generally used to dump the command
line arguments for the current process or spawned child processes.
I have trace2_start() and trace2_child_start() that captures the
argv and additional information about it.  (The "why" if you will.)
So the trace_argv_* forms can go away.

Likewise, all of the trace_performance() and trace_performance_since()
can be converted to trace2_region_enter/_leave calls.  And those forms
can be removed from trace.[ch].

The net-net is that trace.[ch] shrinks in a short sequence of commits
on top of my initial trace2 commit in a reroll of this patch series.
(and replacing some of the demonstration commits in V1)

Then I'll address the trace_printf_key() forms, since they write
to alternate stream.

Then I can delete trace.[ch].  And we can consider renaming
trace2_* functions and/or GIT_TR2_* env vars if we want.

I wanted to avoid rewriting trace.[ch] just to delete them later
in the same patch series.

Jeff
