Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1B11F576
	for <e@80x24.org>; Thu,  1 Mar 2018 07:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935338AbeCAHtW (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 02:49:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:42364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934908AbeCAHtV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 02:49:21 -0500
Received: (qmail 16590 invoked by uid 109); 1 Mar 2018 07:49:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 07:49:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12651 invoked by uid 111); 1 Mar 2018 07:50:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Mar 2018 02:50:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2018 02:49:19 -0500
Date:   Thu, 1 Mar 2018 02:49:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180301074918.GG31079@sigill.intra.peff.net>
References: <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net>
 <20180226173533.GA7877@tor.lan>
 <20180226204635.GB12598@sigill.intra.peff.net>
 <20180227210517.GA17555@tor.lan>
 <20180227212537.GA6899@sigill.intra.peff.net>
 <20180228082005.GA16857@tor.lan>
 <20180228132116.GA32272@sigill.intra.peff.net>
 <xmqqfu5lm2nw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfu5lm2nw.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 09:42:27AM -0800, Junio C Hamano wrote:

> > I also think we'd want a plan for this to be used consistently in other
> > diff-like tools. E.g., "git blame" uses textconv for the starting file
> > content, and it would be nice for this to kick in then, too. Ditto for
> > things like grep, pickaxe, etc.
> 
> You probably do not want to limit your thinking to the generation
> side.  It is entirely plausible to have "we deal with diff in this
> encoding X" in addition to "the in-repo encoding for this project is
> this encoding Y" and "the working tree encoding for this path is Z"
> and allow them to interact in "git diff | git apply" pipeline.
> 
> "diff/format-patch --stdout/etc." on the upstream would first iconv
> Y to X and feed the contents in X to xdiff machinery, which is sent
> down the pipe and received by apply, which reads the preimage from
> the disk or from the repository.  If doing "apply" without
> "--cached/--index", the preimage data from the disk would go through
> iconv Z to X.  If doing "apply --cached/--index", the preimage data
> from the repo would go through iconv Y to X.  The incoming patch is
> in X, so we apply, and the resulting postimage will be re-encoded in
> Z in the working tree and Y in the repository.

I agree that would be convenient, but I have to wonder if all the
complexity is worth it to maintain the idea of a distinct in-repo
representation. It seems like it would open up a ton of corner cases.
And I suspect most people would be happy enough with either a
clean/smudge style worktree conversion or a textconv-style view.

So if somebody wants to work on it, I don't want to stop them. But I
think there's room for the simpler solutions in the meantime.

-Peff
