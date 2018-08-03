Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8152F1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeHCUu6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:50:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:42214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727809AbeHCUu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 16:50:58 -0400
Received: (qmail 15221 invoked by uid 109); 3 Aug 2018 18:53:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 18:53:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5382 invoked by uid 111); 3 Aug 2018 18:53:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 14:53:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 14:53:26 -0400
Date:   Fri, 3 Aug 2018 14:53:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180803185325.GA27977@sigill.intra.peff.net>
References: <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
 <20180731203746.GA9442@sigill.intra.peff.net>
 <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
 <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
 <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
 <20180802190644.GE23690@sigill.intra.peff.net>
 <xmqqmuu4zd1l.fsf@gitster-ct.c.googlers.com>
 <20180802212819.GA32538@sigill.intra.peff.net>
 <5b17454b-7fa7-7a9c-92d9-214e6e697785@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b17454b-7fa7-7a9c-92d9-214e6e697785@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 03, 2018 at 02:23:17PM -0400, Jeff Hostetler wrote:

> > Maybe. It might not work as ino_t. Or it might be expensive to get.  Or
> > maybe it's simply impossible. I don't know much about Windows. Some
> > searching implies that NTFS does have a "file index" concept which is
> > supposed to be unique.
> 
> This is hard and/or expensive on Windows.  Yes, you can get the
> "file index" values for an open file handle with a cost similar to
> an fstat().  Unfortunately, the FindFirst/FindNext routines (equivalent
> to the opendir/readdir routines), don't give you that data.  So we'd
> have to scan the directory and then open and stat each file.  This is
> terribly expensive on Windows -- and the reason we have the fscache
> layer (in the GfW version) to intercept the lstat() calls whenever
> possible.

I think that high cost might be OK for our purposes here. This code
would _only_ kick in during a clone, and then only on the error path
once we knew we had a collision during the checkout step.

> Another thing to keep in mind is that the collision could be because
> of case folding (or other such nonsense) on a directory in the path.
> I mean, if someone on Linux builds a commit containing:
> 
>     a/b/c/D/e/foo.txt
>     a/b/c/d/e/foo.txt
> 
> we'll get a similar collision as if one of them were spelled "FOO.txt".

True, though I think that may be OK. If you had conflicting directories
you'd get a _ton_ of duplicates listed, but that makes sense: you
actually have a ton of duplicates.

> Also, do we need to worry about hard-links or symlinks here?

I think we can ignore hardlinks. Git never creates them, and we know the
directory was empty when we started. Symlinks should be handled by using
lstat(). (Obviously that's for a Unix-ish platform).

> I'm sure there are other edge cases here that make reporting
> difficult; these are just a few I thought of.  I guess what I'm
> trying to say is that as a first step just report that you found
> a collision -- without trying to identify the set existing objects
> that it collided with.

I certainly don't disagree with that. :)

> > At any rate, until we have an actual plan for Windows, I think it would
> > make sense only to split the cases into "has working inodes" and
> > "other", and make sure "other" does something sensible in the meantime
> > (like mention the conflict, but skip trying to list duplicates).
> 
> Yes, this should be split.  Do the "easy" Linux version first.
> Keep in mind that there may also be a different solution for the Mac.

I assumed that an inode-based solution would work for Mac, since it's
mostly BSD under the hood. There may be subtleties I don't know about,
though.

-Peff
