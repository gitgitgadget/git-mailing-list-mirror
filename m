Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F5D208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 17:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbdH1RxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 13:53:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:51074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751345AbdH1RxA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 13:53:00 -0400
Received: (qmail 27549 invoked by uid 109); 28 Aug 2017 17:53:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Aug 2017 17:53:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3386 invoked by uid 111); 28 Aug 2017 17:53:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Aug 2017 13:53:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Aug 2017 13:52:58 -0400
Date:   Mon, 28 Aug 2017 13:52:58 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Automatically delete branches containing accepted patches?
Message-ID: <20170828175258.ssvohh5wljsg4clr@sigill.intra.peff.net>
References: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 27, 2017 at 08:44:06PM +0200, Lars Schneider wrote:

> I have lots of git/git branches and once in a while some patches make it 
> into git/git master. If this happens I would like to delete my branch
> with the patch automatically. That's not easily possible as the hashes 
> on my branches are, of course, not the same as the hashes on git/git.
> 
> How do you deal with this situation? Do you manually delete your 
> branches or do you have some clever script to share?

It's definitely not a trivial problem.  I use a combination of three
scripts/tricks:

 1. I have a script[1] that uses git-cherry to see what's made it to
    master or next. This isn't fool-proof, because sometimes minor
    tweaks mean that the patch-ids differ. But it catches most cases.

    [1] https://github.com/peff/git/blob/meta/merged

 2. I aggressively rebase all of my topics. Basically when I sit down to
    work each day, the first thing I run is a script[2] which
    just loops over each topic, rebasing each against its master.

    When topics have made it to master, this rebase produces an empty
    output, and the script from (1) shows them as merged. The tricky
    thing is that if a series touches the same area in multiple patches,
    rebasing it on itself will often end up with conflicts in the early
    patches. It's pretty easy to recognize this case and just "rebase
    --skip" past the already-applied patches.

    This also very occasionally results in a mis-merge where some little
    tidbit of a patch is left (e.g., if I added a new block but it ended
    up being moved elsewhere when Junio resolved a conflict, Git may
    mis-apply the patch and end up with a duplicate block. For C code
    this usually results in an error, but something like a duplicated
    test can often go unnoticed).

    [2] https://github.com/peff/git/blob/meta/rebase

 3. I have a small wrapper[3] around for-each-ref that shows me my
    topics in reverse authordate order. Reading it in that order reminds
    me of what should be in-flight and might need prodding. This can
    range from "it was merged and I need to delete the local branch" to
    "I sent it and it wasn't picked up for some reason" to "oops, I
    forgot to send it".

    The script's pretty short and I suspect most of it could be done
    with a "git branch --format" alias these days. The authordate
    sorting is very important for me because I have dozens of ancient
    crufty branches that are probably going nowhere but which I refuse
    to delete. ;)

    [3] https://github.com/peff/git/blob/meta/topics

So between the three of those, I generally eventually notice stale
branches lying around.

-Peff
