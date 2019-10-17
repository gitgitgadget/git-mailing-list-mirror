Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA331F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 16:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502198AbfJQQ2l (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 12:28:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392968AbfJQQ2j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 12:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2B0D2BF02
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:28:39 +0000 (UTC)
Received: from trillian.uncooperative.org.com (dhcp-10-20-1-15.bss.redhat.com [10.20.1.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76BE05C1D8;
        Thu, 17 Oct 2019 16:28:39 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     git@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>
Subject: [PATCH 2/2] Make "git branch -d" prune missing worktrees automatically.
Date:   Thu, 17 Oct 2019 12:28:26 -0400
Message-Id: <20191017162826.1064257-2-pjones@redhat.com>
In-Reply-To: <20191017162826.1064257-1-pjones@redhat.com>
References: <20191017162826.1064257-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 17 Oct 2019 16:28:39 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if you do:

$ git branch zonk origin/master
$ git worktree add zonk zonk
$ rm -rf zonk
$ git branch -d zonk

You get the following error:

$ git branch -d zonk
error: Cannot delete branch 'zonk' checked out at '/home/pjones/devel/kernel.org/git/zonk'

It isn't meaningfully checked out, the repo's data is just stale and no
longer reflects reality.

This makes it so that if nothing is present where a worktree is
supposedly checked out, deleting the branch will automatically prune it.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 builtin/branch.c   |  2 +-
 builtin/worktree.c | 14 ++++++++++++++
 worktree.h         |  6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ef214632f0..d611f8183b4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -236,7 +236,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (kinds == FILTER_REFS_BRANCHES) {
 			const struct worktree *wt =
 				find_shared_symref("HEAD", name);
-			if (wt) {
+			if (wt && prune_worktree_if_missing(wt) < 0) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
 				      bname.buf, wt->path);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4de44f579af..b3ad915c3c3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -133,6 +133,20 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	return 0;
 }
 
+int prune_worktree_if_missing(const struct worktree *wt)
+{
+	struct strbuf reason = STRBUF_INIT;
+
+	if (access(wt->path, F_OK) >= 0 ||
+	    (errno != ENOENT && errno == ENOTDIR)) {
+		errno = EEXIST;
+		return -1;
+	}
+
+	strbuf_addf(&reason, _("Removing worktrees/%s: worktree directory is not present"), wt->id);
+	return prune_worktree(wt->id, &reason);
+}
+
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
diff --git a/worktree.h b/worktree.h
index caecc7a281c..75762c25752 100644
--- a/worktree.h
+++ b/worktree.h
@@ -132,4 +132,10 @@ void strbuf_worktree_ref(const struct worktree *wt,
 const char *worktree_ref(const struct worktree *wt,
 			 const char *refname);
 
+/*
+ * Prune a worktree if it is no longer present at the checked out location.
+ * Returns < 0 if the checkout is there or if pruning fails.
+ */
+int prune_worktree_if_missing(const struct worktree *wt);
+
 #endif
-- 
2.23.0

