Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FA1C433E3
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 14:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0092078B
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 14:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHTOkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:40:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:40606 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHTOjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 10:39:53 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6800D3F4139;
        Thu, 20 Aug 2020 10:39:50 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 07F8E3F4127;
        Thu, 20 Aug 2020 10:39:49 -0400 (EDT)
Subject: Re: [RFC PATCH 11/21] parallel-checkout: make it truly parallel
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        jeffhost@microsoft.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Paul Tan <pyokagan@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
 <7e7527ef3e8a9e71a012f1623e9642c47f7f741c.1597093021.git.matheus.bernardino@usp.br>
 <f3291797-3ef1-8a2b-d6d5-394f3c32c83c@jeffhostetler.com>
 <CAHd-oW5QjLPmvRL0YojL=NiO-ciY7rNZkQuvCtnF-1vmR4ykKQ@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5327b0e3-fdaa-11e1-f7da-832eb988555e@jeffhostetler.com>
Date:   Thu, 20 Aug 2020 10:39:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW5QjLPmvRL0YojL=NiO-ciY7rNZkQuvCtnF-1vmR4ykKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/19/20 9:33 PM, Matheus Tavares Bernardino wrote:
> On Wed, Aug 19, 2020 at 6:34 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>> On 8/10/20 5:33 PM, Matheus Tavares wrote:
>>>
>>> +static struct child_process *setup_workers(struct checkout *state, int num_workers)
>>> +{
>>> +     struct child_process *workers;
>>> +     int i, workers_with_one_extra_item;
>>> +     size_t base_batch_size, next_to_assign = 0;
>>> +
>>> +     base_batch_size = parallel_checkout->nr / num_workers;
>>> +     workers_with_one_extra_item = parallel_checkout->nr % num_workers;
>>> +     ALLOC_ARRAY(workers, num_workers);
>>> +
>>> +     for (i = 0; i < num_workers; ++i) {
>>> +             struct child_process *cp = &workers[i];
>>> +             size_t batch_size = base_batch_size;
>>> +
>>> +             child_process_init(cp);
>>> +             cp->git_cmd = 1;
>>> +             cp->in = -1;
>>> +             cp->out = -1;
>>> +             strvec_push(&cp->args, "checkout--helper");
>>> +             if (state->base_dir_len)
>>> +                     strvec_pushf(&cp->args, "--prefix=%s", state->base_dir);
>>> +             if (start_command(cp))
>>> +                     die(_("failed to spawn checkout worker"));
>>
>> We should consider splitting this loop into one to start the helpers
>> and another loop to later send them their assignments.  This would
>> better hide the process startup costs.
>>
>> When comparing this version with my pc-p4-core branch on Windows,
>> I was seeing a delay of 0.8 seconds between each helper process
>> getting started.  And on my version a delay of 0.2 between them.
>>
>> I was testing with a huge repo and the batch size was ~200k, so it
>> foreground process was stuck in send_batch() for a while before it
>> could start the next helper process.
>>
>> It still takes the same amount of time to send each batch, but
>> the 2nd thru nth helpers can be starting while we are sending the
>> batch to the 1st helper.  (This might just be a Windows issue because
>> of how slow process creation is on Windows....)
> 
> Thanks for the explanation. I will split the loop in v2.
> 
>> We could maybe also save a little time splitting the batches
>> across the helpers, but that's a refinement for later...
>>
>>> +
>>> +             /* distribute the extra work evenly */
>>> +             if (i < workers_with_one_extra_item)
>>> +                     batch_size++;
>>> +
>>> +             send_batch(cp->in, next_to_assign, batch_size);
>>> +             next_to_assign += batch_size;
>>>        }
>>>
>>> +     return workers;
>>> +}
>>> +
>>> +static void finish_workers(struct child_process *workers, int num_workers)
>>> +{
>>> +     int i;
>>> +     for (i = 0; i < num_workers; ++i) {
>>> +             struct child_process *w = &workers[i];
>>> +             if (w->in >= 0)
>>> +                     close(w->in);
>>> +             if (w->out >= 0)
>>> +                     close(w->out);
>>
>> You might also consider splitting this loop too.  The net-net here
>> is that the foreground process closes the handle to the child and
>> waits for the child to exit -- which it will because it get EOF on
>> its stdin.
>>
>> But the foreground process is stuck in a wait() for it to do so.
>>
>> You could make finish_workers() just call close() on all the child
>> handles and then have an atexit() handler to actually wait() and
>> reap them.  This would let the children exit asynchronously (while
>> the caller here in the foreground process is updating the index
>> on disk, for example).
> 
> Makes sense, thanks. And I think we could achieve this by setting both
> `clean_on_exit` and `wait_after_clean` on the child_process struct,
> right? (BTW, I have just noticed that we probably want these flags set
> for another reason too: we wouldn't want the workers to keep checking
> out files if the main process was killed.)
> 
> Maybe the downside of using the atexit() handler, instead of calling
> finish_command(), would be that we cannot free the `workers` array
> when cleaning up parallel-checkout, right? Also, we wouldn't be able
> to report an error if the worker ends with an error code (but at this
> point it would have already sent all the results to the foreground
> process, anyway).
> 
> Do you think that we can mitigate the wait() cost by just splitting
> the loop in two, like we are going to do in setup_workers()?

Yeah, I was thinking about that after I hit send, that it'd be simpler
to do a close loop and then a wait loop and not bother with the atexit
complexity and yet get us most of the gains.

> 
>>
>>> +             if (finish_command(w))
>>> +                     die(_("checkout worker finished with error"));
>>> +     }
>>> +     free(workers);
>>> +}
