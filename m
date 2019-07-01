Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8571F461
	for <e@80x24.org>; Mon,  1 Jul 2019 09:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfGAJQF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 05:16:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:55648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728073AbfGAJQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 05:16:04 -0400
Received: (qmail 25635 invoked by uid 109); 1 Jul 2019 09:16:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Jul 2019 09:16:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2187 invoked by uid 111); 1 Jul 2019 09:16:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Jul 2019 05:16:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jul 2019 05:16:02 -0400
Date:   Mon, 1 Jul 2019 05:16:02 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
Message-ID: <20190701091602.GA24791@sigill.intra.peff.net>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
 <20190630222537.GA21696@sigill.intra.peff.net>
 <3e5c0286-7514-9e00-fbc5-5b0ad9403d30@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e5c0286-7514-9e00-fbc5-5b0ad9403d30@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 08:33:18AM +0200, Johannes Sixt wrote:

> > If we are OK relying on rudimentary perl[1], then:
> > 
> >   perl -le "print((stat)[7]) for @ARGV"
> 
> I'm fine with that. But then we should do the sort + head -n 1 at the
> same time. I can do that with a small script, but I'm sure it's possible
> in a one-liner...

Something like:

  perl -le 'print((sort { $a <=> $b } map { (stat)[7] } @ARGV)[0])'

but that is getting pretty unreadable. If we rely on List::Util, it's a
bit nicer:

  perl -MList::Util=min -e 'print min(map { (stat)[7] } @ARGV)'

but that implies perl v5.7.3. Which is from 2002, and older than our
usual minimum-perl version, but we've typically been very conservative
with these one-liners, since they do not respect NO_PERL.

Probably writing it out like:

  perl -le '
    my @sizes = map { (stat)[7] } @ARGV;
    @sizes = sort { $a <=> $b } @sizes;
    print $size[0];
  '

would be better (and makes "3rd-smallest" a trivial change).

I see Gábor suggested using "wc -c" elsewhere in the thread. That would
be fine with me, too, though I think the required sed there may be
getting pretty unreadable, too. :)

-Peff
