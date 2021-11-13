Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA0C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F58060F38
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbhKMDha (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:37:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54572 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235672AbhKMDhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 22:37:23 -0500
Received: from localhost ([38.30.8.235])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AD3YJKD005034
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 22:34:21 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v6 8/8] branch: protect branches checked out in all worktrees
Date:   Fri, 12 Nov 2021 19:33:58 -0800
Message-Id: <20211113033358.2179376-9-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211113033358.2179376-1-andersk@mit.edu>
References: <20211113033358.2179376-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refuse to force-move a branch over the currently checked out branch of
any working tree, not just the current one.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 branch.c          | 13 +++++++++----
 t/t3200-branch.sh |  7 +++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index c7b9ba0e10..3a7d205fa4 100644
--- a/branch.c
+++ b/branch.c
@@ -199,7 +199,8 @@ int validate_branchname(const char *name, struct strbuf *ref)
  */
 int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 {
-	const char *head;
+	struct worktree **worktrees;
+	const struct worktree *wt;
 
 	if (!validate_branchname(name, ref))
 		return 0;
@@ -208,9 +209,13 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 		die(_("a branch named '%s' already exists"),
 		    ref->buf + strlen("refs/heads/"));
 
-	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-		die(_("cannot force update the current branch"));
+	worktrees = get_worktrees();
+	wt = find_shared_symref(worktrees, "HEAD", ref->buf);
+	if (wt && !wt->is_bare)
+		die(_("cannot force update the branch '%s'"
+		      "checked out at '%s'"),
+		    ref->buf + strlen("refs/heads/"), wt->path);
+	free_worktrees(worktrees);
 
 	return 1;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6496e5dd38..797a2c752d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -168,6 +168,13 @@ test_expect_success 'git branch -M foo bar should fail when bar is checked out'
 	test_must_fail git branch -M bar foo
 '
 
+test_expect_success 'git branch -M foo bar should fail when bar is checked out in worktree' '
+	git branch -f bar &&
+	test_when_finished "git worktree remove wt && git branch -D wt" &&
+	git worktree add wt &&
+	test_must_fail git branch -M bar wt
+'
+
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out' '
 	git checkout -b baz &&
 	git branch bam &&
-- 
2.33.1

