Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD4C1F462
	for <e@80x24.org>; Tue, 28 May 2019 19:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfE1TIT (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 15:08:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726452AbfE1TIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 15:08:19 -0400
Received: (qmail 1045 invoked by uid 109); 28 May 2019 19:08:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 19:08:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16539 invoked by uid 111); 28 May 2019 19:08:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 15:08:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 15:08:15 -0400
Date:   Tue, 28 May 2019 15:08:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190528190815.GA20499@sigill.intra.peff.net>
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <20190528055805.GB7946@sigill.intra.peff.net>
 <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 08:01:43PM +0200, René Scharfe wrote:

> Am 28.05.19 um 07:58 schrieb Jeff King:
> > On Sat, May 25, 2019 at 03:26:53PM +0200, René Scharfe wrote:
> >
> >> We could
> >> make git fsck report such symlinks.
> >
> > This is a little tricky, because fsck generally looks at individual
> > objects, and the bad pattern is a combination of a tree and a blob
> > together. I think you could make it work by reusing some of the code and
> > patterns from 9e84a6d758 (Merge branch 'jk/submodule-fsck-loose' into
> > maint, 2018-05-22).
> 
> Actually it's super easy, barely an inconvenience (SCNR, watched a lot
> of those rants recently)..  Did I miss something?

Yes. You cannot rely on calling read_object_file() in real-time when the
fsck is being done by index-pack. The blob in question may be in the
pack you are indexing.

See fsck_finish() for how we do this for .gitmodules checks.

-Peff
