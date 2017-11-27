Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2019C20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 06:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbdK0GNA (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 01:13:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:41186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751685AbdK0GM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 01:12:59 -0500
Received: (qmail 29778 invoked by uid 109); 27 Nov 2017 06:13:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 06:13:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 858 invoked by uid 111); 27 Nov 2017 06:13:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 01:13:17 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 01:12:57 -0500
Date:   Mon, 27 Nov 2017 01:12:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171127061257.GB1247@sigill>
References: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
 <20171126192749.GC1501@sigill>
 <xmqq7euch7jb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7euch7jb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 09:47:20AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure I agree. Lockless writes are actually fine for the original
> > use case of --no-optional-locks (which is a process for the same user
> > that just happens to run in the background).
> 
> The phrase "lockless write" scares me---it sounds as if you
> overwrite the index file no matter what other people (including
> another instance of yourself) are doing to it.  

Ick, no, that would be quite bad. ;)

I only meant that if we "somehow" had a way in the future to update the
stat cache without affecting the other parts of the index, and without
causing lock contention that causes other readers to barf, it could be
triggered even under this option.

That would be quite different from the current index and stat-cache
design, and I have no plans in that area.

Writes to the object database _are_ lockless now (it is OK if two
writers collide, because they are by definition writing the same data).
And I wouldn't expect them to be affected by --no-optional-locks.  I
think elsewhere in the thread you mentioned writing out trees for
cache-tree, which seems like a plausible example. Usually there's not
much point if you're not going to write out the index with the new
cache-tree entries, too. But I could see a program wanting to convert
the index into a tree in order to speed up a series of tree-to-index
diffs within a single program.

This is all pretty hypothetical, though.

-Peff
