Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F281FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 19:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbcKVT1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:27:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:46259 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933632AbcKVT1B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:27:01 -0500
Received: (qmail 12860 invoked by uid 109); 22 Nov 2016 19:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 19:27:00 +0000
Received: (qmail 31508 invoked by uid 111); 22 Nov 2016 19:27:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 14:27:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Nov 2016 14:26:58 -0500
Date:   Tue, 22 Nov 2016 14:26:58 -0500
From:   Jeff King <peff@peff.net>
To:     Matthieu S <matthieu.stigler@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: git diff with =?utf-8?B?4oCcLS13?=
 =?utf-8?Q?ord-diff-regex=E2=80=9D_extremely_slow_compared_to_=E2=80=9C--w?=
 =?utf-8?B?b3JkLWRpZmbigJ0/?=
Message-ID: <20161122192658.annsqeokptac3ivv@sigill.intra.peff.net>
References: <CAEYvigJ14xYDmRG2N0yTgM4spaaB7s9923w0+e9+QQEeFz0NTQ@mail.gmail.com>
 <CAEYvigLz3muWD-QFjMZUn=H3RQoxhTYX9EwB6=aiMjWOEN3CBA@mail.gmail.com>
 <20161120201744.7ym4gsmjoijw6oow@sigill.intra.peff.net>
 <CAEYvigLLQq2SK60UsiTPCxpptpjz85_rGtDVugjfu-sCT1juGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEYvigLLQq2SK60UsiTPCxpptpjz85_rGtDVugjfu-sCT1juGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 10:08:33AM -0800, Matthieu S wrote:

> You are right, I should have compared with the same regex, and indeed,
> --word-diff-regex=[^[:space:]] is also much slower than just
> --word-diff, although they do the same job. Maybe this is a hint that
> the --word-diff-regex code could be made faster?

Maybe. If most of the time is spent in the regex engine, there may not
be much we can do. But perhaps there is something in the surrounding
code that can be improved. Looking at find_word_boundaries() (and this
is the first time I've done so), it does look like we regex-match the
whole buffer, and only then find the end-of-line. Now that we have
regexec_buf(), it might be possible to constrain the regex buffer more.

> I have a small understanding of git, but is git diff computing the
> diff value for the whole file, and then showing in the terminal the 10
> first values? In some cases, it seems to be a lot of unnecessary
> computation! Is there any possibility to ask git-diff to only compare
> say the first 100 lines? Or compute only when necessary, i.e.
> when"enter" is prompted in the console?

Git always computes the diff for the whole file. The paging is done by
an external program. So no, there's no easy way to do it incrementally
as the user interacts with the pager, as the pager does not communicate
back to git in any way. However, git should generally be streaming out
results (and the pager showing them) as they're computed, so in an ideal
world you get output immediately, and then the pager buffers the rest of
it while you're reading the first page.

Git does have to look at the whole file in order to do the initial
line-by-line diff, so it would be hard to make that incremental. It
could do the word-coloring for each hunk incrementally, though. I would
have assumed that is already how it is done, though I didn't dig into
it.

-Peff
