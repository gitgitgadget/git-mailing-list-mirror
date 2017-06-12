Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DB01F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 18:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbdFLSUt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 14:20:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:38370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbdFLSUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 14:20:48 -0400
Received: (qmail 21206 invoked by uid 109); 12 Jun 2017 18:20:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 18:20:47 +0000
Received: (qmail 14892 invoked by uid 111); 12 Jun 2017 18:20:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 14:20:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 14:20:45 -0400
Date:   Mon, 12 Jun 2017 14:20:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
Message-ID: <20170612182045.z4d37ph5uqqhwmas@sigill.intra.peff.net>
References: <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
 <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
 <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
 <22846.51138.555606.729612@a1i15.kph.uni-mainz.de>
 <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 07:53:21PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> Of course we can never know if you were in Tokyo or Seul from the info
> >> in the commit object, but we don't need to, it's enough that we just
> >> emit JST for +0900 and anyone reading the output has at least some
> >> idea what +0900 maps to.
> >
> > Please don't. Outputting invented information for something that
> > really isn't in the data is worse than outputting no information at
> > all.
> 
> It's not invented information. %z being +0900 is the same thing as %Z
> being JST since +0900 == JST, just because some other things are also
> == +0900 that doesn't mean that JST is invalid or less useful than
> +0900 or "" for the purposes of human-readable output.

I think the main problem is that the mapping isn't just "JST->+0900".
It's a set of rules that depend on the specific time being converted. So
it's true that at some time t, +0900 may mean JST or KST or whatever.
But at a different time, those time zones will map to a different
offset.

So I think at best this is semantically confusing (the author was not in
JST, but just happened to be in a time zone that maps to the same thing
at that moment, and any attempt to extrapolate their zone at another
time is going to be wrong). And at worst the output of "git log" is
going to show the same user flip-flopping between zones as their commits
move around with respect to the (politically determined) zone changes.
For instance in my time zone I'd shift between EST and CST twice per
year due to DST. My real time zone is EST5EDT, or better still,
America/New_York (I don't live there, but the Olson database carves up
regions based on the most populous city in the zone).

-Peff
