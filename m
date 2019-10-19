Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021E91F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 23:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfJSXXY (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 19:23:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:53096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726143AbfJSXXY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 19:23:24 -0400
Received: (qmail 20455 invoked by uid 109); 19 Oct 2019 23:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 Oct 2019 23:23:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27056 invoked by uid 111); 19 Oct 2019 23:26:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Oct 2019 19:26:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 19 Oct 2019 19:23:23 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 9/9] pack-objects: improve partial packfile reuse
Message-ID: <20191019232322.GB32408@sigill.intra.peff.net>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
 <20191019103531.23274-10-chriscool@tuxfamily.org>
 <6e4ad9bb-20d7-4ae5-8768-326f5c455c3c@iee.email>
 <CAP8UFD2rsZj3=KoPCEWw2sTXFhNkynrJLeAGWK2vEbD5GU8chA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2rsZj3=KoPCEWw2sTXFhNkynrJLeAGWK2vEbD5GU8chA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 19, 2019 at 09:20:11PM +0200, Christian Couder wrote:

> > > +static void write_reused_pack_one(size_t pos, struct hashfile *out,
> > > +                               struct pack_window **w_curs)
> > > +{
> > > +     off_t offset, next, cur;
> > > +     enum object_type type;
> > > +     unsigned long size;
> >
> > Is this a mem_sized size or a counter for less that 4GiB items?
> 
> What I can see is that `&size` is passed as the last argument to
> unpack_object_header() below. And unpack_object_header() is defined in
> packfile.h like this:
> 
> int unpack_object_header(struct packed_git *, struct pack_window **,
> off_t *, unsigned long *);
> 
> since at least 336226c259 (packfile.h: drop extern from function
> declarations, 2019-04-05)
> 
> So fixing this, if it needs to be fixed, should probably be part of a
> separate topic fixing unpack_object_header().

Yeah, this one definitely should be moved to whatever we used to
represent object sizes in the future (size_t, or I guess off_t if we
really want to handle huge objects on 32-bit systems too). But
definitely it shouldn't happen in this series, and I don't think anybody
interested in the other topic (converting the integer type for object
sizes) needs to keep tabs on it. When they convert
unpack_object_header(), the compiler will complain because of passing
it as a pointer (the more insidious ones will be where we return an
unsigned long to represent an object type, and somebody will have to
look into every caller).

-Peff
