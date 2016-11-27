Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B8A1FC96
	for <e@80x24.org>; Sun, 27 Nov 2016 05:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbcK0FIW (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 00:08:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:47491 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbcK0FIV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 00:08:21 -0500
Received: (qmail 25709 invoked by uid 109); 27 Nov 2016 05:08:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 05:08:20 +0000
Received: (qmail 25569 invoked by uid 111); 27 Nov 2016 05:08:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 00:08:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2016 00:08:18 -0500
Date:   Sun, 27 Nov 2016 00:08:18 -0500
From:   Jeff King <peff@peff.net>
To:     Dun Peal <dunpealer@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: trustExitCode doesn't apply to vimdiff mergetool
Message-ID: <20161127050818.rmjpvha64y4wosq2@sigill.intra.peff.net>
References: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 26, 2016 at 09:44:36PM -0500, Dun Peal wrote:

> I'm using vimdiff as my mergetool, and have the following lines in
> ~/.gitconfig:
> 
> [merge]
>     tool = vimdiff
> [mergetool "vimdiff"]
>     trustExitCode = true
> 
> 
> My understanding from the docs is that this sets
> mergetool.vimdiff.trustExitCode to true, thereby concluding that a
> merge hasn't been successful if vimdiff's exit code is non-zero.
> 
> Unfortunately, when I exit Vim using `:cq` - which returns code 1 -
> the merge is still presumed to have succeeded.
> 
> Is there a way to accomplish the desired effect, such that exiting
> vimdiff with a non-zero code would prevent git from resolving the
> conflict in the merged file?

I don't use mergetool myself, but peeking at the code, it looks like
trustExitCode is used only for a "user" tool, not for the builtin tool
profiles. That sounds kind of confusing to me, but I'll leave discussion
of that to people more interested in mergetool.

However, I think you can work around it by defining your own tool that
runs vimdiff:

  git config merge.tool foo
  git config mergetool.foo.cmd 'vimdiff "$LOCAL" "$BASE" "$REMOTE" "$MERGED"'
  git config mergetool.foo.trustExitCode true

Though note that the builtin vimdiff invocation is a little more
complicated than that. You may want to adapt what is in git.git's
mergetools/vimdiff to your liking.

-Peff
