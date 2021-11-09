Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B64C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1BB610F8
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbhKIXNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:13:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52961 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232159AbhKIXNN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:13:13 -0500
Received: from localhost (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A9NAHpd014870
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Nov 2021 18:10:18 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v5 3/4] receive-pack: Protect current branch for bare repository worktree
Date:   Tue,  9 Nov 2021 15:09:40 -0800
Message-Id: <20211109230941.2518143-3-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109230941.2518143-1-andersk@mit.edu>
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
 <20211109230941.2518143-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A bare repository won’t have a working tree at "..", but it may still
have separate working trees created with git worktree. We should protect
the current branch of such working trees from being updated or deleted,
according to receive.denyCurrentBranch.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/receive-pack.c |  6 +++---
 t/t5516-fetch-push.sh  | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 542431e692..04a2ec6abc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1455,7 +1455,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 	if (!worktree || !worktree->path)
 		BUG("worktree->path must be non-NULL");
 
-	if (is_bare_repository())
+	if (worktree->is_bare)
 		return "denyCurrentBranch = updateInstead needs a worktree";
 	git_dir = get_worktree_git_dir(worktree);
 
@@ -1479,7 +1479,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	struct object_id *old_oid = &cmd->old_oid;
 	struct object_id *new_oid = &cmd->new_oid;
 	int do_update_worktree = 0;
-	const struct worktree *worktree = is_bare_repository() ? NULL : find_shared_symref("HEAD", name);
+	const struct worktree *worktree = find_shared_symref("HEAD", name);
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -1491,7 +1491,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	free(namespaced_name);
 	namespaced_name = strbuf_detach(&namespaced_name_buf, NULL);
 
-	if (worktree) {
+	if (worktree && !worktree->is_bare) {
 		switch (deny_current_branch) {
 		case DENY_IGNORE:
 			break;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f07e32126f..4847793a1c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1769,9 +1769,23 @@ test_expect_success 'denyCurrentBranch and worktrees' '
 	test_must_fail git -C cloned push origin HEAD:new-wt &&
 	test_config receive.denyCurrentBranch updateInstead &&
 	git -C cloned push origin HEAD:new-wt &&
+	test_path_exists new-wt/first.t &&
 	test_must_fail git -C cloned push --delete origin new-wt
 '
 
+test_expect_success 'denyCurrentBranch and bare repository worktrees' '
+	test_when_finished "rm -fr bare.git" &&
+	git clone --bare . bare.git &&
+	git -C bare.git worktree add wt &&
+	test_commit grape &&
+	test_config -C bare.git receive.denyCurrentBranch refuse &&
+	test_must_fail git push bare.git HEAD:wt &&
+	test_config -C bare.git receive.denyCurrentBranch updateInstead &&
+	git push bare.git HEAD:wt &&
+	test_path_exists bare.git/wt/grape.t &&
+	test_must_fail git push --delete bare.git wt
+'
+
 test_expect_success 'refuse fetch to current branch of worktree' '
 	test_when_finished "git worktree remove --force wt && git branch -D wt" &&
 	git worktree add wt &&
-- 
2.33.1

