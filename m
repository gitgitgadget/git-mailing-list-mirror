Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9085C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3BA207CD
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHUVDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:03:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:37654 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHUVDD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:03:03 -0400
Received: (qmail 21224 invoked by uid 109); 21 Aug 2020 21:03:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 21:03:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 475 invoked by uid 111); 21 Aug 2020 21:03:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 17:03:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 17:03:01 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] strmap: add strdup_strings option
Message-ID: <20200821210301.GA11806@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <b3095d97d8ee9d6576292731cc100492e7c64f13.1598035949.git.gitgitgadget@gmail.com>
 <20200821200121.GF1165@coredump.intra.peff.net>
 <CABPp-BGJK4C7U+-MB-+TUgFAuuFJKE-E7y17FFJDRTyFydVX2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGJK4C7U+-MB-+TUgFAuuFJKE-E7y17FFJDRTyFydVX2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 01:41:44PM -0700, Elijah Newren wrote:

> > This is actually one of the ugliest parts of string_list, IMHO, and I'd
> > prefer if we can avoid duplicating it. Yes, sometimes we can manage to
> > avoid an extra copy of a string. But the resulting ownership and
> > lifetime questions are often very error-prone. In other data structures
> > we've moved towards just having the structure own its data (e.g.,
> > strvec does so, and things like oidmap store their own oids). I've been
> > happy with the simplicity of it.
> >
> > It also works if you use a flex-array for the key storage in the
> > strmap_entry. :)
> 
> I can see how it's easier, but that worries me about the number of
> extra copies for my usecase.  In order to minimize actual computation,
> I track an awful lot of auxiliary data in merge-ort so that I know
> when I can safely perform many different case-specific optimizations.
> Among other things, this means 15 strmaps.  1 of those stores a
> mapping from all paths that traverse_trees() walks over (file or
> directory) to metadata about the content on the three different sides.
> 9 of the remaining 14 simply share the strings in the main strmap,
> because I don't need extra copies of the paths in the repository.  I
> could (and maybe should) extend that to 11 of the 14.  Only 3 actually
> do need to store a copy of the paths (because they store data used
> beyond the end of an inner recursive merge or can be used to
> accelerate subsequent commits in a rebase or cherry-pick sequence).

I'd have to see the code, of course, but:

  - keep in mind you're allocating 8 bytes for a pointer (plus 24 for
    the rest of the strmap entry). If you use a flex-array you get those
    8 bytes back. Full paths do tend to be longer than that, so it's
    probably net worse than a pointer to an existing string. But how
    much worse, and does it matter?

  - That sounds like a lot of maps. :) I guess you've looked at
    compacting some of them into a single map-to-struct?

> So, in most my cases, I don't want to duplicate strings.  I actually
> started my implementation using FLEX_ALLOC_STR(), as you suggested
> earlier in this thread, but tossed it because of this same desire to
> not duplicate strings but just share them between the strmaps.
> 
> Granted, I made that decision before I had a complete implementation,
> so I didn't measure the actual costs.  It's possible that was a
> premature optimization.

I'm just really concerned that it poisons the data structure with
complexity that many of the other callers will have to deal with. We've
had several "oops, strdup_strings wasn't what I expected it to be" bugs
with string-list (in both directions: leaks and use-after-free). It
would be nice to have actual numbers and see if it's worth the cost.

-Peff
