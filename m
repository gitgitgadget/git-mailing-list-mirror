Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C163220357
	for <e@80x24.org>; Mon, 10 Jul 2017 15:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754394AbdGJP6e (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 11:58:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:35634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754176AbdGJP6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 11:58:33 -0400
Received: (qmail 23734 invoked by uid 109); 10 Jul 2017 15:58:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 15:58:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6587 invoked by uid 111); 10 Jul 2017 15:58:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 11:58:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 11:58:31 -0400
Date:   Mon, 10 Jul 2017 11:58:31 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] building git with clang/gcc address sanitizer
Message-ID: <20170710155831.3zxijp7bvbquvlau@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
 <40D62A0D-5636-4EC2-ABCB-14175FC541F9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40D62A0D-5636-4EC2-ABCB-14175FC541F9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 04:40:42PM +0200, Lars Schneider wrote:

> > If you want to see it in action, you can do:
> > 
> >  make SANITIZE=address
> >  ./git log -g HEAD HEAD >/dev/null
> > 
> > which finds a bug I recently fixed (but the fix isn't in master yet).
> 
> Do you think it would make sense to run these sanitizers on TravisCI
> to ensure they keep clean? If yes, should we run only "address" or all
> of them (if they run clean)?

Maybe. It's expensive and it's relatively rare that it catches anything.
I used to run valgrind (which is even more expensive) once every release
or so. This is much cheaper, but I've noticed that the Travis
environment is a lot slower than my laptop. So it might take an hour to
run there, which I think would trigger some timeouts?

I guess the best way is to try it and see. I probably wouldn't do an
ASan run for each environment, but just one Linux ASan run, due to the
CPU expense. (TBH, I think the existing gcc versus clang on both
platforms is already slight overkill. But I guess if we have CPU to
burn, more coverage is better than less).

I think "address" is the only one that runs clean right now. With some
work I think we could get "undefined" to run clean. The others, I'm not
so sure.

Some of them can actually be combined in a single build, but I'd have to
dig into the documentation to see which (I think "thread" and "address"
don't work well together, but "undefined" and "address" might). My
SANITIZE trick doesn't handle multiple entries, but it could probably be
taught to.

-Peff
