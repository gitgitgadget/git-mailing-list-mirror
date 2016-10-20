Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079F71F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755716AbcJTXU6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 19:20:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:60370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754097AbcJTXUz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 19:20:55 -0400
Received: (qmail 9908 invoked by uid 109); 20 Oct 2016 23:20:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 23:20:55 +0000
Received: (qmail 31498 invoked by uid 111); 20 Oct 2016 23:21:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 19:21:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 19:20:53 -0400
Date:   Thu, 20 Oct 2016 19:20:53 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161020232052.uggm2w7qitrj5f7g@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610201154070.3264@virtualbox>
 <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
 <CAGZ79ka_McRkOyKH3diCXJSdCm+4pNZfqAqJW_tQLFdhb26tRQ@mail.gmail.com>
 <20161020210013.57wkyhmf2ism6vt2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020210013.57wkyhmf2ism6vt2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 05:00:13PM -0400, Jeff King wrote:

> > I am not an expert on perl nor tracing, but is it feasible to find out
> > how many internal calls there are? i.e. either some shell script (rebase,
> > submodule) calling git itself a couple of times or even from compile/git/git
> > itself, e.g. some submodule operations use forking in there.
> 
> The script below is my attempt, though I think it is not quite right, as
> "make" should be the single apex of the graph. You can run it like:
> 
>   strace -f -o /tmp/foo.out -e clone,execve make test
>   perl graph.pl /tmp/foo.out | less -S

Ah, I see why it is sometimes wrong. We may see parent/child
interactions out of order. E.g., we may see:

  1. Process B execs "git".

  2. Process B exits.

  3. Process A forks pid B.

because strace does not manage to ptrace "A" before "B" finishes
running. It's hard to tell in step 3 if this is the same "A" we saw
earlier. You cannot just go by PID, because the tests run enough
processes that we end up reusing PIDs. My script has a hack which
increments a counter when processes go away, but that happens in step 2
above (and steps 1 and 3 think they are seeing different processes, even
though they are the same).

I'm sure it could be cleverly hacked around, but the easiest thing is
probably to just make sure the tests are not run in parallel. High load
makes that kind of out-of-order sequence much more likely.

Making sure I run it with "make -j1", the script I posted earlier gives
pretty reasonable output. I won't post mine here, as it's double-digit
megabytes, but you should be able to recreate it yourself.

Of course, the call graph by itself isn't that interesting. But you
might be able to do some interesting analysis, or just find spots of
interest to you (like git-submodule).

-Peff
