Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729D61FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 07:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbdCFHdX (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 02:33:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:38957 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752556AbdCFHdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 02:33:21 -0500
Received: (qmail 17085 invoked by uid 109); 6 Mar 2017 07:33:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 07:33:20 +0000
Received: (qmail 14514 invoked by uid 111); 6 Mar 2017 07:33:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 02:33:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Mar 2017 02:33:18 -0500
Date:   Mon, 6 Mar 2017 02:33:17 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?QW5kcsOp?= Laszlo <andre@laszlo.nu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pull: do not segfault when HEAD refers to missing object
 file
Message-ID: <20170306073317.p2txecat56zvzbmz@sigill.intra.peff.net>
References: <20170305234222.4590-1-andre@laszlo.nu>
 <20170305235222.vxia7jw2n5uj2h2e@genre.crustytoothpaste.net>
 <20170306035152.c7bh5jiqrfncyudl@sigill.intra.peff.net>
 <6726b36d-6f50-d258-12e3-8b7b56159631@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6726b36d-6f50-d258-12e3-8b7b56159631@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 07:52:10AM +0100, Johannes Sixt wrote:

> > Yeah, it is. You can do it easily with 'sed', of course, but if you want
> > to avoid the extra process and do it in pure shell, it's more like:
> > 
> >   last38=${REV#??}
> >   first2=${REV%$last38}
> >   rm -f .git/objects/$first2/$last38
> 
> Is it "HEAD points to non-existent object" or ".git/HEAD contains junk"? In
> both cases there are simpler solutions than to remove an object. For
> example, `echo "$_x40" >.git/HEAD` or `echo "this is junk" >.git/HEAD`?

Good point. Unfortunately, it's a little tricky. You can't use "this is
junk" because then git does not recognize it as a git repo at all. You
can't use $_x40 because the null sha1 is used internally to signal an
unborn branch, so we mix it up with that case.

Something like "111..." for 40 characters would work, though at that
point I think just simulating an actual corruption might be less
convoluted.

-Peff
