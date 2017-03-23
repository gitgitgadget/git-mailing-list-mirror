Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55DB620958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbdCWRrz (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:47:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:50360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbdCWRry (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:47:54 -0400
Received: (qmail 6304 invoked by uid 109); 23 Mar 2017 17:47:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 17:47:53 +0000
Received: (qmail 8469 invoked by uid 111); 23 Mar 2017 17:48:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 13:48:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 13:47:50 -0400
Date:   Thu, 23 Mar 2017 13:47:50 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: USE_SHA1DC is broken in pu
Message-ID: <20170323174750.xyucxmfhuc6dbrzc@sigill.intra.peff.net>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
 <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com>
 <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
 <alpine.DEB.2.20.1703212105030.3767@virtualbox>
 <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703221530040.3767@virtualbox>
 <20170322220246.GD26108@aiede.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231724350.3767@virtualbox>
 <CA+55aFyFS2r6isdQU_i5FUQnrzjvWhZdmEVE=KmBVTrMukBbkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyFS2r6isdQU_i5FUQnrzjvWhZdmEVE=KmBVTrMukBbkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 10:16:23AM -0700, Linus Torvalds wrote:

> > If I write out an index, I should not suffer the slowdown from detecting
> > collisions.
> 
> The index case is a complete red herring.
> 
> As already noted, the proper fix for the index case is to simply do it
> asynchronously on read. On write, it's harder to do asynchronously,
> but for a 300MB index file you're likely going to be doing IO in the
> middle, so it's probably not even noticeable.

I think there were some earlier timings that show OpenSSL had a small
but measurable improvement over block-sha1 in this massive case (and
sha1dc is about 1.75x slower than block-sha1, so it will be a little
worse).

So I am mildly sympathetic. BUT. I mostly agree with:

> But the fact is, if you don't want SHA1DC, and you have crazy special
> cases, you just continue to build with openssl support instead. Nobody
> else should ever have to worry about *your* crazy cases.

If somebody who has such a crazy special case wants to tweak the build
to link in a second sha1 implementation and appropriately call it from
non-security spots, I don't have a problem with that. But IMHO that's
the itch of the crazy-case person to scratch.

  Side note: I also have a feeling that any operation that cares about
  non-object sha1 performance is probably ripe for other, bigger
  optimizations. If you update 300MB worth of index entries, then the
  cost of computing a checksum over it isn't a big deal. But if you have
  a 300MB index file and you update one entry (or you just want to read
  one entry), maybe we ought to consider solutions that don't involve
  the whole 300MB in the first place. I know that's a much harder change
  because it may involve new on-disk formats. But it seems like that's
  the right long-term path forward.

-Peff
