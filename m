Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73191F597
	for <e@80x24.org>; Sun, 29 Jul 2018 09:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeG2K5u (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 06:57:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:34460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726214AbeG2K5u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 06:57:50 -0400
Received: (qmail 30265 invoked by uid 109); 29 Jul 2018 09:28:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Jul 2018 09:28:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7415 invoked by uid 111); 29 Jul 2018 09:28:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 29 Jul 2018 05:28:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2018 05:28:00 -0400
Date:   Sun, 29 Jul 2018 05:28:00 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clone and case sensitivity
Message-ID: <20180729092759.GA14484@sigill.intra.peff.net>
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net>
 <20180728043559.GA29185@duynguyen.home>
 <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
 <20180728044857.GA10444@sigill.intra.peff.net>
 <20180728051105.GA32243@duynguyen.home>
 <20180728095659.GA21450@sigill.intra.peff.net>
 <CACsJy8DTQhinpLOhojnrpFt3_2tVo3mo1Dwv-x4aF3mZJ2Rhgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DTQhinpLOhojnrpFt3_2tVo3mo1Dwv-x4aF3mZJ2Rhgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 29, 2018 at 07:26:41AM +0200, Duy Nguyen wrote:

> > strcasecmp() will only catch a subset of the cases. We really need to
> > follow the same folding rules that the filesystem would.
> 
> True. But that's how we handle case insensitivity internally. If a
> filesytem has more sophisticated folding rules then git will not work
> well on that one anyway.

Hrm. Yeah, I guess that's the best we can do for the actual in-memory
checks. Everything else depends on doing an actual filesystem operation,
and our icase stuff kicks in way before then. I was mostly thinking of
HFS+ utf8 normalization weirdness, but I guess people are accustomed to
that by now.

> > For the case of clone, I actually wonder if we could detect during the
> > checkout step that a file already exists. Since we know that the
> > directory we started with was empty, then if it does, either:
> >
> >   - there's some funny case-folding going on that means two paths in the
> >     repository map to the same name in the filesystem; or
> >
> >   - somebody else is writing to the directory at the same time as us
> 
> This is exactly what my first patch does (minus the sparse checkout
> part).

Right, sorry, I should have read that one more carefully.

> But without knowing the exact folding rules, I don't think we can
> locate this "somebody else" who wrote the first path. So if N paths
> are treated the same by this filesystem, we could only report N-1 of
> them.
> 
> If we want to report just one path when this happens though, then this
> works quite well.

Hmm. Since most such systems are case-preserving, would it be possible
to report the name of the existing file? Doing it via opendir/readdir is
hacky, and anyway puts the burden on us to find the matching name. Doing
it via fstat() on the opened file doesn't work because at that the
filesystem has resolved the name to an inode.

So yeah, perhaps strcasecmp() is the best we can do (I do agree that
being able to mention all of the conflicting names is a benefit).

I guess we should be using fspathcmp(), though, in case it later learns
to be smarter.

-Peff
