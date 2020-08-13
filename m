Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB87C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0BA207DA
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgHMFXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:23:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:57342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgHMFXG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 01:23:06 -0400
Received: (qmail 15529 invoked by uid 109); 13 Aug 2020 05:23:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 05:23:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10574 invoked by uid 111); 13 Aug 2020 05:23:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 01:23:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 01:23:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>, Nuthan Munaiah <nm6061@rit.edu>,
        git@vger.kernel.org
Subject: [PATCH 1/3] t8003: check output of coalesced blame
Message-ID: <20200813052305.GA2514880@coredump.intra.peff.net>
References: <20200813052054.GA1962792@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813052054.GA1962792@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit f0cbe742f4 (blame: add a test to cover blame_coalesce(),
2019-06-20) added a test case where blame can usefully coalesce two
groups of lines. But since it relies on the normal blame output, it only
exercises the code and can't tell whether the lines were actually
joined into a single group.

However, by using --porcelain output, we can see how git-blame considers
the groupings (and likewise how the coalescing might have a real
user-visible impact for a tool that uses the porcelain-output
groupings). This lets us confirm that we are indeed coalescing correctly
(and the fact that this test case requires coalescing can be verified by
dropping the call to blame_coalesce(), causing the test to fail).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t8003-blame-corner-cases.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index b871dd4f86..1e89494ef6 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -273,10 +273,6 @@ test_expect_success 'blame file with CRLF core.autocrlf=true' '
 	grep "A U Thor" actual
 '
 
-# Tests the splitting and merging of blame entries in blame_coalesce().
-# The output of blame is the same, regardless of whether blame_coalesce() runs
-# or not, so we'd likely only notice a problem if blame crashes or assigned
-# blame to the "splitting" commit ('SPLIT' below).
 test_expect_success 'blame coalesce' '
 	cat >giraffe <<-\EOF &&
 	ABC
@@ -302,10 +298,11 @@ test_expect_success 'blame coalesce' '
 	git commit -m "same contents as original" &&
 
 	cat >expect <<-EOF &&
-	$oid 1) ABC
-	$oid 2) DEF
+	$oid 1 1 2
+	$oid 2 2
 	EOF
-	git -c core.abbrev=$(test_oid hexsz) blame -s giraffe >actual &&
+	git blame --porcelain giraffe >actual.raw &&
+	grep "^$oid" actual.raw >actual &&
 	test_cmp expect actual
 '
 
-- 
2.28.0.570.ge2c3ee08e4

