Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30E1C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F4E64EC8
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZHOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:14:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:45612 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZHN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 02:13:59 -0500
Received: (qmail 12246 invoked by uid 109); 26 Feb 2021 07:13:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 07:13:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16825 invoked by uid 111); 26 Feb 2021 07:13:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 02:13:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 02:13:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/2] t/perf: avoid copying worktree files from test repo
Message-ID: <YDifi8YeJCcx0FaV@coredump.intra.peff.net>
References: <YDiesofYW18Mzd9Q@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDiesofYW18Mzd9Q@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running the perf suite, we copy files from an existing $GIT_DIR to
a scratch repository to give us a realistic setup on which to operate.
Since the perf scripts themselves may modify the scratch repository, we
want to make sure we've scrubbed any references back to the original.

One existing example is that we avoid copying the file "commondir" at
the top-level of the repository. In a worktree git-dir (e.g.,
.git/worktrees/foo), that file contains the path to the parent
repository; copying it could mean ref updates in the scratch repository
affect the original.

But there are other files we should cover, too:

  - "gitdir" in a worktree git-dir contains the path to the actual .git
    file in the working tree. We _shouldn't_ end up looking at it at
    all, since the lack of a "commondir" file means Git won't consider
    this to be a worktree git-dir. But it's best to err on the safe
    side.

  - in a parent repository that contains worktrees, the
    "$GIT_DIR/worktrees" directory will contain the git dirs for the
    individual worktrees. Which will themselves contain commondir and
    gitdir files that may reference the original repository. We should
    likewise remove them.

    Note that this does mean that the perf suite's scratch repositories
    will never have any worktrees. That's OK; we don't have any perf tests
    that are influenced by their presence. If we add any, they'd
    probably want to create the worktrees themselves anyway.

This patch adds both paths to the set of omissions in
test_perf_copy_repo_contents(). Note that we won't get confused here by
matching arbitrary names like refs/heads/commondir. This list is always
matching top-level entries in $GIT_DIR (we rely on "cp -R" to do the
actual recursion).

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 1226be4005..601d9f67dd 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -74,7 +74,7 @@ test_perf_copy_repo_contents () {
 	for stuff in "$1"/*
 	do
 		case "$stuff" in
-		*/objects|*/hooks|*/config|*/commondir)
+		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees)
 			;;
 		*)
 			cp -R "$stuff" "$repo/.git/" || exit 1
-- 
2.31.0.rc0.520.ge7c5201139
