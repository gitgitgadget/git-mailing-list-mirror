Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E64208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbdHOTub (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:50:31 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:32103 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752757AbdHOTua (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:50:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3xX3450kfGz5tlC;
        Tue, 15 Aug 2017 21:50:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 982D7135;
        Tue, 15 Aug 2017 21:50:28 +0200 (CEST)
Subject: Re: [PATCH 2/5] pack-objects: take lock before accessing `remaining`
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
 <5815ea4f27226b604751961c8b70355a8925f0c5.1502780344.git.martin.agren@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <88ddf942-d7e4-ef1c-3f9c-9816d0571502@kdbg.org>
Date:   Tue, 15 Aug 2017 21:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5815ea4f27226b604751961c8b70355a8925f0c5.1502780344.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.08.2017 um 14:53 schrieb Martin Ågren:
> When checking the conditional of "while (me->remaining)", we did not
> hold the lock. Calling find_deltas would still be safe, since it checks
> "remaining" (after taking the lock) and is able to handle all values. In
> fact, this could (currently) not trigger any bug: a bug could happen if
> `remaining` transitioning from zero to non-zero races with the evaluation
> of the while-condition, but these are always separated by the
> data_ready-mechanism.
> 
> Make sure we have the lock when we read `remaining`. This does mean we
> release it just so that find_deltas can take it immediately again. We
> could tweak the contract so that the lock should be taken before calling
> find_deltas, but let's defer that until someone can actually show that
> "unlock+lock" has a measurable negative impact.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> I don't think this corrects any real error. The benefits of this patch
> would be "future-proofs things slightly" and "silences tsan, so that
> other errors don't drown in noise". Feel free to tell me those benefits
> are negligible and that this change actually hurts.
> 
>   builtin/pack-objects.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c753e9237..bd391e97a 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2170,7 +2170,10 @@ static void *threaded_find_deltas(void *arg)
>   {
>   	struct thread_params *me = arg;
>   
> +	progress_lock();
>   	while (me->remaining) {
> +		progress_unlock();
> +
>   		find_deltas(me->list, &me->remaining,
>   			    me->window, me->depth, me->processed);
>   
> @@ -2192,7 +2195,10 @@ static void *threaded_find_deltas(void *arg)
>   			pthread_cond_wait(&me->cond, &me->mutex);
>   		me->data_ready = 0;
>   		pthread_mutex_unlock(&me->mutex);
> +
> +		progress_lock();
>   	}
> +	progress_unlock();
>   	/* leave ->working 1 so that this doesn't get more work assigned */
>   	return NULL;
>   }
> 

It is correct that this access of me->remaining requires a lock. It 
could be solved in the way you did. I tried to do it differently, but 
all cleaner solutions that I can think of are overkill...

-- Hannes
