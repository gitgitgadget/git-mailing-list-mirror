Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADDF1F461
	for <e@80x24.org>; Fri, 17 May 2019 00:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfEQAT3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 20:19:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:60192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726302AbfEQAT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 20:19:29 -0400
Received: (qmail 7620 invoked by uid 109); 17 May 2019 00:19:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 00:19:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8825 invoked by uid 111); 17 May 2019 00:20:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 20:20:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 20:19:27 -0400
Date:   Thu, 16 May 2019 20:19:27 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
Message-ID: <20190517001926.GA13525@sigill.intra.peff.net>
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
 <20190516221702.GA11784@sigill.intra.peff.net>
 <CAPig+cQQ5svrDKRPenL2+bJHGjddUPnAXCFSsQN+WBHqzGpDow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQQ5svrDKRPenL2+bJHGjddUPnAXCFSsQN+WBHqzGpDow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 07:16:54PM -0400, Eric Sunshine wrote:

> On Thu, May 16, 2019 at 6:17 PM Jeff King <peff@peff.net> wrote:
> > On Thu, May 16, 2019 at 06:25:24PM +0700, Duy Nguyen wrote:
> > > So you probably can still make it work by backing up $GIT_INDEX_FILE
> > > (in case you need it), then unset it before you use "git worktree" (or
> > > cd to it if you keep a permanent separate worktree for pre-commit
> > > activities). [...]
> >
> > The case of actually _adding_ a new work tree (before we enter it) is
> > weirder, though. We definitely want to stay in the same repository, and
> > clearing all of that would not make sense. I do wonder if worktree-add
> > should be handling GIT_INDEX_FILE (ignoring it when we want to be
> > dealing with the index of the new worktree we added, and handling any
> > relative fixups if we chdir inside the worktree code).
> 
> Ignoring GIT_INDEX_FILE was indeed the conclusion reached earlier in
> this thread. Addressing your other point, "git worktree add" does
> chdir() into the new worktree if a post-checkout hook exists since
> that hook needs to run in the new worktree, not in the worktree in
> which the "git worktree add" command itself was invoked. For the hook
> invocation, it already sanitizes the environment of GIT_DIR and
> GIT_WORK_TREE, and GIT_INDEX_FILE ought to be cleaned too. Is there
> any existing code in Git for doing the relative fixups you mention for
> other Git environment variables?

You can assign local_repo_env to child_process.env (or push it
individually to env_array if you have to mix with other variables). See
git_connect() for an example.

-Peff
