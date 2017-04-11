Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761A420970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbdDKUek (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:34:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:60346 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752847AbdDKUej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:34:39 -0400
Received: (qmail 4118 invoked by uid 109); 11 Apr 2017 20:34:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 20:34:38 +0000
Received: (qmail 7184 invoked by uid 111); 11 Apr 2017 20:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 16:34:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 16:34:34 -0400
Date:   Tue, 11 Apr 2017 16:34:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Rast <trast@student.ethz.ch>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 01/12] grep: add ability to disable threading with
 --threads=0 or grep.threads=0
Message-ID: <20170411203434.iiupo2oovzviqju5@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-2-avarab@gmail.com>
 <20170411100656.5bptxdaptc4zznan@sigill.intra.peff.net>
 <CACBZZX7vEQ5jUzX3GsD6JXe50TnRUtGmSVi7zBxwOmAQGABQ4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7vEQ5jUzX3GsD6JXe50TnRUtGmSVi7zBxwOmAQGABQ4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 10:20:59PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I'm struggling to find a use-case where threading makes sense at all.
> The example in the initial introduction in 5b594f457a is always slower
> with >0 for me, and since then in 0579f91dd7 it got disabled entirely
> for non-worktree cases.

It's a big win for me in worktree greps of linux.git:

  $ best-of-five git grep --threads=1 '[q]werty'
  Attempt 1: 0.713
  Attempt 2: 0.708
  Attempt 3: 0.689
  Attempt 4: 0.695
  Attempt 5: 0.7

  real	0m0.689s
  user	0m0.560s
  sys	0m0.248s

  $ best-of-five git grep --threads=8 '[q]werty'
  Attempt 1: 0.238
  Attempt 2: 0.225
  Attempt 3: 0.222
  Attempt 4: 0.221
  Attempt 5: 0.225

  real	0m0.221s
  user	0m0.936s
  sys	0m0.356s

In non-worktree cases most of the time goes to accessing objects, which
happens under a lock. So you don't get any real parallelism, just
overhead.

> But assuming it works for someone out there, then 0 threads is clearly
> not the same as 1. On linux.git with pcre2 grepping for [q]werty for
> example[1]

Right, my suggestion was to teach "grep" to treat --threads=1 as "do not
spawn any other threads". I.e., to make it like the "0" case you were
proposing, and then leave "0" as "auto-detect". There would be no way to
spawn a _single_ thread and feed it. But why would you want to do that?
It's always going to be strictly worse than not threading at all.

-Peff
