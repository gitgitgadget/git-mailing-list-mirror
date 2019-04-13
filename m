Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EED20248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDMFxL (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:53:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:57184 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbfDMFxL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:53:11 -0400
Received: (qmail 27713 invoked by uid 109); 13 Apr 2019 05:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 05:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12585 invoked by uid 111); 13 Apr 2019 05:53:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Apr 2019 01:53:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2019 01:53:09 -0400
Date:   Sat, 13 Apr 2019 01:53:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/7] t5530: check protocol response for "not our ref"
Message-ID: <20190413055309.GB19495@sigill.intra.peff.net>
References: <20190413055127.GA32340@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413055127.GA32340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in 9f9aa76130 (upload-pack: Improve error message when bad ref
requested, 2010-07-31), we added a test to make sure that we die with a
sensible message when the client asks for an object we don't have.

Much later, in bdb31eada7 (upload-pack: report "not our ref" to client,
2017-02-23), we started reporting that information via an "ERR" line in
the protocol. Let's check that part, as well.

While we're touching this test, let's drop the "-q" on the grep calls.
Our usual test style just relies on --verbose to control output.

Signed-off-by: Jeff King <peff@peff.net>
---
If like me, you are scratching your head over the grep for
multi_ack_detailed, it is from 9f9aa76130, which made sure we did not
spew extra cruft as part of the die message.

 t/t5530-upload-pack-error.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 4f6e32b04c..295bd0c83c 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -62,8 +62,9 @@ test_expect_success 'upload-pack error message when bad ref requested' '
 	printf "0045want %s multi_ack_detailed\n00000009done\n0000" \
 		"deadbeefdeadbeefdeadbeefdeadbeefdeadbeef" >input &&
 	test_must_fail git upload-pack . <input >output 2>output.err &&
-	grep -q "not our ref" output.err &&
-	! grep -q multi_ack_detailed output.err
+	grep "not our ref" output.err &&
+	grep "ERR" output &&
+	! grep multi_ack_detailed output.err
 '
 
 test_expect_success 'upload-pack fails due to error in pack-objects enumeration' '
-- 
2.21.0.931.gd0bc72a411

