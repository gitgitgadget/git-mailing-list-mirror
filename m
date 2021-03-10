Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77BEC433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C16C64FC7
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhCJRHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 12:07:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:58718 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233600AbhCJRHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 12:07:38 -0500
Received: (qmail 6449 invoked by uid 109); 10 Mar 2021 17:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 17:07:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23376 invoked by uid 111); 10 Mar 2021 17:07:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 12:07:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 12:07:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/3] filter-branch: drop $_x40 glob
Message-ID: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checking whether a commit was rewritten to a single object id, we
use a glob that insists on a 40-hex result. This works for sha1, but
fails t7003 when run with GIT_TEST_DEFAULT_HASH=sha256.

Since the previous commit simplified the case statement here, we only
have two arms: an empty string or a single object id. We can just loosen
our glob to match anything, and still distinguish those cases (we lose
the ability to notice bogus input, but that's not a problem; we are the
one who wrote the map in the first place, and anyway update-ref will
complain loudly if the input isn't a valid hash).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-filter-branch.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a1e80bd552..cb89372813 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -498,8 +498,6 @@ fi
 
 # Finally update the refs
 
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 echo
 while read ref
 do
@@ -519,7 +517,7 @@ do
 		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
 			die "Could not delete $ref"
 	;;
-	$_x40)
+	*)
 		echo "Ref '$ref' was rewritten"
 		if ! git update-ref -m "filter-branch: rewrite" \
 					"$ref" $rewritten $sha1 2>/dev/null; then
@@ -533,9 +531,6 @@ do
 			fi
 		fi
 	;;
-	*)
-		die "BUG: multiple ancestors in map file?"
-	;;
 	esac
 	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1 ||
 		 exit
-- 
2.31.0.rc2.525.gc2268d2248
