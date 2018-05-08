Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E257C200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeEHSIq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:08:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:60698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932988AbeEHSIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:08:43 -0400
Received: (qmail 15544 invoked by uid 109); 8 May 2018 18:08:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 18:08:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7266 invoked by uid 111); 8 May 2018 18:08:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 14:08:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 14:08:41 -0400
Date:   Tue, 8 May 2018 14:08:41 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] refs.c: do not die if locking fails in
 `write_pseudoref()`
Message-ID: <20180508180840.GA7210@sigill.intra.peff.net>
References: <20180506141031.30204-3-martin.agren@gmail.com>
 <1525621731.16035.11.camel@novalis.org>
 <CAN0heSpfu+070fxhjjccXQpfFnr13O4tvSaj44YWkFWVJL_4mA@mail.gmail.com>
 <01AF002E-C9E2-48FB-97AB-D9D903866310@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01AF002E-C9E2-48FB-97AB-D9D903866310@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 07, 2018 at 05:12:27AM -0600, David Turner wrote:

> >Right. After commit 076aa2cbda (tempfile: auto-allocate tempfiles on
> >heap, 2017-09-05) this is safe though. Quite a few locks have already
> >been moved to the stack, e.g., in 14bca6c63c (sequencer: make lockfiles
> >non-static, 2018-02-27) and 02ae242fdd (checkout-index: simplify
> >locking
> >logic, 2017-10-05).  I could add a note to the commit message to make
> >this clear, like "After 076aa2cbda, locks no longer need to be static."
> 
> I am going to reply now to keep the thread moving, but I am on my
> phone with bad connectivity (few cell towers in Bears Ears), so I
> can't really check the code. Feel free to disregard if I am still
> wrong.
> 
> I saw that patch, but I thought the new logic required that cleanup
> funtions be called before the lock goes out of scope.

No, it should be fine. After 422a21c6a0 (tempfile: remove deactivated
list entries, 2017-09-05) it became _possible_ to use a non-static
tempfile. But it was dangerous, because if you failed to clean up, bad
things would happen. So right after that in 076aa2cbda we switched to
using the heap, which means the tempfile code takes full ownership, and
the local lockfile variable is just a pointer to that storage.

-Peff
