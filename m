Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85B61F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeHJALQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:11:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:49168 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727290AbeHJALQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:11:16 -0400
Received: (qmail 5737 invoked by uid 109); 9 Aug 2018 21:44:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 21:44:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14035 invoked by uid 111); 9 Aug 2018 21:44:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 17:44:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 17:44:30 -0400
Date:   Thu, 9 Aug 2018 17:44:30 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180809214430.GE11342@sigill.intra.peff.net>
References: <20180730152756.15012-1-pclouds@gmail.com>
 <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
 <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
 <20180808223139.GA3902@sigill.intra.peff.net>
 <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
 <20180809142333.GB1439@sigill.intra.peff.net>
 <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
 <CABPp-BHiB_gR-dQbpJtSBYPJ5Om4Mv0ymnZFNocyTfbUotyBgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHiB_gR-dQbpJtSBYPJ5Om4Mv0ymnZFNocyTfbUotyBgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 02:40:58PM -0700, Elijah Newren wrote:

> > I worry that the false positives make this a non-starter.  I mean, if
> > clone creates files 'A' and 'B' (both equal) and then tries to create
> > 'b', would the collision code reports that 'b' collided with 'A' because
> > that was the first OID match?  Ideally with this scheme we'd have to
> > search the entire index prior to 'b' and then report that 'b' collided
> > with either 'A' or 'B'.  Neither message instills confidence.  And
> > there's no way to prefer answer 'B' over 'A' without using knowledge
> > of the FS name mangling/aliasing rules -- unless we want to just assume
> > ignore-case for this iteration.
> 
> A possibly crazy idea: Don't bother reporting the other filename; just
> report the OID instead.
> 
> "Error: Foo.txt cannot be checked out because another file with hash
> <whatever> is in the way."  Maybe even add a hint for the user: "Run
> `git ls-files -s` to see see all files and their hash".
> 
> Whatever the exact wording for the error message, just create a nice
> post on stackoverflow.com explaining the various weird filesystems out
> there (VFAT, NTFS, HFS, APFS, etc) and how they cause differing
> filenames to be written to the same location.  Have a bunch of folks
> vote it up so it has some nice search-engine juice.

Actually, I kind of like the simplicity of that. It puts the human brain
in the loop.

> The error message isn't quite as good, but does the user really need
> all the names of the file?  If so, we gave them enough information to
> figure it out, and this is a really unusual case anyway, right?
> Besides, now we're back to linear performance....

Well, it's still quadratic when they run O(n) iterations of "git
ls-files -s | grep $colliding_oid". You've just pushed the second linear
search onto the user. ;)

-Peff
