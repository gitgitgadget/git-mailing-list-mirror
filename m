Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565F21F462
	for <e@80x24.org>; Tue, 28 May 2019 14:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE1O5w (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 10:57:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:42282 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfE1O5w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 10:57:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0FBA93F408A;
        Tue, 28 May 2019 10:57:51 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:e9b0:e9cc:d6de:e854] (unknown [IPv6:2001:4898:a800:1012:9ae4:e9cc:d6de:e854])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A06473F4083;
        Tue, 28 May 2019 10:57:50 -0400 (EDT)
Subject: Re: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.222.git.gitgitgadget@gmail.com>
 <20190521212744.GC14807@sigill.intra.peff.net>
 <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com>
 <20190523055108.GA20871@sigill.intra.peff.net>
 <CACsJy8D7w4sC_tchx-Q80PCiu+2hYfkZo22_Vb3vgJ+xvgUAAA@mail.gmail.com>
 <20190528062804.GE7946@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <47db8f30-846b-12d0-250e-4bccf1e19c45@jeffhostetler.com>
Date:   Tue, 28 May 2019 10:57:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528062804.GE7946@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/28/2019 2:28 AM, Jeff King wrote:
> On Sat, May 25, 2019 at 05:43:55PM +0700, Duy Nguyen wrote:
> 
>>> +typedef struct {
>>> +       void *data;
>>> +       /* extra indirection because setspecific is passed key by value */
>>> +       void **vdata;
>>
>> Ha! I was thinking a separate key->value mapping which is complicated
>> in C. But this works pretty well for a single thread, and it even
>> supports multiple keys.
> 
> I really wish that all of the functions passed the pthread_key_t by
> reference. That would make it possible to define the key as a single
> pointer.
> 
> I'm not sure if pthread_key_t's are meant to be shallow-copyable. I.e.,
> should this work:
> 
>    void foo(pthread_key_t *out)
>    {
> 	pthread_key_t tmp;
> 	pthread_key_create(&tmp, NULL);
> 	*out = tmp;
>    }
>    ...
>    pthread_key_t k;
>    foo(&k);
>    pthread_setspecific(k, some_ptr);
> 
> It does not with my proposed plan, because the pointer in tmp.data went
> out of scope, leaving tmp.vdata (and thus k.vdata) as a dangling
> pointer.
> 
> The code above seems like a vaguely crazy thing to do. But if we want to
> be absolutely paranoid, we'd have to malloc() an extra pointer in the
> create() function, instead of carrying it inside the key. Or just make a
> global "void *thread_specific_data[PTHREAD_KEYS_MAX]" and make each key
> an integer index into it.
> 
> It's pretty clear that they expect one of those two implementations,
> given that POSIX says key creation can report either ENOMEM, or EAGAIN
> if we exceed PTHREAD_KEYS_MAX. :)
> 
> -Peff
> 


Yes, a fixed global void* array should be fine.
Besides there aren't that many calls to pthread_key_create()  (My use in
Trace2 is the second, right?), so just create an arbitrary value for
PTHREAD_KEYS_MAX and be done.


Jeff
