Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5976C433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4A861352
	for <git@archiver.kernel.org>; Sun,  2 May 2021 16:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhEBQ4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 12:56:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:42522 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhEBQ4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 12:56:44 -0400
Received: (qmail 31429 invoked by uid 109); 2 May 2021 16:55:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 May 2021 16:55:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19993 invoked by uid 111); 2 May 2021 16:55:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 May 2021 12:55:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 May 2021 12:55:51 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: "Unpacking objects" question
Message-ID: <YI7Zl+odFFRIZ7aL@coredump.intra.peff.net>
References: <bdd50fcc-02c3-dc24-9d49-773db881b65d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdd50fcc-02c3-dc24-9d49-773db881b65d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 02, 2021 at 06:06:57PM +0700, Bagas Sanjaya wrote:

> Recently I stumbled upon git unpack-objects documentation, which says:
> 
> > Read a packed archive (.pack) from the standard input, expanding the objects contained within and writing them into the repository in "loose" (one object per file) format.
> 
> However, I have some questions:
> 
> 1. When I do git fetch, what is the threshold/limit for "Unpacking objects",
>    in other words what is the minimum number of objects for invoking
>    "Resolving deltas" instead of "Unpacking objects"?
> 2. Can the threshold between unpacking objects and resolving deltas be
>    configurable?

See the fetch.unpackLimit config. The default is 100 objects.

> 3. Why in some cases Git do unpacking objects where resolving deltas
>    can be done?

I don't know if the documentation discusses this tradeoff anywhere, but
off the top of my head:

  - storing packs can be more efficient in disk space (because of deltas
    within the pack, but also fewer inodes for small objects). This
    effect is bigger the more objects you have.

  - storing packs can be less efficient, because thin packs will be
    completed with duplicates of already-stored objects. The overhead is
    bigger the fewer objects you have.

Which I suspect is the main logic driving the object count (I didn't dig
in the history or the archive, though; you might find more discussion
there). AFAIK the number 100 doesn't have any real scientific basis.

There are some other subtle effects, too:

  - storing packs from the wire may make git-gc more efficient (you can
    often reuse deltas sent by the other side)

  - storing packs from the wire may produce a worse outcome after
    git-gc, because you are reusing deltas produced by the client for
    their push (who might not have spent as much CPU looking for them as
    you would)

-Peff
