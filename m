Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B964202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 07:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdJYH1Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 03:27:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:35158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751792AbdJYH1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 03:27:21 -0400
Received: (qmail 22421 invoked by uid 109); 25 Oct 2017 07:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 25 Oct 2017 07:27:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19097 invoked by uid 111); 25 Oct 2017 07:27:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 25 Oct 2017 03:27:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Oct 2017 00:27:18 -0700
Date:   Wed, 25 Oct 2017 00:27:18 -0700
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrey Okoshkin <a.okoshkin@samsung.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
Message-ID: <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net>
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
 <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
 <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
 <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
 <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
 <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
 <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
 <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 12:07:12AM -0400, Eric Sunshine wrote:

> On Tue, Oct 24, 2017 at 9:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >> I definitely agree with the sentiment that as few things as possible
> >> should happen between calling getenv() and using its result. I've seen
> >> real bugs there from unexpected invalidation of the static buffer.
> >
> > Sure.  I do not think we mind xstrdup()ing the result and freeing
> > after we are done, though ;-)
> 
> More specifically, xstrdup_or_null(getenv(...)), if that route is chosen.

That would be the way to do it, but I do not see thta we need to record
the string at all. The current code is calling strtol on it on it
immediately.

So the options are:

  1. Save the result of getenv() in a variable. If it is non-NULL, then
     immediately call strtol() on it.

  2. Do nothing. The double-call to getenv() is actually fine in the
     real world as it will return consistent results.

But the patch under discussion, which calls getenv() then expects it
to be correct after a call to merge_recursive_config(), introduces a
problem.

-Peff
