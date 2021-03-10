Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D2EC433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE2F64FCA
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhCJRHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 12:07:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:58710 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233620AbhCJRH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 12:07:28 -0500
Received: (qmail 6432 invoked by uid 109); 10 Mar 2021 17:07:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 17:07:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23369 invoked by uid 111); 10 Mar 2021 17:07:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 12:07:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 12:07:27 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] filter-branch: drop multiple-ancestor warning
Message-ID: <YEj8zy5JX+KvlfGJ@coredump.intra.peff.net>
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a ref maps to a commit that is neither rewritten nor kept by
filter-branch (e.g., because it was eliminated by rev-list's pathspec
selection), we rewrite it to its nearest ancestor.

Since the initial commit in 6f6826c52b (Add git-filter-branch,
2007-06-03), we have warned when there are multiple such ancestors in
the map file. However, the warning code is impossible to trigger these
days. Since a0e46390d3 (filter-branch: fix ref rewriting with
--subdirectory-filter, 2008-08-12), we find the ancestor using "rev-list
-1", so it can only ever have a single value.

This code is made doubly confusing by the fact that we append to the map
file when mapping ancestors. However, this can never yield multiple
values because:

  - we explicitly check whether the map already exists, and if so, do
    nothing (so our "append" will always be to a file that does not
    exist)

  - even if we were to try mapping twice, the process to do so is
    deterministic. I.e., we'd always end up with the same ancestor for a
    given sha1. So warning about it would be pointless; there is no
    ambiguity.

So swap out the warning code for a BUG (which we'll simplify further in
the next commit). And let's stop using the append operator to make the
ancestor-mapping code less confusing.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-filter-branch.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index fea7964617..a1e80bd552 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -492,7 +492,7 @@ then
 		sha1=$(git rev-parse "$ref"^0)
 		test -f "$workdir"/../map/$sha1 && continue
 		ancestor=$(git rev-list --simplify-merges -1 "$ref" "$@")
-		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
+		test "$ancestor" && echo $(map $ancestor) >"$workdir"/../map/$sha1
 	done < "$tempdir"/heads
 fi
 
@@ -534,14 +534,7 @@ do
 		fi
 	;;
 	*)
-		# NEEDSWORK: possibly add -Werror, making this an error
-		warn "WARNING: '$ref' was rewritten into multiple commits:"
-		warn "$rewritten"
-		warn "WARNING: Ref '$ref' points to the first one now."
-		rewritten=$(echo "$rewritten" | head -n 1)
-		git update-ref -m "filter-branch: rewrite to first" \
-				"$ref" $rewritten $sha1 ||
-			die "Could not rewrite $ref"
+		die "BUG: multiple ancestors in map file?"
 	;;
 	esac
 	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1 ||
-- 
2.31.0.rc2.525.gc2268d2248

