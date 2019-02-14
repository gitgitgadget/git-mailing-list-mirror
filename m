Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC2A1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 11:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406620AbfBNLHi (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 06:07:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:44082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2405025AbfBNLHi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 06:07:38 -0500
Received: (qmail 15236 invoked by uid 109); 14 Feb 2019 11:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 11:07:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9273 invoked by uid 111); 14 Feb 2019 11:07:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 06:07:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 06:07:36 -0500
Date:   Thu, 14 Feb 2019 06:07:36 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] prune: lazily perform reachability traversal
Message-ID: <20190214110736.GA27609@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043522.GA19183@sigill.intra.peff.net>
 <CAPig+cQVUZT4ZyMeP5xDcvypjucVeRUP2cN=tL9c5DVoONSNng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQVUZT4ZyMeP5xDcvypjucVeRUP2cN=tL9c5DVoONSNng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 05:54:25AM -0500, Eric Sunshine wrote:

> On Wed, Feb 13, 2019 at 11:35 PM Jeff King <peff@peff.net> wrote:
> > diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> > @@ -274,6 +274,18 @@ test_expect_success 'prune .git/shallow' '
> > +test_expect_success 'prune .git/shallow when there are no loose objects' '
> > +       SHA1=$(echo hi|git commit-tree HEAD^{tree}) &&
> 
> Perhaps name this variable 'oid' rather than 'SHA1' to make brian happy.

Heh, that line (and the one below it) are cut-and-paste from the setup
of the test directly above.

Perhaps we should do this on top:

-- >8 --
Subject: [PATCH] t5304: rename "sha1" variables to "oid"

Let's make the script less jarring to read in a post-sha1 world by
using more hash-agnostic variable names.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5304-prune.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 2c19a790c1..1eeb828a15 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -118,10 +118,10 @@ test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 
 test_expect_success 'prune: prune former HEAD after checking out branch' '
 
-	head_sha1=$(git rev-parse HEAD) &&
+	head_oid=$(git rev-parse HEAD) &&
 	git checkout --quiet master &&
 	git prune -v >prune_actual &&
-	grep "$head_sha1" prune_actual
+	grep "$head_oid" prune_actual
 
 '
 
@@ -265,24 +265,24 @@ EOF
 '
 
 test_expect_success 'prune .git/shallow' '
-	SHA1=$(echo hi|git commit-tree HEAD^{tree}) &&
-	echo $SHA1 >.git/shallow &&
+	oid=$(echo hi|git commit-tree HEAD^{tree}) &&
+	echo $oid >.git/shallow &&
 	git prune --dry-run >out &&
-	grep $SHA1 .git/shallow &&
-	grep $SHA1 out &&
+	grep $oid .git/shallow &&
+	grep $oid out &&
 	git prune &&
 	test_path_is_missing .git/shallow
 '
 
 test_expect_success 'prune .git/shallow when there are no loose objects' '
-	SHA1=$(echo hi|git commit-tree HEAD^{tree}) &&
-	echo $SHA1 >.git/shallow &&
-	git update-ref refs/heads/shallow-tip $SHA1 &&
+	oid=$(echo hi|git commit-tree HEAD^{tree}) &&
+	echo $oid >.git/shallow &&
+	git update-ref refs/heads/shallow-tip $oid &&
 	git repack -ad &&
 	# verify assumption that all loose objects are gone
 	git count-objects | grep ^0 &&
 	git prune &&
-	echo $SHA1 >expect &&
+	echo $oid >expect &&
 	test_cmp expect .git/shallow
 '
 
@@ -326,8 +326,8 @@ test_expect_success 'prune: handle HEAD reflog in multiple worktrees' '
 		git reset --hard HEAD^
 	) &&
 	git prune --expire=now &&
-	SHA1=`git hash-object expected` &&
-	git -C third-worktree show "$SHA1" >actual &&
+	oid=`git hash-object expected` &&
+	git -C third-worktree show "$oid" >actual &&
 	test_cmp expected actual
 '
 
-- 
2.21.0.rc1.567.g7f045cdc92

