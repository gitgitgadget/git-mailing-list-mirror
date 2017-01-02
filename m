Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B14205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 18:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933746AbdABSXV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 13:23:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:34340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756508AbdABSW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 13:22:29 -0500
Received: (qmail 25381 invoked by uid 109); 2 Jan 2017 18:22:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 18:22:28 +0000
Received: (qmail 18762 invoked by uid 111); 2 Jan 2017 18:23:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 13:23:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jan 2017 13:22:26 -0500
Date:   Mon, 2 Jan 2017 13:22:26 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 14/17] sha1_file: introduce an nth_packed_object_oid
 function
Message-ID: <20170102182226.6ddpmhmng2cqf4wf@sigill.intra.peff.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
 <20170101191847.564741-15-sandals@crustytoothpaste.net>
 <8c205558-928d-42ac-d401-e73e19c96030@alum.mit.edu>
 <20170102170902.6g6bxvaanewxzm2v@sigill.intra.peff.net>
 <eb8a3dad-9ca7-e0e6-3c31-9cd2e02e0bf9@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb8a3dad-9ca7-e0e6-3c31-9cd2e02e0bf9@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 02, 2017 at 07:18:58PM +0100, Michael Haggerty wrote:

> > Given that this patch only converts one caller, I'd be more inclined to
> > just have the caller do its own hashcpy. Like:
> > 
> > diff --git a/sha1_file.c b/sha1_file.c
> > index 1173071859..16345688b5 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -3769,12 +3769,14 @@ static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn c
> >  
> >  	for (i = 0; i < p->num_objects; i++) {
> >  		const unsigned char *sha1 = nth_packed_object_sha1(p, i);
> > +		struct object_id oid;
> >  
> >  		if (!sha1)
> >  			return error("unable to get sha1 of object %u in %s",
> >  				     i, p->pack_name);
> >  
> > -		r = cb(sha1, p, i, data);
> > +		hashcpy(oid.hash, sha1);
> > +		r = cb(&oid, p, i, data);
> >  		if (r)
> >  			break;
> >  	}
> > 
> > That punts on the issue for all the other callers, but like I said, I'm
> > not quite sure if, when, and how it would make sense to convert them to
> > using a "struct oid".
> 
> Your change is not safe if any of the callback functions ("cb") tuck
> away a copy of the pointer that they are passed, expecting it to contain
> the same object id later.

I think it's generally a given that callback functions should not assume
the lifetime of parameters extend beyond the end of the callback. That
said, I didn't audit the callers (although I'm pretty sure I wrote all
of them myself in this particular case).

-Peff
