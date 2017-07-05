Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C53202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 07:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdGEH5k (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 03:57:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:59756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750841AbdGEH5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 03:57:39 -0400
Received: (qmail 21408 invoked by uid 109); 5 Jul 2017 07:57:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 07:57:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5673 invoked by uid 111); 5 Jul 2017 07:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 03:57:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 03:57:37 -0400
Date:   Wed, 5 Jul 2017 03:57:37 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: [PATCH 1/6] reflog-walk: skip over double-null oid due to HEAD rename
Message-ID: <20170705075737.6qsotqkzxdxofni6@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 39ee4c6c2f (branch: record creation of renamed branch
in HEAD's log, 2017-02-20), a rename on the currently
checked out branch will create two entries in the HEAD
reflog: one where the branch goes away (switching to the
null oid), and one where it comes back (switching away from
the null oid).

This confuses the reflog-walk code. When walking backwards,
it first sees the null oid in the "old" field of the second
entry. Thanks to the "root commit" logic added by 71abeb753f
(reflog: continue walking the reflog past root commits,
2016-06-03), we keep looking for the next entry by scanning
the "new" field from the previous entry. But that field is
also null! We need to go just a tiny bit further, and look
at its "old" field. But with the current code, we decide the
reflog has nothing else to show and just give up. To the
user this looks like the reflog was truncated by the rename
operation, when in fact those entries are still there.

This patch does the absolute minimal fix, which is to look
back that one extra level and keep traversing.

The resulting behavior may not be the _best_ thing to do in
the long run (for example, we show both reflog entries each
with the same commit id), but it's a simple way to fix the
problem without risking further regressions.

Signed-off-by: Jeff King <peff@peff.net>
---
I do still think it would be worth looking into making this rename
create a single reflog entry, but that's largely orthogonal to making
the display code sane(r).

 reflog-walk.c     |  2 ++
 t/t3200-branch.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/reflog-walk.c b/reflog-walk.c
index ed99437ad2..b7e489ad32 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -259,6 +259,8 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 		/* a root commit, but there are still more entries to show */
 		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 		logobj = parse_object(&reflog->noid);
+		if (!logobj)
+			logobj = parse_object(&reflog->ooid);
 	}
 
 	if (!logobj || logobj->type != OBJ_COMMIT) {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 48d152b9a9..dd37ac47c5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -162,6 +162,17 @@ test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD'
 	grep "^0\{40\}.*$msg$" .git/logs/HEAD
 '
 
+test_expect_success 'resulting reflog can be shown by log -g' '
+	oid=$(git rev-parse HEAD) &&
+	cat >expect <<-EOF &&
+	HEAD@{0} $oid $msg
+	HEAD@{1} $oid $msg
+	HEAD@{2} $oid checkout: moving from foo to baz
+	EOF
+	git log -g --format="%gd %H %gs" -3 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
 	git checkout master &&
 	git worktree add -b baz bazdir &&
-- 
2.13.2.892.g25f9b59978

