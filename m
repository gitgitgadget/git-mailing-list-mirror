Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B0C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 20:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9202520708
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 20:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGHUNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:13:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:52520 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgGHUNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 16:13:54 -0400
Received: (qmail 31386 invoked by uid 109); 8 Jul 2020 20:13:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2020 20:13:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14140 invoked by uid 111); 8 Jul 2020 20:13:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jul 2020 16:13:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jul 2020 16:13:53 -0400
From:   Jeff King <peff@peff.net>
To:     Zach Riggle <zachriggle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep --threads 12 --textconv is effectively single-threaded
Message-ID: <20200708201353.GA2354599@coredump.intra.peff.net>
References: <CAMP9c5nUteg_HouuYJZtq7g4MrSE638mns=HeKhNpNTYgQB4=w@mail.gmail.com>
 <20200707215951.GB2300296@coredump.intra.peff.net>
 <CAMP9c5mpJ9_HvEBTiEQj=vocTdH6N9uXkpLKiE8+hFbAt9p5Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP9c5mpJ9_HvEBTiEQj=vocTdH6N9uXkpLKiE8+hFbAt9p5Ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 08, 2020 at 12:40:49PM -0500, Zach Riggle wrote:

> So I just need to
> 
> git -c "diff.c.cachetextconv=true" ...
> 
> And the cache should automagically work?

Yes, but there's a bit of subtlety with what you're grepping.

Try this example setup:

  git init -q repo
  cd repo
  echo content >file
  echo 'file diff=foo' >.gitattributes
  git add .
  git commit -m base
  git config diff.foo.textconv 'echo >&2 converting...; sleep 1; tr a-z A-Z <'

which should make it clear when the filter actually runs.

Now try this:

  echo >&2 "==> no textconv"
  git grep . file
  echo >&2 "==> with textconv"
  git grep --textconv . file
  echo >&2 "==> cached (one)"
  git -c diff.foo.cachetextconv=true grep --textconv . file
  echo >&2 "==> cached (two)"
  git -c diff.foo.cachetextconv=true grep --textconv . file

We'd expect the final one to say "file:CONTENT" but _without_ a
"converting" line. But it still runs the textconv script!

The problem is that the cache uses the blob id of the source as its key.
But since we're grepping files in the working directory, they don't have
an object id at all. If we grep in the tree, it works as expected:

  $ git -c diff.foo.cachetextconv=true grep --textconv . HEAD -- file
  converting...
  HEAD:file:CONTENT
  $ git -c diff.foo.cachetextconv=true grep --textconv . HEAD -- file
  HEAD:file:CONTENT

All of this textconv stuff was originally designed for the diff
infrastructure. Even when it's diffing files, if they're tracked in the
repository the diff code will pull the oid from the index (assuming the
file is stat-clean). But the grep code doesn't do that (and I doubt that
it matters for anything at all except this textconv caching feature).

It's probably possible to teach the grep code to do the same
check-in-the-index trick, but I'm not sure how complicated it would be.

-Peff
