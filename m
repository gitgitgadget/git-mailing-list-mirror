Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4839211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 09:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeLFJa7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 04:30:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:60820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727575AbeLFJa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 04:30:59 -0500
Received: (qmail 10136 invoked by uid 109); 6 Dec 2018 09:30:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Dec 2018 09:30:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7748 invoked by uid 111); 6 Dec 2018 09:30:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Dec 2018 04:30:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2018 04:30:34 -0500
Date:   Thu, 6 Dec 2018 04:30:34 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Coiner, John" <John.Coiner@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
Message-ID: <20181206093034.GC31335@sigill.intra.peff.net>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
 <20181205210104.GC19936@sigill.intra.peff.net>
 <xmqqwoona2c6.fsf@gitster-ct.c.googlers.com>
 <20181206072002.GA29787@sigill.intra.peff.net>
 <8736rbypy3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736rbypy3.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 10:17:24AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > The other major user of that feature I can think of is LFS. There Git
> > ends up diffing the LFS pointers, not the big files. Which arguably is
> > the wrong thing (you'd prefer to see the actual file contents diffed),
> > but I think nobody cares in practice because large files generally don't
> > have readable diffs anyway.
> 
> I don't use this either, but I can imagine people who use binary files
> via clean/smudge would be well served by dumping out textual metadata of
> the file for diffing instead of showing nothing.
> 
> E.g. for a video file I might imagine having lines like:
> 
>     duration-seconds: 123
>     camera-model: Shiny Thingamabob
> 
> Then when you check in a new file your "git diff" will show (using
> normal diff view) that:
> 
>    - duration-seconds: 123
>    + duration-seconds: 321
>     camera-model: Shiny Thingamabob

I think that's orthogonal to clean/smudge, though. Neither the in-repo
nor on-disk formats are going to show that kind of output. For that
you'd want a separate textconv filter (and fun fact: showing exif data
was actually the original use case for which I wrote textconv).

If you are using something like LFS, using textconv on top is a little
trickier, because we'd always feed the filter the LFS pointer file, not
the actual data contents. Doing the "reversal" that Junio suggested
would fix that. Or with the code as it is, you can simply define your
filter to convert the LFS pointer data into the real content. I don't
really use LFS, but it looks like:

  [diff "mp4"]
  textconv = git lfs smudge | extract-metadata

would probably work.

-Peff
