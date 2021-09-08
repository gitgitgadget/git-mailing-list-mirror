Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE4C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 21:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D7860EB7
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 21:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhIHVlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 17:41:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:42456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhIHVk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 17:40:59 -0400
Received: (qmail 26354 invoked by uid 109); 8 Sep 2021 21:39:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 21:39:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2181 invoked by uid 111); 8 Sep 2021 21:39:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 17:39:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 17:39:49 -0400
From:   Jeff King <peff@peff.net>
To:     Aleksey Midenkov <midenok@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git diff: print hunk numbers?
Message-ID: <YTktpQ9uZkbwtuLO@coredump.intra.peff.net>
References: <CAF8BazDKG03bpBEQyC9EsM8WxV_7WnQ386T=VT49EHNzsZ3PPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF8BazDKG03bpBEQyC9EsM8WxV_7WnQ386T=VT49EHNzsZ3PPw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 11:40:20PM +0300, Aleksey Midenkov wrote:

> Is that possible/how to print hunk numbers with git diff?
> 
> F.ex. instead of:
> 
> @@ -106,7 +110,6 @@ while ($r < $statement_count)
> ...
> 
> To print something like:
> 
> @@ -106,7 +110,6 @@ 4 @@ while ($r < $statement_count)
> ...
> 
> filterdiff uses hunk numbers intensively. Work with line-number ranges
> is not so effective.

No, Git doesn't know how to do any annotations on hunk lines (aside from
finding and reporting the funcname lines from the source). So you'd have
to post-process it, like:

  git diff ... |
  perl -pe 's/^@@.*?@@/join(" ", $&, ++$i, "@@")/e'

but I'm not sure if that's quite what you're after. If you're using
filterdiff to pick out hunks, then piping through "filterdiff
--annotate" does something similar.

If you want to post-process your diffs all the time, you can do
something like:

  git config pager.color false
  git config pager.diff 'filterdiff --annotate | less'

to show the annotations anytime the output is going to a terminal.
Though sadly filterdiff does not handle the colors; other
post-processors like diff-highlight parse around them.

And finally, if your ultimate goal is to use filterdiff to pick out
hunks, you might find using Git's picking tools like "checkout -p"
easier. Even if you are starting with an actual patch, you can apply it
and then pick out bits, like:

  git checkout --detach ;# temporary head for applying patch
  git apply </path/to/patch
  git commit -m "temporary commit for patch"
  git checkout - ;# back to the original branch
  git checkout -p HEAD@{1} ;# now selectively grab parts

Of course that only helps if the patch actually applies. If your goal is
to filter out hunks that don't apply, it won't help. :)

-Peff
