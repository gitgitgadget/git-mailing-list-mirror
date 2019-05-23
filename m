Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23F91F462
	for <e@80x24.org>; Thu, 23 May 2019 13:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfEWNzQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 09:55:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:40865 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWNzP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 09:55:15 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CDC743F4088;
        Thu, 23 May 2019 09:55:13 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7FD853F404C;
        Thu, 23 May 2019 09:55:13 -0400 (EDT)
Subject: Re: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <pull.222.git.gitgitgadget@gmail.com>
 <20190521212744.GC14807@sigill.intra.peff.net>
 <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com>
 <20190523055108.GA20871@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <50badedb-7856-374e-b14c-1eb1951c63f0@jeffhostetler.com>
Date:   Thu, 23 May 2019 09:55:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190523055108.GA20871@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/23/2019 1:51 AM, Jeff King wrote:
> On Wed, May 22, 2019 at 09:23:39AM -0400, Jeff Hostetler wrote:
> 
>> I was wondering about that too as the proper long term solution.
>> We would need (as the discussion suggests [1]) to properly
>> respect/represent the pthread_key_t argument.
>>
>> For now, I've guarded my usage of pthread_getspecific() in the trace2
>> (similar to what index-pack does), so its not urgent that we update it.
>> And I'd rather we take this simple trace2 fix now and not try to combine
>> it with fixes for the pthread macros.  Especially now as we're in the RC
>> cycle for 2.22.
> 
> Yeah, I think that makes sense.
> 
>> I'll make a note to revisit the pthread code after 2.22.
> 
> For fun, here's a constant-time zero-allocation implementation that I
> came up with. It passes t0211 with NO_PTHREADS, but I didn't test it
> beyond that.
> 
> diff --git a/thread-utils.h b/thread-utils.h
> index 4961487ed9..f466215742 100644
> --- a/thread-utils.h
> +++ b/thread-utils.h
> @@ -18,7 +18,7 @@
>   #define pthread_t int
>   #define pthread_mutex_t int
>   #define pthread_cond_t int
> -#define pthread_key_t int
> +#define pthread_key_t git_pthread_key_t
>   
>   #define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
>   #define pthread_mutex_lock(mutex)
> @@ -31,16 +31,49 @@
>   #define pthread_cond_broadcast(cond)
>   #define pthread_cond_destroy(cond)
>   
> -#define pthread_key_create(key, attr) dummy_pthread_init(key)
> -#define pthread_key_delete(key)
> +#define pthread_key_create(key, destroy) git_pthread_key_create(key, destroy)
> +#define pthread_key_delete(key) git_pthread_key_delete(key)
>   
>   #define pthread_create(thread, attr, fn, data) \
>   	dummy_pthread_create(thread, attr, fn, data)
>   #define pthread_join(thread, retval) \
>   	dummy_pthread_join(thread, retval)
>   
> -#define pthread_setspecific(key, data)
> -#define pthread_getspecific(key) NULL
> +#define pthread_setspecific(key, data) git_pthread_setspecific(key, data)
> +#define pthread_getspecific(key) git_pthread_getspecific(key)
> +
> +typedef struct {
> +	void *data;
> +	/* extra indirection because setspecific is passed key by value */
> +	void **vdata;
> +} git_pthread_key_t;
> +
> +static inline int git_pthread_key_create(git_pthread_key_t *key,
> +					 void (*destroy)(void *))
> +{
> +	key->data = NULL;
> +	key->vdata = &key->data;
> +	/* We don't use this; alternatively we could all via atexit(). */
> +	if (destroy)
> +		BUG("NO_PTHREADS does not support pthread key destructors");
> +	return 0;
> +}
> +
> +static inline int git_pthread_key_delete(git_pthread_key_t key)
> +{
> +	/* noop */
> +	return 0;
> +}
> +
> +static inline void git_pthread_setspecific(git_pthread_key_t key, void *data)
> +{
> +	*(key.vdata) = data;
> +}
> +
> +static inline void *git_pthread_getspecific(git_pthread_key_t key)
> +{
> +	return key.data;
> +}
>   
>   int dummy_pthread_create(pthread_t *pthread, const void *attr,
>   			 void *(*fn)(void *), void *data);
> 

Thanks!  I'll play with this and submit something after 2.22 and
things slow down a bit.

Jeff

