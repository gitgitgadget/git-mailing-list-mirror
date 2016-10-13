Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951A420989
	for <e@80x24.org>; Thu, 13 Oct 2016 16:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbcJMQ0v (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 12:26:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:57041 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756793AbcJMQ0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 12:26:36 -0400
Received: (qmail 23818 invoked by uid 109); 13 Oct 2016 15:26:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 15:26:34 +0000
Received: (qmail 30415 invoked by uid 111); 13 Oct 2016 15:26:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 11:26:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2016 11:26:32 -0400
Date:   Thu, 13 Oct 2016 11:26:32 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Huge performance bottleneck reading packs
Message-ID: <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
 <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 09:20:07AM +0200, Vegard Nossum wrote:

> > Does the patch below help?
> 
> Yes, ~2m10s -> ~1m25s when I test a git fetch this morning (the other
> variation in time may be due to different CPU usage by other programs,
> but I ran with/without the patch multiple times and the difference is
> consistent).
> [...]
> There are some 20k refs on the remote, closer to 25k locally.

OK, that makes some sense. For whatever reason, your remote has a bunch
of tags that point to objects you do not already have. That could
happen, I think, if the remote added a lot of tags since you cloned
(because clone will grab all of the tags), but those tags do not point
to history that you are otherwise fetching (since fetch by default will
"auto-follow" such tags).

It might be interesting to see the results of:

  # all the objects we have
  git cat-file --batch-all-objects --batch-check='%(objectname)' >us

  # all the objects the remote is advertising
  git ls-remote origin | cut -f1 | sort -u >them

  # what they are advertising that we don't have
  comm -13 us them | wc -l

My guess is that the number is relatively high. And that would explain
why nobody else has really complained much; such a pattern is probably
uncommon.

> The fetch doesn't actually get anything from the remote as everything is
> already up to date (that makes the 2m40s times even more frustrating in
> a way :-)). Here's count-objects:

If the fetch is largely a noop, then that makes me wonder why we are
spending even a minute in the "good" case. I wonder if there is some
other spot that is wasting CPU on some inefficient data structure
related to the number of refs you have. If you can do any profiling that
points to a hot spot, that would be interesting to see (and also whether
a gc improves things).

I see in find_non_local_tags() that we build up a sorted string_list via
repeated calls to string_list_insert(), which will keep the thing sorted
at each stage. That's not as efficient as just sorting at the end, but I
think it's probably OK in practice because we actually feed it via
for_each_ref(), whose output is sorted, and so we'd always just be
appending to the end.

-Peff
