Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F665202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 07:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdI0HKC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 03:10:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:51778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751136AbdI0HKB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 03:10:01 -0400
Received: (qmail 28103 invoked by uid 109); 27 Sep 2017 07:10:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 07:10:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12588 invoked by uid 111); 27 Sep 2017 07:10:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 03:10:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 03:09:59 -0400
Date:   Wed, 27 Sep 2017 03:09:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/7] prefer "!=" when checking read_in_full() result
Message-ID: <20170927070959.snjdfrunaybo2buc@sigill.intra.peff.net>
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
 <20170927060028.ehddn5zwf6v6jsvs@sigill.intra.peff.net>
 <xmqqr2us4ofw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2us4ofw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 03:59:15PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/csum-file.c b/csum-file.c
> > index a172199e44..2adae04073 100644
> > --- a/csum-file.c
> > +++ b/csum-file.c
> > @@ -19,7 +19,7 @@ static void flush(struct sha1file *f, const void *buf, unsigned int count)
> >  
> >  		if (ret < 0)
> >  			die_errno("%s: sha1 file read error", f->name);
> > -		if (ret < count)
> > +		if (ret != count)
> >  			die("%s: sha1 file truncated", f->name);
> 
> I personally find that this "ret < count" that comes after checking
> if ret is negative expresses what it is checking in a more natural
> way than "ret must be exactly count".
> 
> It is not a big deal, as either one needs to be read with an
> understanding that read_in_full() would read at most "count" bytes
> to see if the right condition is being checked to declare
> "truncated" anyway.  But I somehow find
> 
> 	ret = read up to count
> 	if (ret < 0)
> 		read failed
> 	if (ret < count)
> 		we failed to read as much as expected
> 
> a bit more natural.

I actually do, too, and I wouldn't terribly mind to drop these. Mostly I
didn't want people blindly copying only the second half. The fact that
the second condition is OK only because the first condition is present
is somewhat subtle.

I also wondered if this would shut up -Wsign-compare. But it doesn't
seem to complain about the originals, which kind of surprises me.

-Peff
