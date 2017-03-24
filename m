Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78DA1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbdCXRda (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:33:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:58340 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdCXRd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:33:28 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 92342845F5;
        Fri, 24 Mar 2017 13:33:26 -0400 (EDT)
Subject: Re: [PATCH] read-cache: call verify_hdr() in a background thread
To:     Jonathan Nieder <jrnieder@gmail.com>
References: <1490362071-46932-1-git-send-email-git@jeffhostetler.com>
 <1490362071-46932-2-git-send-email-git@jeffhostetler.com>
 <20170324163540.GB31294@aiede.mtv.corp.google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <23685f59-138f-51c8-61f4-6f46d153ff89@jeffhostetler.com>
Date:   Fri, 24 Mar 2017 13:33:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170324163540.GB31294@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/24/2017 12:35 PM, Jonathan Nieder wrote:
> git@jeffhostetler.com wrote:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teash do_read_index() in read-cache.c to call verify_hdr()
>...
> Nice.  Do you have example commands I can run to reproduce
> that benchmark?  (Even better if you can phrase that as a
> patch against t/perf/.)

I debated doing a t/perf and/or t/helper to demonstrate this
like I did for the lazy-init-name-hash changes the other day,
but decided against it.  I'll put together something and
include it in the next version.

>
> [...]
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1564,6 +1564,83 @@ static void post_read_index_from(struct index_state *istate)
>>  	tweak_untracked_cache(istate);
>>  }
>>
>> +#ifdef NO_PTHREADS
>> +
>> +struct verify_hdr_thread_data {
>> +	struct cache_header *hdr;
>> +	size_t size;
>
> 'size' appears to always be cast to an unsigned long when it's
> used.  Why not use unsigned long consistently?
>
>> +};
>> +
>> +/*
>> + * Non-threaded version does all the work immediately.
>> + * Returns < 0 on error or bad signature.
>> + */
>> +static int verify_hdr_start(struct verify_hdr_thread_data *d)
>> +{
>> +	return verify_hdr(d->hdr, (unsigned long)d->size);
>> +}
>> +
>> +static int verify_hdr_finish(struct verify_hdr_thread_data *d)
>> +{
>> +	return 0;
>> +}
>> +
>> +#else
>> +
>> +#include <pthread.h>
>
> Please put this at the top of the file with other #includes.  One
> simple way to do that is to #include "thread-utils.h" at the top of
> the file unconditionally.
>
>> +
>> +/*
>> + * Require index file to be larger than this threshold before
>> + * we bother using a background thread to verify the SHA.
>> + */
>> +#define VERIFY_HDR_THRESHOLD    (1024)
>
> nits: (1) no need for parens for a numerical macro like this
> (2) comment can be made briefer and more explicit:
>
> /*
>  * Index size threshold in bytes before it's worth bothering to
>  * use a background thread to verify the index file.
>  */
>
> How was this value chosen?

This was somewhat at random.  I'll update with the t/perf stuff.

>
>> +
>> +struct verify_hdr_thread_data {
>> +	pthread_t thread_id;
>> +	struct cache_header *hdr;
>> +	size_t size;
>> +	int result;
>> +};
>
> All structs are data.  Other parts of git seem to name this kind of
> callback cookie *_cb_data, so perhaps verify_hdr_cb_data?
>
> On the other hand this seems to also be used by the caller as a handle
> to the async verify_hdr process. Maybe verify_hdr_state?
>
> This seems to be doing something similar to the existing 'struct
> async' interface.  Could it use that instead, or does it incur too
> much overhead?  An advantage would be avoiding having to handle the
> NO_PTHREADS ifdef-ery.
>
>> +
>> +/*
>> + * Thread proc to run verify_hdr() computation in a background thread.
>> + */
>> +static void *verify_hdr_thread_proc(void *_data)
>
> Please don't name identifiers with a leading underscore --- those are
> reserved names.
>
>> +{
>> +	struct verify_hdr_thread_data *d = _data;
>> +	d->result = verify_hdr(d->hdr, (unsigned long)d->size);
>> +	return NULL;
>> +}

I was just modeling the code on what I saw in preload-index.c.
There the #ifdef side defines the trivial functions. Then the #else
and the #include, the struct thread_data, and then the
preload_thread(void *_data) function declaration.  But blame reports
that code dating back to 2008.  Is there an example of a newer
preferred style somewhere ?

>> +
>> +/*
>> + * Threaded version starts background thread and returns zero
>> + * to indicate that we don't know the hash is bad yet.  If the
>> + * index is too small, we just do the work imediately.
>> + */
>> +static int verify_hdr_start(struct verify_hdr_thread_data *d)
>
> This comment restates what the code says.  Is there background or
> something about the intent behind the code that could be said instead
> to help the reader?  Otherwise I'd suggest removing the comment.
>
> [...]
>
> What happens if there is an error before the code reaches the end of
> the function?  I think there needs to be a verify_hdr_finish call in
> the 'unmap:' cleanup section.

But the "unmap" section calls die().  Do need to join first ??
(It's OK if we do, just asking.)

>
> The rest looks reasonable.
>
> Thanks and hope that helps,
> Jonathan
>

Thanks,
Jeff
