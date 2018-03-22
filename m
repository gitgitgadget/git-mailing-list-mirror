Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5E31FAE2
	for <e@80x24.org>; Thu, 22 Mar 2018 10:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeCVKBs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 06:01:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:38584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751753AbeCVKBr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 06:01:47 -0400
Received: (qmail 6915 invoked by uid 109); 22 Mar 2018 10:01:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Mar 2018 10:01:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18183 invoked by uid 111); 22 Mar 2018 10:02:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Mar 2018 06:02:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2018 06:01:45 -0400
Date:   Thu, 22 Mar 2018 06:01:45 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180322100145.GA21410@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <87tvt9xuel.fsf@evledraar.gmail.com>
 <20180322080740.GA28907@sigill.intra.peff.net>
 <CACsJy8AF0FYysw48Y1CKdAHs_zWN8raYaGXrKQ9OmeKS-XujLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AF0FYysw48Y1CKdAHs_zWN8raYaGXrKQ9OmeKS-XujLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 09:23:42AM +0100, Duy Nguyen wrote:

> > I wish you were right about the rarity, but it's unfortunately something
> > I have seen multiple times in the wild (and why I spent time optimizing
> > the many-packs case for pack-objects). Unfortunately I don't know how
> > often it actually comes up, because in theory running "git repack"
> > cleans it up without further ado. But after these patches, not so much.
> 
> It's good to know this case is real and I can start to fix it
> (assuming that the other concern about readability will not stop this
> series).
> 
> I think I'll try to fix this without involving repack. pack-objects
> can produce multiple packs, so if we have more than 16k pack files, we
> produce  one new pack per 16k old ones.

I suspect that's going to be hard given the structure of the code.

Could we perhaps just bump to an auxiliary storage in that case?  I.e.,
allocate the final index number to mean "look in this other table", and
then have another table of uint32 indices?

That would mean we can behave as we did previously, but just use a
little more memory in the uncommon >16k case.

-Peff
