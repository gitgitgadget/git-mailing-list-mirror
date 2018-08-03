Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623361F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeHCSDc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:03:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:41886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727356AbeHCSDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:03:32 -0400
Received: (qmail 8928 invoked by uid 109); 3 Aug 2018 16:06:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 16:06:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2693 invoked by uid 111); 3 Aug 2018 16:06:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 12:06:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 12:06:34 -0400
Date:   Fri, 3 Aug 2018 12:06:34 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180803160634.GA19944@sigill.intra.peff.net>
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
 <20180801001942.GC45452@genre.crustytoothpaste.net>
 <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
 <20180803133630.32oxubwttealvhxk@work-pc>
 <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 03, 2018 at 11:43:44AM -0400, Santiago Torres wrote:

> > This is not a deviation. GPG correctly recognizes difference between trusted,
> > untrusted and unknown levels. git on the other hand does not. Well it did until
> > the commit a4cc18f29. That one removed GPG exit code propagation.
> 
> Oh wow. Sorry my assumption parted from looking at the code back in the
> day where this happens. I assumed git was quietly propagating the gpg
> error code and took it from there. 
> 
> Now that I think about it though, verify tag can verify more than one
> tag. I assume that this would make it difficult to propagate individual
> errors in trusting. I honestly don't know what's the best way to modify
> this behavior then.

I think the only sensible thing is to err on the conservative side, and
return non-zero if we saw _any_ invalid signature.

I will note, though, that just checking the exit code of `verify-tag`
isn't really that thorough. It shows that there was _a_ signature, but
we don't know:

  - if it was an identity the user would expect to be signing tags

  - if it even matches the refname we used to find the tag

So I'd argue that any real verification needs to either have a human in
the loop, or implement a custom policy based on reading the full output.

I know we (and you specifically Santiago) talked about this a while ago,
and we ended up providing ways to get more information out of
verify-tag, so that a tool could sit on top of that and implement more
project-specific policy. I don't know offhand of any reusable tools that
do so, though.

-Peff
