Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6F11F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 08:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdFDIhr (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 04:37:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:34523 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdFDIhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 04:37:45 -0400
Received: (qmail 16107 invoked by uid 109); 4 Jun 2017 08:37:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 08:37:44 +0000
Received: (qmail 7808 invoked by uid 111); 4 Jun 2017 08:38:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 04:38:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Jun 2017 04:37:43 -0400
Date:   Sun, 4 Jun 2017 04:37:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
Message-ID: <20170604083743.kovvk5k43fk4kmur@sigill.intra.peff.net>
References: <20170602103330.25663-1-avarab@gmail.com>
 <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
 <xmqqwp8sv77h.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp8sv77h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 04, 2017 at 11:04:50AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I think a more compelling case is that there may be an ongoing
> > operation in the original repo (e.g., say you are in the middle of
> > writing a commit message) when we do a blind copy of the filesystem
> > contents. You might racily pick up a lockfile.
> >
> > Should we find and delete all *.lock files in the copied directory? That
> > would get ref locks, etc. Half-formed object files are OK. Technically
> > if you want to get an uncorrupted repository you'd also want to copy
> > refs before objects (in case somebody makes a new object and updates a
> > ref while you're copying).
> 
> Or "git branch -m A B" is in progress.
> 
> I think it all depends on what your "threat" model is ;-).  Do we
> assume that many users are "time-sharing" a box and a repository?
> If not, i.e. if you are the sole user of a box and a repository on
> it, such a concurrent access to make the result of git-unaware copy
> problematic will not be in index.lock (after all you are now doing
> the perf thing, not editing a commit log message in the repository
> used for testing Git), but will be in ref locks (somebody else
> pushing into the repository you are *not* currently using from
> sideways).

I was specifically thinking of the case where you run "git commit -a",
it locks the index, and then while you are writing the commit message
you need to collect some more perf results. The default perf repo is the
current repository itself, so running any perf script will copy the
index.lock and probably cause the script to misbehave.

That doesn't seem like an implausible sequence of events (frankly, I'm
surprised I haven't hit it myself, as I often run perf scripts while
writing commit messages. I think I've been saved by generally using a
separate linux.git clone as my test repo).

So it may be reasonable to say that the index.lock is special. We hold
it for a long time (compared to reflocks, which do a quick compare-and-swap).
And then we can throw up our hands for any other races. People who run
"git prune" on their test repository running the perf scripts get what
they deserve. :)

-Peff
