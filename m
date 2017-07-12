Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10B4202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 23:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdGLXQA (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 19:16:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:38652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750775AbdGLXP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 19:15:59 -0400
Received: (qmail 15391 invoked by uid 109); 12 Jul 2017 23:15:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 23:15:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28483 invoked by uid 111); 12 Jul 2017 23:16:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 19:16:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 19:15:57 -0400
Date:   Wed, 12 Jul 2017 19:15:57 -0400
From:   Jeff King <peff@peff.net>
To:     roeder.git@mailnull.com
Cc:     git@vger.kernel.org
Subject: Re: Git on macOS shows committed files as untracked
Message-ID: <20170712231557.lu7ppj3bric2fahi@sigill.intra.peff.net>
References: <20170712222128.A2F7A246E3@outside.256stuff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170712222128.A2F7A246E3@outside.256stuff.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 06:21:28PM -0400, roeder.git@mailnull.com wrote:

> In Git on macOS (git version 2.13.2 | brew install git) the status
> command will show folders as untracked even though they are committed
> and checked out from the repository. Does not reproduce on Windows and
> Ubuntu.
> [...]
> 
> 	"d\314\207\316\271\314\223\314\200\342\225\223\316\265\357\256\257\360\222\221\217\342\227\213\342\225\223\320\243\314\213/"

Probably the issue has to do with Unicode normalization, and you have
files in your repository that can't be represented on your filesystem.
For example, the first two code-points above are "d" followed by U+0307,
"COMBINING DOT ABOVE". That pair can also be represented as U+1E0B,
"LATIN SMALL LETTER D WITH DOT ABOVE".

I don't recall which form HFS+ normalizes to, but basically what happens
is that Git opens the file with some name, and the filesystem quietly
rewrites that under the hood to a different, normalized name. Then when
Git walks the directory later to ask which files are present, it sees
this other filename that it has no clue about.

Generally the solution is to commit the normalized name. There's some
logic inside Git to "precompose" names to the right normalization, but I
think that only affects new files you add. Existing committed files with
the wrong normalization run into this issue.

-Peff
