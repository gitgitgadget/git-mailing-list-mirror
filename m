Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E895D20248
	for <e@80x24.org>; Wed, 13 Mar 2019 15:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfCMPkm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 11:40:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:48882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727123AbfCMPkl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 11:40:41 -0400
Received: (qmail 15996 invoked by uid 109); 13 Mar 2019 15:40:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 15:40:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11585 invoked by uid 111); 13 Mar 2019 15:39:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 11:39:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 11:39:24 -0400
Date:   Wed, 13 Mar 2019 11:39:24 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
Message-ID: <20190313153923.GC24101@sigill.intra.peff.net>
References: <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
 <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
 <20190311182328.GB16865@sigill.intra.peff.net>
 <xmqqa7i0h7r6.fsf@gitster-ct.c.googlers.com>
 <20190312105159.GB2023@sigill.intra.peff.net>
 <7435b80b-6bd7-cab9-c646-5c81b639f117@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7435b80b-6bd7-cab9-c646-5c81b639f117@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 12:47:51PM +0100, Thomas Braun wrote:

> > Reading Thomas's email again, that might actually have been what he was
> > recommending. If so, sorry for the confusion. And I agree that's a valid
> > solution.
> 
> Yes that is what I tried to explain. Looks like it was lost in translation.

I think the problem was on the reading end. :)

> > That said, I do wonder at some point if there's a huge value in using a
> > submodule at that point. I think there is if the dependent project is
> > large (and if it's optional, and some people might not need it). But in
> > this case, it is not a big deal to just carry the sha1dc code in-tree.
> 
> A big win with submodules is that you have separate histories and can,
> quite easily, update to newer versions without manual copying.

True. We'd generally be picking up snapshots in our in-tree sha1dc/, so
bisecting on it is not as fine-grained. We _could_ pull in the full
history using something like git-subtree, but that comes with its own
complications.

> One grievance with submodules is the URL switching if you need to go
> with a forked repo for some time and then back to the original.
> Is it possible to have multiple remotes for a submodule?
> 
> Something like:
> 
> [submodule "libfoo"]
> 	path = include/foo
> 	url1 = git://foo.com/upstream/lib.git
> 	url2 = git://foo.com/myFork/lib.git
> 
> With that the error prone git submodule sync step is not required anymore.

I assume you'd fetch from _all_ of them during a fetch, and assume that
one of them will get you the objects you need (or I guess if you are
looking for a specific object, you'd try them one at a time until you
get the object).

That makes sense, though it might be kind of annoying when fetching is
expensive (especially if it involves manually authenticating).

> submodule.alternateLocation looks like it is going into the right direction.

I think that's mostly about pointing back to the superproject for local
storage. Though I think there's a pretty reasonable solution to the
problem we're discussing there: git.git could carry a "sha1dc" branch
that points to our modified submodule history. So it's "in-tree" in the
sense that that it is in our repo, and under our full control, but still
managed like a submodule.

And we'd probably not even duplicate a lot of storage in the actual
clone of the upstream project, because it would be pointing to us as an
alternate.

-Peff
