Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DA9C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F8C2067D
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGIXKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:10:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:53748 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIXKb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 19:10:31 -0400
Received: (qmail 6409 invoked by uid 109); 9 Jul 2020 23:10:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 23:10:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26663 invoked by uid 111); 9 Jul 2020 23:10:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 19:10:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 19:10:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Zach Riggle <zachriggle@gmail.com>, git@vger.kernel.org
Subject: Re: git grep --threads 12 --textconv is effectively single-threaded
Message-ID: <20200709231030.GD664420@coredump.intra.peff.net>
References: <CAMP9c5nUteg_HouuYJZtq7g4MrSE638mns=HeKhNpNTYgQB4=w@mail.gmail.com>
 <20200707215951.GB2300296@coredump.intra.peff.net>
 <CAMP9c5mpJ9_HvEBTiEQj=vocTdH6N9uXkpLKiE8+hFbAt9p5Ow@mail.gmail.com>
 <20200708201353.GA2354599@coredump.intra.peff.net>
 <xmqqfta11zu0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfta11zu0.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 08, 2020 at 02:06:31PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's probably possible to teach the grep code to do the same
> > check-in-the-index trick, but I'm not sure how complicated it would be.
> 
> I am not sure if we should even depend on the "check the object
> database and use it instead of reading the working tree files" done
> in diff code---somehow I thought we did the opposite for performance
> (i.e. when we ought to be comparing two objects, taken from tree and
> the index, if we notice that the index side is stat clean, we can
> read/mmap the working tree file instead of going to the object layer
> and deflating a loose object, or, worse yet, construct the blob by
> repeatedly applying deltas on a base object in a packfile).
> 
> Is this one in the opposite direction done specifically for gaining
> performance when textconv cache is in use?  If so, kudos to whoever
> did it---that sounds like a clever thing to do.

No, it turns out that nobody was that clever (and I was simply
misremembering how it worked).

For a tree-to-tree or index-to-tree comparison, both sides will have an
oid and can use the textconv cache. Even for an index case where we
might choose to use a stat-fresh working tree file as an optimization,
we'll still consult the textconv cache before loading those contents.

But for diffing a file in the working tree, we'll never have an oid and
will always run the textconv command). So "git diff" against the index,
for example, would run _one_ textconv (using the cached value for the
index, and running one for the working tree version). And we know that
isn't that interesting for optimizing, since by definition the file is
stat-dirty in that case (or else we'd skip the content-level comparison
entirely). So you'd have to compute the sha1 of the working tree file
from scratch. Plus the lifetime of a working tree file's entry in the
textconv cache is probably smaller, since it hasn't even been committed
yet.

I don't think I ever noticed because the primary thing I was trying to
speed up with the textconv cache is "git log -p", etc, which always has
an oid to work with.

But "grep" is a totally different story. It is frequently looking at all
of the stat-fresh working tree files.

-Peff
