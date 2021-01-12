Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CD5C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 14:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9546323121
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 14:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbhALOST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:18:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:53452 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbhALOSS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 09:18:18 -0500
Received: (qmail 10595 invoked by uid 109); 12 Jan 2021 14:17:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 14:17:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14840 invoked by uid 111); 12 Jan 2021 14:17:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 09:17:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 09:17:37 -0500
From:   Jeff King <peff@peff.net>
To:     Arnaud Morin <arnaud.morin@gmail.com>
Cc:     git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: rev-list with multiple commits sharing same patch-id
Message-ID: <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
References: <20210109162440.GM31701@sync>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210109162440.GM31701@sync>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 09, 2021 at 04:24:40PM +0000, Arnaud Morin wrote:

> After digging a little bit, the thing is that this commit is having the
> following patch-id:
> $ git show dbf86d8aafc897a25a3093139b4237a62395041e | git patch-id
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
> 
> Which is also already existing in an other commit:
> $ for c in $(git rev-list HEAD) ; do git show $c |git patch-id |grep 20f4ace68e80a751b07d78a27c94e83d6c5314bc; done
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc 8969d3fa9159730fd3b23199873bfb26e3d20027

A slight nit first. Those two commits have the same patch-id, but in
your graph they are on the same branch ("master", not "B"):

> The commits in B are cherry-picked from master.
> Here is the graph:
> $ git log --graph --oneline --all
> * ae2e3c4 (origin/B, B) remove line2 and add line4 (bis)
> * a7a0339 remove line4
> * caa4aad restore line2
> * d7dc596 remove line2 add line4
> * 44bcfd4 add line3
> * e372641 b
> | * dbf86d8 (HEAD -> master, origin/master) remove line2 and add line4 (bis)
> | * 4017282 remove line4
> | * 0f2a449 restore line2
> | * 8969d3f remove line2 add line4
> | * e73b420 add line3
> | * fe5a75a b
> |/  
> * 6192505 a
> * b4089e1 init

And --cherry-pick is only looking for matches between the two sides of
the symmetric difference.

However, I think that patch-id does exist on the other side (it appears
again twice in fact, which is not surprising):

  $ git rev-list --all | git diff-tree --stdin -p | git patch-id | grep 20f4ace68e80
  20f4ace68e80a751b07d78a27c94e83d6c5314bc ae2e3c4754f53440cc4612d35f80d795a695c862
  20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
  20f4ace68e80a751b07d78a27c94e83d6c5314bc d7dc596fcc34662cba35363febc846bfcab1e4be
  20f4ace68e80a751b07d78a27c94e83d6c5314bc 8969d3fa9159730fd3b23199873bfb26e3d20027

So the entries should be suppressed from both sides.

It looks like this was broken in v2.10.0, via dfb7a1b4d0 (patch-ids:
stop using a hand-rolled hashmap implementation, 2016-07-29).

I think the issue is that it is allowing duplicate entries in the
hashmap. The algorithm is something like:

  - iterate over left-hand commits, inserting patch-id for each into
    hashmap

  - iterate over right-hand commits, seeing if any are present in
    hashmap. If so, we exclude the commit _and_ mark the patch-id as
    "seen"

  - iterate again over left-hand commits, omitting any whose patch-ids
    are marked as "seen"

So if two commits on the left-hand side have the same patch-id, if we
insert two entries into the hashmap, then only one of them is going to
get its "seen" flag marked in the middle step.

-Peff
