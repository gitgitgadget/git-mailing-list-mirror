Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE5B1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfAXMex (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:34:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:47124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727386AbfAXMew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:34:52 -0500
Received: (qmail 25876 invoked by uid 109); 24 Jan 2019 12:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:34:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27992 invoked by uid 111); 24 Jan 2019 12:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:34:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:34:51 -0500
Date:   Thu, 24 Jan 2019 07:34:51 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] combine-diff: treat --shortstat like --stat
Message-ID: <20190124123450.GD11354@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124122603.GA10415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --stat of a combined diff is defined as the first-parent stat,
going all the way back to 965f803c32 (combine-diff: show diffstat with
the first parent., 2006-04-17).

Naturally, we gave --numstat the same treatment in 74e2abe5b7 (diff
--numstat, 2006-10-12).

But --shortstat, which is really just the final line of --stat, does
nothing, which produces confusing results:

  $ git show --oneline --stat eab7584e37
  eab7584e37 Merge branch 'en/show-ref-doc-fix'

   Documentation/git-show-ref.txt | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)

  $ git show --oneline --shortstat eab7584e37
  eab7584e37 Merge branch 'en/show-ref-doc-fix'

  [nothing! We'd expect to see the "1 file changed..." line]

This patch teaches combine-diff to treats the two formats identically.

Reported-by: David Turner <novalis@novalis.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c                                 | 1 +
 t/t4013-diff-various.sh                        | 1 +
 t/t4013/diff.diff-tree_--cc_--shortstat_master | 4 ++++
 3 files changed, 6 insertions(+)
 create mode 100644 t/t4013/diff.diff-tree_--cc_--shortstat_master

diff --git a/combine-diff.c b/combine-diff.c
index b1d259d5a0..83ec3dfffa 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1325,6 +1325,7 @@ static const char *path_path(void *obj)
  * Diff stat formats which we always compute solely against the first parent.
  */
 #define STAT_FORMAT_MASK (DIFF_FORMAT_NUMSTAT \
+			  | DIFF_FORMAT_SHORTSTAT \
 			  | DIFF_FORMAT_DIFFSTAT)
 
 /* find set of paths that every parent touches */
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 7d985ff6b1..9ccdf08730 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -239,6 +239,7 @@ diff-tree --cc --stat --summary master
 # stat summary should show the diffstat and summary with the first parent
 diff-tree -c --stat --summary side
 diff-tree --cc --stat --summary side
+diff-tree --cc --shortstat master
 # improved by Timo's patch
 diff-tree --cc --patch-with-stat master
 # improved by Timo's patch
diff --git a/t/t4013/diff.diff-tree_--cc_--shortstat_master b/t/t4013/diff.diff-tree_--cc_--shortstat_master
new file mode 100644
index 0000000000..a4ca42df2a
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--cc_--shortstat_master
@@ -0,0 +1,4 @@
+$ git diff-tree --cc --shortstat master
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+ 2 files changed, 5 insertions(+)
+$
-- 
2.20.1.842.g8986705066

