Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B6A1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdAYU50 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:57:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:44766 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbdAYU50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:57:26 -0500
Received: (qmail 2182 invoked by uid 109); 25 Jan 2017 20:57:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 20:57:21 +0000
Received: (qmail 15769 invoked by uid 111); 25 Jan 2017 20:57:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 15:57:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 15:57:18 -0500
Date:   Wed, 25 Jan 2017 15:57:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after
 --exclude
Message-ID: <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
 <20170125125054.7422-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170125125054.7422-5-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 07:50:53PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Behavior change: "--exclude --blah --remotes" will not exclude remote
> branches any more. Only "--exclude --remotes" does.
> 
> This is because --exclude is going to have a new friend --decorate-reflog
> who haves the same way. When you allow a distant --remotes to complement
> a previous option, things get complicated. In
> 
>     --exclude .. --decorate-reflog ... --remotes
> 
> Does it mean decorate remote reflogs, or does it mean exclude remotes
> from the selected revisions?

I don't think it means either. It means to include remotes in the
selected revisions, but excluding the entries mentioned by --exclude.

IOW:

  --exclude=foo --remotes
	include all remotes except refs/remotes/foo

  --exclude=foo --unrelated --remotes
        same

  --exclude=foo --decorate-reflog --remotes
        decorate reflogs of all remotes except "foo". Do _not_ use them
	as traversal tips.

  --decorate-reflog --exclude=foo --remotes
        same

IOW, the ref-selector options build up until a group option is given,
which acts on the built-up options (over that group) and then resets the
built-up options. Doing "--unrelated" as above is orthogonal (though I
think in practice nobody would do that, because it's hard to read).

> Granted, there may be valid use cases for such a combination (e.g.
> "decorate all reflogs except remote ones") but I feel option order is
> not a good fit to express them.

That would be spelled:

  --exclude=refs/remotes --decorate-reflogs --all

(or you could swap the first two options).

Again, I'm not sure if I'm missing something subtle, or if you are
confused about how --exclude works. :)

-Peff
