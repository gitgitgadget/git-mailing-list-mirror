Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635B6C2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 17:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370832071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 17:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAYRhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 12:37:50 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58279 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAYRhu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 12:37:50 -0500
X-Originating-IP: 112.133.229.71
Received: from localhost.localdomain (unknown [112.133.229.71])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C9A1C1BF206;
        Sat, 25 Jan 2020 17:37:46 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] worktree: add shorthand '-d' for detach
Date:   Sat, 25 Jan 2020 23:07:44 +0530
Message-Id: <20200125173744.4334-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Often someone might want to checkout an older commit in a separate
worktree to test it out without having any intention of making any
changes. Simply using 'git worktree add' means that a branch will be
created based on the name of the worktree folder. This branch will then
have to be deleted by the user once they are done with the worktree.

An alternative to this is to create a detached worktree which doesn't
lead to a branch being created. This can be done by the '--detach'
option. Add the shorthand to make it more convenient to use it.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
For more context:
https://lore.kernel.org/git/CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com/

I'll send a patch to add the config option as a follow up some time
later.

 Documentation/git-worktree.txt | 7 ++++---
 builtin/worktree.c             | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 85d92c9761..cc227dd382 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
+'git worktree add' [-f] [-d] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -52,7 +52,7 @@ directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
 If <commit-ish> is a branch name (call it `<branch>`) and is not found,
-and neither `-b` nor `-B` nor `--detach` are used, but there does
+and neither `-b` nor `-B` nor `-d` are used, but there does
 exist a tracking branch in exactly one remote (call it `<remote>`)
 with a matching name, treat as equivalent to:
 +
@@ -69,7 +69,7 @@ branches from there if `<branch>` is ambiguous but exists on the
 'origin' remote. See also `checkout.defaultRemote` in
 linkgit:git-config[1].
 +
-If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
+If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `-d` used,
 then, as a convenience, the new worktree is associated with a branch
 (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
 doesn't exist, a new branch based on HEAD is automatically created as
@@ -140,6 +140,7 @@ To remove a locked working tree, specify `--force` twice.
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<commit-ish>`.

+-d::
 --detach::
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d6bc5263f1..dab5f76788 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -500,7 +500,7 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
-		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
--
2.24.1

