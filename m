Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E78120D09
	for <e@80x24.org>; Sat, 27 May 2017 20:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbdE0Ujm (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 16:39:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:58874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdE0Ujl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 16:39:41 -0400
Received: (qmail 26302 invoked by uid 109); 27 May 2017 20:39:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 May 2017 20:39:40 +0000
Received: (qmail 5680 invoked by uid 111); 27 May 2017 20:40:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 May 2017 16:40:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 May 2017 16:39:38 -0400
Date:   Sat, 27 May 2017 16:39:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] recognize pathspec magic without "--" disambiguation
Message-ID: <20170527203937.hto7lwxfbjvl5f7o@sigill.intra.peff.net>
References: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net>
 <CACBZZX6K7ppVB0qYah76_+pjTKjsco3rHT0xRyKtF2H1dS4k_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6K7ppVB0qYah76_+pjTKjsco3rHT0xRyKtF2H1dS4k_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2017 at 11:54:07AM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Thu, May 25, 2017 at 5:27 PM, Jeff King <peff@peff.net> wrote:
> >         git log :/foo.*bar
> 
> Another option would be to deprecate the :/rx syntax over some period
> in favor of ^{/rx}.

Yeah, the latter is more flexible (can start at a tip of your choosing)
and syntactically matches other object selectors much better.

> I think it's too ugly to live, and really useless. It's equivalent to
> "--grep=<rx> --all". Does anyone use this and not really mean to use
> ^{/rx}? E.g. "git show :/fix" might show a fix on some unrelated
> branch you recently rebased.

It's actually _worse_ than that --grep because it only picks one result.
So not only do we look at unrelated branches, but they may take
precedence (based on commit timestamp) over the current branch.

It is shorter than "HEAD^{/re}", though. So I suspect people do use it
and would be slightly annoyed if it went away.

> >       will be treated as a pathspec (if it doesn't match a
> >       commit message) due to the wildcard matching in
> >       28fcc0b71.
> 
> So it might DWYM after hanging there looking at your entire history
> for a commit message matching foo.*bar? And if you make such a commit
> it'll start meaning something else entirely?

Yeah. That's a good reason not to use ":/" without a disambiguating "--"
(which _does_ work, even without my series, because check_filename()
does specific path-matching). At best, you pay for a complete useless
history traversal before the command actually starts running. But much
more likely is that Git just complains of ambiguity, because people tend
to mention top-level paths in their commit messages. E.g.:

  $ cd t
  $ git grep foo :/Documentation
  fatal: ambiguous argument ':/Documentation': both revision and filename

So it really is a pretty horrible syntax.

-Peff
