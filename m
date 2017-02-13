Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737FC1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbdBMVKz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:10:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:54479 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbdBMVKy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:10:54 -0500
Received: (qmail 5859 invoked by uid 109); 13 Feb 2017 21:10:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 21:10:54 +0000
Received: (qmail 25710 invoked by uid 111); 13 Feb 2017 21:10:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 16:10:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 16:10:52 -0500
Date:   Mon, 13 Feb 2017 16:10:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] clean: use warning_errno() when appropriate
Message-ID: <20170213211051.vsnnrtcsvuvfcwyk@sigill.intra.peff.net>
References: <20170213092702.10462-1-pclouds@gmail.com>
 <xmqqwpcudjoh.fsf@gitster.mtv.corp.google.com>
 <20170213191433.muwhz7zem64p3rxr@sigill.intra.peff.net>
 <xmqqk28tddwo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk28tddwo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 12:38:47PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I wonder if xmalloc() should be the one doing the saved_errno trick.
> > After all, it has only two outcomes: we successfully allocated the
> > memory, or we called die().
> 
> I would be lying if I said I did not considered it when I wrote the
> message you are responding to, but I rejected it because that would
> be optimizing for a wrong case, in that most callers of xmalloc()
> and friends do not do so in the error codepath, and we would be
> penalizing them by doing the saved_errno dance unconditionally.

Yes, that also occurred to me. I'm not sure if two integer swaps is
enough to care about when compared to the cost of a malloc(), though.

IOW, I think this may be a case where we should be optimizing for
programmer time (fewer lines of code, and one less thing to worry about
in the callers) versus squeezing out every instruction.

-Peff
