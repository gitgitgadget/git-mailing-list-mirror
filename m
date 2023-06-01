Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE8C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 14:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjFAOEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjFAOEj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 10:04:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC2E184
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 07:04:38 -0700 (PDT)
Received: (qmail 4870 invoked by uid 109); 1 Jun 2023 14:04:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 14:04:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23428 invoked by uid 111); 1 Jun 2023 14:04:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 10:04:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 10:04:36 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] fsck: mention file path for index errors
Message-ID: <20230601140436.GB2458601@coredump.intra.peff.net>
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
 <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
 <mvmzg5j8jkk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mvmzg5j8jkk.fsf@suse.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2023 at 02:15:39PM +0200, Andreas Schwab wrote:

> On Feb 24 2023, Jeff King wrote:
> 
> > If we encounter an error in an index file, we may say something like:
> >
> >   error: 1234abcd: invalid sha1 pointer in resolve-undo
> >
> > But if you have multiple worktrees, each with its own index, it can be
> > very helpful to know which file had the problem. So let's pass that path
> > down through the various index-fsck functions and use it where
> > appropriate. After this patch you should get something like:
> >
> >   error: 1234abcd: invalid sha1 pointer in resolve-undo of .git/worktrees/wt/index
> 
> That is still suboptimal, because there is no obvious mapping from the
> internal worktree name to the directory where it lives (git worktree
> list doesn't mention the internal name).  If you have several worktrees
> with the same base name in different places, the name under
> .git/worktrees is just made unique by appending a number.  Normally you
> would want to change to the affected worktree directory to repair it.

I don't use worktrees all that much, and I never had to repair one of
these cases in the real world, but I would have imagined you'd chdir
into the affected .git directory to fix things (either by blowing away
the index, or by running Git commands inside there).

I don't think it would be too hard to print more information. The caller
of fsck_index() has the "struct worktree", which contains more path
information. But we'd need to figure out how to present it, as well as
which paths to show in fsck_cache_tree(), etc.

So I'd say "patches welcome" if anybody wants to figure out those
issues. :)

-Peff
