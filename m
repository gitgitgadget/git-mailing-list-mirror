Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833D91F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423919AbeCBKyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:54:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:44066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1423832AbeCBKyI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:54:08 -0500
Received: (qmail 7972 invoked by uid 109); 2 Mar 2018 10:54:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Mar 2018 10:54:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27245 invoked by uid 111); 2 Mar 2018 10:54:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 05:54:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 05:54:06 -0500
Date:   Fri, 2 Mar 2018 05:54:06 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Reduce pack-objects memory footprint?
Message-ID: <20180302105405.GD11074@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash>
 <CACsJy8AzP9HLc02LbSxBvNM6Dg4FsgRt57SgaNFyT5TBPRq-Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AzP9HLc02LbSxBvNM6Dg4FsgRt57SgaNFyT5TBPRq-Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 02, 2018 at 05:18:45PM +0700, Duy Nguyen wrote:

> On Wed, Feb 28, 2018 at 4:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > linux-2.6.git current has 6483999 objects. "git gc" on my poor laptop
> > consumes 1.7G out of 4G RAM, pushing lots of data to swap and making
> > all apps nearly unusuable (granted the problem is partly Linux I/O
> > scheduler too). So I wonder if we can reduce pack-objects memory
> > footprint a bit.
> 
> Next low hanging fruit item:
> 
> struct revindex_entry {
>         off_t offset;
>         unsigned int nr;
> };
> 
> We need on entry per object, so 6.5M objects * 16 bytes = 104 MB. If
> we break this struct apart and store two arrays of offset and nr in
> struct packed_git, we save 4 bytes per struct, 26 MB total.
> 
> It's getting low but every megabyte counts for me, and it does not
> look like breaking this struct will make horrible code (we recreate
> the struct at find_pack_revindex()) so I'm going to do this too unless
> someone objects. There will be slight performance regression due to
> cache effects, but hopefully it's ok.

Maybe you will prove me wrong, but I don't think splitting them is going
to work. The point of the revindex_entry is that we sort the (offset,nr)
tuple as a unit.

Or are you planning to sort it, and then copy the result into two
separate arrays? I think that would work, but it sounds kind of nasty
(arcane code, and extra CPU work for systems that don't care about the
26MB).

-Peff
