Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28DE420226
	for <e@80x24.org>; Thu,  4 Aug 2016 07:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbcHDH1K (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 03:27:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:54612 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbcHDH1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 03:27:09 -0400
Received: (qmail 11940 invoked by uid 102); 4 Aug 2016 07:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:27:10 -0400
Received: (qmail 10555 invoked by uid 107); 4 Aug 2016 07:27:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:27:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 03:27:05 -0400
Date:	Thu, 4 Aug 2016 03:27:05 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] xdl_change_compact(): fix compaction heuristic to
 adjust io
Message-ID: <20160804072705.a53mospcccksiz4e@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 12:00:33AM +0200, Michael Haggerty wrote:

> The code branch used for the compaction heuristic incorrectly forgot to
> keep io in sync while the group was shifted. I think that could have
> led to reading past the end of the rchgo array.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> I didn't actually try to verify the presence of a bug, because it
> seems like more work than worthwhile. But here is my reasoning:
> 
> If io is not decremented correctly during one iteration of the outer
> `while` loop, then it will loose sync with the `end` counter. In
> particular it will be too large.
> 
> Suppose that the next iterations of the outer `while` loop (i.e.,
> processing the next block of add/delete lines) don't have any sliders.
> Then the `io` counter would be incremented by the number of
> non-changed lines in xdf, which is the same as the number of
> non-changed lines in xdfo that *should have* followed the group that
> experienced the malfunction. But since `io` was too large at the end
> of that iteration, it will be incremented past the end of the
> xdfo->rchg array, and will try to read that memory illegally.

Hmm. In the loop:

  while (rchgo[io])
	io++;

that implies that rchgo has a zero-marker that we can rely on hitting.
And it looks like rchgo[io] always ends the loop on a 0. So it seems
like we would just hit that condition again.

That doesn't make it _right_, but I'm not sure I see how it would walk
off the end of the array.  But I'm very sure I don't understand this
code completely, so I may be missing something.

Anyway, I'd suggest putting your cover letter bits into the commit
message. Even though they are all suppositions, they are the kind of
thing that could really help somebody debugging this in 2 years, and are
better than nothing.

-Peff
