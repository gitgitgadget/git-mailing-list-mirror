Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE5C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EFD64E68
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhBQXgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:36:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:36782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232478AbhBQXgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 18:36:14 -0500
Received: (qmail 20886 invoked by uid 109); 17 Feb 2021 23:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 23:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10807 invoked by uid 111); 17 Feb 2021 23:35:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 18:35:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 18:35:33 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] docs/rev-list: add some examples of --disk-usage
Message-ID: <YC2oRaMtBo/zMBmi@coredump.intra.peff.net>
References: <YC2nOxPP3SAY2g1I@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC2nOxPP3SAY2g1I@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not immediately obvious why --disk-usage might be a useful thing.
These examples show off a few of the real-world cases I've used it for.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-rev-list.txt | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index d7ff519b90..20bb8e8217 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -83,6 +83,47 @@ git rev-list --author=you@example.com --since=1.year.ago --all
 git rev-list --objects HEAD
 ----------
 
+* Compare the disk size of all reachable objects, versus those
+  reachable from reflogs, versus the total packed size. This can tell
+  you whether running `git repack -ad` might reduce the repository size
+  (by dropping unreachable objects), and whether expiring reflogs might
+  help.
++
+----------
+# reachable objects
+git rev-list --disk-usage --objects --all
+# plus reflogs
+git rev-list --disk-usage --objects --all --reflog
+# total disk size used
+du -c .git/objects/pack/*.pack .git/objects/??/*
+# alternative to du: add up "size" and "size-pack" fields
+git count-objects -v
+----------
+
+* Report the disk size of each branch, not including objects used by the
+  current branch. This can find outliers that are contributing to a
+  bloated repository size (e.g., because somebody accidentally committed
+  large build artifacts).
++
+----------
+git for-each-ref --format='%(refname)' |
+while read branch
+do
+	size=$(git rev-list --disk-usage --objects HEAD..$branch)
+	echo "$size $branch"
+done |
+sort -n
+----------
+
+* Compare the on-disk size of branches in one group of refs, excluding
+  another. If you co-mingle objects from multiple remotes in a single
+  repository, this can show which remotes are contributing to the
+  repository size (taking the size of `origin` as a baseline).
++
+----------
+git rev-list --disk-usage --objects --remotes=$suspect --not --remotes=origin
+----------
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.30.1.989.g5e01c2f281
