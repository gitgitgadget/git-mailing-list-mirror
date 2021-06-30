Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65CC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E6661461
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhF3SAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 14:00:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:37622 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3SAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 14:00:39 -0400
Received: (qmail 24711 invoked by uid 109); 30 Jun 2021 17:58:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 17:58:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9315 invoked by uid 111); 30 Jun 2021 17:58:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Jun 2021 13:58:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Jun 2021 13:58:08 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git log exclude pathspec from file - supported? plans?
Message-ID: <YNywsEbFcrQFeH91@coredump.intra.peff.net>
References: <CACPiFCLtj5QF6_Goc5UYh9KHWgkrKtjApL-cCH04S5gdTFyk7Q@mail.gmail.com>
 <CACPiFCLXxwaWOuR6sy8H4hCG-H0ZFvVYma7COfDq3zxoUt=VtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPiFCLXxwaWOuR6sy8H4hCG-H0ZFvVYma7COfDq3zxoUt=VtA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 12:59:43PM -0400, Martin Langhoff wrote:

> long time no see! I'm doing some complex git repo spelunking and
> pushing the boundaries of the pathspec magic for excludes.
> 
> Is there a reasonable way to provide a (potentially large) set of
> excludes? something like
> 
>      git log --exclude-pathspec-file paths-to-exclude.txt .
> 
> Has there been discussion / patches / plans related to this? I may
> have some cycles (hopefully!)

You can feed pathspecs via --stdin. So:

  {
	echo "--"
	sed s/^/:^/ paths-to-exclude.txt
  } | git log --stdin

works. Obviously it's not as turn-key if you really do have a list of
paths in a file already, but it's much more flexible.

I'll caution you that the pathspec code is not well-optimized to handle
a large number of pathspecs. E.g.:

  [no pathspecs]
  $ time git rev-list HEAD /dev/null
  real	0m0.033s
  user	0m0.017s
  sys	0m0.017s

  [trivial pathspec; now we have to actually open up trees]
  $ { echo --; echo .; } >input
  $ time git rev-list HEAD --stdin <input >/dev/null
  real	0m1.338s
  user	0m1.294s
  sys	0m0.045s

  [lots of pathspecs; now we spend loads of time actually matching
   strings; the ^C is when I got bored and killed it]
  $ { echo --; git ls-files; } >input
  $ time git rev-list HEAD --stdin <input >/dev/null
  ^C
  real	1m24.406s
  user	1m24.369s
  sys	0m0.036s

The problem is that we try to linearly match every pathspec against
every path we consider, so it's quadratic-ish in the number of files in
the repo. I played a long time ago with storing non-wildcard pathspecs
in a trie that we could traverse as we talked the individual trees we
were matching. It performed well, but IIRC the interface was hacky (I
had to bolt it specifically onto the way the tree-walker uses
pathspecs, and the other pathspec matchers didn't benefit at all).

I can probably dig it up if anybody's interested in looking at it.

-Peff
