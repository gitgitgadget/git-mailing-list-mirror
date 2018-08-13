Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3EF11F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeHNAbI (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:31:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:53898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730027AbeHNAbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:31:07 -0400
Received: (qmail 17794 invoked by uid 109); 13 Aug 2018 21:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 21:47:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14241 invoked by uid 111); 13 Aug 2018 21:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 17:47:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 17:47:03 -0400
Date:   Mon, 13 Aug 2018 17:47:03 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
Message-ID: <20180813214702.GA16006@sigill.intra.peff.net>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com>
 <20180813192526.GC10013@sigill.intra.peff.net>
 <CACsJy8Cxp9+xiMB6C71Kr63EWyAni-K0ZwVBbpBjUieDbZ+6AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Cxp9+xiMB6C71Kr63EWyAni-K0ZwVBbpBjUieDbZ+6AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 09:52:41PM +0200, Duy Nguyen wrote:

> I don't think I have really fully mastered 'perf'. In this case for
> example, I don't think the default event 'cycles' is the right one
> because we are hit hard by I/O as well. I think at least I now have an
> excuse to try that famous flamegraph out ;-) but if you have time to
> run a quick analysis of this unpack-trees with 'perf', I'd love to
> learn a trick or two from you.

To be honest, I don't feel like I know how to use perf either. ;) But
I'll try to contribute what I know.

Usually I'd just use perf to get a callgraph with hot-spots, like:

  perf record -g git ...
  perf report --call-graph=fractal,0.05,caller

But that's not going to show you absolute times, which makes it lousy
for comparing run-to-run (if you speed something up, its percentage gets
smaller, but it's hard to tell _how much_ you've sped it up). And as you
note, it's measuring CPU cycles, not wall-clock.

To get output most similar to what you've shown, I think you'd define
some probes at functions of interest:

  for i in unpack_trees cache_tree_update; do
    # Cover both function entrance and return.
    perf probe -x $(which git) $i
    perf probe -x $(which git) ${i}%return
  done

and then record a run looking for those events:

  perf record -e 'probe_git:*' git ...

and then dump the result:

  perf script -F time,event

which gives you the times for each event. If you want elapsed times, you
have to compute them yourself:

  perf script -F time,event |
  perl -ne '
    /([0-9.]+):\s+probe_git:(.*):/ or die "confusing: $_";
    my ($t, $func) = ($1, $2);
    if ($func =~ s/__return$//) {
      my $start = pop @stack;
      printf "%0.9f", $t - $start;
      print " s: ";
      print "  " for (0..@stack-1);
      print $func, "\n";
    } else {
      push @stack, $t;
    }
  '

which gives a similar inverted-graph elapsed-time output that your trace
output does. One annoying downside is that you have to be root to create
or use the dynamic probes. I don't know if there's an easy way around
that. Or if there's a perf command which already handles this kind of
elapsed stuff (there's a "perf trace" which seems really close, but I
couldn't convince it to look at elapsed time for non-syscalls).

> > I can buy the argument that it's nice to have some form of profiling
> > that works everywhere, even if it's lowest-common-denominator. I just
> > wonder if we could be investing effort into tooling around existing
> > solutions that will end up more powerful and flexible in the long run.
> 
> I think part of this sprinkling is to highlight the performance
> sensitive spots in the code. And it would be helpful to ask a user to
> enable GIT_TRACE_PERFORMANCE to have a quick breakdown when something
> is reported slow. I don't care that much about other platforms to be
> honest, but perf being largely restricted to root does prevent it from
> replacing GIT_TRACE_PERFORMANCE in this case.

Yeah, this line of reasoning (which is similar to what Stefan said) is
compelling to me. GIT_TRACE_* is _most_ useful when we can ask ordinary
users to give us output. Even if we scripted the complexity I showed
above, it's not guaranteed that perf is even available or that the user
has permissions to use it.

-Peff
