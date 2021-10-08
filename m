Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD58DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC636600CD
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbhJHVeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:34:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:36164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230384AbhJHVeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:34:36 -0400
Received: (qmail 6384 invoked by uid 109); 8 Oct 2021 21:32:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 21:32:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19004 invoked by uid 111); 8 Oct 2021 21:32:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 17:32:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 17:32:39 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YWC49+xCh+zum8Ms@coredump.intra.peff.net>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
 <YV5yi+AejPGO9qOi@nand.local>
 <YV/BMkZrj4xQyvUL@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 09:51:33AM +0200, Johannes Schindelin wrote:

> > Sort of. They basically wrap the "make" invocation to intercept "cc". My
> > understanding is that their faux-compiler is mostly about gathering data
> > about the code. That gets stuffed into a tarball and uploaded to their
> > servers, where the real analysis happens.
> >
> > It's very black-box, which I don't love. But in my experience it
> > produces by far the most useful static-analysis output of any tool I've
> > seen.
> 
> It is pretty black box, but I have to disagree that the static analysis
> output is very useful. The majority are false positives about
> strbuf/strvec type usage of a static, fixed-size array that is dynamically
> replaced by a dynamically-allocated array. Coverity misses that subtlety
> and reports out-of-bounds accesses.

Yes, I remember skipping past quite a few of those.

To be clear, I don't claim that its output is amazing. Only that it has
produced actionable output on many occasions. Grepping commit messages
for "Coverity" turns up several hits (many from you :) ). Most of those
are leak fixes, and I do think we have better options there. But I
recall it detecting some hard-to-find memory and logic errors, too.

> Granted, I worked around those (I thought) by using the
> `-DFLEX_ARRAY=65536` trick, but I guess that is either not working as
> designed, or it stopped working at some stage.
> 
> FWIW I have set up an Azure Pipeline to keep Git for Windows' `main`
> branch covered by Coverity:
> 
> https://dev.azure.com/git-for-windows/git/_build?definitionId=35
> 
> It essentially calls into this scripted code:
> https://github.com/git-for-windows/build-extra/blob/4676f286a1ec830a5038b32400808a353dc6c48d/please.sh#L1820-L1915

Do you have any objection to adding something like the Action I showed
eariler? It would do nothing in git-for-windows/git unless you set up
the right environment, so there shouldn't be any downside.

I admit I was not really planning to try to suppress the false positives
as you've done here; my plan was to just keep an eye on the "new"
entries (having already gone through the existing ones years ago).

-Peff
