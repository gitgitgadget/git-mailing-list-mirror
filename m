Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D86C77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 06:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjFDGAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 02:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDGAx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 02:00:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F7CF
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 23:00:51 -0700 (PDT)
Received: (qmail 647 invoked by uid 109); 4 Jun 2023 06:00:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 Jun 2023 06:00:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17632 invoked by uid 111); 4 Jun 2023 06:00:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Jun 2023 02:00:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 4 Jun 2023 02:00:48 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     paul@mad-scientist.net, git@vger.kernel.org
Subject: Re: Anyone know why git ls-remote output might be corrupted?
Message-ID: <20230604060048.GA38176@coredump.intra.peff.net>
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
 <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2023 at 06:12:52PM -0700, Elijah Newren wrote:

> > Also a bunch of the heads are missing.  It's pretty clear that right in
> > the middle of printing one of the SHAs we suddenly lost a bunch of
> > output, and started printing stuff from later (in the last instance 66
> > out of 131 heads were missing).  Breaking down the output above you can
> > see:
> >
> >   3a2e8036a6f6605d4dd14c72bd395298bff9d80e        refs/heads/xxx2
> >   795d2ff669041fc91341cf5bf820aibab79dc92bd741e77a7dcf71d94285a6ae494dc0        refs/heads/yyy1
> >                                ^
> >
> > where the "795d2ff669041fc91341cf5bf820a" before the "i" char is a
> > valid start of a SHA for a head (not shown), then the "i", then a fully
> > valid SHA for heads/yyy1 which is 66 heads later.
> 
> Sounds kind of like
> https://lore.kernel.org/git/6786526.72e2EbofS7@devpool47/ which also
> triggered for some other tooling and then was reduced down to some
> shell commands.  Unfortunately, the thread ended without a lot of
> resolution other than "don't mix stdout and stderr" and "if we slow
> down the network connection somehow, that'll avoid the problem".

Thanks for digging up that thread. I had a vague memory of this coming
up before, but wasn't sure what to search for to find it. :)

From that thread, one theory that I think remains unexplored: could
ls-remote's stdout be opened in non-blocking mode?

The output of ls-remote is written with printf(). We don't bother
checking for errors from stdio, since typically a write error would
result in us getting EPIPE and being killed. But if stdout were
unexpectedly in non-blocking mode, we might get EAGAIN. I'm not sure how
libc would handle that.

Now, why the descriptor would be in non-blocking mode, I have no idea.
But maybe something funny going on in your python script.

I'd be curious if applying the patch from:

  https://lore.kernel.org/git/YUTo1BTp7BXOw6K9@coredump.intra.peff.net/

reports any problems. As well as whether the suggested "sleep" pipeline
there (triggered via your script in this case) shows the problem more
reliably.

-Peff
