Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9AD1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 20:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbdCJUSo (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 15:18:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:42289 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754943AbdCJUSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 15:18:43 -0500
Received: (qmail 31837 invoked by uid 109); 10 Mar 2017 20:18:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 20:18:42 +0000
Received: (qmail 8800 invoked by uid 111); 10 Mar 2017 20:18:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 15:18:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 15:18:40 -0500
Date:   Fri, 10 Mar 2017 15:18:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
Message-ID: <20170310201840.fubshjp2bjg4bjxq@sigill.intra.peff.net>
References: <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
 <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
 <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
 <xmqqfuikyjoo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfuikyjoo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 12:13:11PM -0800, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> >> I think this misses the other two cases: (*dst, src) and (*dst, *src).
> >
> > ... and that's why I left them out.  You can't get dst vs. *dst wrong
> > with structs (at least not without the compiler complaining); only
> > safe transformations are included in this round.
> 
> I haven't followed this discussion to the end, but the omission of 2
> out of obvious 4 did pique my curiosity when I saw it, too, and made
> me wonder if the omission was deliberate.  If so, it would be nice
> to state why in the log message (or in copy.cocci file itself as a
> comment).

Yeah, it definitely would be worth mentioning. I'm still undecided on
whether we want to be endorsing struct assignment more fully.

> It also made me wonder if we would be helped with a further
> combinatorial explosion from "T **dstp, **srcp" and somesuch (in
> other words, I am wondering why a rule for 'T *src' that uses '*src'
> need to be spelled out separately when there already is a good rule
> for 'T src' that uses 'src'---is that an inherent restriction of the
> tool?).

I had that thought, too, but I think the 4-way rules are necessary,
because the transformations aren't the same in each case. E.g., for the
four cases, the resulting assignments are:

    (dst, src): dst = src;
   (dst, *src): dst = *src;
   (*dst, src): *dst = src;
  (*dst, *src): *dst = *src;

For pointer-to-pointer, I assumed the tool would handle that
automatically by matching "T" as "T*". Though if that is the case, I
think "(dst, src)" and "(*dst, *src)" would be equivalent (though of
course our rule matches are different, as you do not memcpy the raw
structs).

-Peff
