Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531AD1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 04:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbdAZE5E (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 23:57:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:45110 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbdAZE5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 23:57:04 -0500
Received: (qmail 1547 invoked by uid 109); 26 Jan 2017 04:57:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 04:57:04 +0000
Received: (qmail 20228 invoked by uid 111); 26 Jan 2017 04:57:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 23:57:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 23:57:01 -0500
Date:   Wed, 25 Jan 2017 23:57:01 -0500
From:   Jeff King <peff@peff.net>
To:     Paul Hammant <paul@hammant.org>
Cc:     git@vger.kernel.org
Subject: Re: sparse checkout - weird behavior
Message-ID: <20170126045701.eouw5kzyq5bevc5c@sigill.intra.peff.net>
References: <CA+298Uh=bfCJq3hmVdGUsinAgKFQd86em_J_8fwB9jQR5PZVgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+298Uh=bfCJq3hmVdGUsinAgKFQd86em_J_8fwB9jQR5PZVgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 09:59:38PM -0500, Paul Hammant wrote:

> Here's a simple reproducible bug - something unexpected in sparse-checkout mode:
> 
>   $ git clone git@github.com:jekyll/jekyll.git --no-checkout
>   Cloning into 'jekyll'...
>   remote: Counting objects: 41331, done.
>   remote: Compressing objects: 100% (5/5), done.
>   remote: Total 41331 (delta 0), reused 0 (delta 0), pack-reused 41326
>   Receiving objects: 100% (41331/41331), 11.91 MiB | 7.98 MiB/s, done.
>   Resolving deltas: 100% (26530/26530), done.
>   $ cd jekyll
>   $ ls
>   $ git config core.sparsecheckout true
>   $ echo 'docs*' > .git/info/sparse-checkout
>   $ git read-tree -mu HEAD
>   $ ls
>   docs rake
> 
> I didn't expect to see 'rake' amongst the results.

If you look inside the rake/ directory, you should see that only
"docs.rake" was checked out.

The sparse-checkout file uses the same parser as .git/info/exclude. One
important aspect of that file is that entries are _not_ left-anchored
unless they start with "/". So you asked Git to include files named
"docs*" anywhere in the tree.

You probably wanted just:

  echo /docs >.git/info/sparse-checkout

-Peff
