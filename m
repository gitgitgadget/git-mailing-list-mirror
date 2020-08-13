Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7990CC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D4F20829
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMFXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:23:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:57354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgHMFXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 01:23:42 -0400
Received: (qmail 15545 invoked by uid 109); 13 Aug 2020 05:23:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 05:23:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10600 invoked by uid 111); 13 Aug 2020 05:23:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 01:23:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 01:23:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>, Nuthan Munaiah <nm6061@rit.edu>,
        git@vger.kernel.org
Subject: [PATCH 2/3] t8003: factor setup out of coalesce test
Message-ID: <20200813052341.GB2514880@coredump.intra.peff.net>
References: <20200813052054.GA1962792@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813052054.GA1962792@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding more tests of blame's coalesce code, let's
split the setup out from the first test, and give each of the commits
a more meaningful name:

  - $orig for the original source that added the lines

  - $split for the version where they are split apart

  - $final for the final version that re-joins them

That's not strictly necessary, but makes the follow-on tests less
brittle than relying on HEAD^, etc, to name the commits.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t8003-blame-corner-cases.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 1e89494ef6..7f39a84289 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -273,14 +273,14 @@ test_expect_success 'blame file with CRLF core.autocrlf=true' '
 	grep "A U Thor" actual
 '
 
-test_expect_success 'blame coalesce' '
+test_expect_success 'setup coalesce tests' '
 	cat >giraffe <<-\EOF &&
 	ABC
 	DEF
 	EOF
 	git add giraffe &&
 	git commit -m "original file" &&
-	oid=$(git rev-parse HEAD) &&
+	orig=$(git rev-parse HEAD) &&
 
 	cat >giraffe <<-\EOF &&
 	ABC
@@ -289,20 +289,24 @@ test_expect_success 'blame coalesce' '
 	EOF
 	git add giraffe &&
 	git commit -m "interior SPLIT line" &&
+	split=$(git rev-parse HEAD) &&
 
 	cat >giraffe <<-\EOF &&
 	ABC
 	DEF
 	EOF
 	git add giraffe &&
 	git commit -m "same contents as original" &&
+	final=$(git rev-parse HEAD)
+'
 
+test_expect_success 'blame coalesce' '
 	cat >expect <<-EOF &&
-	$oid 1 1 2
-	$oid 2 2
+	$orig 1 1 2
+	$orig 2 2
 	EOF
-	git blame --porcelain giraffe >actual.raw &&
-	grep "^$oid" actual.raw >actual &&
+	git blame --porcelain $final giraffe >actual.raw &&
+	grep "^$orig" actual.raw >actual &&
 	test_cmp expect actual
 '
 
-- 
2.28.0.570.ge2c3ee08e4

