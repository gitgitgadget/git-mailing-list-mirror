Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79BF81FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756056AbcLATJ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:09:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:50014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753824AbcLATJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:09:27 -0500
Received: (qmail 9891 invoked by uid 109); 1 Dec 2016 19:09:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:09:27 +0000
Received: (qmail 2192 invoked by uid 111); 1 Dec 2016 19:10:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 14:10:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 14:09:25 -0500
Date:   Thu, 1 Dec 2016 14:09:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-2-git-send-email-bmwill@google.com>
 <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 10:46:23AM -0800, Junio C Hamano wrote:

> > mkpath() is generally an unsafe function because it uses a static
> > buffer, but it's handy and safe for handing values to syscalls like
> > this.
> 
> I think your "unsafe" is not about thread-safety but about "the
> caller cannot rely on returned value staying valid for long haul".
> If this change since v5 is about thread-safety, I am not sure if it
> is safe to use mkpath here.

Oh, good point. I meant "staying valid", but somehow totally forgot that
we cared about thread reentrancy here. As if I hadn't just spent an hour
debugging a thread problem.

My suggestion is clearly nonsense.

> I am a bit wary of making the check too sketchy like this, but this
> is not about determining if a random "path" that has ".git" in a
> superproject working tree is a submodule or not (that information
> primarily comes from the superproject index), so I tend to agree
> with the patch that it is sufficient to check presence of ".git"
> alone.

The real danger is that it is a different check than the child process
is going to use, so they may disagree (see the almost-infinite-loop
discussion elsewhere).

It feels quite hacky, but checking:

  if (is_git_directory(suspect))
	return 1; /* actual git dir */
  if (!stat(suspect, &st) && S_ISREG(st.st_mode))
	return 1; /* gitfile; may or may not be valid */
  return 0;

is a little more robust, because the child process will happily skip a
non-repo ".git" and keep walking back up to the superproject. Whereas if
it sees any ".git" file, even if it is bogus, it will barf then and
there.

I'm actually not sure if that latter behavior is a bug or not. I don't
think it was really planned out, and it obviously is inconsistent with
the other repo-discovery cases. But it is a convenient side effect for
submodules, and I doubt anybody is bothered by it in practice.

-Peff
