Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2110AC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036CE206DA
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgHMFU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:20:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:57320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgHMFUz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 01:20:55 -0400
Received: (qmail 15500 invoked by uid 109); 13 Aug 2020 05:20:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 05:20:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10546 invoked by uid 111); 13 Aug 2020 05:20:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 01:20:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 01:20:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>, Nuthan Munaiah <nm6061@rit.edu>,
        git@vger.kernel.org
Subject: [PATCH 0/3] blame: fix bug in coalescing non-adjacent "-L" chunks
Message-ID: <20200813052054.GA1962792@coredump.intra.peff.net>
References: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
 <20200807212159.GA1871940@coredump.intra.peff.net>
 <20200807213349.GB1871940@coredump.intra.peff.net>
 <xmqq7duaf6xk.fsf@gitster.c.googlers.com>
 <20200807222630.GA3750245@coredump.intra.peff.net>
 <20200807223522.GB3750245@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807223522.GB3750245@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 06:35:22PM -0400, Jeff King wrote:

> > > I think the only conceivable case is that in the middle of a single
> > > block of text in an ancient version, another block of lines gets
> > > inserted during the evolution of the file, but in the end these
> > > intermediate edits all go away and the same original text remains.
> > > 
> > > In such a case, without coalescing, we would not treat the original
> > > single block of text as a single unit.
> > 
> > Yeah, that makes sense, and it should be possible to construct a case
> > based on that.

I started to add a test for this, and it turns out we already had one!
It just wasn't checking the output as carefully as it could. :)

So here's a series which actually checks that blame_coalesce() is doing
something useful, and then fixes Nuthan's bug on top (with a test case,
but I also confirmed it makes the original tomcat issue go away).

  [1/3]: t8003: check output of coalesced blame
  [2/3]: t8003: factor setup out of coalesce test
  [3/3]: blame: only coalesce lines that are adjacent in result

 blame.c                       |  1 +
 t/t8003-blame-corner-cases.sh | 28 +++++++++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

-Peff
