Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D631F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeHWBVm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 21:21:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:52328 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727353AbeHWBVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 21:21:42 -0400
Received: (qmail 6035 invoked by uid 109); 22 Aug 2018 21:55:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 21:55:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5006 invoked by uid 111); 22 Aug 2018 21:55:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 17:55:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 17:55:02 -0400
Date:   Wed, 22 Aug 2018 17:55:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rev-list: make empty --stdin not an error
Message-ID: <20180822215501.GA27737@sigill.intra.peff.net>
References: <20180727174811.27360-1-avarab@gmail.com>
 <20180822174820.12909-1-szeder.dev@gmail.com>
 <xmqqefeqme0p.fsf@gitster-ct.c.googlers.com>
 <20180822192308.GB19730@sigill.intra.peff.net>
 <20180822195045.GC19730@sigill.intra.peff.net>
 <xmqqa7pem8ul.fsf@gitster-ct.c.googlers.com>
 <20180822213722.GA25180@sigill.intra.peff.net>
 <xmqqr2iqkr5e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2iqkr5e.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 02:50:05PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes. I was thinking it had more purpose than this, but it really is just
> > a flag to check "did we do this already?". Which is one of the main
> > purposes I claimed for the new flag in my commit message. :)
> 
> OK.  
> 
> The reason I was on the fence was primarily because read_from_stdin
> field in the structure observable from outside can be a boolean
> (that is, "unsigned :1"), but internally this may want to count up
> to two.
> 
> Or with "unsigned read_from_stdin:1", would this 
> 
> 	if (revs->read_from_stdin++)
> 		die("twice???");
> 
> still be usable?  As the value of post-increment would be 1 even
> when the resulting field would have wrapped-around already, it
> should be OK, but it just felt strange to me.

I agree it would work in practice, though I also agree it is funny and
should be avoided.

> But that is something we do not have to worry about until somebody
> tries to shrink the structure by making these flags into bitfields.

Also agreed. I'd probably resolve it then by writing:

  if (revs->read_from_stdin)
	die("twice");
  revs->read_from_stdin = 1;

I guess we could even do that now. Or add a test to make sure "--stdin
--stdin" barfs. But I am perfectly happy to punt until somebody actually
wants to use a bitfield.

-Peff
