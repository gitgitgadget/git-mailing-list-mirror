Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA88C07E96
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 07:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553DB61288
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 07:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhGMHzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 03:55:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:47562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233762AbhGMHzL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:11 -0400
Received: (qmail 32343 invoked by uid 109); 13 Jul 2021 07:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 07:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7388 invoked by uid 111); 13 Jul 2021 07:52:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 03:52:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 03:52:21 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] load_ref_decorations(): fix decoration with tags
Message-ID: <YO1GNWjMol8JV8MR@coredump.intra.peff.net>
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
 <20210713074018.232372-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210713074018.232372-1-martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Junio; this patch looks good to me, and should go on top of
	    jk/log-decorate-optim, which is in 'next' and has a pretty
	    ugly regression]

On Tue, Jul 13, 2021 at 09:40:18AM +0200, Martin Ågren wrote:

> Commit 88473c8bae ("load_ref_decorations(): avoid parsing non-tag
> objects", 2021-06-22) introduced a shortcut to `add_ref_decoration()`:
> Rather than calling `parse_object()`, we go for `oid_object_info()` and
> then `lookup_object_by_type()` using the type just discovered. As
> detailed in the commit message, this provides a significant time saving.
> 
> Unfortunately, it also changes the behavior: We lose all annotated tags
> from the decoration.
> 
> The reason this happens is in the loop where we try to peel the tags, we
> won't necessarily have parsed that first object. If we haven't, its
> `tag` will be NULL, so nothing will be displayed, and its `tagged` will
> also be NULL, so we won't peel any further.

Thanks, nicely explained.

> Note how this commit could have been done as an optimization before
> 88473c8bae: When our peeling hits a non-tag, we won't parse that tagged
> object only to immediately end the loop.

Yep, thanks for mentioning this, as it's somewhat subtle.

>  On Tue, 13 Jul 2021 at 02:06, Jeff King <peff@peff.net> wrote:
>  >
>  > Your fix is _almost_ there.
> 
>  It's very kind of you to put it like that. I've picked up your
>  suggestions and have tried to summarize my understanding of the issue
>  and the fix in the commit message.

When I wrote that, I thought the fix would just be:

  if (obj_type == OBJ_TAG)
	parse_object(...);

which really would put it only one line off of your fix. :)

>  > That's the minimum needed to unbreak things. I think we could do even
>  > better, though. There is no need for us to parse a commit object pointed
>  > to by a tag here. We should only be parsing tags we see (whether at the
>  > top-level or recursively).
> 
>  Maybe you wrote this before circling back and actually writing that
>  "even better" thing? Because it seems to me like that's what you did.
>  Maybe I'm still missing something.

Nope, I'm just dumb. I wrote what I sent in the other email (rather than
just adding the "if" as above) because it only involved having a single
parse_object() call in the function. To my credit, I did realize about
an hour after sending the other email that I had in fact done the
"better thing" quite accidentally. But I really like how you explained
it in the commit message here, which I had not quite thought through.

>  log-tree.c     | 4 ++--
>  t/t4202-log.sh | 9 +++++++++

Patch looks good. Thanks for noticing the problem and cleaning up my
mess.

-Peff
