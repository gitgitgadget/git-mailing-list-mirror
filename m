Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B8EC3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 06:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLHG7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 01:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHG7k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 01:59:40 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084BC69327
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 22:59:38 -0800 (PST)
Received: (qmail 23223 invoked by uid 109); 8 Dec 2022 06:59:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Dec 2022 06:59:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9825 invoked by uid 111); 8 Dec 2022 06:59:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 01:59:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 01:59:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Message-ID: <Y5GLWe4Kdaz+T5P8@coredump.intra.peff.net>
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221208.86a63y9309.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 12:57:45AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Is this for a very large hosting site that's anywhere near GitHub,
> GitLab's etc. scale?
> 
> A "git gc" on a "live" repo is always racy in theory, but the odds that
> you'll run into data corrupting trouble tends to approach zero as you
> increase the gc.pruneExpire setting, with the default 2 weeks being more
> than enough for even the most paranoid user.

I'm a bit less optimistic than "tends to approach zero" here. The
objects themselves might be older, but they may become referenced or
unreferenced in an immediate racy way. E.g., intending to move branch Z
to branch A, a client asks to add A and remove Z. Since there is no
atomic view of the ref namespace, a simultaneous gc might see Z gone,
but A not yet existing (and of course it could also be _two_ clients,
etc).

> The "cruft pack" facility does many different things, and my
> understanding of it is that GitHub's not using it only as an end-run
> around potential corruption issues, but that some not yet in tree
> patches on top of it allow more aggressive "gc" without the fear of
> corruption.

I don't think cruft packs themselves help against corruption that much.
For many years, GitHub used "repack -k" to just never expire objects.
What cruft packs help with is:

  1. They keep cruft objects out of the main pack, which reduces the
     costs of lookups and bitmaps for the main pack.

  2. When you _do_ choose to expire, you can do so without worrying
     about accidentally exploding all of those old objects into loose
     ones (which is not wrong from a correctness point of view, but can
     have some amazingly bad performance characteristics).

I think the bits you're thinking of on top are in v2.39. The "repack
--expire-to" option lets you write objects that _would_ be deleted into
a cruft pack, which can serve as a backup (but managing that is out of
scope for repack itself, so you have to roll your own strategy there).

-Peff
