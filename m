Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D5CC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 06:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E156B20772
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 06:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgHKGxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:53:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:54864 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgHKGxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 02:53:49 -0400
Received: (qmail 27268 invoked by uid 109); 11 Aug 2020 06:53:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Aug 2020 06:53:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13797 invoked by uid 111); 11 Aug 2020 06:53:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Aug 2020 02:53:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Aug 2020 02:53:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
Message-ID: <20200811065347.GA1486938@coredump.intra.peff.net>
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgcub811.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 12:44:26PM -0700, Junio C Hamano wrote:

> * ps/ref-transaction-hook (2020-08-07) 1 commit
>   (merged to 'next' on 2020-08-10 at d8ad7cc8f6)
>  + refs: fix interleaving hook calls with reference-transaction hook
> 
>  The logic to find the ref transaction hook script attempted to
>  cache the path to the found hook without realizing that it needed
>  to keep a copied value, as the API it used returned a transitory
>  buffer space.  This has been corrected.
> 
>  Will merge to 'master'.
>  to be followed by a removal of the caching feature, which does not
>  seem to help even as a negative cache.

I noticed this had a CI problem. Fix is below.

-- >8 --
Subject: [PATCH] t1416: avoid hard-coded sha1 ids

The test added by e5256c82e5 (refs: fix interleaving hook calls with
reference-transaction hook, 2020-08-07) uses hard-coded sha1 object ids
in its expected output. This causes it to fail when run with
GIT_TEST_DEFAULT_HASH=sha256.

Let's make use of the oid variables we define earlier, as the rest of
the nearby tests do.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1416-ref-transaction-hooks.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index d4d19194bf..f6e741c6c0 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -7,6 +7,7 @@ test_description='reference transaction hooks'
 test_expect_success setup '
 	mkdir -p .git/hooks &&
 	test_commit PRE &&
+	PRE_OID=$(git rev-parse PRE) &&
 	test_commit POST &&
 	POST_OID=$(git rev-parse POST)
 '
@@ -120,10 +121,10 @@ test_expect_success 'interleaving hook calls succeed' '
 	EOF
 
 	cat >expect <<-EOF &&
-		hooks/update refs/tags/PRE 0000000000000000000000000000000000000000 63ac8e7bcdb882293465435909f54a96de17d4f7
+		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
 		hooks/reference-transaction prepared
 		hooks/reference-transaction committed
-		hooks/update refs/tags/POST 0000000000000000000000000000000000000000 99d53161c3a0a903b6561b9f6c0c665b3a476401
+		hooks/update refs/tags/POST $ZERO_OID $POST_OID
 		hooks/reference-transaction prepared
 		hooks/reference-transaction committed
 	EOF
-- 
2.28.0.532.g36127779a4

