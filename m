Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642661F954
	for <e@80x24.org>; Tue, 21 Aug 2018 20:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeHUXn6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:43:58 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:41267 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUXn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:43:57 -0400
Received: by mail-qt0-f177.google.com with SMTP id e19-v6so21827388qtp.8
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 13:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfqnth562VVjQq9sQvOpu3ISYaA/v5vcK09SpePDDO8=;
        b=hSIMvQDzvmRNyOH8eKSaBeVbrzavUj4tWbY2FlKCxIC344V1dUEWwycrg/x8lKpl01
         3scJo1kU/Rxd/SHcaqeVokw5g7nbn+Nvx1xcWdDTLZHhceEOvH38ZOVfKcI3WJX8efF1
         I/Nnnp7cWAWUAqcjYx3rwXcU2vpYI5lseuAicK+0igZwFzlednNEQ2ze57LT7oWFJ6jn
         veLaeVyVcNHuc9KY/91UOI1CdDgbnaSCPoi+T+FK7+gMrTp56UNSqwxYU5H+vxIknCyc
         TQn3d5kONWBftCNVzOVmzQ9lHBfpwcNIGTvXRHHuAXTJtYRI0Uvpy31LYCCzw9LHdwKz
         fE9Q==
X-Gm-Message-State: AOUpUlG0uuTGIHRdIj5903WhuX30JItpTvH14b3p16iuY91Uii4EbKDT
        hA7xJKY5YgLGMx9HzP//ar6yMQGA1CMoymjJGFs=
X-Google-Smtp-Source: AA+uWPxJJuqLZ4pK7+ebrJNRAGehFaVsNIYC/nzHH5glWcGtfDpGOUjkNlUa5VDag+Eo9+glJY5iERavHewoBND6Hzk=
X-Received: by 2002:a0c:b458:: with SMTP id e24-v6mr47410719qvf.82.1534882939398;
 Tue, 21 Aug 2018 13:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180821192321.GA720@sigill.intra.peff.net> <20180821193556.GA859@sigill.intra.peff.net>
In-Reply-To: <20180821193556.GA859@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Aug 2018 16:22:08 -0400
Message-ID: <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com>
Subject: Re: worktree duplicates, was: [PATCH] SubmittingPatches: mention doc-diff
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 3:36 PM Jeff King <peff@peff.net> wrote:
> The script does basically this to set up the temporary tree:
>
>   test -d $tmp || git worktree add $tmp ...
>
> The script never cleans up the worktree (since its results can often be
> reused between runs), but you may do so with "rm" or "git clean". That
> creates an interesting situation if the script is run again before
> "worktree prune" runs.

Aside from the problems you enumerate below, leaving worktrees sitting
around which the user did not create explicitly does seem a bit
unfriendly, which leads me to think that worktrees may not be the best
tool for this task. How about using "git clone --shared" instead?

More below...

> We identify the directory as a "new" worktree,
> and add it to the list. So you may end up with several copies:
>
>   $ git worktree list
>   [...]
>   /home/peff/compile/git/Documentation/tmp-doc-diff/worktree  cc6237c051 (detached HEAD)
>   /home/peff/compile/git/Documentation/tmp-doc-diff/worktree  e55de40950 (detached HEAD)
>   /home/peff/compile/git/Documentation/tmp-doc-diff/worktree  e55de40950 (detached HEAD)
>
> If I then run "git worktree prune", those duplicates don't go away
> (because the directory is still there; it just corresponds to only the
> final entry). If I delete the tmp-doc-diff directory and then run "git
> worktree prune", they do all go away.
>
>   1. Should the script be doing something else to indicate that the
>      worktree may be reused? I tried "git worktree remove", but it's
>      unhappy that the directory doesn't exist. Should it quietly handle
>      ignore that and remove any leftover cruft in $GIT_DIR/worktrees?

That's a weird case. There are multiple entries in
.git/worktrees/*/gitdir pointing at the same worktree directory, which
I don't think was considered when the machinery was being designed.
"git worktree remove" refusing to delete the worktree in this case
seems a good safety measure since something is obviously askew in the
bookkeeping and it doesn't want to lose potential work.

The solution to this problem might be to upgrade "prune" as you
describe in #3 and then ensure that that sort of aggressive pruning
happens automatically at "git worktree add" time.

>   2. Should "git worktree add" be more clever about realizing that an
>      existing entry in $GIT_DIR/worktrees points to this directory? That
>      would be fine for my use, but I wonder if there's some potential
>      for loss (e.g., you blew away the work tree but until you do a
>      "worktree prune", the refs are still there, objects reachable,
>      etc).

In the case that you've already blown away the directory, then having
"git worktree add" prune away the old worktree bookkeeping would make
sense and wouldn't lose anything (you've already thrown it away
manually). However, it could be lossy for the case when the directory
is only temporarily missing (because it's on removable media or a
network share).

In this case, it might make sense for "git worktree add" to refuse to
operate if an existing worktree entry still points at the directory
that you're trying to add. That should prevent those duplicate
worktree entries you saw.

>   3. Should "git worktree prune" be more clever about dropping
>      duplicates? I think it should be easy to identify them: they are
>      entries in $GIT_DIR/worktrees for which:
>
>        - the directory in $entry/gitdir does exist, but
>        - $(cat $entry/gitdir)/.git does not point back to $entry

Seems a sensible improvement to the pruning logic.

However, upon further consideration, any of the proposed "fixes" could
potentially be lossy. Consider a case like this:

% git worktree add foo
... make some changes in 'foo' ...
% mv foo bar # (fogetting to do "git worktree move foo bar")
% git worktree add foo

As currently implemented, one can "correct" the situation by manually
fixing the bookkeeping file in .git/worktrees for the worktree created
first. If it gets pruned automatically, then the state of those
changes in "bar" (nee "foo") could be lost.

So, I'm not sure what, if any, fix is appropriate.

Such uncertainty also further argues in favor of "git clone --shared"
for your particular use-case, I think.
