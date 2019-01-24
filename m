Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0A01F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfAXMfm (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:35:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:47134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727386AbfAXMfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:35:42 -0500
Received: (qmail 25933 invoked by uid 109); 24 Jan 2019 12:35:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:35:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28010 invoked by uid 111); 24 Jan 2019 12:35:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:35:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:35:40 -0500
Date:   Thu, 24 Jan 2019 07:35:40 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] combine-diff: treat --summary like --stat
Message-ID: <20190124123539.GE11354@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124122603.GA10415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently "--cc --summary" on a merge shows nothing. Since we show "--cc
--stat" as a stat against the first parent, and because --summary is
typically used in combination with --stat, it makes sense to treat them
both the same way.

Note that we have to tweak t4013's setup a bit to test this case, as the
existing merges do not have any --summary results against their first
parent. But since the merge at the tip of 'master' does add and remove
files with respect to the second parent, we can just make a reversed
doppelganger merge where the parents are swapped.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c                                | 1 +
 t/t4013-diff-various.sh                       | 7 +++++++
 t/t4013/diff.diff-tree_--cc_--summary_REVERSE | 6 ++++++
 3 files changed, 14 insertions(+)
 create mode 100644 t/t4013/diff.diff-tree_--cc_--summary_REVERSE

diff --git a/combine-diff.c b/combine-diff.c
index 83ec3dfffa..f42b41d884 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1326,6 +1326,7 @@ static const char *path_path(void *obj)
  */
 #define STAT_FORMAT_MASK (DIFF_FORMAT_NUMSTAT \
 			  | DIFF_FORMAT_SHORTSTAT \
+			  | DIFF_FORMAT_SUMMARY \
 			  | DIFF_FORMAT_DIFFSTAT)
 
 /* find set of paths that every parent touches */
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9ccdf08730..e28953975b 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -98,6 +98,12 @@ test_expect_success setup '
 	git commit -m "update mode" &&
 	git checkout -f master &&
 
+	# Same merge as master, but with parents reversed. Hide it in a
+	# pseudo-ref to avoid impacting tests with --all.
+	commit=$(echo reverse |
+		 git commit-tree -p master^2 -p master^1 master^{tree}) &&
+	git update-ref REVERSE $commit &&
+
 	git config diff.renames false &&
 
 	git show-branch
@@ -240,6 +246,7 @@ diff-tree --cc --stat --summary master
 diff-tree -c --stat --summary side
 diff-tree --cc --stat --summary side
 diff-tree --cc --shortstat master
+diff-tree --cc --summary REVERSE
 # improved by Timo's patch
 diff-tree --cc --patch-with-stat master
 # improved by Timo's patch
diff --git a/t/t4013/diff.diff-tree_--cc_--summary_REVERSE b/t/t4013/diff.diff-tree_--cc_--summary_REVERSE
new file mode 100644
index 0000000000..e208dd5682
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--cc_--summary_REVERSE
@@ -0,0 +1,6 @@
+$ git diff-tree --cc --summary REVERSE
+2562325a7ee916efb2481da93073b82cec801cbc
+ create mode 100644 file1
+ delete mode 100644 file2
+ delete mode 100644 file3
+$
-- 
2.20.1.842.g8986705066

