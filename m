Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ABEC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625682075E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDHSsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:48:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:37304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728208AbgDHSsp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 14:48:45 -0400
Received: (qmail 12766 invoked by uid 109); 8 Apr 2020 18:48:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 18:48:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10986 invoked by uid 111); 8 Apr 2020 18:59:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 14:59:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 14:48:43 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
Message-ID: <20200408184843.GA1963695@coredump.intra.peff.net>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 01:22:03AM +0000, Derrick Stolee via GitGitGadget wrote:

> The default file history simplification of "git log -- <path>" or
> "git rev-list -- <path>" focuses on providing the smallest set of
> commits that first contributed a change. The revision walk greatly
> restricts the set of walked commits by visiting only the first
> TREESAME parent of a merge commit, when one exists. This means
> that portions of the commit-graph are not walked, which can be a
> performance benefit, but can also "hide" commits that added changes
> but were ignored by a merge resolution.
> [...]

Thanks for a really great description of the problem.

Playing around with the patch, I found one curiosity. Try this:

  git log --graph --oneline origin -- GIT-VERSION-GEN >old
  git log --graph --oneline --include-diversions \
                            origin -- GIT-VERSION-GEN >new
  diff -u old new

The first hunk has:

  @@ -70,6 +70,7 @@
   * 20769079d2 Git 2.12-rc2
   * 5588dbffbd Git 2.12-rc1
   * 6e3a7b3398 Git 2.12-rc0
  +* 0a45050a14 Merge branch 'rj/git-version-gen-do-not-force-abbrev'
   * a7659747c2 GIT-VERSION-GEN: do not force abbreviation length used by 'describe'
   * 8d7a455ed5 Start post 2.11 cycle
   * 454cb6bd52 Git 2.11

which makes sense. That merge brought in a7659747c2, and the other side
hadn't touched it. But I can't tell from the output how the two are
related. Nor can I just add "-p" to the invocation; after we've
simplified, it has only a single parent, but it's TREESAME to that
parent. So it has no diff.

I actually think the most descriptive output here would be something
like:

  * 6e3a7b3398 Git 2.12-rc0
  * 0a45050a14 Merge branch 'rj/git-version-gen-do-not-force-abbrev'
  |\
  | * a7659747c2 GIT-VERSION-GEN: do not force abbreviation length used by 'describe'
  |/
  * Start post 2.11 cycle

I.e., leaving both parents intact for a "diversion" merge. But maybe
that would have secondary effects in other places.

-Peff
