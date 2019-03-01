Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28ED20248
	for <e@80x24.org>; Fri,  1 Mar 2019 21:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfCAVgW (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 16:36:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:35008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725988AbfCAVgW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 16:36:22 -0500
Received: (qmail 26012 invoked by uid 109); 1 Mar 2019 21:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 21:36:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1901 invoked by uid 111); 1 Mar 2019 21:36:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 16:36:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 16:36:19 -0500
Date:   Fri, 1 Mar 2019 16:36:19 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190301213619.GA1518@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 11:57:46AM -0800, Johannes Schindelin via GitGitGadget wrote:

> In d85b0dff72 (Makefile: use `find` to determine static header
> dependencies, 2014-08-25), we switched from a static list of header
> files to a dynamically-generated one, asking `find` to enumerate them.
> 
> Back in those days, we did not use `$(LIB_H)` by default, and many a
> `make` implementation seems smart enough not to run that `find` command
> in that case, so it was deemed okay to run `find` for special targets
> requiring this macro.
> 
> However, as of ebb7baf02f (Makefile: add a hdr-check target,
> 2018-09-19), $(LIB_H) is part of a global rule and therefore must be
> expanded. Meaning: this `find` command has to be run upon every
> `make` invocation. In the presence of many a worktree, this can tax the
> developers' patience quite a bit.

I'm confused about this part. We don't run hdr-check by default. Why
would make need the value of $(LIB_H)? Yet empirically it does run find.

Worse, it seems to actually run it _three times_. Once for the $(HCO)
target, once for the .PHONY, and once for the hdr-check target. I think
the .PHONY one is unavoidable (it doesn't know which names we might
otherwise be building should be marked), but the other two seem like
bugs in make (or at least pessimisations).

It makes me wonder if we'd be better off pushing hdr-check into a
separate script. It doesn't actually use make's dependency tree in any
meaningful way. And then regular invocations wouldn't even have to pay
the `ls-files` price.

If we are going to keep it in the Makefile, we should probably use a
":=" rule to avoid running it three times.

> Even in the absence of worktrees or other untracked files and
> directories, the cost of I/O to generate that list of header files is
> simply a lot larger than a simple `git ls-files` call.
> 
> Therefore, just like in 335339758c (Makefile: ask "ls-files" to list
> source files if available, 2011-10-18), we now prefer to use `git
> ls-files` to enumerate the header files to enumerating them via `find`,
> falling back to the latter if the former failed (which would be the case
> e.g. in a worktree that was extracted from a source .tar file rather
> than from a clone of Git's sources).

That seems reasonable (regardless of whether it is in a script or in the
Makefile). Another option is to use -maxdepth, but that involves
guessing how deep people might actually put header files.

> This has one notable consequence: we no longer include `command-list.h`
> in `LIB_H`, as it is a generated file, not a tracked one.

We should be able to add back $(GENERATED_H) as appropriate. I see you
did it for the non-computed-dependencies case. Couldn't we do the same
for $(LOCALIZED_C) and $(CHK_HDRS)?

> Likewise, we no longer include not-yet-tracked header files in `LIB_H`.

I think that's probably OK.

-Peff
