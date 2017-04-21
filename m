Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721F71FAA1
	for <e@80x24.org>; Fri, 21 Apr 2017 21:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162665AbdDUVf6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 17:35:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:37994 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162663AbdDUVf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 17:35:56 -0400
Received: (qmail 24270 invoked by uid 109); 21 Apr 2017 21:35:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 21:35:55 +0000
Received: (qmail 20533 invoked by uid 111); 21 Apr 2017 21:36:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 17:36:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 17:35:53 -0400
Date:   Fri, 21 Apr 2017 17:35:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] t/perf: correctly align non-ASCII descriptions in output
Message-ID: <20170421213553.6vqcmnwolwtieqo4@sigill.intra.peff.net>
References: <20170421194428.1377-1-avarab@gmail.com>
 <20170421204154.c5mvmnccxkxdm5aw@sigill.intra.peff.net>
 <CACBZZX4oMFkZ93YxXrByh-jCK-eVxNBj+UgF77zm5Pq1mzf+WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4oMFkZ93YxXrByh-jCK-eVxNBj+UgF77zm5Pq1mzf+WQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 11:28:42PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I thought there was some "use" flag we could set to just make all of our
> > handles utf8. But all I could come up with was stuff like PERLIO and
> > "perl -C". Using binmode isn't too bad, though (I think you could
> > just do it as part of the open, too, but I'm not sure if antique
> > versions of perl support that).
> 
> [Debugging perl encoding issues is one of the many perks of my dayjob]
> 
> Using binmode like this is about as straightforward as you can get,
> the former occurrence could be equivalently replaced by:
> 
>     utf8::decode(my $line = <$fh>);
> 
> But better just to mark the handle as utf8. There's a fancier way to
> do it as part of the three-arg-open syntax, but I couldn't remember
> whether all the perl versions we support have it.

Yeah, I agree marking the handle is better. binmode is pretty
straightforward, but we'd have to remember to manually set it if we add
any other handles. That's probably not a big deal in this particular
script, though, which is pretty short.

> About the "use" flag, you're probably thinking of the confusingly
> named "use utf8", but that's to set your source code to utf8, not your
> handles, e.g.:
> 
> $ perl -CA -MDevel::Peek -wE 'use utf8; my $日本語 = shift; Dump $日本語' æ
> SV = PV(0x12cc090) at 0x12cded8
>   REFCNT = 1
>   FLAGS = (PADMY,POK,pPOK,UTF8)
>   PV = 0x12de460 "\303\246"\0 [UTF8 "\x{e6}"]
>   CUR = 2
>   LEN = 16
> 
> As you can see people got a bit overexcited about Unicode in the 90s.

Yeah, I know "use utf8" doesn't work for that, but I was thinking there
was some other trick. Digging...ah, here it is:

  use open ':encoding(utf8)'

No clue how portable that is. For such a small script it may be better
to just stick with vanilla binmode().

-Peff
