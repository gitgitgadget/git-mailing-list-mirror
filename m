Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08D5C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 08:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCJIkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 03:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCJIjR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 03:39:17 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322BD108C3B
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 00:37:35 -0800 (PST)
Received: (qmail 18994 invoked by uid 109); 10 Mar 2023 08:37:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 08:37:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10213 invoked by uid 111); 10 Mar 2023 08:37:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 03:37:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 03:37:24 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix stale packfile locks when dying
Message-ID: <ZArsRLHksmJ9Tgoy@coredump.intra.peff.net>
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
 <ZAoCUPsHbstSJ0+B@coredump.intra.peff.net>
 <ZArNJHMmPd8QCLwQ@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZArNJHMmPd8QCLwQ@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 07:24:36AM +0100, Patrick Steinhardt wrote:

> > I think one could also make an argument that index_pack_lockfile()
> > should return a tempfile struct itself, but I didn't look too closely at
> > the other caller on the fetch side (but it should be conceptually the
> > same).
> 
> I had a look at it, but git-fetch-pack(1) works quite differently in
> that regard as it also supports the case where the packfile lock should
> stay locked after it exits via the `--keep` switch. So the logic is more
> intricate here.
> 
> Furthermore, git-fetch-pack(1) only does the locking, but never unlocks
> the packfiles. That is instead handled by git-fetch(1). So converting
> the interface to use tempfiles directly wouldn't work as we are crossing
> process boundaries here.

I think the calls into fetch-pack.c that handle the pack lockfiles can
happen in-process from git-fetch itself. But I also think there are
probably cases where they don't (v0 git-over-http should use a separate
"fetch-pack --stateless-rpc", I believe).

So yeah, it's probably too complicated to worry about lumping in here,
especially since you noted that it handles cleanup correctly already.

Thanks for looking into it.

-Peff
