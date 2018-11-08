Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA321F453
	for <e@80x24.org>; Thu,  8 Nov 2018 12:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeKHViJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 16:38:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:44776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726252AbeKHViJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 16:38:09 -0500
Received: (qmail 24060 invoked by uid 109); 8 Nov 2018 12:02:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Nov 2018 12:02:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30183 invoked by uid 111); 8 Nov 2018 12:02:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Nov 2018 07:02:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2018 07:02:57 -0500
Date:   Thu, 8 Nov 2018 07:02:57 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181108120256.GA29432@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181107225524.GA119693@amazon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 07, 2018 at 10:55:24PM +0000, Geert Jansen wrote:

> On Mon, Oct 29, 2018 at 07:27:39PM -0400, Jeff King wrote:
> 
> > On Mon, Oct 29, 2018 at 08:36:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > >  * Re-roll my 4 patch series to include the patch you have in
> > >    <20181027093300.GA23974@sigill.intra.peff.net>
> > 
> > I don't think it's quite ready for inclusion as-is. I hope to brush it
> > up a bit, but I have quite a backlog of stuff to review, as well.
> 
> We're still quite keen to get this patch included. Is there anything I can do
> to help?

Yes, testing and review. :)

I won't send the series out just yet, as I suspect it could use another
read-through on my part. But if you want to peek at it or try some
timings, it's available at:

  https://github.com/peff/git jk/loose-cache

It's quite a bit bigger than the original patch, as some refactoring was
necessary to reuse the existing cache in alternate_object_directories.
I'm rather pleased with how it turned out; it unifies the handling of
alternates and the main object directory, which is a cleanup I've been
wanting to do for some time.

> Also I just re-read your comments on maximum cache size. I think you were
> arguing both sides of the equation and I wasn't sure where you'd ended up. :)
> A larger cache size potentially takes more time to fill up especially on NFS
> while a smaller cache size obviously would less effective. That said a small
> cache is still effective for the "clone" case where the repo is empty.

I ended up thinking that a large cache is going to be fine. So I didn't
even bother implementing a limit in my series, which makes things a bit
simpler (it's one less state to deal with).

Since it reuses the existing cache code, it's better in a few ways than
my earlier patch:

  1. If a program uses OBJECT_INFO_QUICK and prints abbreviated sha1s,
     we only have to load the cache once (I think fetch does this, but I
     didn't test it).

  2. The cache is filled one directory at a time, which avoids
     unnecessary work when there are only a few lookups.

  3. The cache is per-object-directory. So if a request can be filled
     without looking at an alternate, we avoid looking at the alternate.
     I doubt this matters much in practice (the case we care about is
     when we _don't_ have the object, and there you have to look
     everywhere).

The one thing I didn't implement is a config option to disable this.
That would be pretty easy to add. I don't think it's necessary, but it
would make testing before/after behavior easier if somebody thinks it's
slowing down their particular case.

> It also occurred to me that as a performance optimization your patch could read
> the the loose object directories in parallel using a thread pool. At least on
> Amazon EFS this should result in al almost linear performance increase. I'm not
> sure how much this would help for local file systems. In any case this may be
> best done as a follow-up patch (that I'd be happy to volunteer for).

Yeah, I suspect it could make things faster in some cases. But it also
implies filling all of the cache directories at once up front. The code
I have now tries to avoid unnecessary cache fills. But it would be
pretty easy to kick off a full fill.

I agree it would make more sense as a follow-up patch (and probably
controlled by a config option, since it likely only makes sense when you
have a really high-latency readdir).

-Peff
