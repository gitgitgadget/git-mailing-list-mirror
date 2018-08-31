Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896961F428
	for <e@80x24.org>; Fri, 31 Aug 2018 11:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeHaPIR (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 11:08:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52854 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeHaPIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 11:08:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A03311F404;
        Fri, 31 Aug 2018 11:01:20 +0000 (UTC)
Date:   Fri, 31 Aug 2018 11:01:20 +0000
From:   Eric Wong <e@80x24.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180831110120.vbyxnnpu2iparxck@dcvr>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net>
 <20180829100243.GA28180@dcvr>
 <20180830033000.GD665@sigill.intra.peff.net>
 <20180830035609.GA140348@aiede.svl.corp.google.com>
 <20180830072043.GA14514@dcvr.yhbt.net>
 <20180831011417.GA98946@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831011417.GA98946@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Wong wrote:
> > Jonathan Nieder <jrnieder@gmail.com> wrote:
> >> Jeff King wrote:
> 
> >>> I guess I just wonder if I set up a mirror on another domain, would
> >>> anybody actually _use_ it? I'd think most people would just go to
> >>> public-inbox.org as the de facto URL.
> >>
> >> If it's faster than public-inbox.org and you don't mind the traffic I
> >> would send, then I'll use it. :)
> >
> > Is performance a problem on public-inbox.org for you?
> 
> It's pretty fast.  I'm just very, very picky about latency. ;-)

Best way for good latency is to have a local mirror, but I guess
Googlers still aren't allowed to run AGPL software?

> It's good to know you're interested in which corner cases are bad.
> The next time I have a noticeably slow page load, I'll contact meta@.

Alright. It could also be a general datacenter/networking
problem so https://status.linode.com/ (my VPS provider) is worth
checking.

> [...]
> > I've also been sorta considering downgrading to a $5/month VPS
> > (from a $20/month VPS) to force myself to pay more attention to
> > performance while saving myself a few bucks.  But I wouldn't get
> > to dogfood on SMP, anymore...
> 
> Sounds reasonable to me.  If performance gets bad, that's just a
> reason for people to help out (either with patches or e.g. with
> donated VMs for hosting).

> Speaking of the latter: what are your current resource requirements?

Not too much; but could always be better on the software side.

> E.g. which of the dimensions in [1] do you not fit into?

> [1] https://cloud.google.com/free/docs/always-free-usage-limits#compute_name

Dunno, I'm not seeing RAM, there.

Depending on traffic, it's around 200MB per-public-inbox-httpd
worker (2 workers for 2 cores) when there's a traffic surge on
from popular sites.  Memory usage is the biggest disappointment
and only happens when Varnish can't read fast enough.
Everything in the PSGI code is is streamed if possible(*).
My goal is to maintain <50MB per worker process, but it could
be tough in Perl5. Anyways $20/month gets me 4GB RAM (so I have
way more than I need).

CPU usage isn't even noticeable (only bursts) and I do other
stuff on that server all the time.

HDDs wouldn't work well at all and I've noticed differences
based on SSD quality with Xapian.  Storage for Xapian+SQLite is
4-5x what's in git, so for this list, it's under 7G total
(but more will be needed for Xapian reindexing/compact and
git repacking).



(*) Individual messages for returning giant mboxes and threads are
    all lazily fleshed out from skeleton data structures as the
    client socket becomes writable (and quickly discarded after writing).
    Technically it's all compatible with any PSGI server, but all
    the streaming stuff is tailored to run on public-inbox-httpd.
    But there's also git-http-backend memory use which comes in
    bursts (bitmaps enabled, of course)
