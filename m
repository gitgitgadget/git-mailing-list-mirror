Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4DB1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 10:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeJQSJN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 14:09:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:43260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726964AbeJQSJN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 14:09:13 -0400
Received: (qmail 19939 invoked by uid 109); 17 Oct 2018 10:14:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 10:14:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19262 invoked by uid 111); 17 Oct 2018 10:13:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 06:13:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 06:14:12 -0400
Date:   Wed, 17 Oct 2018 06:14:12 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] pack-objects (mingw): initialize `packing_data`
 mutex in the correct spot
Message-ID: <20181017101411.GA12554@sigill.intra.peff.net>
References: <pull.47.git.gitgitgadget@gmail.com>
 <8979693922364ef2e4a84a29298b081e86fa9ffa.1539723766.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8979693922364ef2e4a84a29298b081e86fa9ffa.1539723766.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 02:02:52PM -0700, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 9ac3f0e5b3e4 (pack-objects: fix performance issues on packing large
> deltas, 2018-07-22), a mutex was introduced that is used to guard the
> call to set the delta size. This commit even added code to initialize
> it, but at an incorrect spot: in `init_threaded_search()`, while the
> call to `oe_set_delta_size()` (and hence to `packing_data_lock()`) can
> happen in the call chain `check_object()` <- `get_object_details()` <-
> `prepare_pack()` <- `cmd_pack_objects()`, which is long before the
> `prepare_pack()` function calls `ll_find_deltas()` (which initializes
> the threaded search).
> 
> Another tell-tale that the mutex was initialized in an incorrect spot is
> that the function to initialize it lives in builtin/, while the code
> that uses the mutex is defined in a libgit.a header file.
> 
> Let's use a more appropriate function: `prepare_packing_data()`, which
> not only lives in libgit.a, but *has* to be called before the
> `packing_data` struct is used that contains that mutex.

Nicely explained. I think this is a good solution.

Both before and after your patch, we do still take the lock even in
single-threaded scenarios (the case you found where we are not yet in
the delta search phase, but also when --threads=1). I think that should
be fine.  It looks like we do that with the other locks in
pack-objects.c already.

In index-pack.c, we check a threads_active flag before looking at the
lock, which could be another possible solution. I doubt it's any faster,
though (which is why I assume index-pack.c does it). Locking/unlocking a
mutex should not really be much slower than checking the conditional
flag in the first place.

Which is all a roundabout way of saying "looks good to me".

-Peff
