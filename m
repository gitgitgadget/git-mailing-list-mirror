Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3A01F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbeGTS3Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:29:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:54264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733128AbeGTS3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:29:24 -0400
Received: (qmail 29472 invoked by uid 109); 20 Jul 2018 17:40:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 17:40:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30003 invoked by uid 111); 20 Jul 2018 17:40:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 13:40:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 13:40:04 -0400
Date:   Fri, 20 Jul 2018 13:40:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large
 deltas
Message-ID: <20180720174004.GA22486@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180720153943.575-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180720153943.575-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 05:39:43PM +0200, Nguyễn Thái Ngọc Duy wrote:

> Let's start with some background about oe_delta_size() and
> oe_set_delta_size(). If you already know, skip the next paragraph.
> 
> These two are added in 0aca34e826 (pack-objects: shrink delta_size
> field in struct object_entry - 2018-04-14) to help reduce 'struct
> object_entry' size. The delta size field in this struct is reduced to
> only contain max 2MB. So if any new delta is produced and larger than
> 2MB, it's dropped because we can't really save such a large size
> anywhere. Fallback is provided in case existingpackfiles already have
> large deltas, then we can retrieve it from the pack.

Minor nit, but isn't this 1MB (it was 2MB after one of your patches, but
I think v2.18.0 has 20 bits)?

> [...more commit message...]

Nicely explained overall.

> With this, we do not have to drop deltas in try_delta() anymore. Of
> course the downside is we use slightly more memory, even compared to
> 2.17.0. But since this is considered an uncommon case, a bit more
> memory consumption should not be a problem.

I wondered how common this might be. The easiest way to see the largest
delta sizes is:

  git cat-file --batch-all-objects \
               --batch-check='%(objectsize:disk) %(deltabase)' |
  grep -v 0000000000000000000000000000000000000000 |
  sort -rn | head

The biggest one in the kernel is ~300k. Which is about what I'd expect
for a normal source code repo. Even some private repos I have with a lot
of binary artifacts top out at about 3MB. So the new 32MB is probably
pretty unlikely to trigger, unless you really do have a bunch of huge
artifacts.

If you do, then more memory pressure isn't great. But as a relative
measure, the extra couple megabytes to store one 32-bit int per object
is probably fine.

> A note about thread synchronization. Since this code can be run in
> parallel during delta searching phase, we need a mutex. The realloc
> part in packlist_alloc() is not protected because it only happens
> during the object counting phase, which is always single-threaded.

Right, thanks for clarifying this here.

> The locking in oe_delta_size() could also be dropped if we make sure
> the pack->delta_size pointer assignment in oe_set_delta_size() is
> atomic. But let's keep the lock for now to be on the safe side. Lock
> contention should not be that high for this lock.

Yeah, I agree with this, now that we're not using the read_lock().

> [1] With a small tweak. 2.17.0 on 64-bit linux can hold 2^64 byte
>     deltas, which is absolutely insane. But windows builds, even
>     64-bit version, only hold 2^32. So reducing it to 2^32 should be
>     quite safe.

I'm not sure I completely agree with this. While 4GB deltas should be
pretty rare, the nice thing about 64-bit is that you never have to even
think about whether the variable is large enough. I think the 2^32
limitations on Windows are something we should be fixing in the long
term (though there it is even worse because it is not just deltas, but
entire objects).

> ---
>  I'm optimistic that the slowness on linux repo is lock contention
>  (because if it's not then I have no clue what is). So let's start
>  doing proper patches.

Me too, but I'd love to see more numbers from Elijah.

>  If we want a quick fix for 2.18.1. I suggest bumping up
>  OE_DELTA_SIZE_BITS like Elijah did in his second option. I don't
>  think it's safe to fast track this patch.

Also agreed.

> @@ -2278,6 +2274,8 @@ static void init_threaded_search(void)
>  	pthread_mutex_init(&cache_mutex, NULL);
>  	pthread_mutex_init(&progress_mutex, NULL);
>  	pthread_cond_init(&progress_cond, NULL);
> +	pthread_mutex_init(&to_pack.lock, NULL);
> +	to_pack.lock_initialized = 1;
>  	old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
>  }

This is new in this iteration. I guess this is to cover the case where
we are built with pthread support, but --threads=1?

Given that we no longer have to touch this lock during the realloc, is
it worth actually putting it into to_pack? Instead, we could keep it
local to pack-objects, alongside all the other locks (and use the
lock_mutex() helper which handles the single-thread case).

Your original patch had to copy the oe_* helpers into the file to handle
that. But I think we're essentially just locking the whole functions:

> @@ -330,20 +353,37 @@ static inline void oe_set_size(struct packing_data *pack,
>  static inline unsigned long oe_delta_size(struct packing_data *pack,
>  					  const struct object_entry *e)
>  {
> -	if (e->delta_size_valid)
> -		return e->delta_size_;
> -	return oe_size(pack, e);
> +	unsigned long size;
> +
> +	packing_data_lock(pack);
> +	if (pack->delta_size)
> +		size = pack->delta_size[e - pack->objects];
> +	else
> +		size = e->delta_size_;
> +	packing_data_unlock(pack);
> +	return size;
>  }

So could we just wrap that like:

  static inline DELTA_SIZE(struct object_entry *oe)
  {
	unsigned long ret;

	delta_lock();
	ret = oe_delta_size(&to_pack, oe);
	delta_unlock();

	return size;
  }

That makes the implementation of oe_delta_size() simpler, too, since
we'd be free to directly return.

(Yes, it's a little weird to keep the all-caps name for a non-macro. I'd
be fine downcasing it, though I think it still works to point out that
something funny and global is going on).

> [...]

The rest of the patch looks pretty sensible to me.

-Peff
