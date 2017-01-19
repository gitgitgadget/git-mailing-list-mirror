Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D532720A17
	for <e@80x24.org>; Thu, 19 Jan 2017 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbdASRau (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 12:30:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:41601 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753526AbdASRaT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 12:30:19 -0500
Received: (qmail 32390 invoked by uid 109); 19 Jan 2017 17:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 17:23:12 +0000
Received: (qmail 6907 invoked by uid 111); 19 Jan 2017 17:24:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 12:24:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 12:23:10 -0500
Date:   Thu, 19 Jan 2017 12:23:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] log: new option decorate reflog of remote refs
Message-ID: <20170119172310.6meuj6ksxloeee2t@sigill.intra.peff.net>
References: <20170119122630.27645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170119122630.27645-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 07:26:30PM +0700, Nguyễn Thái Ngọc Duy wrote:

> This is most useful when you fork your branches off a remote ref and
> rely on ref decoration to show your fork points in `git log`. Then you
> do a "git fetch" and suddenly the remote decoration is gone because
> remote refs are moved forward. With this, we can still see something
> like "origin/foo@{1}"
> 
> This is for remote refs only because based on my experience, docorating
> local reflog is just too noisy. You will most likely see HEAD@{1},
> HEAD@{2} and so on. We can add that as a separate option in future if we
> see a need for it.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  I've been using this for many weeks and it has proven its usefulness
>  (to me). Looks like good material to send upstream.

I think it's a neat idea, but the actual option:

> +--decorate-remote-reflog[=<n>]::
> +	Decorate `<n>` most recent reflog entries on remote refs, up
> +	to the specified number of entries. By default, only the most
> +	recent reflog entry is decorated.

seems weirdly limited and non-orthogonal. What happens when somebody
wants to decorate other reflogs besides refs/remotes?

We already have very flexible ref-selectors like --remotes, --branches,
etc. The generalization of this would perhaps be something like:

  git log --decorate-reflog --remotes --branches

where "--decorate-reflog" applies to the next ref selector and then is
reset, the same way --exclude is. And it includes those refs _only_ for
decoration, not for traversal. So you could do:

  git log --decorate-reflog --remotes --remotes

if you wanted to see use those as traversal roots, too (if this is
common, it might even merit another option for "decorate and show").

That's just off the top of my head, so maybe there are issues. I was
just surprised to see the "-remote" part in your option name.

-Peff
