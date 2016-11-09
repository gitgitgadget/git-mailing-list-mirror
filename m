Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F05B2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbcKIUnz (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 15:43:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:40864 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754297AbcKIUny (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 15:43:54 -0500
Received: (qmail 17996 invoked by uid 109); 9 Nov 2016 20:43:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 20:43:54 +0000
Received: (qmail 31549 invoked by uid 111); 9 Nov 2016 20:44:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 15:44:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2016 15:43:52 -0500
Date:   Wed, 9 Nov 2016 15:43:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree
 .gitattributes
Message-ID: <20161109204351.dflnqifjn6div5at@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
 <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
 <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
 <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
 <20161108222127.mejb74maewzhn3qg@sigill.intra.peff.net>
 <xmqqd1i49yj1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1i49yj1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2016 at 12:41:22PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For matching specific names, we have to deal with case-folding.  It's
> > easy to hit the common ones like ".GITIGNORE" with fspathcmp(). But if
> > this is actually protection against malicious repositories, we have to
> > match all of the horrible filesystem-specific junk that we did for
> > ".git".
> >
> > Symlinks are likewise tricky.
> 
> Wouldn't it be the simplest to say these:
> 
>  (1) The code attempts to read ".gitignore" (or ".git<something>")
>      in general from the filesystem, or the index, or a tree. No
>      case permutations are attempted.
> 
>  (2) When the code tries to do the above, we open with nofollow (or
>      protect racily with lstat(2) which may be the best we could do)
>      when reading from the filesystem, or check the ce_mode type
>      when reading from the index or from a tree, and ignore if the
>      path we are using is a symbolic link.
> 
> That way, case funny filesystems that cause trouble like the ".git"
> thing would not have a chance to interfere and fool us, no?

That's what my series does. The question is just whether people will be
unhappy with (2), because they are using symbolic links in their
.gitignore files.

-Peff
