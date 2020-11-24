Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45413C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 06:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C222080A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 06:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgKXG6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 01:58:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:39836 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgKXG6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 01:58:47 -0500
Received: (qmail 32351 invoked by uid 109); 24 Nov 2020 06:58:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 06:58:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11868 invoked by uid 111); 24 Nov 2020 06:58:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Nov 2020 01:58:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Nov 2020 01:58:46 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
Message-ID: <X7yvJkCHa0+mpwPr@coredump.intra.peff.net>
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
 <20201120235203.GA353076@coredump.intra.peff.net>
 <xmqq3613tuwy.fsf@gitster.c.googlers.com>
 <20201121004033.GD353076@coredump.intra.peff.net>
 <CAMP44s0E+e11jGFDa1zLK5Tv+2Zuv-_wXNF0NysoqEjtMgv0Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s0E+e11jGFDa1zLK5Tv+2Zuv-_wXNF0NysoqEjtMgv0Pw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 07:18:39PM -0600, Felipe Contreras wrote:

> On Fri, Nov 20, 2020 at 6:40 PM Jeff King <peff@peff.net> wrote:
> 
> > I don't think we do advertise the symref in such a case. In v2, the
> > symref information is attached to individual lines in the ref
> > advertisement. And we don't advertise the unborn line (we could, but I
> > think we might need a special syntax for the oid field).
> 
> This may be worth considering changing.

I agree it might be nice, but may not be worth the effort (it will
require a protocol extension).

However...

> If a hosting provider (e.g. GitHub) decides to configure an initial
> branch (e.g. main) it would be nice for "git clone" to have
> information about that initial branch so the user doesn't have to
> change it manually to please the provider's aesthetics.
> 
> So the instructions could be:
> 
>   git clone $url .
>   echo "# myproject" >> README.md
>   git add README.md
>   git commit -m "first commit"
>   # git branch -M main # this step would not be necessary
>   git push -u origin HEAD
> 
> Personally I don't care about this. But others might find it useful.

I don't think you have to do the rename here if you don't want to.
If there is already content on the "main" branch at GitHub, then clone
should pick that as the default branch for your local clone.

If there isn't, then you'll get whatever your local git-clone decides
on. But when you push, at least to GitHub, if the server-side HEAD
points to an unborn branch, it will re-point to the newly pushed branch.
So with the current version of Git, you would end up with "master" on
the remote side. And that should continue to work as it always has
(AFAIK any changes on GitHub's side are purely about default branch
names, such as when you add template files as part of the repo
initialization).

Of course if you _want_ "main" in both cases, you'd have to rename the
branch. But you would probably set init.defaultBranch in that case.

-Peff
