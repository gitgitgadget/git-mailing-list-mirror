Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0F420248
	for <e@80x24.org>; Tue, 19 Mar 2019 18:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfCSSdk (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 14:33:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:16244 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfCSSdk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 14:33:40 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1B8F13F400C;
        Tue, 19 Mar 2019 14:33:39 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C8FE03F4025;
        Tue, 19 Mar 2019 14:33:38 -0400 (EDT)
Subject: Re: [PATCH v2 1/4] progress: add sparse mode to force 100% complete
 message
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.166.git.gitgitgadget@gmail.com>
 <pull.166.v2.git.gitgitgadget@gmail.com>
 <e1da1f84a85165703e3b6be4a240bd36d62b4b01.1553006268.git.gitgitgadget@gmail.com>
 <CAPig+cTC0AmJyU7D=f9VAGOOwJpk+aMe95MDqiiCqMdU5-kk+A@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fbb2ce21-18ce-3d1e-e6f6-907c8b9693d9@jeffhostetler.com>
Date:   Tue, 19 Mar 2019 14:33:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTC0AmJyU7D=f9VAGOOwJpk+aMe95MDqiiCqMdU5-kk+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/19/2019 12:42 PM, Eric Sunshine wrote:
> On Tue, Mar 19, 2019 at 10:37 AM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Add new start_sparse_progress() and start_delayed_sparse_progress()
>> constructors and "sparse" flag to struct progress.
>>
>> Teach stop_progress() to force a 100% complete progress message before
>> printing the final "done" message when "sparse" is set.
>>
>> Calling display_progress() for every item in a large set can
>> be expensive.  If callers try to filter this for performance
>> reasons, such as emitting every k-th item, progress would
>> not reach 100% unless they made a final call to display_progress()
>> with the item count before calling stop_progress().
>>
>> Now this is automatic when "sparse" is set.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>> diff --git a/progress.c b/progress.c
>> +/*
>> + * Here "sparse" means that the caller might use some sampling criteria to
>> + * decide when to call display_progress() rather than calling it for every
>> + * integer value in[0 .. total).  In particular, the caller might not call
>> + * display_progress() for the last value in the range.
>> + *
>> + * When "sparse" is set, stop_progress() will automatically force the done
>> + * message to show 100%.
>> + */
>> +static void finish_if_sparse(struct progress **p_progress)
>> +{
>> +       struct progress *progress = *p_progress;
>> +
>> +       if (progress &&
>> +           progress->sparse &&
>> +           progress->last_value != progress->total)
>> +               display_progress(progress, progress->total);
>>   }
> 
> There's no reason for this function to take a 'struct progress **'
> rather than the simpler 'struct progress *', and doing so just
> confuses the reader.

I was just trying to match the existing API in the stop_progress()
and stop_progress_msg() routines.  But yes, I can simplify this.

> 
>>   void stop_progress(struct progress **p_progress)
>>   {
>> +       finish_if_sparse(p_progress);
>> +
>>          stop_progress_msg(p_progress, _("done"));
>>   }
> 
> Rather than adding a new "sparse" mode, I wonder if this entire
> concept can be boiled down to a single new function:
> 
>      void finish_progress(struct progress **p_progress, const char *msg)
>      {
>          struct progress *progress = *p_progress;
>          if (progress && progress->last_value != progress->total)
>              display_progress(progress, progress->total);
>          if (msg)
>              stop_progress_msg(p_progress, msg);
>          else
>              stop_progress(p_progress);
>      }
> 
> without having to make any other changes to the implementation or add
> a new field to the structure.

The existing model has start_progress() and start_delayed_progress().
I was following that model and added the new option at the start.
I'm not planning on adding any additional flags, but if we had some
we'd want them available on the startup next to this one.


>                                It would mean, though, that the caller
> would have to remember to invoke finish_progress() rather than
> stop_progress().

Right, I was trying to isolate the change to the setup, so that loop
bottoms and any in-loop return points don't all have to worry about
whether to call stop_ or finish_.


>                   Which leads one to wonder why this functionality is
> needed at all since it's easy enough for a caller to make the one
> extra call to simulate this:
> 
>      /* client code */
>      if (progress)
>          display_progress(progress, progress->total);
>      stop_progress(&progress);
> 

"struct progress" is private and I didn't want to publish it just for
this.  And again as with the finish_ remarks, that leads to more
places that would need to be updated or maintained.

And you're right, callers could always just call:
	x = ...whatever...
	progress = start_progress(..., x);
	...loop or whatever...
	display_progress(progress, x);
	stop_progress(...);

but that puts the burden on the caller to keep a copy of "x"
that matches the original value so that we get the 100% message.
I was doing that for a while, but after 3 or 4 progress loops,
I found myself wanting the progress routines to handle that
bookkeeping for me.

Jeff

