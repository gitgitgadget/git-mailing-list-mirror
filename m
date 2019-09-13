Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URI_HEX shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A38C1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 05:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfIMFME (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 01:12:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:48928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725868AbfIMFME (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 01:12:04 -0400
Received: (qmail 24491 invoked by uid 109); 13 Sep 2019 05:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Sep 2019 05:12:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14615 invoked by uid 111); 13 Sep 2019 05:14:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2019 01:14:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Sep 2019 01:12:03 -0400
From:   Jeff King <peff@peff.net>
To:     Diomidis Spinellis <dds@aueb.gr>
Cc:     git@vger.kernel.org
Subject: Re: Patching Git to handle dates before the Unix epoch
Message-ID: <20190913051203.GB28353@sigill.intra.peff.net>
References: <c12e3505-7a02-3eaf-7d71-57a3b4df28d1@aueb.gr>
 <20190910162629.GA12758@sigill.intra.peff.net>
 <7a9fdb7d-265f-a877-1a5d-619890910340@aueb.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a9fdb7d-265f-a877-1a5d-619890910340@aueb.gr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 08:19:49PM +0300, Diomidis Spinellis wrote:

> > > - Can you think of any non-obvious issues (e.g. backward compatibility,
> > > switch to the Gregorian calendar) I should be aware of?
> > 
> > The big question is: what will existing implementations do with a commit
> > object that contains a negative timestamp?
> 
> Negative timestamps can already be created, because some Git libraries can
> create such objects, and one can also create them by hand; see http://git.661346.n2.nabble.com/Back-dating-commits-way-back-for-constitution-git-tp5365303p5367657.html
> 
> Consequently, I don't think that worrying about how existing clients will
> handle such timestamps should be a big issue, as long as we don't break the
> handling of modern dates.

Yes, it's easy to create lots of things with git-hash-object, but that
doesn't mean we should be encouraging people (yet). :) That said, I
think the handling here is pretty favorable: if you're not using very
old timestamps, you won't see any problem. And if you do use them, the
old presentation code handles it pretty well. We'd probably want to warn
people that older versions of Git may complain when fsck-ing.

> > Here's how far I got working on this yesterday. It's quite messy, but
> > seems to work at least for basic tests like:
> 
> Amazing!  Given that you have made significant progress, I think it's best
> to leave it to you to complete it, right?

I was afraid you'd say that. :)

I did spend a few more minutes looking into it after the last email.
There's a rabbit hole of handling timestamp parsing where many cases are
not actually checking appropriately for errors. So I think we'd want to
deal with those sites, too, while we're touching parse_timestamp().

It's not clear to me yet how deep the rabbit hole of little fixes goes
(or how deep we need to go for this particular feature). So I hope to
return to it when I have time, but if you or anybody else would like to
poke at it in the meantime, be my guest.

-Peff
