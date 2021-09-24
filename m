Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C391C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DE06127B
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbhIXSiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:38:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:54636 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344684AbhIXSiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:38:18 -0400
Received: (qmail 19084 invoked by uid 109); 24 Sep 2021 18:36:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:36:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11055 invoked by uid 111); 24 Sep 2021 18:36:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:36:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:36:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 06/16] t5312: test non-destructive repack
Message-ID: <YU4aukHUjq3+24zn@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t5312, we create a state with a broken ref, and then make sure that
destructive repacks don't silently ignore the breakage (where a
destructive repack is one that might drop objects). But we don't check
the behavior of non-destructive repacks at all (i.e., ones where we'd
keep unreachable objects).

So let's add a test to confirm the current behavior, which is that
they are allowed (i.e., ignoring the breakage and considering any
objects it points to as unreachable). This may change in the future, but
we'd like for the test suite to alert us to that fact.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5312-prune-corruption.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 0704f3e930..c7010fb754 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -46,6 +46,11 @@ test_expect_success 'put bogus object into pack' '
 	git cat-file -e $bogus
 '
 
+test_expect_success 'non-destructive repack ignores bogus name' '
+	create_bogus_ref &&
+	git repack -adk
+'
+
 test_expect_success 'destructive repack keeps packed object' '
 	create_bogus_ref &&
 	test_might_fail git repack -Ad --unpack-unreachable=now &&
-- 
2.33.0.1071.gb37e412355

