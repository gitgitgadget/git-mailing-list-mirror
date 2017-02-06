Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC621FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 16:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbdBFQOg (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 11:14:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:49828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbdBFQOf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 11:14:35 -0500
Received: (qmail 12603 invoked by uid 109); 6 Feb 2017 16:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 16:14:35 +0000
Received: (qmail 14084 invoked by uid 111); 6 Feb 2017 16:14:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 11:14:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 17:14:33 +0100
Date:   Mon, 6 Feb 2017 17:14:33 +0100
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/5] stash: support pathspec argument
Message-ID: <20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170205202642.14216-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2017 at 08:26:37PM +0000, Thomas Gummerer wrote:

> Thanks Junio for the review in the previous round.
> 
> Changes since v2:
> 
> - $IFS should now be supported by using "$@" everywhere instead of using
>   a $files variable.
> - Added a new patch showing the old behaviour of git stash create is
>   preserved.
> - Rephrased the documentation
> - Simplified the option parsing in save_stash, by leaving the
>   actual parsing to push_stash instead.

Overall, I like the direction this is heading. I raised a few issues,
the most major of which is whether we want to allow the minor regression
in "git stash create -m foo".

This also makes "git stash push -p <pathspec...>" work, which is good. I
don't think "git stash -p <pathspec...>" does, though. I _think_ it
would be trivial to do on top, since we already consider that case an
error. That's somewhat outside the scope of your series, so I won't
complain (too much :) ) if you don't dig into it, but it might just be
trivial on top.

A few other random bits I noticed while playing with the new code:

  $ git init
  $ echo content >file && git add file && git commit -m file
  $ echo change >file

  $ git stash push -p not-file
  No changes.
  No changes selected

Probably only one of those is necessary. :)

Let's keep trying a few things:

  $ git stash push not-file
  Saved working directory and index state WIP on master: 5d5f951 file
  Unstaged changes after reset:
  M	file
  M	file

The unstaged change is mentioned twice, which is weird. But weirder
still is that we created a stash at all, as it's empty. Why didn't we
hit the "no changes selected" path?

And one more:

  $ echo foo >untracked
  $ git stash push untracked
  Saved working directory and index state WIP on master: 5d5f951 file
  Unstaged changes after reset:
  M	file
  M	file
  Removing untracked

We removed the untracked file, even though it wasn't actually stashed! I
thought at first this was because it was mentioned as a pathspec, but it
seems to happen even with a different name:

  $ echo foo >untracked
  $ git stash push does-not-exist
  ...
  Removing untracked

That seems dangerous.

-Peff
