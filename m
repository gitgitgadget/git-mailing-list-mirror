Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36BC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 18:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624B86138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 18:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhKRSLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 13:11:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:34122 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhKRSLm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 13:11:42 -0500
Received: (qmail 30686 invoked by uid 109); 18 Nov 2021 18:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Nov 2021 18:08:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32569 invoked by uid 111); 18 Nov 2021 18:08:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Nov 2021 13:08:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Nov 2021 13:08:41 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Waleed Khan <me@waleedkhan.name>,
        git@vger.kernel.org
Subject: Re: Bug report: Strange behavior with `git gc` and
 `reference-transaction` hook
Message-ID: <YZaWqTwPOyQz0/mu@coredump.intra.peff.net>
References: <CAKjfCeBcuYC3OXRVtxxDGWRGOxC38Fb7CNuSh_dMmxpGVip_9Q@mail.gmail.com>
 <CAGyf7-FoRyVtQHa2ETQtRA6fD7x0GDhKVPg+eAajhgPNrsw_OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-FoRyVtQHa2ETQtRA6fD7x0GDhKVPg+eAajhgPNrsw_OQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc pks]

On Wed, Nov 17, 2021 at 04:52:46PM -0800, Bryan Turner wrote:

> > The expected behavior would be that the latest reference transaction
> > hook refers to the state of the references on disk. That is, either
> > `master` should point to 0 (be deleted), or it should have said that
> > `master` pointed to `e197d1`.
> >
> > But if we actually examine `master`, it's set to `e197d1`, just as you
> > would expect. The GC should have been a no-op overall.
> 
> One of the subtasks of "git gc" is "git pack-refs". If you inspect in
> more detail, I suspect you'll find that "refs/heads/master" was loose
> before "git gc" ran (as in, there was a file
> "$GIT_DIR/refs/heads/master") and "packed-refs" either didn't have a
> "refs/heads/master" entry or had a different hash. (Loose refs always
> "win" over packed, since ref updates only write loose refs.)

It seems totally broken to me that we'd trigger the
reference-transaction hook for ref packing. The point of the hook is to
track logical updates to the refs. But during ref packing that does not
change at all; the value remains the same. So I don't think we should be
triggering the hook at all, let alone with confusing values.

This snippet shows a simple case that I think is wrong:

-- >8 --
git init -q repo
cd repo

cat >.git/hooks/reference-transaction <<\EOF
#!/bin/sh
echo >&2 "==> reference-transaction $*"
sed 's/^/  /'
EOF
chmod +x .git/hooks/reference-transaction

echo >&2 "running commit..."
git commit --allow-empty -qm foo
echo >&2 "running pack-refs..."
git pack-refs --all --prune
-- >8 --

It produces:

  running commit...
  ==> reference-transaction prepared
    0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d40e7a9a5f71b HEAD
    0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d40e7a9a5f71b refs/heads/main
  ==> reference-transaction committed
    0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d40e7a9a5f71b HEAD
    0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d40e7a9a5f71b refs/heads/main
  running pack-refs...
  ==> reference-transaction prepared
    0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d40e7a9a5f71b refs/heads/main
  ==> reference-transaction committed
    0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d40e7a9a5f71b refs/heads/main
  ==> reference-transaction prepared
    77bcab0d950aee3021e8aa13a15d40e7a9a5f71b 0000000000000000000000000000000000000000 refs/heads/main
  ==> reference-transaction committed
    77bcab0d950aee3021e8aa13a15d40e7a9a5f71b 0000000000000000000000000000000000000000 refs/heads/main

I think the final four invocations should be skipped entirely. They're
pointless at best (nothing actually changed), and extremely misleading
at worst (they look like the ref ended up deleted!).

-Peff
