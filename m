Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B8C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7A020777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgCYFjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:39:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:50294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725781AbgCYFjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:39:09 -0400
Received: (qmail 22958 invoked by uid 109); 25 Mar 2020 05:39:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 25 Mar 2020 05:39:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32352 invoked by uid 111); 25 Mar 2020 05:49:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Mar 2020 01:49:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Mar 2020 01:39:08 -0400
From:   Jeff King <peff@peff.net>
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "git rebase" behavior change in 2.26.0
Message-ID: <20200325053908.GC651138@coredump.intra.peff.net>
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 08:38:04PM -0700, Norbert Kiesel wrote:

> I track an upstream repo with "pull.rebase = true" where I do a `git
> pull` followed by a `git log -p ORIG_HEAD..` for a branch to see
> changes since the last "pull".  I normally do not commit to this
> branch and thus this normally is a "fast-forward" merge.
> 
> Starting with 2.26 this no longer works because ORIG_HEAD is always
> set to HEAD after my `git pull`.
> 
> I track other prances from the same repo where I do local changes and
> then want the `git pull --rebase` and I thus do not want to
> give up on the `pull.rebase = true` configuration.

I can imagine this is related to the switch to the "merge" backend for
git-pull, which may be more eager to overwrite ORIG_HEAD. Perhaps try:

  git -c rebase.backend=apply pull

and see if that behaves differently.

I tried to reproduce what you're seeing, but my recipe doesn't seem to
show any difference between the two versions:

-- >8 --
#!/bin/sh

rm -rf repo

git init -q repo
cd repo
echo content >base && git add base && git commit -q -m base
git clone -q . dst
echo content >new && git add new && git commit -q -m new

cd dst
git rev-parse HEAD >.git/ORIG_HEAD
echo before: $(git log -1 --oneline ORIG_HEAD)
git -c pull.rebase=true pull -q ..
echo after: $(git log -1 --oneline ORIG_HEAD)
-- 8< --

We don't seem to touch ORIG_HEAD in either case. But maybe a more
complex set of pulled commits would trigger it?

-Peff
