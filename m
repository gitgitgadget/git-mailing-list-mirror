Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1D7201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 08:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbdB0IQA (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 03:16:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:34608 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbdB0IP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 03:15:59 -0500
Received: (qmail 12599 invoked by uid 109); 27 Feb 2017 07:49:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 07:49:17 +0000
Received: (qmail 20623 invoked by uid 111); 27 Feb 2017 07:49:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 02:49:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 02:49:16 -0500
Date:   Mon, 27 Feb 2017 02:49:16 -0500
From:   Jeff King <peff@peff.net>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 11:43:46AM +0530, Karthik Nayak wrote:

> On Mon, Feb 27, 2017 at 10:22 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Hi,
> >
> > I just discover something which very much seems a bug to me
> > while making an error in renaming a branch.
> > The scenario is the following:
> > - I have a branch named 'orig'
> > - I want to make some experimental changes on it:
> >         $ git checkout -b temp orig
> >         $ ... edit some files ...
> >         $ ... make some tests & commits ...
> > - I'm happy with my changes, so I want to have my original
> >   branch to now points to the head of this temp branch
> >   but did it wrongly:
> >         $ git branch -m -f orig @
> 
> Here you are using the '-m' flag, which is to rename a branch. So what
> you're essentially
> doing is:
>     $ git branch -m -f orig HEAD
> Do note that this won't reset 'orig' to point to 'HEAD', rather this
> renames 'orig' to 'HEAD'.
> 
> What you actually want to do (to reset 'orig' to 'HEAD') is:
>     $ git branch -f orig @
> This would make orig point to the current HEAD.

Regardless of the original intent, I think it is wrong to convert "@" to
a branch named "HEAD". I think the bug is in strbuf_check_branch_ref(),
which blindly sticks "refs/heads/" in front of any value we get from
interpret_branch_name(), which clearly does not make sense for HEAD.

-Peff
