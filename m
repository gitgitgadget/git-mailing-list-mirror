Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7611F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 07:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbdFHHL5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 03:11:57 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40926 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdFHHL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 03:11:57 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dIrbk-0003js-F3; Thu, 08 Jun 2017 16:11:52 +0900
Date:   Thu, 8 Jun 2017 16:11:52 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] fast-import: Increase the default pack depth to 50
Message-ID: <20170608071152.bnjr5zopbb3aly62@glandium.org>
References: <20170608053436.9121-1-mh@glandium.org>
 <20170608070537.zgrcxhl57u4akzvq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608070537.zgrcxhl57u4akzvq@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 03:05:37AM -0400, Jeff King wrote:
> On Thu, Jun 08, 2017 at 02:34:36PM +0900, Mike Hommey wrote:
> 
> > In 618e613a70, 10 years ago, the default for pack depth used for
> > git-pack-objects and git-repack was changed from 10 to 50, while
> > leaving fast-import's default to 10.
> > 
> > There doesn't seem to be a reason besides oversight for the change not
> > having happened in fast-import as well.
> > 
> > Interestingly, fast-import uses pack.depth when it's set, and the
> > git-config manual says the default for pack.depth is 50. While the
> > git-fast-import manual does say the default depth is 10, the
> > inconsistency is also confusing.
> 
> Makes sense. If anything, fast-import would want to allow a deeper depth
> than normal, since (IIRC) its delta chains are always completely linear.
> Whereas in a real pack, if we decide not to make a delta off the 50th
> item in a chain, we usually find the 48th or 49th, and end up with a
> bushier graph.
> 
> It probably doesn't matter that much, though, as you'd really want to
> `repack -f` afterwards if you care about getting good deltas. And one
> base object every 50 versions is probably fine for keeping the initial
> pack manageable.

It actually is possible to have non-linear delta chains with
fast-import, because the cat-blob command resets the delta base when
storing a blob. See
https://github.com/git/git/blob/v2.13.1/fast-import.c#L2984-L2987

As a side effect of that, git-cinnabar[1] ends up with decent-ish delta
chains out of the box, without having to go with repack -f, when the
mercurial server gives out changegroup version 2.

Mike

1. https://github.com/glandium/git-cinnabar/
