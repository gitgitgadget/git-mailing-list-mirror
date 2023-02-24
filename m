Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3BC677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 08:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBXIpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXIpV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 03:45:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5184DBC3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 00:45:20 -0800 (PST)
Received: (qmail 4907 invoked by uid 109); 24 Feb 2023 08:45:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 08:45:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32456 invoked by uid 111); 24 Feb 2023 08:45:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 03:45:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 03:45:15 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] fsck: check index files in all worktrees
Message-ID: <Y/h5G+D3jRLXeD16@coredump.intra.peff.net>
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
 <Y/hw1YVgCYWX2yNK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/hw1YVgCYWX2yNK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 03:09:58AM -0500, Jeff King wrote:

> +		for (p = get_worktrees(); *p; p++) {
> +			struct worktree *wt = *p;
> +			struct index_state istate =
> +				INDEX_STATE_INIT(the_repository);
> +
> +			if (read_index_from(&istate,
> +					    worktree_git_path(wt, "index"),
> +					    get_worktree_git_dir(wt)) > 0)
> +				fsck_index(&istate);
> +			discard_index(&istate);
> +		}

I didn't realize that get_worktrees() returns an allocated array, so
this is a small leak. I'll squash this in locally:

diff --git a/builtin/fsck.c b/builtin/fsck.c
index ddd13cb2b3..c11cb2a95f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -984,12 +984,13 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (keep_cache_objects) {
-		struct worktree **p;
+		struct worktree **worktrees, **p;
 
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
 
-		for (p = get_worktrees(); *p; p++) {
+		worktrees = get_worktrees();
+		for (p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
 			struct index_state istate =
 				INDEX_STATE_INIT(the_repository);
@@ -1000,7 +1001,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				fsck_index(&istate);
 			discard_index(&istate);
 		}
-
+		free_worktrees(worktrees);
 	}
 
 	check_connectivity();

but I'll hold off for other comments before sending a re-roll.

-Peff
