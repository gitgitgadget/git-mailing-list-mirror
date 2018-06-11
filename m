Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122E81F403
	for <e@80x24.org>; Mon, 11 Jun 2018 08:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932298AbeFKIfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 04:35:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:41180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932109AbeFKIfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 04:35:42 -0400
Received: (qmail 11270 invoked by uid 109); 11 Jun 2018 08:35:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 08:35:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14197 invoked by uid 111); 11 Jun 2018 08:35:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 04:35:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 04:35:40 -0400
Date:   Mon, 11 Jun 2018 04:35:40 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v3 1/2] t7415: don't bother creating commit for symlink test
Message-ID: <20180611083540.GA16131@sigill.intra.peff.net>
References: <20180611083515.GA1815@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611083515.GA1815@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Early versions of the fsck .gitmodules detection code
actually required a tree to be at the root of a commit for
it to be checked for .gitmodules. What we ended up with in
159e7b080b (fsck: detect gitmodules files, 2018-05-02),
though, finds a .gitmodules file in _any_ tree (see that
commit for more discussion).

As a result, there's no need to create a commit in our
tests. Let's drop it in the name of simplicity. And since
that was the only thing referencing $tree, we can pull our
tree creation out of a command substitution.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7415-submodule-names.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index a770d92a55..541bd81684 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -135,13 +135,10 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
 		tricky="[foo]bar=true" &&
 		content=$(git hash-object -w ../.gitmodules) &&
 		target=$(printf "$tricky" | git hash-object -w --stdin) &&
-		tree=$(
-			{
-				printf "100644 blob $content\t$tricky\n" &&
-				printf "120000 blob $target\t.gitmodules\n"
-			} | git mktree
-		) &&
-		commit=$(git commit-tree $tree) &&
+		{
+			printf "100644 blob $content\t$tricky\n" &&
+			printf "120000 blob $target\t.gitmodules\n"
+		} | git mktree &&
 
 		# Check not only that we fail, but that it is due to the
 		# symlink detector; this grep string comes from the config
-- 
2.18.0.rc1.446.g4486251e51

