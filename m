Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7229C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 23:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjC2Xhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjC2Xhl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 19:37:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183465FF5
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 16:37:36 -0700 (PDT)
Received: (qmail 18096 invoked by uid 109); 29 Mar 2023 23:37:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Mar 2023 23:37:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12584 invoked by uid 111); 29 Mar 2023 23:37:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Mar 2023 19:37:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Mar 2023 19:37:35 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     git@vger.kernel.org
Subject: Re: `git gc` says "unable to read" but `git fsck` happy
Message-ID: <20230329233735.GD2314218@coredump.intra.peff.net>
References: <jwvfs9nusjm.fsf-monnier+Inbox@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jwvfs9nusjm.fsf-monnier+Inbox@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 06:05:24PM -0400, Stefan Monnier wrote:

> Here's an example session:
> 
>     % LANG=C git fsck --strict; LANG=C git gc
>     Checking object directories: 100% (256/256), done.
>     error in tree 2699d230e3b592ae42506d7b5c969a7ac6a4593c: zeroPaddedFilemode: contains zero-padded file modes
>     Checking objects: 100% (462555/462555), done.
>     Verifying commits in commit graph: 100% (117904/117904), done.
>     Enumerating objects: 462573, done.
>     Counting objects: 100% (462573/462573), done.
>     Delta compression using up to 8 threads
>     Compressing objects: 100% (155363/155363), done.
>     fatal: unable to read f5e44b38fc8f7e15e5e6718090d05b09912254fa
>     fatal: failed to run repack
>     %
> 
> How come it can't read `f5e44b38fc8f7e15e5e6718090d05b09912254fa` during
> "repack" while `git fsck` says everything is fine?

Do you use separate worktrees? It sounds like it might be similar to
this case:

  https://lore.kernel.org/git/c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org/

If so, there are patches in the current "master" (but not in a released
version yet) that fix fsck to detect this.

> More importantly: how do I diagnose this further and fix it?

If it is the same problem (which would be a blob or maybe cached tree
missing in one of the worktree's index files), then probably you'd
either:

  1. Accept the loss and blow away that worktree's index file (or
     perhaps even the whole worktree, and just recreate it).

  2. Try to "git add" the file in question to recreate the blob
     (assuming that the file itself is still hanging around).

The original corruption bug itself (gc not taking into account worktree
index files) has been fixed for a while, so the theory is that this can
be lingering corruption from a repack by an older version of Git. But if
you have evidence to the contrary, we'd like to hear that, too. ;)

> Rumors on the net suggest that `git gc --aggressive` may circumvent this
> problem occasionally, but those don't seem to know what they're talking
> about, and in my case it didn't make any difference (except that it
> takes more time :-).

I don't think --aggressive would help at all. In theory --prune=now
might, but I think even that won't help if the problem is that the
object is referenced in an index file.

It could also be a totally unrelated bug, perhaps where we are too eager
to complain about missing objects in unreachable history we're trying to
retain. In which case "git gc --prune=now" _would_ help (but it might be
nice to save a copy of the repository before trying, because that would
indicate a bug we still need to fix, and your repo is worth
investigating).

-Peff
