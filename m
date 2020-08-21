Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A61C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD4620735
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHUUQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:16:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:37596 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHUUQu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 16:16:50 -0400
Received: (qmail 20889 invoked by uid 109); 21 Aug 2020 20:16:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 20:16:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31936 invoked by uid 111); 21 Aug 2020 20:16:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 16:16:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 16:16:48 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/5] Add struct strmap and associated utility functions
Message-ID: <20200821201648.GH1165@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 06:52:24PM +0000, Elijah Newren via GitGitGadget wrote:

> Here I introduce a new strmap type, which my new merge backed, merge-ort,
> uses heavily. (I also made significant use of it in my changes to
> diffcore-rename). This strmap type was based on Peff's proposal from a
> couple years ago[1], but has additions that I made as I used it. I also
> start the series off with a quick documentation improvement to hashmap.c to
> differentiate between hashmap_free() and hashmap_free_entries(), since I
> personally had difficulty understanding them and it affects how
> strmap_clear()/strmap_free() are written.

I like the direction overall (unsurprisingly), but left a bunch of
comments. I do think if we're going to do this that it may be worth
cleaning up hashmap a bit first, especially around its clear/free
semantics, and its ability to lazy-allocate the table.

I'm happy to work on that, but don't want to step on your toes.

I also wonder if you looked at the khash stuff at all. Especially for
storing integers, it makes things much more natural. You'd do something
like:

  /* you might even be able to just write !strcmp in the macro below */
  static inline int streq(const char *a, const char *b)
  {
          return !strcmp(a, b);
  }

  KHASH_INIT(strint_map, char *, int, 1, strhash, streq);

and then you'd probably want a "put" wrapper that makes a copy of the
string. khash has its own charming awkwardness, but I'm just curious if you
looked at it and found it more awkward than hashmap.c, or if you just
didn't look at it.

-Peff
