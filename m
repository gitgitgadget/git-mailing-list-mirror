Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A37C433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AD6610FF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhKMDhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:37:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54555 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235637AbhKMDhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 22:37:19 -0500
Received: from localhost ([38.30.8.235])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AD3YFON005013
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 22:34:16 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v6 6/8] receive-pack: clean dead code from update_worktree()
Date:   Fri, 12 Nov 2021 19:33:56 -0800
Message-Id: <20211113033358.2179376-7-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211113033358.2179376-1-andersk@mit.edu>
References: <20211113033358.2179376-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

update_worktree() can only be called with a non-NULL worktree parameter,
because that’s the only case where we set do_update_worktree = 1.
worktree->path is always initialized to non-NULL.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/receive-pack.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5d7c4832c1..b04d4ad268 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1444,29 +1444,22 @@ static const char *push_to_checkout(unsigned char *hash,
 
 static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
 {
-	const char *retval, *work_tree, *git_dir = NULL;
+	const char *retval, *git_dir;
 	struct strvec env = STRVEC_INIT;
 
-	if (worktree && worktree->path)
-		work_tree = worktree->path;
-	else if (git_work_tree_cfg)
-		work_tree = git_work_tree_cfg;
-	else
-		work_tree = "..";
+	if (!worktree || !worktree->path)
+		BUG("worktree->path must be non-NULL");
 
 	if (is_bare_repository())
 		return "denyCurrentBranch = updateInstead needs a worktree";
-	if (worktree)
-		git_dir = get_worktree_git_dir(worktree);
-	if (!git_dir)
-		git_dir = get_git_dir();
+	git_dir = get_worktree_git_dir(worktree);
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
 	if (!find_hook(push_to_checkout_hook))
-		retval = push_to_deploy(sha1, &env, work_tree);
+		retval = push_to_deploy(sha1, &env, worktree->path);
 	else
-		retval = push_to_checkout(sha1, &env, work_tree);
+		retval = push_to_checkout(sha1, &env, worktree->path);
 
 	strvec_clear(&env);
 	return retval;
@@ -1587,9 +1580,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	if (do_update_worktree) {
-		ret = update_worktree(new_oid->hash,
-				      find_shared_symref(worktrees, "HEAD",
-							 name));
+		ret = update_worktree(new_oid->hash, worktree);
 		if (ret)
 			goto out;
 	}
-- 
2.33.1

