Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1763201A4
	for <e@80x24.org>; Tue, 16 May 2017 06:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbdEPG7o (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 02:59:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52469 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbdEPG7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 02:59:43 -0400
Received: (qmail 9854 invoked by uid 109); 16 May 2017 06:59:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 06:59:41 +0000
Received: (qmail 25434 invoked by uid 111); 16 May 2017 07:00:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 03:00:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 02:59:40 -0400
Date:   Tue, 16 May 2017 02:59:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: How to force a pull to succeed?
Message-ID: <20170516065939.uy3ib7z2v6gkldox@sigill.intra.peff.net>
References: <CAH8yC8k8sTGDA=C8vLCE090Y1B4TK86bOnZMNjj13C-JXVEBHQ@mail.gmail.com>
 <xmqq8tlx4h1y.fsf@gitster.mtv.corp.google.com>
 <CAH8yC8mOc68A-0uM8b3AKAYo9VqYNUjHkGw0knbXL0suM25tfA@mail.gmail.com>
 <xmqqmvad31sr.fsf@gitster.mtv.corp.google.com>
 <CAH8yC8kVFGe9gnj8P+=Pp1ToDvMPXiViVM-HzhkZ6SAteoPZaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8kVFGe9gnj8P+=Pp1ToDvMPXiViVM-HzhkZ6SAteoPZaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:47:14PM -0400, Jeffrey Walton wrote:

> > The fact that you think it is expected is immaterial. Git doesn't
> > know (or care) how you made the files different from HEAD, so it
> > looks like a damage to it.
> 
> 'git pull' fails and its expected, but 'git pull -f' is supposed to
> succeed. That's what -f is supposed to do.

Well, no. "pull -f" does something else, and is documented as such.

> Is there a way to add intelligence to Git so that it sees they are the
> _exact_ same file, and it stops bothering me with details of problems
> that don't exist?
> 
> It seems like adding the intelligence is a good enhancement. A version
> control tool has to do three things: check-out, check-in, and
> determine differences. Its not doing a good job of determining
> differences considering they are the exact same file.

AFAICT there are basically two changes we could consider here:

  1. Some kind of --force option to git-merge and git-pull that just
     overwrites files, regardless of content. That's not much better
     than "git reset --hard && git merge", but I suppose it might save
     the state of files that wouldn't otherwise be affected by the
     merge. We already have something similar for "checkout -f".

  2. Right now the verify_uptodate() check happens deep in unpack-trees,
     which doesn't actually know what the merge result is going to be
     for that file. In some cases (like yours) the threeway result is
     trivial, but in others it requires doing an actual content-level
     merge. But in theory we could get the entire merge result and only
     then decide whether to write it in place (after comparing to the
     on-disk contents).

     I suspect that covering the latter would take some major surgery to
     the way that the merge code works. The trivial cases could probably
     be handled inside unpack-trees.

Neither seem totally unreasonable to me. But without working patches,
there's not much to discuss.

-Peff
