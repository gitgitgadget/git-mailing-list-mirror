Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BAC20985
	for <e@80x24.org>; Mon, 12 Sep 2016 21:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755344AbcILVqV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:46:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:42153 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752858AbcILVqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:46:19 -0400
Received: (qmail 1531 invoked by uid 109); 12 Sep 2016 21:46:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 21:46:18 +0000
Received: (qmail 16794 invoked by uid 111); 12 Sep 2016 21:46:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 17:46:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 17:46:12 -0400
Date:   Mon, 12 Sep 2016 17:46:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #03; Fri, 9)
Message-ID: <20160912214611.wz6uduf33os3iprq@sigill.intra.peff.net>
References: <xmqqoa3w8zco.fsf@gitster.mtv.corp.google.com>
 <20160912164616.vg33kldazuthff3d@sigill.intra.peff.net>
 <xmqqlgyx2aui.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgyx2aui.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 12:10:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I happened to notice today that this topic needs a minor tweak:
> >
> > -- >8 --
> > Subject: [PATCH] add_delta_base_cache: use list_for_each_safe
> >
> > We may remove elements from the list while we are iterating,
> > which requires using a second temporary pointer. Otherwise
> > stepping to the next element of the list might involve
> > looking at freed memory (which generally works in practice,
> > as we _just_ freed it, but of course is wrong to rely on;
> > valgrind notices it).
> 
> I failed to notice it, too.  Thanks.

After staring at this, I was wondering how the _original_ ever worked.
Because the problem is in the linked-list code, which I did not really
change (I switched it to LIST_HEAD(), but the code is equivalent).

The answer is that in the original, there was no free() in the original
code when we released an entry; it just went back to the (static) pool.

So the bug is in the conversion to hashmap, where we start allocating
(and freeing) the entries individually.

-Peff
