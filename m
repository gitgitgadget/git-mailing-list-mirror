Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F5AC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AEF22BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgHCVLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:11:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:46882 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbgHCVLN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 17:11:13 -0400
Received: (qmail 29476 invoked by uid 109); 3 Aug 2020 21:11:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Aug 2020 21:11:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5109 invoked by uid 111); 3 Aug 2020 21:11:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Aug 2020 17:11:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Aug 2020 17:11:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
Message-ID: <20200803211112.GA2720049@coredump.intra.peff.net>
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
 <20200803160051.GA50799@syl.lan>
 <20200803194006.GA2715275@coredump.intra.peff.net>
 <20200803204503.GB2715275@coredump.intra.peff.net>
 <xmqq1rknv3xl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rknv3xl.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 02:02:14PM -0700, Junio C Hamano wrote:

> > There are probably some rough edges that could be smoothed (only looking
> > in refs/heads/ and using branch names instead of fully qualified refs,
> > handling the case that $to already exists more gracefully, better
> > prompting). But something like that might be useful for projects that
> > are transitioning.
> >
> > Note that it only works with protocol v2, though, because we don't
> > report non-HEAD symrefs in v0.
> 
> Renaming local branches themselves is probably the least interesting
> part.  You could even do _without_ renaming your local branches at
> all and keep working without any problem.  But you need to be able
> to adjust to the renaming upstream does, so if your 'topic' branch
> builds on top of 'refs/remotes/origin/master' and your upstream
> renames it to 'refs/remotes/origin/stuff' you'd need to reconfigure
> 'topic' branch to also build on and/or integrate with 'stuff'
> instead of 'master'.

Yeah, good point. That would be pretty easy to add to the script I
showed by looking at:

  git config --get-regexp 'branch\..*\.merge' refs/heads/master

And I guess checking the matching branch.*.remote to match $remote. I
think we're getting to the realm where it would be easier to implement
in something besides shell. :)

But I do think a "branch renaming" helper like this might be useful for
projects undergoing this rename. I don't think it makes sense to have as
a first-class Git command, but I wouldn't be opposed to carrying
something like it in contrib/ if somebody wanted to polish it up.

-Peff
