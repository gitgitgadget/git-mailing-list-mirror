Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7464C1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbcLFN4w (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:56:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:52407 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751798AbcLFN4w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:56:52 -0500
Received: (qmail 18246 invoked by uid 109); 6 Dec 2016 13:56:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:56:51 +0000
Received: (qmail 13516 invoked by uid 111); 6 Dec 2016 13:57:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 08:57:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 08:56:50 -0500
Date:   Tue, 6 Dec 2016 08:56:50 -0500
From:   Jeff King <peff@peff.net>
To:     paddor <paddor@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git add -p doesn't honor diff.noprefix config
Message-ID: <20161206135650.wv5cw3at4tqgpp6o@sigill.intra.peff.net>
References: <E1D7329A-A54B-4D09-A72A-62ECA8005752@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1D7329A-A54B-4D09-A72A-62ECA8005752@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2016 at 07:45:18AM +0100, paddor wrote:

> I set the config diff.noprefix = true because I don't like the a/ and
> b/ prefixes, which nicely changed the output of `git diff`.
> Unfortunately, the filenames in the output of `git add --patch` are
> still prefixed.
> 
> To me, this seems like a bug. Or there's a config option missing.

The interactive-add process is a perl script built around plumbing
commands like diff-tree, diff-files, etc.  Plumbing commands do not
respect some config options, so that the output remains stable or
scripts built around them. And diff.noprefix is one of these. So scripts
have to get the value themselves and decide whether to pass it along to
the plumbing.

In this case, I think there are two steps needed:

  1. Confirm that git-add--interactive.perl can actually handle
     no-prefix patches. It feeds the patches back to git-apply, which
     may be a complication (so it may need, for example, to pass a
     special flag to git-apply).

  2. git-add--interactive.perl needs to parse the config value, and if
     set, pass the appropriate option to the diff plumbing. This should
     only be one or two lines; see how $diff_algorithm is handled in
     that script.

-Peff
