Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BF3203E2
	for <e@80x24.org>; Sun, 24 Jul 2016 11:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbcGXLU3 (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 07:20:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57822 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbcGXLU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 07:20:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31ED203E2;
	Sun, 24 Jul 2016 11:20:27 +0000 (UTC)
Date:	Sun, 24 Jul 2016 11:20:27 +0000
From:	Eric Wong <e@80x24.org>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC 0/3] dumb HTTP transport speedups
Message-ID: <20160724112027.GB25507@starla>
References: <20160711205131.1291-1-e@80x24.org>
 <57949467.60904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57949467.60904@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> wrote:
> W dniu 2016-07-11 o 22:51, Eric Wong pisze:
> 
> > TL;DR: dumb HTTP clone from a certain badly-packed repo goes from
> > ~2 hours to ~30 min memory usage drops from 2G to 360M
> > 
> > 
> > I hadn't packed the public repo at https://public-inbox.org/git
> > for a few weeks.  As an admin of a small server limited memory
> > and CPU resources but fairly good bandwidth, I prefer clients
> > use dumb HTTP for initial clones.
> 
> Hopefully the solution / workaround for large initial clone
> problem utilizing bundles (`git bundle`), which can be resumably
> transferred, would get standarized and automated.

I've been hoping to look at this more in coming weeks/months.
It would be nice if bundles and packs could be unified somehow
to avoid doubling storage on the server.

> Do you use bitmap indices for speeding up fetches?

Yes, but slow clients are still a problem since big responses
keeps memory-hungry processes running while trickling
(or waste disk space buffering the pack output up front)

Static packfiles/bundles are nice since all the clients can
share the same data on the server side as it's trickled out.

> BTW. IMVHO the problem with dumb HTTP is the latency, not extra
> bandwidth needed...

I enabled persistent connections for 404s on loose objects for
this reason :)  We should probably be doing it across the board
on 404s, just haven't gotten around to it...

Increasing default parallelism should also help; but might hurt
some servers which can't handle many connections...
Hard to imagine people using antiquated prefork servers for
slow clients in a post-Slowloris world, but maybe it happens?
