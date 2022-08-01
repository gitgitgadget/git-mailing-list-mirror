Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C79C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 17:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiHARnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHARnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 13:43:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A2A18B33
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 10:43:08 -0700 (PDT)
Received: (qmail 620 invoked by uid 109); 1 Aug 2022 17:43:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Aug 2022 17:43:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23378 invoked by uid 111); 1 Aug 2022 17:43:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Aug 2022 13:43:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Aug 2022 13:43:06 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
Message-ID: <YugQqp4oN26OFOpt@coredump.intra.peff.net>
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
 <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
 <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 30, 2022 at 05:44:25PM -0700, Linus Torvalds wrote:

> Put another way: I think my patch is likely the right thing to do (and
> I'd personally prefer the stricter check without the ALLOW_ONELEVEL
> flag), but you and Junio are right about it being a bigger change than
> I in my naivete thought it was.
> 
> So I won't really push for this, I suspect this needs very much to be
> a judgement call by you guys.

Just to lay out the options, I think we have:

  1. Do nothing. This breaks nothing. ;)

  2. Your patch, but with ALLOW_ONELEVEL. This fixes nonsense like
     "foo..bar", but doesn't break "FETCH_HEAD". Requires fixing t4202's
     ".lock" example. Replaces the HEAD starts_with("refs/") check.

  3. Your patch as-is. Same as (2), but also breaks FETCH_HEAD.

  4. Your patch, plus any extra tightening of HEAD to refs/heads/. I
     think this is probably breaking too much (I put more details
     elsewhere in the thread).

I'd be in favor of (2), which is really just catching syntactically
invalid crap, and shouldn't break anyone. Technically it's possible
somebody could be using a symref pointing at arbitrary data for
who-knows-what reason, and extracting it with "symbolic-ref", but that
is getting beyond far-fetched, I think.

I'm also tempted by (3), but we should be prepared for obscure breakage
reports.

-Peff
