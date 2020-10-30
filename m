Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5257FC388F9
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 12:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C5A20756
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJ3MvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 08:51:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:42410 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgJ3MvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 08:51:00 -0400
Received: (qmail 6772 invoked by uid 109); 30 Oct 2020 12:51:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 12:51:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20872 invoked by uid 111); 30 Oct 2020 12:50:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 08:50:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 08:50:59 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 01/10] hashmap: add usage documentation explaining
 hashmap_free[_entries]()
Message-ID: <20201030125059.GA3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:41AM +0000, Elijah Newren via GitGitGadget wrote:

> The existence of hashmap_free() and hashmap_free_entries() confused me,
> and the docs weren't clear enough.  We are dealing with a map table,
> entries in that table, and possibly also things each of those entries
> point to.  I had to consult other source code examples and the
> implementation.  Add a brief note to clarify the differences.  This will
> become even more important once we introduce a new
> hashmap_partial_clear() function which will add the question of whether
> the table itself has been freed.

This is a definite improvement, and I don't see any inaccuracies in the
descriptions. I do think some re-naming would help in the long run,
though. E.g.:

  - hashmap_clear() - remove all entries and de-allocate any
    hashmap-specific data, but be ready for reuse

  - hashmap_clear_and_free() - ditto, but free the entries themselves

  - hashmap_partial_clear() - remove all entries but don't deallocate
    table

  - hashmap_partial_clear_and_free() - ditto, but free the entries

So always call it "clear", but allow options in two dimensions (partial
or not, free entries or not).

Those could be parameters to a single function, but I think it gets a
little ugly because "and_free" requires passing in the type of the
entries in order to find the pointers.

The "not" cases are implied in the names, but hashmap_clear_full() would
be OK with me, too.

But I think in the current scheme that "free" is somewhat overloaded,
and if we end with a "clear" and a "free" that seems confusing to me.

-Peff
