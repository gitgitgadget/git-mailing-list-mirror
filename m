Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E61DC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 14:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiGKOGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKOGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 10:06:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CD6BC17
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:06:33 -0700 (PDT)
Received: (qmail 7762 invoked by uid 109); 11 Jul 2022 14:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 14:06:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19703 invoked by uid 111); 11 Jul 2022 14:06:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 10:06:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 10:06:32 -0400
From:   Jeff King <peff@peff.net>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org
Subject: Re: git tag triggers out-of-memory killer
Message-ID: <YswuaPx6Mk7YkIim@coredump.intra.peff.net>
References: <20220711153135.35b1b135.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711153135.35b1b135.olaf@aepfle.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 03:31:35PM +0200, Olaf Hering wrote:

> What knobs exist inside git to restrict the amount of memory for each
> individual git process?

You can set GIT_ALLOC_LIMIT in the environment to limit the size of a
single heap allocation. But there's no overall limit for all
allocations. You'd have to use an OS-level tool like ulimit or cgroups
there.

> Running a large number of "git tag --sort=taggerdate --contains "
> processes in parallel triggers the OOM killer because each one
> allocates more than one gigabyte resident memory.

How did you measure?  Are you sure that each one is allocating a
gigabyte itself, or might some of it be shared between the processes?
Git will mmap the packfiles on disk, which will count against RSS
(assuming the memory even gets faulted in). But multiple processes on
the same repository will share those read-only pages.

Are you running the command against a large number of distinct
repositories? In that case, the pages obviously wouldn't be shared. You
_might_ have some success with core.packedGitLimit, which would lower
the amount that each process will mmap. But in general I'd expect the OS
to happily evict read-only mmap'd pages rather than OOM.

Is there anything about your repository that might be unusual? A large
number of commits, or tags?  If I run "git tag --sort=taggerdate
--contains" against linux.git, measuring with massif shows it uses about
2MB of heap. Digging for a much older commit, like 1da177e4c3, uses
about 16MB (there's some per-commit internal bookkeeping for each commit
we actually have to traverse).

Those are both with commit-graphs enabled (i.e., running "git
commit-graph write --reachable"). Without them, it looks like the heap
is closer to 100MB. Probably git-tag should be disabling
save_commit_buffer internally. Unlike git-log, it won't end up
pretty-printing the commits it walks during the --contains traversal.

So maybe try with this patch:

diff --git a/builtin/tag.c b/builtin/tag.c
index 75dece0e4f..8f3a6dffb4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -486,6 +486,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	int ret = 0;
 	const char *only_in_list = NULL;
 
+	save_commit_buffer = 0;
+
 	setup_ref_filter_porcelain_msg();
 
 	git_config(git_tag_config, &sorting_options);

or with commit graphs written, and see if that improves things for you.
Those numbers aren't anywhere near the 1GB you mentioned, but perhaps a
sufficient number of 100MB heaps is enough to cause problems for you.

-Peff
