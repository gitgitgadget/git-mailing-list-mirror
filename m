Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE7671FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 14:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbdFVOX5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 10:23:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:48688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752015AbdFVOXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 10:23:55 -0400
Received: (qmail 908 invoked by uid 109); 22 Jun 2017 14:23:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 14:23:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1201 invoked by uid 111); 22 Jun 2017 14:23:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 10:23:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 10:23:48 -0400
Date:   Thu, 22 Jun 2017 10:23:48 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Ambiguity warning printed twice ?
Message-ID: <20170622142348.hwlrajujgrxo6nwf@sigill.intra.peff.net>
References: <1498135581.2089.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1498135581.2089.1.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 06:16:21PM +0530, Kaartic Sivaraam wrote:

> I accidentally noticed a weird behaviour of 'git status'. In a
> repository I created a branch with the name 'HEAD' by chance. When I
> run 'git status' in the repository it prints a warning about an
> ambiguous reference about 'HEAD' which is expected but it prints it
> twice which seems suspicious.
> 
>     $ git branch
>       HEAD
>       master
>     * test
> 
>     $ git status
>     warning: refname 'HEAD' is ambiguous.
>     warning: refname 'HEAD' is ambiguous.
>     On branch test
>     ....
> 
> Any reasons behind this behaviour or is this a bug?

It's not unreasonable for a complex command like git-status to need to
resolve HEAD multiple times. You can see how we get to each case by
running:

  gdb /path/to/git-status

and then doing:

  break warning
  run

Each time it breaks, you can run "bt" to get a backtrace, and then "c"
to continue".

It looks like the first one is when cmd_status() resolves the HEAD to
see if we are on an unborn branch, and the second is done by wt_status
to diff the index against HEAD. It would probably be possible to feed
the results of the first resolution to wt-status. But that would just
help this case, and I wouldn't be surprised if there are other commands
that do multiple resolutions (or even scripts which call multiple
commands).

Since warning should be rare, we could keep track of which names we've
warned about and suppress multiple warnings. That would help
single-process cases like this, but scripts which call multiple Git
commands would still show multiple warnings. I don't know if that's
worth doing or not.

-Peff
