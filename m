Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A329EC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7813A61157
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhINWQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:16:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:47514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhINWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:16:58 -0400
Received: (qmail 26404 invoked by uid 109); 14 Sep 2021 22:15:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 22:15:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29801 invoked by uid 111); 14 Sep 2021 22:15:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 18:15:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 18:15:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/9] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUEfDBjAAsH9SLeY@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
 <YUEdqRQ4qQdHuSV/@coredump.intra.peff.net>
 <YUEeFENv04Ht5zXd@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUEeFENv04Ht5zXd@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 06:11:32PM -0400, Taylor Blau wrote:

> On Tue, Sep 14, 2021 at 06:09:45PM -0400, Jeff King wrote:
> > On Tue, Sep 14, 2021 at 11:37:06AM -0400, Jeff King wrote:
> >
> > > +test_expect_success 'ignore very large set of prefixes' '
> > > +	# generate a large number of ref-prefixes that we expect
> > > +	# to match nothing; the value here exceeds MAX_ALLOWED_PREFIXES
> > > +	# from ls-refs.c.
> > > +	{
> > > +		echo command=ls-refs &&
> > > +		echo object-format=$(test_oid algo)
> > > +		echo 0001 &&
> > > +		perl -le "print \"refs/heads/$_\" for (1..65536+1)" &&
> > > +		echo 0000
> > > +	} |
> > > +	test-tool pkt-line pack >in &&
> >
> > Yuck. While double-checking some refactoring, I realized this test does
> > not actually generate the correct input!
> >
> > It omits the "ref-prefix" header. _And_ it accidentally expands $_ in
> > the shell rather than in perl.
> 
> Hah, nice find. You'd think that one of us would have caught it earlier
> given that we both discussed it.

Really, I'd have thought that ls-refs would complain about a totally
bogus capability. I'll see if I can fix that, as well.

-Peff
