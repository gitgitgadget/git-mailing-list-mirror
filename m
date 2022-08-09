Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B6C25B07
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbiHIMyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiHIMyf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:54:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AB12D28
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:54:34 -0700 (PDT)
Received: (qmail 30652 invoked by uid 109); 9 Aug 2022 12:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Aug 2022 12:54:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2001 invoked by uid 111); 9 Aug 2022 12:54:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Aug 2022 08:54:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Aug 2022 08:54:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Noneman <emily.noneman@gmail.com>,
        Paul Horn <git@knutwalker.engineer>
Subject: Re: [PATCH] revision.c: set-up "index_state.repo", don't segfault in
 pack-objects
Message-ID: <YvJZCGyhd6KJCabi@coredump.intra.peff.net>
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
 <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
 <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
 <Yu02dOo4G8sy8tI6@coredump.intra.peff.net>
 <xmqqo7wyzlpm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7wyzlpm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 05, 2022 at 09:41:57AM -0700, Junio C Hamano wrote:

> Ah, OK, I think the steps can be tweaked to
> 
>       git config core.untrackedCache true
>     - git worktree add at
>     - rm .git/worktrees/wt/index
>     + git worktree add --no-checkout wt
> 
>       git gc
> 
> i.e. (1) With "worktree add --no-checkout", there is no need to
> manually remove the index file, and (2) "at" is an obvious typo of
> "wt".  This does not require the history to be a singleton empty
> tree, either.

That makes sense. I worked backwards from the guess that Martin's patch
was relevant, hence trying to trigger ENOENT on the file. Using
--no-checkout is a plausible way to get there. (And yes, the "at" is a
typo. I double-checked the script I actually ran and it did not have the
typo; not sure how I managed to introduce it via cut and paste!).

The singleton empty tree was only there in my example because "git
worktree" insists on having a starting point. Its contents shouldn't
matter either way.

Here's the test addition you mentioned, though I'm really not sure it's
adding much. The source lines for both the bug/fix and the spot where we
segfault should be identical between the two cases. It's really just
about how we ended up calling into the code.

-- >8 --
Subject: [PATCH] t7063: add another missing-index test

Commit 4447d4129d (read-cache: make `do_read_index()` always set up
`istate->repo`, 2022-07-22) fixed a case where a missing "index" file
caused us to segfault in the untracked-cache code.

We ran into another situation in the wild which caused a similar
segfault, this time with an empty worktree. These actually segfault at
the same spot (inside the index reading code), but the call path to get
there is different between the two, hence it may be worth checking both.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7063-status-untracked-cache.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index c1f0d95036..a0e8920ffa 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -990,4 +990,9 @@ test_expect_success 'empty repo (no index) and core.untrackedCache' '
 	git -C emptyrepo -c core.untrackedCache=true write-tree
 '
 
+test_expect_success 'empty worktree and core.untrackedCache' '
+	git worktree add --no-checkout empty-worktree &&
+	git -c core.untrackedCache=true gc
+'
+
 test_done
-- 
2.37.1.845.ge5d2b690ea

