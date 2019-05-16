Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFAB1F461
	for <e@80x24.org>; Thu, 16 May 2019 22:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfEPWRE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 18:17:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:60026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726762AbfEPWRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 18:17:04 -0400
Received: (qmail 3103 invoked by uid 109); 16 May 2019 22:17:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 22:17:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7894 invoked by uid 111); 16 May 2019 22:17:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 18:17:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 18:17:02 -0400
Date:   Thu, 16 May 2019 18:17:02 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
Message-ID: <20190516221702.GA11784@sigill.intra.peff.net>
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 06:25:24PM +0700, Duy Nguyen wrote:

> > Is it forbidden to call this command from a hook?
> 
> pre-commit hook sets GIT_INDEX_FILE to this "index.lock" so you have
> the latest index content (which is not the same as from
> $GIT_DIR/index). This variable will interfere with any commands that
> work on a different worktree.
> 
> So you probably can still make it work by backing up $GIT_INDEX_FILE
> (in case you need it), then unset it before you use "git worktree" (or
> cd to it if you keep a permanent separate worktree for pre-commit
> activities). To make sure you don't have similar problems, you
> probably should do "env | grep GIT" from the hook and see if any other
> variables are set.

If you're entering another repo from a hook, you're supposed to use:

  unset $(git rev-parse --local-env-vars)

I wondered if we'd need another similar mechanism for entering the
worktree of another repo, that would maybe clear fewer variables. But I
think it's actually the same: we really want to clear everything and let
our "cd" pick up the new repository path.

The case of actually _adding_ a new work tree (before we enter it) is
weirder, though. We definitely want to stay in the same repository, and
clearing all of that would not make sense. I do wonder if worktree-add
should be handling GIT_INDEX_FILE (ignoring it when we want to be
dealing with the index of the new worktree we added, and handling any
relative fixups if we chdir inside the worktree code).

-Peff
