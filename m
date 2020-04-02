Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67008C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453862078E
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 12:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbgDBMvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:51:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:59406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726252AbgDBMvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 08:51:14 -0400
Received: (qmail 12540 invoked by uid 109); 2 Apr 2020 12:51:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Apr 2020 12:51:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5125 invoked by uid 111); 2 Apr 2020 13:01:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2020 09:01:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Apr 2020 08:51:13 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] t5319: replace 'touch -m' with 'test-tool chmtime'
Message-ID: <20200402125113.GA3091800@coredump.intra.peff.net>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
 <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
 <24e26ecda632421e4c1a61ebabf6ea78301685b1.1585774844.git.gitgitgadget@gmail.com>
 <xmqq369m6g9u.fsf@gitster.c.googlers.com>
 <8e6b1f75-534a-ad79-544b-126ea61b2058@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e6b1f75-534a-ad79-544b-126ea61b2058@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 08:06:47PM -0400, Derrick Stolee wrote:

> > Also, in the best case (i.e. original timestamp of A/B/C/D are the
> > same), the above seems to assume that the filesystem has at least 1
> > second file timestamp granularity.  Do we want to make them at least
> > 2 seconds apart, or am I worried too much about ancient filesystems
> > that no longer metter?
> 
> The old test relied on one-second granularity, so that hasn't changed.
> I could easily space it out a bit more without issue.
> 
> Your concern about the original timestamps getting skewed shouldn't
> be an issue because "test-tool chmtime =-<seconds>" subtracts the
> <seconds> from the current system time, not the file's mtime. This
> is subtle: without the "=" it would modify it from the file's mtime.
> 
> Since we are assigning the offset values in the proper order (D to A)
> there isn't an issue if time ticks forward between these steps.

I wonder if that would run afoul of the same "mtime and system clock are
not quite the same" issue we saw recently in [1].

I think it might not because we're only comparing mtimes set through the
same mechanism (find the system time, subtract from it, and assign to
mtime). If system time is monotonically increasing at any rate, that
would produce the desired effect.

That said, it seems so easy to just give it a 10 second (or even 10
minute) spread to avoid any possibility of confusion.

-Peff

[1] https://lore.kernel.org/git/pull.725.git.git.1584125875550.gitgitgadget@gmail.com/
