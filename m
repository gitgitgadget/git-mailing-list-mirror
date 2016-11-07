Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779F32022A
	for <e@80x24.org>; Mon,  7 Nov 2016 21:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbcKGVKN (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 16:10:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:39902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752070AbcKGVKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 16:10:12 -0500
Received: (qmail 10437 invoked by uid 109); 7 Nov 2016 21:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 21:10:12 +0000
Received: (qmail 16053 invoked by uid 111); 7 Nov 2016 21:10:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 16:10:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 16:10:10 -0500
Date:   Mon, 7 Nov 2016 16:10:10 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree
 .gitattributes
Message-ID: <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
 <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 05:03:42PM +0700, Duy Nguyen wrote:

> On Wed, Nov 2, 2016 at 8:08 PM, Jeff King <peff@peff.net> wrote:
> > The attributes system may sometimes read in-tree files from
> > the filesystem, and sometimes from the index. In the latter
> > case, we do not resolve symbolic links (and are not likely
> > to ever start doing so). Let's open filesystem links with
> > O_NOFOLLOW so that the two cases behave consistently.
> 
> This sounds backward to me. The major use case is reading
> .gitattributes on worktree, which follows symlinks so far. Only
> git-archive has a special need to read index-only versions. The
> worktree behavior should influence the in-index one, not the other way
> around. If we could die("BUG" when git-archive is used on symlinks
> (without --worktree-attributes). If people are annoyed by it, they can
> implement symlink folllowing (to another version in index, not on
> worktree).

I agree it feels a little backwards, as we are choosing the
lowest-common denominator of the two (so it would be reasonable to have
the in-index version follow symbolic links, or at least do so on
platforms where core.symlinks is true).

And I'll admit my main motivation is not that index/filesystem parity,
but rather just that:

  git clone git://host.com/malicious-repo.git
  git log

might create and read symlinks to arbitrary files on the cloner's box.
I'm not sure to what degree to be worried about that. It's not like you
can't make other arbitrary symlinks which are likely to be read if the
user actually starts looking at checked-out files. It's just that we
usually try to make a clone+log of a malicious repository safe.

That being said, I'm not convinced that reading the index version of
.gitattributes and .gitignore is just an optimization. Don't we read the
destination attributes when checking out a new tree? And doesn't merge
need to use the in-index version when we see conflicts?

So I was hoping that this was a practice that is unlikely to be in wide
use, and that we could simply ban in order to keep the attribute and
ignore code simpler and safer, both now and if we change them to do more
in-index lookups.

-Peff
