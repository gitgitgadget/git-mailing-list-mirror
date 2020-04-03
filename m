Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B83C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 12:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9767020737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 12:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403879AbgDCMOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:14:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:60444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2403852AbgDCMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 08:14:18 -0400
Received: (qmail 27075 invoked by uid 109); 3 Apr 2020 12:14:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 12:14:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18678 invoked by uid 111); 3 Apr 2020 12:24:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 08:24:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 08:14:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: fast-import's hash table is slow
Message-ID: <20200403121417.GB65799@coredump.intra.peff.net>
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
 <c0398484-15f4-e5c2-d229-82037094417c@web.de>
 <20200401102435.GD60227@coredump.intra.peff.net>
 <31a0efbe-8ab0-045a-fcab-3211c0d641f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31a0efbe-8ab0-045a-fcab-3211c0d641f6@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 02, 2020 at 08:40:58PM +0200, René Scharfe wrote:

> >> Storing the objects directly in the set and getting rid of new_object()
> >> could improve performance due to reduced dereferencing overhead -- or
> >> make it slower because more data has to be copied when the hashmap needs
> >> to grow.  Worth a shot.  Later.
> >
> > Yeah. I tried that, too, but it caused tons of test failures. Quite
> > possibly just a bug in my patch, which I did as quickly as possible. But
> > I think it performed about the same. Here it is for reference (though
> > you may be better off to start from scratch).
> 
> Tried that earlier, ran into failures as well.  I think the pointer
> returned from insert_object() is stored somewhere and still used after
> the next call, which could have invalidated it by a rehash.  E.g.
> insert_mark() seems to do that.

That doesn't surprise me. I didn't look very hard, but mostly just did
the minimum to see if it would work (and it didn't).

It could perhaps be overcome, and I certainly don't mind if you want to
dig further, but I'm happy enough with the hashmap solution.

> > Note the "this is OK to cast from oid to object_entry" comment is
> > leftover from the earlier attempt, but it probably _isn't_ OK. Even
> > though we don't do anything actionable on the non-oid bytes, they do get
> > passed by value, which could mean reading random bytes.
> 
> "Value" meaning pointer value when KHASH_INIT is give a pointer type,
> as was the case in the patch with that comment (unlike in the patch
> below).  So it should be OK there.

Right, I meant the comment no longer applies in the patch below, because
we're not using a pointer type anymore.

> > -	for (o = blocks; o; o = o->next_pool)
> > -		for (e = o->next_free; e-- != o->entries;)
> > +	for (iter = kh_begin(&object_table); iter != kh_end(&object_table); iter++) {
> > +		if (kh_exist(&object_table, iter)) {
> > +			e = &kh_key(&object_table, iter);
> >  			if (pack_id == e->pack_id)
> >  				*c++ = &e->idx;
> > +		}
> > +	}
> 
> The original code writes the objects in reverse order of their creation
> (LIFO), right?  Is that relevant?

Yeah, agreed this is another weakness of this approach.

> But anyway,  we need stable object locations anyway if their addresses are
> stored in other structs, as mentioned above.  Those pointers would have to
> be replaced by object_ids and pointer derefs by hashmap lookups.  Not a
> promising direction.

Agreed.

-Peff
