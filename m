Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9AD61F453
	for <e@80x24.org>; Wed,  1 May 2019 18:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEASgk (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:36:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:46096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726069AbfEASgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:36:40 -0400
Received: (qmail 23566 invoked by uid 109); 1 May 2019 18:36:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:36:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21005 invoked by uid 111); 1 May 2019 18:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:37:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:36:38 -0400
Date:   Wed, 1 May 2019 14:36:38 -0400
From:   Jeff King <peff@peff.net>
To:     Aleksey Midenkov <midenok@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
Message-ID: <20190501183638.GF4109@sigill.intra.peff.net>
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
 <20190430174110.GA16729@sigill.intra.peff.net>
 <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 10:15:19AM +0300, Aleksey Midenkov wrote:

> > Usually when we see racy contention on index.lock, the culprit turns out
> > to be another unrelated git process refreshing the index. Do you have
> > anything else running which might be using "git status" (e.g., magit in
> > emacs, vim git integration, etc)?
> 
> kdevelop which is git-aware. But if git fails on concurrent operation
> this is still not good. I would expect it to wait until lock releases
> for some time.

Historically Git does not wait for locks because whoever is holding the
lock is likely to invalidate the changes we're proposing to make by
taking the lock in the first place. We've softened on that a bit in
recent years (e.g., ref updates now retry with a timeout to accommodate
things like reflog pruning), but I don't think the index code does.

If the other entity holding the lock is just updating the stat
information in the index, that's probably OK. If it's actually
manipulating the index, I think we'd have to give more thought about
whether that's safe.

Assuming that kdevelop is just running "git status" in the background,
though, there's an easier solution. If it uses "git --no-optional-locks
status" instead, that will instruct it not to take the index lock at
all.

-Peff
