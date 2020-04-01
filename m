Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F2C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 10:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D67214DB
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 10:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgDAKfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:35:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:58082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728087AbgDAKfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 06:35:23 -0400
Received: (qmail 1259 invoked by uid 109); 1 Apr 2020 10:35:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 10:35:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6838 invoked by uid 111); 1 Apr 2020 10:45:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 06:45:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 06:35:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: fast-import's hash table is slow
Message-ID: <20200401103522.GE60227@coredump.intra.peff.net>
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 09:14:58PM +0200, René Scharfe wrote:

> > nr_objects   master       patch
> > 2^20         0m04.317s    0m5.109s
> > 2^21         0m10.204s    0m9.702s
> > 2^22         0m27.159s    0m17.911s
> > 2^23         1m19.038s    0m35.080s
> > 2^24         4m18.766s    1m10.233s
> 
> I get similar numbers.
> 
> Pre-sizing by putting this near the top of cmd_main() gets the time
> for 1M down to 4 seconds:
> 
> 	kh_resize_object_entry_set(&object_table, 1 << 18);
> 
> The more fair 1 << 16 does not cut it, the totally unfair 1 << 20 gives
> a small extra boost.

Good call. I can reproduce those results, too ("1 << 20" gives me a 12%
overall speedup). I'm surprised the growth isn't aggressive enough for
this early expansion to get lost in the noise.

> > +	/*
> > +	 * this cast works because we only look at the oid part of the entry,
> > +	 * and it comes first in the struct
> > +	 */
> > +	khiter_t pos = kh_get_object_entry_set(&object_table,
> > +					       (struct object_entry *)oid);
> 
> Dirty, but I can believe the comment.

Our hashmap.c implementation gets around this by letting the equality
function take an extra parameter. It's annoying when you're writing
those functions, but it should allow this case without any casting (or
preemptively allocating a struct).

> > -	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
> > -		struct object_entry *e;
> > -
> > -		for (e = object_table[h]; e; e = e->next)
> > +	for (iter = kh_begin(&object_table); iter != kh_end(&object_table); iter++) {
> > +		if (kh_exist(&object_table, iter)) {
> > +			struct object_entry *e = kh_key(&object_table, iter);
> >  			if (e->pack_id == id)
> >  				e->pack_id = MAX_PACK_ID;
> > +		}
> >  	}
> 
> Is this really the best way to handle that, independently of the hashmap
> that's used?  I wonder how an extra hashmap or set of valid pack_id
> values (or set of invalidated pack_id values?) would fare against having
> to touch all object entries here.

I think the invalidation is pretty infrequent. It only gets called by
end_packfile() when there are few enough objects to loosen them. So
usually that would only happen once per process. You can also trigger it
manually with a "checkpoint" command, but if you're checkpointing often
enough to dump loose objects, I suspect you have other performance
problems.

-Peff
