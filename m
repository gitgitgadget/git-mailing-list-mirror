Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F7C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 22:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D83207D3
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 22:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHXWIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:08:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:39300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHXWIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 18:08:30 -0400
Received: (qmail 24530 invoked by uid 109); 24 Aug 2020 22:08:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2020 22:08:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18844 invoked by uid 111); 24 Aug 2020 22:08:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2020 18:08:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Aug 2020 18:08:29 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 0/7] Better threaded delta resolution in index-pack
 (another try)
Message-ID: <20200824220829.GA802799@coredump.intra.peff.net>
References: <cover.1598296530.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 24, 2020 at 12:16:30PM -0700, Jonathan Tan wrote:

> I'm trying to resurrect [1] and have rebased it to latest master
> (675a4aaf3b ("Ninth batch", 2020-08-19)).
> 
> Peff said [2] (of v1) that the overall direction seems reasonable and
> Josh Steadmon said [3] (of v2) that it looks mostly good except for
> possible improvements to commit messages and comments. Josh did not list
> out specific improvements to commit messages but I have taken his
> suggestions for comments.

I haven't looked closely yet, but since I was doing timings of
index-pack recently[1], I wondered if this might change anything
(spoiler: it doesn't really seem to).

Here's the result of p5302 with my extra tests on my 8-core (16 with
hyperthreading) laptop against linux.git:

  5302.3: index-pack 0 threads                   266.66(263.85+2.71)
  5302.4: index-pack 1 threads                   275.06(272.11+2.85)
  5302.5: index-pack 2 threads                   159.49(285.44+3.51)
  5302.6: index-pack 4 threads                   102.54(318.86+4.30)
  5302.7: index-pack 8 threads                   75.60(391.39+6.56) 
  5302.8: index-pack 16 threads                  75.56(748.45+13.37)
  5302.9: index-pack default number of threads   75.01(389.33+6.59) 

So the conclusions from that other series remain pretty similar: nothing
gets faster as we move past the number of actual cores. The penalty for
doing so seems less than what I got before, though (though it might just
be a fluke; it was something like 2s worse before your patches, and
there's a bit of noise; the increased CPU time can be disregarded as the
processors are throttled down when more are running).

The overall time seems to get slightly worse, though (HEAD~7 is before
your patch, HEAD is with it):

  Test                                           HEAD~7               HEAD                    
  --------------------------------------------------------------------------------------------
  5302.9: index-pack default number of threads   71.96(376.11+3.66)   74.18(390.62+6.08) +3.1%

There may be other cases that get better, though. A 3% increase here is
probably OK if we get something for it. But if our primary goal here is
increasing multithread efficiency, then we should be able to show some
benchmark that improves. :)

-Peff

[1] https://lore.kernel.org/git/20200821175153.GA3263018@coredump.intra.peff.net/
