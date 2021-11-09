Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A08CC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 03:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B206120A
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 03:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbhKIDEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 22:04:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42872 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242285AbhKIDEb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 22:04:31 -0500
Received: from localhost (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A931ZuH005659
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 Nov 2021 22:01:37 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v4 4/4] branch: Protect branches checked out in all worktrees
Date:   Mon,  8 Nov 2021 19:00:28 -0800
Message-Id: <20211109030028.2196416-4-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109030028.2196416-1-andersk@mit.edu>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu>
 <20211109030028.2196416-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refuse to force-move a branch over the currently checked out branch of
any working tree, not just the current one.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 branch.c          | 10 ++++++----
 t/t3200-branch.sh |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 07a46430b3..581f0c02c2 100644
--- a/branch.c
+++ b/branch.c
@@ -199,7 +199,7 @@ int validate_branchname(const char *name, struct strbuf *ref)
  */
 int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 {
-	const char *head;
+	const struct worktree *wt;
 
 	if (!validate_branchname(name, ref))
 		return 0;
@@ -208,9 +208,11 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 		die(_("A branch named '%s' already exists."),
 		    ref->buf + strlen("refs/heads/"));
 
-	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-		die(_("Cannot force update the current branch."));
+	wt = find_shared_symref("HEAD", ref->buf);
+	if (wt && !wt->is_bare)
+		die(_("Cannot force update the branch '%s'"
+		      "checked out at '%s'."),
+		    ref->buf + strlen("refs/heads/"), wt->path);
 
 	return 1;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e575ffb4ff..4c868bf971 100755
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

