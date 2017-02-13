Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6261FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbdBMWWN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:22:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:54556 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdBMWWN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:22:13 -0500
Received: (qmail 10928 invoked by uid 109); 13 Feb 2017 22:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 22:22:13 +0000
Received: (qmail 28914 invoked by uid 111); 13 Feb 2017 22:22:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 17:22:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 17:22:10 -0500
Date:   Mon, 13 Feb 2017 17:22:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] clean: use warning_errno() when appropriate
Message-ID: <20170213222210.dtfnxbbi77tsx4a6@sigill.intra.peff.net>
References: <20170213092702.10462-1-pclouds@gmail.com>
 <xmqqwpcudjoh.fsf@gitster.mtv.corp.google.com>
 <20170213191433.muwhz7zem64p3rxr@sigill.intra.peff.net>
 <xmqqk28tddwo.fsf@gitster.mtv.corp.google.com>
 <20170213211051.vsnnrtcsvuvfcwyk@sigill.intra.peff.net>
 <xmqqy3x9bvvm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3x9bvvm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 01:53:33PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > IOW, I think this may be a case where we should be optimizing for
> > programmer time (fewer lines of code, and one less thing to worry about
> > in the callers) versus squeezing out every instruction.
> 
> Fair enough.
> 
> Unless we do the save_errno dance in all the helper functions we
> commonly use to safely stash away errno as necessary and tell
> developers that they can depend on it, the code in the patch that
> began this discussion still needs its own saved_errno dance to be
> safe, though.  I do not have a feeling that we are not there yet,
> even after we teach xmalloc() and its family to do so.

Yeah, I certainly agree that is a potential blocker. Even if it is true
today, there's nothing guaranteeing that the quote functions don't grow
a new internal detail that violates.

So in that sense doing the errno dance as close to the caller who cares
is the most _obvious_ thing, even if it isn't the shortest.

It would be nice if there was a way to annotate a function as
errno-safe, and then transitively compute which other functions were
errno-safe when they do not call any errno-unsafe function. I don't know
if any static analyzers allow that kind of custom annotation, though
(and also I wonder whether the cost/benefit of maintaining those
annotations would be worth it).

-Peff
