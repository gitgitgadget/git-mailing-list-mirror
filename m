Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C4520248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfDESwo (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:52:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:48912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731589AbfDESwo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:52:44 -0400
Received: (qmail 12721 invoked by uid 109); 5 Apr 2019 18:52:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:52:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28873 invoked by uid 111); 5 Apr 2019 18:53:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:53:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:52:42 -0400
Date:   Fri, 5 Apr 2019 14:52:42 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190405185241.GG2284@sigill.intra.peff.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
 <20190405184229.GB8796@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405184229.GB8796@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 08:42:29PM +0200, SZEDER Gábor wrote:

> > > Don't run git commands upstream of a pipe, because the pipe hides
> > > their exit code.  This applies to several other tests below as well.
> > 
> > I disagree with that rule here. We're not testing "cat-file" in any
> > meaningful way, but just getting some stock output from a known-good
> > commit.
> 
> It makes auditing harder and sets bad example.

I disagree that it's a bad example. Just because a reader might not
realize that it is sometimes OK and sometimes not, does not make it bad
to do so in the OK case. It means the reader needs to understand the
rule in order to correctly apply it.

I am sympathetic to the auditing issue, though.

I dunno. In this case it is not too bad to do:

  git cat-file commit $commit >good-commit &&
  perl ... <good-commit >broken-commit

but I am not sure I am on board with a blanket rule of "git must never
be on the left-hand side of a pipe".

> > > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> > > dependency?
> > 
> > Heh, this was actually the subject of much discussion before the patches
> > hit the list. If you can write such a one-liner that is both readable
> > and portable, please share it. I got disgusted with sed and suggested
> > this perl.
> 
> Hm, so the trivial s/// with '\n' in the replacement part is not
> portable, then?  Oh, well.

I don't think it is, but I could be wrong. POSIX does say that "\n"
matches a newline in the pattern space, but nothing about it on the RHS
of a substitution. I have a vague feeling of running into problems in
the past, but I could just be misremembering.

We also tried matching /^tree/ and using "a\" to append a line, but it
was both hard to read and hit portability issues with bsd sed.

-Peff
