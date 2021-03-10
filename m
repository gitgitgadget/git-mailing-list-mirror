Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB31C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E46664F9A
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCJRHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 12:07:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:58698 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhCJRHU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 12:07:20 -0500
Received: (qmail 6414 invoked by uid 109); 10 Mar 2021 17:07:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 17:07:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23356 invoked by uid 111); 10 Mar 2021 17:07:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 12:07:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 12:07:19 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] t7003: test ref rewriting explicitly
Message-ID: <YEj8x5fQl1fyLGNg@coredump.intra.peff.net>
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After it has rewritten all of the commits, filter-branch will then
rewrite each of the input refs based on the resulting map of old/new
commits. But we don't have any explicit test coverage of this code.
Let's make sure we are covering each of those cases:

  - deleting a ref when all of its commits were pruned

  - rewriting a ref based on the mapping (this happens throughout the
    script, but let's make sure we generate the correct messages)

  - rewriting a ref whose tip was excluded, in which case we rewrite to
    the nearest ancestor. Note in this case that we still insist that no
    "warning" line is present (even though it looks like we'd trigger
    the "... was rewritten into multiple commits" one). See the next
    commit for more details.

Note these all pass currently, but the latter two will fail when run
with GIT_TEST_DEFAULT_HASH=sha256.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7003-filter-branch.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 1c55695034..1349e5b232 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -506,4 +506,35 @@ test_expect_success 'rewrite repository including refs that point at non-commit
 	! fgrep fatal filter-output
 '
 
+test_expect_success 'filter-branch handles ref deletion' '
+	git switch --orphan empty-commit &&
+	git commit --allow-empty -m "empty commit" &&
+	git tag empty &&
+	git branch to-delete &&
+	git filter-branch -f --prune-empty to-delete >out 2>&1 &&
+	grep "to-delete.*was deleted" out &&
+	test_must_fail git rev-parse --verify to-delete
+'
+
+test_expect_success 'filter-branch handles ref rewrite' '
+	git checkout empty &&
+	test_commit to-drop &&
+	git branch rewrite &&
+	git filter-branch -f \
+		--index-filter "git rm --ignore-unmatch --cached to-drop.t" \
+		 rewrite >out 2>&1 &&
+	grep "rewrite.*was rewritten" out &&
+	! grep -i warning out &&
+	git diff-tree empty rewrite
+'
+
+test_expect_success 'filter-branch handles ancestor rewrite' '
+	test_commit to-exclude &&
+	git branch ancestor &&
+	git filter-branch -f ancestor -- :^to-exclude.t >out 2>&1 &&
+	grep "ancestor.*was rewritten" out &&
+	! grep -i warning out &&
+	git diff-tree HEAD^ ancestor
+'
+
 test_done
-- 
2.31.0.rc2.525.gc2268d2248

