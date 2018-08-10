Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C931F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeHKBsj (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:48:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:50712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726774AbeHKBsj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:48:39 -0400
Received: (qmail 28267 invoked by uid 109); 10 Aug 2018 23:16:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 23:16:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24790 invoked by uid 111); 10 Aug 2018 23:16:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 19:16:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 19:16:40 -0400
Date:   Fri, 10 Aug 2018 19:16:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 5/7] t1006: test cat-file --batch-all-objects with duplicates
Message-ID: <20180810231640.GE19875@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test for --batch-all-objects in t1006 covers a variety
of object storage situations, but one thing it doesn't cover
is that we avoid mentioning duplicate objects. We won't have
any because running "git repack -ad" will have packed them
all and deleted the loose ones.

This does work (because we sort and de-dup the output list),
but it's good to include it in our test. And doubly so for
when we add an unordered mode which has to de-dup in a
different way.

Note that we cannot just re-create one of the objects, as
Git will omit the write of an object that is already
present. However, we can create a new pack with one of the
objects, which forces the duplication.

One alternative would be to just use "git repack -a" instead
of "-ad". But then _every_ object would be duplicated as
loose and packed, and we might miss a bug that omits packed
objects (because we'd show their loose counterparts).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1006-cat-file.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 13dd510b2e..4fb5e098f2 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -550,8 +550,8 @@ test_expect_success 'git cat-file --batch --follow-symlink returns correct sha a
 test_expect_success 'cat-file --batch-all-objects shows all objects' '
 	# make new repos so we know the full set of objects; we will
 	# also make sure that there are some packed and some loose
-	# objects, some referenced and some not, and that there are
-	# some available only via alternates.
+	# objects, some referenced and some not, some duplicates, and that
+	# there are some available only via alternates.
 	git init all-one &&
 	(
 		cd all-one &&
@@ -567,6 +567,8 @@ test_expect_success 'cat-file --batch-all-objects shows all objects' '
 		cd all-two &&
 		echo local-unref | git hash-object -w --stdin
 	) >>expect.unsorted &&
+	git -C all-two rev-parse HEAD:file |
+		git -C all-two pack-objects .git/objects/pack/pack &&
 	sort <expect.unsorted >expect &&
 	git -C all-two cat-file --batch-all-objects \
 				--batch-check="%(objectname)" >actual &&
-- 
2.18.0.1058.g7433f71063

