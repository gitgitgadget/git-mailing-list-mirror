Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C141F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbeGWWdt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:33:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:56662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388088AbeGWWds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:33:48 -0400
Received: (qmail 12715 invoked by uid 109); 23 Jul 2018 21:30:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Jul 2018 21:30:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21528 invoked by uid 111); 23 Jul 2018 21:30:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 23 Jul 2018 17:30:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2018 17:30:40 -0400
Date:   Mon, 23 Jul 2018 17:30:40 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] pack-objects: fix performance issues on packing large
 deltas
Message-ID: <20180723213040.GA7870@sigill.intra.peff.net>
References: <20180720153943.575-1-pclouds@gmail.com>
 <20180722080421.12887-1-pclouds@gmail.com>
 <xmqq8t617rqv.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BskYdANe9HnuLj8sqa8hRqzSAQ+q11C8faJ-YBtA3Xeg@mail.gmail.com>
 <CACsJy8Cex0Uby-eBRBqc_ScZd=EnCV6e0ZuaZEmopGkrvhrBzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Cex0Uby-eBRBqc_ScZd=EnCV6e0ZuaZEmopGkrvhrBzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 08:49:59PM +0200, Duy Nguyen wrote:

> On Mon, Jul 23, 2018 at 8:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > I will have to study the thread dispatch code more to have a better
> > answer, unfortunately.
> 
> Well.. I thought I would need this weekend for this, but a quick look
> and ll_find_deltas() suggests that what we're doing is safe. At least
> you and Jeff are way to familiar with the delta window concept in
> pack-objects. So in multithread mode, we have a big list of all
> objects, then the list is cut in N sublists and each is owned entirely
> by one thread. Each thread then can slide a window over this sublist
> to search for the best delta.
> 
> Because of this partitioning, if trg_entry is being processed now, it
> will not be accessed by any other thread. It's owned by this thread
> and will be accessed again as src_entry when the next entry becomes
> the delta target in the same thread. As long as we don't access
> objects of another thread (and my v1 violates this) we should be ok.

Yes, that matches my knowledge of how this all works. And if it didn't,
I think the code would have been racy even _before_ your patches.

The only thing that this pack->delta_size approach is changing is that
managing that array needs to happen under lock, because it touches the
whole list.

And as long as we back-fill it from any arbitrary e->delta_size_, that
means that touching e->delta_size_ needs to be done under lock. That's
why I think keeping the individual valid flag in each entry makes the
most sense. Then whenever we overflow a particular e->delta_size_, we
don't have to care about anybody else's size.

Which I think is what your v2 patch is doing.

-Peff
