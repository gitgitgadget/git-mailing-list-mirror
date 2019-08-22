Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CA21F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbfHVQ3J (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:29:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:52550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733046AbfHVQ3J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:29:09 -0400
Received: (qmail 32409 invoked by uid 109); 22 Aug 2019 16:29:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Aug 2019 16:29:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22283 invoked by uid 111); 22 Aug 2019 16:30:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Aug 2019 12:30:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Aug 2019 12:29:08 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Charles Diza <chdiza@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: v2.22.1 and later regression wrt display of progress indicators
Message-ID: <20190822162907.GA17013@sigill.intra.peff.net>
References: <20190822141928.GA3163@323642-phi-gmno-clahs>
 <20190822160702.GD20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822160702.GD20404@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 06:07:02PM +0200, SZEDER Gábor wrote:

> On Thu, Aug 22, 2019 at 10:20:08AM -0400, Charles Diza wrote:
> > By 2.22.1 at the latest (and continuing into 2.23.0) there is a
> > problem with the display of progress indication during `git pull`
> > (and possibly other commands, I don't know).
> > 
> > I'm on macOS, and this happens in both Terminal.app and iTerm2.app,
> > on both macOS 10.13.6 and 10.14.6:  In a standard 80-column wide
> > terminal window, cd into a git repo and do `git pull`.  The chances
> > are high (though not 100%) that one will see this:
> 
> I noticed this today when pushing to GitHub (I suppose they have very
> recently upgraded?) from Linux, so this is neither specific to 'git
> pull' nor to macOS.
> 
> I'm sure the culprits are commits cd1096b282 (pager: add a helper
> function to clear the last line in the terminal, 2019-06-24) and
> 5b12e3123b (progress: use term_clear_line(), 2019-06-24) with the
> added complication of communicating with a remote.

Yes, we moved to v2.22.1 last night. I'll revert those commits on our
servers until we come up with a more permanent solution upstream.

> I'm not sure how to handle the situation.  A few ideas to consider:
> 
>   1. Update 'git upload-pack/receive-pack' to use some kind of magic
>      character or char sequence instead of a "real" line clearing
>      sequence, and update 'git pull/push' to replace that magic with
>      the line clearing sequence appropriate for the terminal.
> 
>   2. Variant of the above: leave 'git upload-pack/receive-pack' as they
>      are now, and declare that those 80 spaces indicate when to clear
>      progress lines.  Update 'git push/pull' to catch those 80 spaces,
>      and replace them with the line clearing sequence appropriate for
>      the terminal.
> 
>   3. Update 'git pull/push' to explicitly tell the remote what line
>      clearing sequence to use.
> 
>   4. Revert, and go back to calculating how many spaces we need to
>      append to clear the previously displayed progress line, and hope
>      that we don't mess it up (or even if we do, it still won't be as
>      noticable as this).
> 
> I suppose this issue affects other git clients as well, so (1), (2),
> and (3) might not even be an option.

Yes on that final bit. We could always fall back to (4) if the terminal
information is not available, but given that the benefit is mostly in
simplifying the code, I don't know if it's worth carrying around _two_
solutions.

One interesting bit: we have traditionally used \033[K on the _client_
side of the sideband demuxer. So I think in the "remote:" case we were
already handling this correctly, even before your patch.

-Peff
