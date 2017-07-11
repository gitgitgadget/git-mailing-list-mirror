Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F72820357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbdGKHbe (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:31:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:36624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755257AbdGKHbc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:31:32 -0400
Received: (qmail 28043 invoked by uid 109); 11 Jul 2017 07:31:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 07:31:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13547 invoked by uid 111); 11 Jul 2017 07:31:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 03:31:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 03:31:25 -0400
Date:   Tue, 11 Jul 2017 03:31:25 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Andreas Krey <a.krey@gmx.de>, Git Users <git@vger.kernel.org>
Subject: Re: Flurries of 'git reflog expire'
Message-ID: <20170711073125.bddyb3ledzasbhtl@sigill.intra.peff.net>
References: <20170704075758.GA22249@inner.h.apk.li>
 <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
 <20170706133124.GB1216@inner.h.apk.li>
 <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 06, 2017 at 10:01:05AM -0700, Bryan Turner wrote:

> I also want to add that Bitbucket Server 5.x includes totally
> rewritten GC handling. 5.0.x automatically disables auto GC in all
> repositories and manages it explicitly, and 5.1.x fully removes use of
> "git gc" in favor of running relevant plumbing commands directly. We
> moved away from "git gc" specifically to avoid the "git reflog expire
> --all", because there's no config setting that _fully disables_
> forking that process.

FWIW, I think auto-gc in general is not a good way to handle maintenance
on a busy hosting server. Repacking can be very resource hungry (both
CPU and memory), and it needs to be throttled. You _could_ throttle with
an auto-gc hook, but that isn't very elegant when it comes to
re-queueing jobs which fail or timeout.

The right model IMHO (and what GitHub uses, and what I'm guessing
Bitbucket is doing in more recent versions) is to make note of write
operations in a data structure, then use that data to schedule
maintenance in a job queue. But that can never really be part of Git
itself, as the notion of a system job queue is outside its scope.

-Peff
