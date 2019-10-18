Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BA71F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 19:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440122AbfJRTqF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 15:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440155AbfJRTqD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 15:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F62A3090FD6;
        Fri, 18 Oct 2019 19:46:03 +0000 (UTC)
Received: from trillian.uncooperative.org.com (dhcp-10-20-1-15.bss.redhat.com [10.20.1.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB3A75C1B5;
        Fri, 18 Oct 2019 19:46:02 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH v2 3/4] Make die_if_checked_out() prune missing checkouts of unlocked worktrees.
Date:   Fri, 18 Oct 2019 15:45:41 -0400
Message-Id: <20191018194542.1316981-3-pjones@redhat.com>
In-Reply-To: <20191018194542.1316981-1-pjones@redhat.com>
References: <20191018194317.wvqphshpkfskvkyh@redhat.com>
 <20191018194542.1316981-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 18 Oct 2019 19:46:03 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently if you do, for example:

$ git worktree add path foo

And "foo" has already been checked out at some other path, but the user
has removed it without pruning, and the worktree is not locked, you'll
get an error that the branch is already checked out.  It isn't
meaningfully checked out, the repo's data is just stale and no longer
reflects reality.

This makes it so that if nothing is present where a worktree is
supposedly checked out, and it is not locked, we ignore that the
worktree exists, then it should be cleaned up.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 branch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/branch.c b/branch.c
index 579494738a7..760ef387144 100644
--- a/branch.c
+++ b/branch.c
@@ -360,6 +360,12 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 	wt = find_shared_symref("HEAD", branch);
 	if (!wt || (ignore_current_worktree && wt->is_current))
 		return;
+
+	if (prune_worktree_if_missing(wt) >= 0) {
+		delete_worktrees_dir_if_empty();
+		return;
+	}
+
 	skip_prefix(branch, "refs/heads/", &branch);
 	die(_("'%s' is already checked out at '%s'"),
 	    branch, wt->path);
-- 
2.23.0

