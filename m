Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA15C20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 05:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbdK0FEX (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:04:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:41088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750726AbdK0FEW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:04:22 -0500
Received: (qmail 26535 invoked by uid 109); 27 Nov 2017 05:04:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 05:04:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 380 invoked by uid 111); 27 Nov 2017 05:04:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 00:04:39 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 00:04:20 -0500
Date:   Mon, 27 Nov 2017 00:04:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Takuto Ikuta <tikuta@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
Message-ID: <20171127050420.GB6858@sigill>
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
 <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com>
 <20171127043740.GA5994@sigill>
 <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 01:53:34PM +0900, Junio C Hamano wrote:

> > I'd be curious if the 5th patch there provides an additional speedup for
> > Takuto's case.
> 
> Indeed, it is a very good point.
> 
> IIUC, the 5th one is about fetching tons of refs that you have never
> seen, right?  If a repository that has trouble with everything-local
> is suffering because it right now has 300k remote-tracking branches,
> I'd imagine that these remote-tracking branches are being added at a
> considerable rate, so I'd not be surprised if these "new" refs
> benefits from that patch.  And it would be nice to know how much a
> real life scenario actually does improve.

Right, I think it will only kick in for new refs (and maybe deleted
ones, but I didn't check).

I actually did have a real life scenario that was improved, but it's not
very typical. As I've mentioned before, we keep a big shared-object
repository for forks of a single repo, so a fairly common operation is

  git -C network.git fetch ../$fork.git +refs/*:refs/remotes/$fork/*

The first time that's run on a fork, everything looks like a new ref.

So "real life", but thankfully not life for most git users. :)

-Peff
