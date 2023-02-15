Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9B0C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 15:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBOPA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 10:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBOPA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 10:00:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E80C526B
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 07:00:24 -0800 (PST)
Received: (qmail 11557 invoked by uid 109); 15 Feb 2023 15:00:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Feb 2023 15:00:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14207 invoked by uid 111); 15 Feb 2023 15:00:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 10:00:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 10:00:23 -0500
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren <newren@gmail.com>, John Cai <johncai86@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Message-ID: <Y+zzh80fybq8Tn66@coredump.intra.peff.net>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
 <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
 <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
 <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
 <Y+b2l4Le2gTxGwO8@coredump.intra.peff.net>
 <2ca47f26-f10a-1fae-c879-f9479f7acdb1@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ca47f26-f10a-1fae-c879-f9479f7acdb1@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 02:44:59PM +0000, Phillip Wood wrote:

> Indeed. Ironically as there are no unique context lines in that example the
> blank lines are being matched by patience implementation falling back to the
> myers algorithm. Normally the myers implementation tries to avoid matching
> common context lines between two blocks of changed lines but I think because
> in this case it is only called on a small part of the file the blank lines
> are not common enough to trigger that heuristic. I've got a patch[1] that
> stops the patience implementation falling back to the myers algorithm and
> just trims any leading and trailing context. On the whole it I think it
> gives more readable diffs but I've not got any systematic data to back that
> up. I also suspect there are pathological cases such as each line in the
> file being duplicated where the falling back to the myers algorithm gives a
> much better result.

Ah, I should have suspected it was something like that (since one of the
purposes of patience is trying not to key on meaningless lines).

I tried your patch on my test case, and the result is even more readable
than the myers output, because it really was effectively a complete
rewrite of the function. It is, of course, not the minimal diff. I'm not
sure if there would be cases where you'd prefer the minimal. I guess if
each stanza's change really was independent of the others. But if there
is no commonality except for blank lines, I find it hard to imagine that
it's much worse to just treat the whole thing as a block.

Anyway, thank you (and Elijah) for explaining. I'm getting more
comfortable with the idea of switching the default.

-Peff
