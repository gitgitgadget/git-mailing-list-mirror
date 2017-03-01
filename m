Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAAD20282
	for <e@80x24.org>; Wed,  1 Mar 2017 23:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbdCAXNR (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:13:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:36791 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbdCAXNP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:13:15 -0500
Received: (qmail 20969 invoked by uid 109); 1 Mar 2017 23:13:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 23:13:05 +0000
Received: (qmail 11112 invoked by uid 111); 1 Mar 2017 23:13:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 18:13:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 18:13:02 -0500
Date:   Wed, 1 Mar 2017 18:13:02 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170301231302.o2tw6vlu2wqeltzj@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
 <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
 <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
 <CA+55aFwr1jncrk-cekn0Y8rs_S+zs7RrgQ-Jb-ZbgCvmVrHT_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwr1jncrk-cekn0Y8rs_S+zs7RrgQ-Jb-ZbgCvmVrHT_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 12:58:39PM -0800, Linus Torvalds wrote:

>> I don't think that helps. The sha1 over the pack-file takes about 1.3s
>> with openssl, and 5s with sha1dc. So we already know the increase there
>> is only a few seconds, not a few minutes.
> 
> OK. I guess what w could easily do is to just add an argument to
> git_SHA1_Init() to say whether we want checking or not, and only use the
> checking functions when receiving objects (which would include creating new
> objects from files, and obviously deck).
> 
> You'd still eat the cost on the receiving side of a clone, but that's when
> you really want the checking anyway. At least it wouldn't be so visible on
> the sending side, which is all the hosting etc, where there might be server
> utilization issues.
> 
> Would that make deployment happier? It should be an easy little flag to
> add, I think.

I don't think it makes all that big a difference. The sending side
wastes the extra 2-3 seconds of CPU to checksum the whole packfile, but
it's not inflating all the object contents in the first place (between
reachability bitmaps to get the list of objects in the first place, and
then verbatim reuse of pack contents).

Which isn't to say it's not reasonable to limit the checking to a few
spots (basically anything that's _writing_ objects). But I don't think
it makes a big difference to the server side of a fetch or clone.

-Peff
