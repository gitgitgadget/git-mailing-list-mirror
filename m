Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1591F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeHUW5Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:57:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:50842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726627AbeHUW5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:57:25 -0400
Received: (qmail 8095 invoked by uid 109); 21 Aug 2018 19:35:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:35:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26384 invoked by uid 111); 21 Aug 2018 19:36:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:36:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:35:56 -0400
Date:   Tue, 21 Aug 2018 15:35:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: worktree duplicates, was: [PATCH] SubmittingPatches: mention doc-diff
Message-ID: <20180821193556.GA859@sigill.intra.peff.net>
References: <20180821192321.GA720@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821192321.GA720@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 03:23:21PM -0400, Jeff King wrote:

> We already advise people to make sure their documentation
> formats correctly. Let's point them at the doc-diff script,
> which can help with that.
> 
> Let's also put a brief note in the script about its purpose,
> since that otherwise can only be found in the original
> commit message. Along with the existing -h/usage text,
> that's hopefully enough for developers to make use of it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just a finishing touch on the jk/diff-rendered-docs topic.

I noticed one other oddity with this script, but I actually think the
fix lies elsewhere.

The script does basically this to set up the temporary tree:

  test -d $tmp || git worktree add $tmp ...

The script never cleans up the worktree (since its results can often be
reused between runs), but you may do so with "rm" or "git clean". That
creates an interesting situation if the script is run again before
"worktree prune" runs. We identify the directory as a "new" worktree,
and add it to the list. So you may end up with several copies:

  $ git worktree list
  /home/peff/compile/git                                      eee785d2e0 [jk/doc-diff]
  /home/peff/compile/git/.git/tmp-ci                          290f16acda (detached HEAD)
  /home/peff/compile/git/Documentation/tmp-doc-diff/worktree  cc6237c051 (detached HEAD)
  /home/peff/compile/git/Documentation/tmp-doc-diff/worktree  e55de40950 (detached HEAD)
  /home/peff/compile/git/Documentation/tmp-doc-diff/worktree  e55de40950 (detached HEAD)

If I then run "git worktree prune", those duplicates don't go away
(because the directory is still there; it just corresponds to only the
final entry). If I delete the tmp-doc-diff directory and then run "git
worktree prune", they do all go away.

So I'm not sure:

  1. Should the script be doing something else to indicate that the
     worktree may be reused? I tried "git worktree remove", but it's
     unhappy that the directory doesn't exist. Should it quietly handle
     ignore that and remove any leftover cruft in $GIT_DIR/worktrees?

  2. Should "git worktree add" be more clever about realizing that an
     existing entry in $GIT_DIR/worktrees points to this directory? That
     would be fine for my use, but I wonder if there's some potential
     for loss (e.g., you blew away the work tree but until you do a
     "worktree prune", the refs are still there, objects reachable,
     etc).

  3. Should "git worktree prune" be more clever about dropping
     duplicates? I think it should be easy to identify them: they are
     entries in $GIT_DIR/worktrees for which:

       - the directory in $entry/gitdir does exist, but

       - $(cat $entry/gitdir)/.git does not point back to $entry

I could see any of them being plausible fixes, but people who have given
worktrees a lot of thought may have stronger opinions.

-Peff
