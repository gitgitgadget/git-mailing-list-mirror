Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA5CC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 09:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C162070B
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 09:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgHJJ4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:56:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:53884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgHJJ4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 05:56:50 -0400
Received: (qmail 20274 invoked by uid 109); 10 Aug 2020 09:56:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Aug 2020 09:56:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4188 invoked by uid 111); 10 Aug 2020 09:56:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Aug 2020 05:56:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Aug 2020 05:56:48 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: disallow --separate-git-dir with bare repository
Message-ID: <20200810095648.GA37030@coredump.intra.peff.net>
References: <20200809225316.19503-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200809225316.19503-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 09, 2020 at 06:53:16PM -0400, Eric Sunshine wrote:

> The purpose of "git init --separate-git-dir" is to separate the
> repository from the worktree. This is true even when --separate-git-dir
> is used on an existing worktree, in which case, it moves the .git/
> subdirectory to a new location outside the worktree.
> 
> However, an outright bare repository (such as one created by "git init
> --bare"), has no worktree, so using --separate-git-dir to separate it
> from its non-existent worktree is nonsensical. Therefore, make it an
> error to use --separate-git-dir on a bare repository.

I agree that it seems like nonsense. I'm a little curious what it
happens to do today, just because I'd wonder if it could possibly be of
any use to somebody.

> Implementation note: "git init" considers a repository bare if told so
> explicitly via --bare or if it guesses it to be so based upon
> heuristics. In the explicit --bare case, a conflict with
> --separate-git-dir is easy to detect early. In the guessed case,
> however, the conflict can only be detected once "bareness" is guessed,
> which happens after "git init" has begun creating the repository.
> Technically, we can get by with a single late check which would cover
> both cases, however, erroring out early, when possible, without leaving
> detritus provides a better user experience.

I think we'd clean up that detritus with our atexit handler, but I like
the extra check here. It lets us give a slightly more specific message
when we can catch it early ("these two options are incompatible").

>  builtin/init-db.c |  5 +++++
>  t/t0001-init.sh   | 13 +++++++++++++
>  2 files changed, 18 insertions(+)

The patch itself looks good, assuming my "I'd wonder..." line of inquiry
above produces nothing of value. :)

-Peff
