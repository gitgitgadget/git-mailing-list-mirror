Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D9DC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618922070E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbgFWPYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:24:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:40110 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgFWPYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:24:48 -0400
Received: (qmail 11782 invoked by uid 109); 23 Jun 2020 15:24:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:24:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16882 invoked by uid 111); 23 Jun 2020 15:24:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:24:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:24:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 01/10] t9351: derive anonymized tree checks from original repo
Message-ID: <20200623152447.GA1435482@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our tests of the anonymized repo just hard-code the expected set of
objects in the root and subdirectory trees. This makes them brittle to
the test setup changing (e.g., adding new paths that need tested).

Let's look at the original repo to compute our expected set of objects.
Note that this isn't completely perfect (e.g., we still rely on there
being only one tree in the root), but it does simplify later patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9351-fast-export-anonymize.sh | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 897dc50907..e772cf9930 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -71,22 +71,18 @@ test_expect_success 'repo has original shape and timestamps' '
 
 test_expect_success 'root tree has original shape' '
 	# the output entries are not necessarily in the same
-	# order, but we know at least that we will have one tree
-	# and one blob, so just check the sorted order
-	cat >expect <<-\EOF &&
-	blob
-	tree
-	EOF
+	# order, but we should at least have the same set of
+	# object types.
+	git -C .. ls-tree HEAD >orig-root &&
+	cut -d" " -f2 <orig-root | sort >expect &&
 	git ls-tree $other_branch >root &&
 	cut -d" " -f2 <root | sort >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'paths in subdir ended up in one tree' '
-	cat >expect <<-\EOF &&
-	blob
-	blob
-	EOF
+	git -C .. ls-tree other:subdir >orig-subdir &&
+	cut -d" " -f2 <orig-subdir | sort >expect &&
 	tree=$(grep tree root | cut -f2) &&
 	git ls-tree $other_branch:$tree >tree &&
 	cut -d" " -f2 <tree >actual &&
-- 
2.27.0.517.gbc32778fa3

