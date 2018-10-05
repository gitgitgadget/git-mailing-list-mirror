Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543731F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeJFEsB (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:48:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:43994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725787AbeJFEsA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:48:00 -0400
Received: (qmail 30437 invoked by uid 109); 5 Oct 2018 21:47:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 21:47:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17225 invoked by uid 111); 5 Oct 2018 21:46:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 17:46:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 17:47:22 -0400
Date:   Fri, 5 Oct 2018 17:47:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
Message-ID: <20181005214721.GA12992@sigill.intra.peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
 <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
 <20181004220711.GA28287@sigill.intra.peff.net>
 <c75fa650-d2b4-9979-a1f2-25d75c6f447b@web.de>
 <20181005202737.GA22460@sigill.intra.peff.net>
 <a5a5b0c5-cc97-dc50-56dd-25ec64c03e48@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5a5b0c5-cc97-dc50-56dd-25ec64c03e48@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 11:22:31PM +0200, René Scharfe wrote:

> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 53914563b5..c0a1b80f4c 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -606,6 +606,12 @@ static void filter_refs(struct fetch_pack_args *args,
> >  			ref->match_status = REF_MATCHED;
> >  			*newtail = copy_ref(ref);
> >  			newtail = &(*newtail)->next;
> > +			/*
> > +			 * No need to update tip_oids with ref->old_oid; we got
> > +			 * here because either it was already there, or we are
> > +			 * in !strict mode, in which case we do not use
> > +			 * tip_oids at all.
> > +			 */
> >  		} else {
> >  			ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
> >  		}
> 
> This comment puzzles me -- why ask the question it answers?
> `tip_oids` has been loaded with all `refs` at that point; adding
> more seems odd.

If you think that tip_oids is a fast lookup for what's in newlist, then
I think it is a reasonable question to ask whether new additions to
newlist need the same treatment. That was what the comment in the
original lazy-load was answering.

> I feel the code needs be simplified further; not sure how, though,
> except perhaps by using the `unfound` array added in another reply.

I agree it's not the most clear code in the world, but we may be
reaching a point of diminishing returns in discussing it further.

-Peff
