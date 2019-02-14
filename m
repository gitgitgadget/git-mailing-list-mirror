Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E681F453
	for <e@80x24.org>; Thu, 14 Feb 2019 04:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392256AbfBNEls (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 23:41:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:43634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727763AbfBNEls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 23:41:48 -0500
Received: (qmail 30447 invoked by uid 109); 14 Feb 2019 04:41:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 04:41:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6385 invoked by uid 111); 14 Feb 2019 04:41:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 23:41:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 23:41:46 -0500
Date:   Wed, 13 Feb 2019 23:41:46 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 04/31] pack-bitmap: replace sha1_to_hex
Message-ID: <20190214044145.GA19071@sigill.intra.peff.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-5-sandals@crustytoothpaste.net>
 <20190212063749.GC21872@sigill.intra.peff.net>
 <20190213000007.GG684736@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190213000007.GG684736@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 12:00:07AM +0000, brian m. carlson wrote:

> On Tue, Feb 12, 2019 at 01:37:49AM -0500, Jeff King wrote:
> > On Tue, Feb 12, 2019 at 01:22:29AM +0000, brian m. carlson wrote:
> > > -static uint32_t find_object_pos(const unsigned char *sha1)
> > > +static uint32_t find_object_pos(const unsigned char *hash)
> > 
> > Isn't this really just a "struct object_id"? Why don't we want to use
> > that here?
> > 
> > I suspect it may be partially because our khash is storing raw sha1s.
> > But shouldn't we also be converted that to store object_ids?
> 
> I think probably there are some more places that we could convert here.
> There may have been one or two places that weren't convertible because
> we ended up passing data from some sort of buffer around. I'll take
> another look.

Thanks. I don't want to derail you too much if you have a series of
other changes on top. And moving to "hash" here is a step in the right
direction. But if we can take it all the way to object_id while we're
looking at it, I think that's preferable.

> > >  	hash_pos = kh_put_sha1(index->bitmaps, stored->oid.hash, &ret);
> > 
> > This last line (which is actually from the previous patch) is going to
> > always truncate the stored data to 20 bytes, isn't it?
> 
> No, I don't think it does. The _sha1 variant stores pointers to unsigned
> char, while the _oid variant stores the entire struct object_id (not
> just a pointer to it). We don't care how much data the pointer points
> to.

Oh, you're right. I was thinking it actually stored the 20-byte
sequences, but I was just reading it wrong. Sorry for the confusion.

> > I think we need to define a kh_oid. We have the "set" version already in
> > oidset.[ch]; I think we need to make that more public.
> 
> I wrote this quite a bit before that code came in, which is probably why
> I didn't do that originally. I seem to recall last time I looked at this
> that there was some reason that hoisting this didn't work as I expected
> due to header include order, but I'll take a look and see if I can
> figure out a way to do this.

Great, thanks!

-Peff
