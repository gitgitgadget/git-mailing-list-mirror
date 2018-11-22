Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628FB1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391343AbeKWDHM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 22:07:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:48672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733000AbeKWDHL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 22:07:11 -0500
Received: (qmail 23781 invoked by uid 109); 22 Nov 2018 16:27:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 16:27:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23380 invoked by uid 111); 22 Nov 2018 16:26:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 11:26:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 11:27:05 -0500
Date:   Thu, 22 Nov 2018 11:27:05 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
Message-ID: <20181122162705.GE28192@sigill.intra.peff.net>
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
 <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <87k1l5zabd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1l5zabd.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 11:16:38AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > +test_expect_success 'log -G looks into binary files with textconv filter' '
> > +	rm -rf .git &&
> > +	git init &&
> > +	echo "* diff=bin" > .gitattributes &&
> > +	printf "a\0b" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git -c diff.bin.textconv=cat log -G a >actual &&
> > +	git log >expected &&
> > +	test_cmp actual expected
> > +'
> > +
> >  test_done
> 
> This patch seems like the wrong direction to me. In particular the
> assertion that "the concept of differences only makes sense for text
> files". That's just not true. This patch breaks this:

But "-G" is defined as "look for differences whose patch text contains
added/removed lines that match <regex>". We don't have patch text here,
let alone added/removed lines.

For binary files, "-Sfoo" is better defined. I think we _could_ define
"search for <pattern> in the added/removed bytes of a binary file".  But
I don't think that's what the current code does (it really does a line
diff on a binary file, which is likely to put tons of unchanged crap
into the "added and removed" lines, because the line divisions aren't
meaningful in the first place).

>     (
>         rm -rf /tmp/g-test &&
>         git init /tmp/g-test &&
>         cd /tmp/g-test &&
>         for i in {1..10}; do
>             echo "Always matching thensome 5" >file &&
>             printf "a thensome %d binary \0" $i >>file &&
>             git add file &&
>             git commit -m"Bump $i"
>         done &&
>         git log -Gthensome.*5
>     )
> 
> Right now this will emit 3/10 patches, and the right ones! I.e. "Bump
> [156]". The 1st one because it introduces the "Always matching thensome
> 5". Then 5/6 because the add/remove the string "a thensome 5 binary",
> respectively. Which matches /thensome.*5/.

Right, this will sometimes do the right thing. But it will also often do
the wrong thing. It's also very expensive (we specifically avoid feeding
large binary files to xdiff, but I think "-G" will happily do so -- I
didn't double check, though).

-Peff
