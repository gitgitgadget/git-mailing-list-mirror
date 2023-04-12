Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1447EC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDLGfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDLGfp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:35:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C323ABC
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:35:44 -0700 (PDT)
Received: (qmail 17938 invoked by uid 109); 12 Apr 2023 06:35:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 06:35:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17179 invoked by uid 111); 12 Apr 2023 06:35:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 02:35:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 02:35:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH 5/7] t5512: allow any protocol version for filtered symref
 test
Message-ID: <20230412063543.GE1681312@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412062300.GA838367@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a test that checks that ls-remote, when asked only about HEAD,
will report the HEAD symref, and not others. This was marked to always
run with the v0 protocol by b2f73b70b2 (t5512: compensate for v0 only
sending HEAD symrefs, 2019-02-25).

But in v0 this test is doing nothing! For v0, upload-pack only reports
the HEAD symref anyway, so we'd never have any other symref to report.

For v2, it is useful; we learn about all symrefs (and the test repo has
multiple), so this demonstrates that we correctly avoid showing them.

We could perhaps mark this to test explicitly with v2, but since that is
the default these days, it's sufficient to just run ls-remote without
any protocol specification. It still passes if somebody does an explicit
GIT_TEST_PROTOCOL_VERSION=0; it's just testing less.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5512-ls-remote.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 74f0204c5b..1ac3b50ca5 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -271,9 +271,7 @@ test_expect_success 'ls-remote with filtered symref (refname)' '
 	ref: refs/heads/main	HEAD
 	$rev	HEAD
 	EOF
-	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
-	# protocol v0 here.
-	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref . HEAD >actual &&
+	git ls-remote --symref . HEAD >actual &&
 	test_cmp expect actual
 '
 
-- 
2.40.0.493.gfc602f1919

