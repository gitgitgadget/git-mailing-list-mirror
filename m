Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2E91F453
	for <e@80x24.org>; Thu, 14 Feb 2019 06:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390641AbfBNGG7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 01:06:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:43798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726407AbfBNGG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 01:06:59 -0500
Received: (qmail 1759 invoked by uid 109); 14 Feb 2019 06:06:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 06:06:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7205 invoked by uid 111); 14 Feb 2019 06:07:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 01:07:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 01:06:57 -0500
Date:   Thu, 14 Feb 2019 01:06:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: [RFC PATCH] pack-refs: fail on falsely sorted packed-refs
Message-ID: <20190214060657.GA20997@sigill.intra.peff.net>
References: <20190130231359.23978-1-max@max630.net>
 <87lg2kj91a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg2kj91a.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 11:08:01AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I happened to have a not really sorted packed-refs file. As you might guess,
> > it was quite wtf-ing experience. It worked, mostly, but there was one branch
> > which just did not resolve, regardless of existing and being presented in
> > for-each-refs output.
> >
> > I don't know where the corruption came from. I should admit it could even be a manual
> > editing but last time I did it (in that reporitory) was several years ago so it is unlikely.
> >
> > I am not sure what should be the proper fix. I did a minimal detection, so that
> > it does not go unnoticed. Probably next step would be either fixing in `git fsck` call.
> >
> >  refs/packed-backend.c               | 15 +++++++++++++++
> >  t/t3212-pack-refs-broken-sorting.sh | 26 ++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >  create mode 100755 t/t3212-pack-refs-broken-sorting.sh
> 
> This is not an area I'm very familiar with. So mostly commeting on
> cosmetic issues with the patch. FWIW the "years back" issue you had
> could be that an issue didn't manifest until now, i.e. in a sorted file
> format you can get lucky and not see corruption for a while with a
> random insert.

It actually shouldn't be that old a breakage. Until 02b920f3f7
(read_packed_refs(): ensure that references are ordered when read,
2017-09-25), we did not assume the file was sorted (even though we
always wrote it out sorted). And we continue to not assume the file is
sorted unless it is written out with an explicit "sorted" trait in the
header (which we started doing in that commit, too).

So a years-old manual edit would not have the "sorted" trait, and should
not have manifested as a problem, even now.  Likewise for a years-old
bug. It would have to be a bug in a _new_ writer which writes out the
sorted trait.  If there is such a bug in our implementation, this would
be the first report we've seen. Given the number of times pack-refs has
been run, without further evidence I'm inclined to think it was some
weird manual edit, or maybe an alternate implementation (though one
would _hope_ they would not write out the sorted trait without actually
sorting!).

I agree with all of the cosmetic issues you mentioned. As far as what
the patch itself does, I think it's OK. We could probably go further and
actually sort it (or even just write it out without a "sorted" trait,
which means the next read would load it all into memory and sort it).
That's a little friendlier, since just dying leaves the user to fix it
up themselves. But given that we expect this code to trigger
approximately never, it's probably not worth spending much time on a
fancy solution.

-Peff
