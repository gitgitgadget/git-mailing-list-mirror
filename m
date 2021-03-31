Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A22C433E0
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77876199A
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhCaLeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:34:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:38518 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235262AbhCaLdt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 07:33:49 -0400
Received: (qmail 28718 invoked by uid 109); 31 Mar 2021 11:32:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Mar 2021 11:32:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3471 invoked by uid 111); 31 Mar 2021 11:32:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Mar 2021 07:32:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Mar 2021 07:32:04 -0400
From:   Jeff King <peff@peff.net>
To:     stdedos@gmail.com
Cc:     git@vger.kernel.org, stdedos+git@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: Branches, upstreams, rebases and logistics
Message-ID: <YGRdtHjaL5l5v5Ym@coredump.intra.peff.net>
References: <20210330202852.9673-1-stdedos+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330202852.9673-1-stdedos+git@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 11:28:52PM +0300, stdedos@gmail.com wrote:

> However, with the Github way of working, that means:
> I have two remotes, (origin and upstream), on which, I develop and
> push on the `origin`, but I am really tracking/rebasing on/from `upstream`.
> 
> I cannot `--track` upstream, as plain `git push` won't work, and
> for pull, I have to separately `git fetch --all`, `git rebase upstream/<branch>`
> 
> - OR -
> 
> I have a branch, which depends on top of another branch (not yet merged upstream).
> 
> o - origin/master
>  \
>   o---o---o---o
>   |            \
>   fix/local     o--o - (fix/depends-on-local)
> 
> For brevity, I am setting "git branch --set-upstream-to=fix/local",
> which helps, when rebasing fix/local on top of origin/master, to rebase
> fix/depends-on-local on top of fix/local.
> 
> However, as noted above, a branch cannot be pushed upstream easily and
> have a different upstream set at the same time.

This is usually called a "triangular" workflow; you can find some
discussion in the list archive and documentation by searching for that
term.

But in short, what you probably want is to set:

  git config remote.pushdefault yourfork

(I'm not entirely sure, but I think "yourfork" is "origin" in your
example). Which means that "git push" will behave as you'd like, pushing
to your fork. And you are free to set the "upstream" of each branch to
the thing it is based on (again, assuming your "upstream" remote is the
actual upstream project that you can't push to):

  git branch --set-upstream-to=upstream/master fix/local
  git branch --set-upstream-to=fix/local fix/depends-on-local

And then from either "fix/local" or "fix/depends-on-local" branches, you
can "git pull --rebase" (or in the case of the latter, just "git rebase"
would do the same thing).

-Peff
