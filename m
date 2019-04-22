Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738281F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 16:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfDVQV3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 12:21:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:36942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726098AbfDVQV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 12:21:29 -0400
Received: (qmail 31552 invoked by uid 109); 22 Apr 2019 16:21:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 16:21:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 420 invoked by uid 111); 22 Apr 2019 16:22:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 12:22:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 12:21:27 -0400
Date:   Mon, 22 Apr 2019 12:21:27 -0400
From:   Jeff King <peff@peff.net>
To:     Klaus Ethgen <Klaus@ethgen.ch>
Cc:     git@vger.kernel.org
Subject: Re: fatal: unable to read after commit - deeper analysis
Message-ID: <20190422162127.GC9680@sigill.intra.peff.net>
References: <20190411164440.GC12669@ikki.ethgen.ch>
 <CAP8UFD0bBBtOOz9ew_2URCp3nY1v0_OHMby1-N+T0nCDW82DRg@mail.gmail.com>
 <20190413092136.GK12669@ikki.ethgen.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413092136.GK12669@ikki.ethgen.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 13, 2019 at 10:21:36AM +0100, Klaus Ethgen wrote:

> Finally, the error was a combination of 4 tools, git, vim, the mentioned
> vim-addon and task with a task-hook for committing pending.data.
> 
> When I do a git commit which invokes vim, then the following variables
> are set:
> - GIT_INDEX_FILE
> - GIT_AUTHOR_DATE
> - GIT_PREFIX
> - GIT_EXEC_PATH
> 
> And $GIT_INDEX_FILE is the source of trouble here. The task-hook clears
> respective sets the variables GIT_DIR and GIT_WORK_TREE. However, the
> GIT_INDEX_FILE environment is set (in some cases) to an absolute path
> pointing to .git/index.lock or .git/index (I have no idea when it is
> taking the .lock variant).
> 
> Now we have a mismatch of GIT_DIR and GIT_WORK_TREE on one hand and the
> absolute path of GIT_INDEX_FILE on the other. So the trouble is set. The
> following "git add pending.data" did break all. It does something to an
> index that does not belong to the git repo.
> 
> Mystery is when and why this changed in git. It was definitively changed
> in some recent version.

It was always the case that GIT_INDEX_FILE would sometimes be set. For a
partial commit like:

  echo changes >>one
  echo changes >>two
  git add .
  git commit two

we have to create a temporary index (so as not to commit the staged
changes from "one").

I was curious if we started setting it for the more vanilla case of
just "git commit" more recently. But trying to bisect on:

  GIT_EDITOR=set | grep ^GIT_INDEX; :' git commit

I couldn't find any version where we _didn't_ set $GIT_INDEX_FILE, going
back to v1.6.0. So I don't know of any recent changes in this area.

Presumably you've fixed it by unsetting $GIT_INDEX_FILE in your vim
task-hook when it switches to another repo. However, you may want to
switch to asking Git about the full list of repo-related variables you
should clear. In the shell that looks like:

  unset $(git rev-parse --local-env-vars)

That should be more thorough, and will future-proof you against new
variables being added.

-Peff
