Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SUSPICIOUS_RECIPS shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCD21F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfBUN6I (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:58:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:52608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725858AbfBUN6H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:58:07 -0500
Received: (qmail 20477 invoked by uid 109); 21 Feb 2019 13:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 13:58:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12710 invoked by uid 111); 21 Feb 2019 13:58:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:58:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 08:58:05 -0500
Date:   Thu, 21 Feb 2019 08:58:05 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: safe-guard a bit more against getenv()
 problems
Message-ID: <20190221135805.GB20899@sigill.intra.peff.net>
References: <pull.127.git.gitgitgadget@gmail.com>
 <53e3d159c8c80924188f57c44efd2170612f2ee5.1550243863.git.gitgitgadget@gmail.com>
 <96793350-0991-6e8f-6ab2-15777e2071be@jeffhostetler.com>
 <nycvar.QRO.7.76.6.1902181950130.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902181950130.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 07:57:14PM +0100, Johannes Schindelin wrote:

> > Why not use a mem_pool for this?  We have that code isolated
> > and re-usable now.  Have mingw_getenv() copy the string into
> > the pool always return the pointer from within the pool.  The
> > pool automatically handles allocating new blocks as necessary.
> > And (if we care) we can bulk free the pool before existing.
> 
> The problem with the mem_pool would be that I do *not* want to accumulate
> tons and tons of stale copies (remember that `difftool` bug? Apparently it
> calls `getenv()` in a loop that scales with the number of modified files;
> I would hate to have copies for all of those).
> 
> And all you could do to remedy this would be to blow away all of them it
> the mem_pool grew too much, *including* the latest `getenv()` (which we
> painfully keep valid, e.g. in the case of `git_committer_info()` which
> calls `getenv()` *three* times *inside* the parameter list of the
> `fmt_ident()` function call.

One suggestion I made elsewhere[1] is to use strintern() to de-dup the
responses, and then keep them around forever.  That bounds the memory
usage by the number of unique environment variables requested (which is
probably finite and limited), rather than the number of getenv() calls
(which as we have seen can be done in an arbitrary-sized loop).

I say "probably" because it's possible that there is code which mutates
the environment, reads it back, etc, in a loop. But that would be pretty
out-of-character for Git, I think.

-Peff

[1] https://public-inbox.org/git/20190115194726.GA5818@sigill.intra.peff.net/
