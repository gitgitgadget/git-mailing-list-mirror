Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FBE21FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755924AbcLNRI4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 12:08:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:56489 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753990AbcLNRIz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 12:08:55 -0500
Received: (qmail 8623 invoked by uid 109); 14 Dec 2016 17:08:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 17:08:54 +0000
Received: (qmail 26346 invoked by uid 111); 14 Dec 2016 17:09:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 12:09:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 12:08:52 -0500
Date:   Wed, 14 Dec 2016 12:08:52 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Leho Kraav <leho@conversionready.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 0/7] Fix and generalize version sort reordering
Message-ID: <20161214170852.bzh5pyl4bov6rwbt@sigill.intra.peff.net>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161208142401.1329-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2016 at 03:23:54PM +0100, SZEDER Gábor wrote:

> > With my patches it looks like this:
> > 
> >     $ git -c versionsort.prereleasesuffix=-pre \
> >           -c versionsort.prereleasesuffix=-prerelease \
> >           tag -l --sort=version:refname
> >     v1.0.0-prerelease1
> >     v1.0.0-pre1
> >     v1.0.0-pre2
> >     v1.0.0
> 
> And when there happen to be more than one matching suffixes starting
> at the same earliest position, then we should pick the longest of
> them.  The new patch 6/7 implements this behavior.

The whole approach taken by the suffix code (before your patches) leaves
me with the nagging feeling that the comparison is not always going to
be transitive (i.e., that "a < b && b < c" does not always imply "a <
c"), which is going to cause nonsensical sorting results.

And that may be part of the issue your 6/7 fixes.

I spent some time playing with this the other day, though, and couldn't
come up with a specific example that fails the condition above.

It just seems like the whole thing would conceptually easier if we
pre-parsed the versions into a sequence of elements, then the comparison
between any two elements would just walk that sequence. The benefit
there is that you can implement whatever rules you like for the parsing
(like "prefer longer suffixes to shorter"), but you know the comparison
will always be consistent.

It would also be more efficient, I think (it seems like the sort is
O(nr_tags * lg(nr_tags) * nr_suffixes) due to parsing suffixes in the
comparator). Though that probably doesn't matter much in practice.

I dunno. I think maybe your 6/7 has converged on an equivalent behavior.
And I am certainly not volunteering to re-write it, so if what you have
works, I'm not opposed to it.

-Peff
