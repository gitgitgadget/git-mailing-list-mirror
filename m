Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99CF21F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 19:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440127AbfJRTqF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 15:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440164AbfJRTqE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 15:46:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 098153071D96;
        Fri, 18 Oct 2019 19:46:04 +0000 (UTC)
Received: from trillian.uncooperative.org.com (dhcp-10-20-1-15.bss.redhat.com [10.20.1.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E06A5C1B5;
        Fri, 18 Oct 2019 19:46:03 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH v2 4/4] Make "git branch -d" prune missing worktrees automatically.
Date:   Fri, 18 Oct 2019 15:45:42 -0400
Message-Id: <20191018194542.1316981-4-pjones@redhat.com>
In-Reply-To: <20191018194542.1316981-1-pjones@redhat.com>
References: <20191018194317.wvqphshpkfskvkyh@redhat.com>
 <20191018194542.1316981-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 18 Oct 2019 19:46:04 +0000 (UTC)
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
 builtin/branch.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ef214632f0..a2a1e89c66b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -236,13 +236,17 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (kinds == FILTER_REFS_BRANCHES) {
 			const struct worktree *wt =
 				find_shared_symref("HEAD", name);
-			if (wt) {
+			int rc = -1;
+
+			if (wt && (rc = prune_worktree_if_missing(wt)) < 0) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
 				      bname.buf, wt->path);
 				ret = 1;
 				continue;
 			}
+			if (rc >= 0)
+				delete_worktrees_dir_if_empty();
 		}
 
 		target = resolve_refdup(name,
-- 
2.23.0

