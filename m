Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F5EC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 16:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjEKQSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbjEKQST (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 12:18:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B17695
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:17:58 -0700 (PDT)
Received: (qmail 26742 invoked by uid 109); 11 May 2023 16:17:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 May 2023 16:17:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10505 invoked by uid 111); 11 May 2023 16:17:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 May 2023 12:17:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 May 2023 12:17:57 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] fsck: mention file path for index errors
Message-ID: <20230511161757.GA1973344@coredump.intra.peff.net>
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
 <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
 <305ccc55-25e3-6b01-cd86-9a9035839d06@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <305ccc55-25e3-6b01-cd86-9a9035839d06@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 02:39:59AM -0400, Eric Sunshine wrote:

> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > @@ -795,7 +797,8 @@ static int fsck_resolve_undo(struct index_state *istate)
> > -static void fsck_index(struct index_state *istate)
> > +static void fsck_index(struct index_state *istate, const char *index_path,
> > +		       int is_main_index)
> 
> This adds an `is_main_index` flag, but...
> 
> > @@ -993,12 +998,19 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
> > +			if (read_index_from(&istate, path,
> >   					    get_worktree_git_dir(wt)) > 0)
> > -				fsck_index(&istate);
> > +				fsck_index(&istate, path, wt->is_current);
> 
> ...this accesses `is_current`, the value of which is "true" only for the
> worktree in which the Git command was run, which is not necessarily the main
> worktree. The main worktree, on the other hand, is guaranteed to be the
> first entry returned by get_worktrees(), so shouldn't this instead be:
> 
>     worktrees = get_worktrees();
>     for (p = worktrees; *p; p++) {
>         ...
>         fsck_index(&istate, path, p == worktrees);
>         ...
>     }
>     free_worktrees(worktrees);
> 
> Or am I fundamentally misunderstanding something?

I think "current" is what we want here, since the point was to return
the short-but-syntactically-correct ":path-in-index" for the current
worktree, which is where "rev-parse :path-in-index", etc, would look
when resolving that name.

So the code is working as intended, but I may have misused the term
"main" with respect to other worktree code. I didn't even know that was
a concept, not having dealt much with worktrees.

Maybe it's worth s/main/current/ here (and I guess in t1450)?

-Peff
