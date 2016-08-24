Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239F21F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbcHXRl1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:41:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60579 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754521AbcHXRl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:41:26 -0400
Received: (qmail 13197 invoked by uid 109); 24 Aug 2016 17:41:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 17:41:25 +0000
Received: (qmail 4856 invoked by uid 111); 24 Aug 2016 17:41:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 13:41:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 13:41:22 -0400
Date:   Wed, 24 Aug 2016 13:41:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] release_delta_base_cache: reuse existing detach
 function
Message-ID: <20160824174122.372c7pi4ub5bxcat@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
 <20160822215758.uamavr7koin3ze6c@sigill.intra.peff.net>
 <xmqqwpj7tauc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpj7tauc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 02:49:15PM -0700, Junio C Hamano wrote:

> > diff --git a/sha1_file.c b/sha1_file.c
> > index 1d0810c..8264b39 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -2152,10 +2152,7 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
> >  {
> >  	if (ent->data) {
> >  		free(ent->data);
> > -		ent->data = NULL;
> > -		ent->lru.next->prev = ent->lru.prev;
> > -		ent->lru.prev->next = ent->lru.next;
> > -		delta_base_cached -= ent->size;
> > +		detach_delta_base_cache_entry(ent);
> 
> If we were designing this from scratch, we might have made detach_*
> to return the pointer to minimize direct access to ent->data, but I
> do not think it is worth it.  Looks very sensible.

I actually looked into that during the conversion in patch 2/7. I didn't
want to just return ent->data, because there are actually several bits
of information to "rescue" from the entry. So it looks more like:

  char *data = detach_delta_base_cache_entry(ent, NULL, NULL);
  free(data);

here, and

  data = detach_delta_base_cache_entry(ent, &type, &size);

in unpack_entry().

That is not too bad, I guess. I can switch it if you prefer that way.
Since there are only these two callers with two different sets of needs
(and the function is static), I just let them continue inspecting the
elements directly.

-Peff
