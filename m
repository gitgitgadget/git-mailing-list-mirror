Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD59A20133
	for <e@80x24.org>; Fri,  3 Mar 2017 22:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdCCWbb (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 17:31:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:38379 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752004AbdCCWba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 17:31:30 -0500
Received: (qmail 15235 invoked by uid 109); 3 Mar 2017 22:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 22:31:30 +0000
Received: (qmail 1110 invoked by uid 111); 3 Mar 2017 22:31:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 17:31:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 17:31:27 -0500
Date:   Fri, 3 Mar 2017 17:31:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/perf: export variable used in other blocks
Message-ID: <20170303223127.vqqkmxmcclkmw6wm@sigill.intra.peff.net>
References: <20170228221236.selqkf5wme3fvued@sigill.intra.peff.net>
 <20170302195041.1699-1-jonathantanmy@google.com>
 <20170303064512.khs2seru5onl54mh@sigill.intra.peff.net>
 <xmqqbmti9os2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmti9os2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 10:51:57AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Thanks, this is obviously the right thing to do, and the mistake is mine
> > from ea97002fc (t/perf: time rev-list with UNINTERESTING commits,
> > 2014-01-20). This is not the first time I've been confused by missing
> > variables in t/perf scripts, since it behaves differently than the
> > normal test suite. I wonder if we should turn on "set -a" during t/perf
> > setup snippets. That's a bit of a blunt tool, but I suspect it would
> > just be easier to work with.
> 
> I wonder if we can make t/perf to behave more similar to the normal
> test suite to eliminate the need for this exporting, by the way.
> t/perf/README does not say anything more than "for lack of better
> options" throughout its history, which does not help very much.

The problem is that it has to run each block multiple times under an
external "time" program. If you assume that the shell running the perf
suite is bash, you can do:

  i=0
  foo() { echo $i; i=$(($i+1)); }
  for run in 1 2 3; do time foo; done

which shows that you can get repeated timings from a shell function.
That shell function would run the actual test snippet, and would have to
do some redirect trickery to split the "time" results from the stderr of
the underlying test. And parse bash's time output.

But those are all do-able things. The main thing is throwing out a
dependency on an external "time" for "bash". That may not be a big loss,
though.

-Peff
