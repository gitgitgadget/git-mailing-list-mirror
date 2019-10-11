Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263A71F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfJKSFJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 14:05:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:46016 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728374AbfJKSFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 14:05:09 -0400
Received: (qmail 16090 invoked by uid 109); 11 Oct 2019 18:05:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 18:05:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3599 invoked by uid 111); 11 Oct 2019 18:08:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 14:08:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 14:05:07 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH 04/10] ewah/bitmap: always allocate 2 more words
Message-ID: <20191011180507.GB20601@sigill.intra.peff.net>
References: <20190913130226.7449-5-chriscool@tuxfamily.org>
 <20191010234040.168894-1-jonathantanmy@google.com>
 <CAP8UFD0-NHCj6KcbdMG3bCwWp=wUdoYugLggsbnpvr1d6-P4yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0-NHCj6KcbdMG3bCwWp=wUdoYugLggsbnpvr1d6-P4yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 09:49:53AM +0200, Christian Couder wrote:

> > I think this should be squashed with patch 3, adding to that commit
> > message "since word_alloc might be 0, we need to change the growth
> > function". (Or just make the minimum word_alloc be 1 or 32 or something
> > positive, if that's possible.)
> 
> Yeah, thank you for the suggestion. I still wonder why 2 is added
> instead of just 1 though.

Yeah, I think it should be squashed. I think it is not intentionally 2,
it is just that adding "1" to block makes sure we always make forward
progress. It could equally well be:

  self->word_alloc = block ? block * 2 : 1;

I think. Or probably this whole thing could be ALLOC_GROW(), as the
numbers aren't particularly important. I guess we need to make sure the
grown part is zero'd, so probably using alloc_nr() directly would make
more sense.

-Peff
