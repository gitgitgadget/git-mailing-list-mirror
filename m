Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937D91F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfAXMgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:36:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:47146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727522AbfAXMgt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:36:49 -0500
Received: (qmail 25980 invoked by uid 109); 24 Jan 2019 12:36:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:36:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28029 invoked by uid 111); 24 Jan 2019 12:36:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:36:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:36:47 -0500
Date:   Thu, 24 Jan 2019 07:36:47 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] combine-diff: treat --dirstat like --stat
Message-ID: <20190124123647.GF11354@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124122603.GA10415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently "--cc --dirstat" will show nothing for a merge.  Like
--shortstat and --summary in the previous two patches, it probably makes
sense to treat it like we do --stat, and show a stat against the
first-parent.

This case is less obviously correct than for --shortstat and --summary,
as those are basically variants of --stat themselves. It's possible we
could develop a multi-parent combined dirstat format, in which case we
might regret defining this first-parent behavior. But the same could be
said for --stat, and in the 12+ years of it showing first-parent stats,
nobody has complained.

So showing the first-parent dirstat is at least _useful_, and if we
later develop a clever multi-parent stat format, we'd probably have to
deal with --stat anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c                                   | 1 +
 t/t4013-diff-various.sh                          | 1 +
 t/t4013/diff.diff_--dirstat_--cc_master~1_master | 3 +++
 3 files changed, 5 insertions(+)
 create mode 100644 t/t4013/diff.diff_--dirstat_--cc_master~1_master

diff --git a/combine-diff.c b/combine-diff.c
index f42b41d884..23d8fabe75 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1327,6 +1327,7 @@ static const char *path_path(void *obj)
 #define STAT_FORMAT_MASK (DIFF_FORMAT_NUMSTAT \
 			  | DIFF_FORMAT_SHORTSTAT \
 			  | DIFF_FORMAT_SUMMARY \
+			  | DIFF_FORMAT_DIRSTAT \
 			  | DIFF_FORMAT_DIFFSTAT)
 
 /* find set of paths that every parent touches */
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e28953975b..9f8f0e84ad 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -358,6 +358,7 @@ diff --line-prefix=abc master master^ side
 diff --dirstat master~1 master~2
 diff --dirstat initial rearrange
 diff --dirstat-by-file initial rearrange
+diff --dirstat --cc master~1 master
 # No-index --abbrev and --no-abbrev
 diff --raw initial
 :noellipses diff --raw initial
diff --git a/t/t4013/diff.diff_--dirstat_--cc_master~1_master b/t/t4013/diff.diff_--dirstat_--cc_master~1_master
new file mode 100644
index 0000000000..fba4e34175
--- /dev/null
+++ b/t/t4013/diff.diff_--dirstat_--cc_master~1_master
@@ -0,0 +1,3 @@
+$ git diff --dirstat --cc master~1 master
+  40.0% dir/
+$
-- 
2.20.1.842.g8986705066
