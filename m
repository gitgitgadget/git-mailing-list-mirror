Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A62C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072576143B
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhEMJ7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 05:59:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:53468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232770AbhEMJ7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 05:59:10 -0400
Received: (qmail 3489 invoked by uid 109); 13 May 2021 09:57:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 May 2021 09:57:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15132 invoked by uid 111); 13 May 2021 09:58:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 May 2021 05:58:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 May 2021 05:57:57 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
Message-ID: <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 02:44:52PM -0400, Jeff Hostetler wrote:

> > > remote: ...<skipped>
> > > Receiving objects: 100% (64/64), 154.49 KiB | 2.97 MiB/s, done.
> > > remote: ...<skipped>
> > > Receiving objects: 100% (37/37), 168.35 KiB | 4.95 MiB/s, done.
> > > Resolving deltas: 100% (5/5), done.
> > > Resolving deltas: 100% (49/49), completed with 47 local objects.
> > > fatal: bad revision 'd5e9cd36ab21839af3d116eff3221c53f6ca7fd6'
> > > error: https://<myhost>/bagas/gitea.git did not send all necessary
> > > objects
> [...]
> 
> I'm not sure why you're getting that error, but you might
> also try enabling `uploadpack.allowAnySHA1InWant`
> (or one of the other "allow*SHS1InWant" values) and see if
> that helps.

That shouldn't be necessary these days, since the v2 protocol allows
arbitrary objects to be fetched.

I think it is actually a bug with pack-objects not sending the object,
but it only seems to trigger with bitmaps. This works:

  git init repo
  cd repo

  echo content >file
  git add file
  git commit -m base

  git config uploadpack.allowfilter true
  git clone --no-local --bare --filter=blob:none . clone

  cd clone
  git fetch origin $(git rev-parse HEAD:file)

But if I add a "git repack -adb" in the parent repository before the "cd
clone", then I get:

  remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
  fatal: bad revision 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
  error: /home/peff/tmp/repo/. did not send all necessary objects

So presumably this is a bug in the bitmap-aware filtering code that is
not present in the regular filter-traversing code. But what really
puzzles me is that the result seems totally broken. Yet the test
coverage in t5310 passes, and nobody has noticed on major sites like
GitHub (which supports partial clones and most certainly has bitmaps
enabled).

So I think it will require some digging. My _guess_ is that it has to do
with the "never filter out an object that was explicitly requested" rule
not being consistently followed. But we'll see.

-Peff
