Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3717E1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 15:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfJBP5X (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 11:57:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:38084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727103AbfJBP5X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 11:57:23 -0400
Received: (qmail 25097 invoked by uid 109); 2 Oct 2019 15:57:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Oct 2019 15:57:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22997 invoked by uid 111); 2 Oct 2019 16:00:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2019 12:00:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Oct 2019 11:57:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
Message-ID: <20191002155721.GD6116@sigill.intra.peff.net>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
 <20190913130226.7449-11-chriscool@tuxfamily.org>
 <xmqq7e6bde4z.fsf@gitster-ct.c.googlers.com>
 <20190914020225.GB28422@sigill.intra.peff.net>
 <xmqqy2yrbmqu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2yrbmqu.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 08:06:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Sep 13, 2019 at 03:29:00PM -0700, Junio C Hamano wrote:
> >
> >> This comment has nothing to do with the change, but the way the
> >> patch is presented is quite hard to follow, in that the preimage or
> >> the common context lines do not help understand what the new code is
> >> doing at all ;-)
> >> 
> >> I'll come back to the remainder of the patch later.  Thanks.
> >
> > I applaud Christian's effort to tease it out into separate patches.
> 
> Ah, no question about it.  I have a suspicion that 10/10 alone may
> still be a bit too large a ball of wax, but with all the earlier
> preparatory steps are bite-sized and trivial to see how they are
> correct.
> 
> The "way the patch is presented" comment was not at all about what
> Christian did, but was about what the diff machinery computed when
> comparing the 9th step Christian created and the final step.  In its
> attempt to find and align common context lines, it ended up finding
> blank lines and almost nothing else in the earlier part of the
> patch, not just making it harder to read the new helper function
> (i.e. the best way to read record_reused_object(), for example, is
> to look only at '+' and ' ' lines, because the '-' lines are
> irrelevant), it also made it hard to see what got discarded.

Hmm, I see the early parts of this graduated to 'next'. I'm not sure
everything there is completely correct, though. E.g. I'm not sure of the
reasoning in df75281e78 (ewah/bitmap: always allocate 2 more words,
2019-09-13).

I think the "block+1" there is actually because "block" might be "0".
Prior to 2820ed171a (ewah/bitmap: introduce bitmap_word_alloc(),
2019-09-13) from the same series, that could never be the case because
we know that we always start with at least 32 allocated words. But after
that we _could_ start with an empty word array, and allocating "block *
2" would not make forward progress.

And then the "2 more words" thing is used as justification in the next
patch, 04a32d357f (pack-bitmap: don't rely on bitmap_git->reuse_objects,
2019-09-13). I won't say that there isn't some subtle dependency there,
but I certainly don't remember any logic like that at all. ;) So I think
it might bear a little more scrutiny.

I'm sorry for being so slow on giving it a more careful review. I was
traveling for work, then playing catch-up, and am now going on vacation.
So it might be a little while yet.

-Peff
