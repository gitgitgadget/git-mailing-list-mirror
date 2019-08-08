Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98131F731
	for <e@80x24.org>; Thu,  8 Aug 2019 09:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfHHJhe (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 05:37:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:37542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732286AbfHHJhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 05:37:34 -0400
Received: (qmail 11096 invoked by uid 109); 8 Aug 2019 09:37:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Aug 2019 09:37:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18727 invoked by uid 111); 8 Aug 2019 09:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Aug 2019 05:40:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Aug 2019 05:37:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH bc/hash-independent-tests-part-4] t: decrease nesting in
 test_oid_to_path
Message-ID: <20190808093732.GA12257@sigill.intra.peff.net>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
 <20190628225928.622372-2-sandals@crustytoothpaste.net>
 <20190808065614.GA209195@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808065614.GA209195@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 07, 2019 at 11:56:14PM -0700, Jonathan Nieder wrote:

> But a dash bug[*] causes it to instead expand to
> 
> 	/3456789...
> 
> The stream of symbols that makes up this function is hard for humans
> to follow, too.  The complexity mostly comes from the repeated use of
> the expression ${1#??} for the basename of the loose object.

Yeah, both seem like good reasons to change this (and the patch looks
good to me).

> Use a variable instead --- nowadays, the dialect of shell used by Git
> permits local variables, so this is cheap.

I don't recall whether we ever made a conscious decision about that.
Commit 01d3a526ad (t0000: check whether the shell supports the "local"
keyword, 2017-10-26) put in a test balloon about 2 years ago. Since then
several other uses have crept in to test-lib-function.sh.

But I think we can probably call the experiment a success at this point.
Maybe we'd want to do this, as well:

-- >8 --
Subject: [PATCH] t0000: reword comments for "local" test

Commit 01d3a526ad (t0000: check whether the shell supports the "local"
keyword, 2017-10-26) added a test to gather data on whether people run
the test suite with shells that don't support "local".

After almost two years, nobody has complained, and several other uses
have cropped up in test-lib-functions.sh. Let's declare it acceptable to
use.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index e89438e619..9ca0818cbe 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -25,16 +25,14 @@ try_local_x () {
 	echo "$x"
 }
 
-# This test is an experiment to check whether any Git users are using
-# Shells that don't support the "local" keyword. "local" is not
+# Check whether the shell supports the "local" keyword. "local" is not
 # POSIX-standard, but it is very widely supported by POSIX-compliant
-# shells, and if it doesn't cause problems for people, we would like
-# to be able to use it in Git code.
+# shells, and we rely on it within Git's test framework.
 #
-# For now, this is the only test that requires "local". If your shell
-# fails this test, you can ignore the failure, but please report the
-# problem to the Git mailing list <git@vger.kernel.org>, as it might
-# convince us to continue avoiding the use of "local".
+# If your shell fails this test, the results of other tests may be
+# unreliable. You may wish to report the problem to the Git mailing
+# list <git@vger.kernel.org>, as it could cause us to reconsider
+# relying on "local".
 test_expect_success 'verify that the running shell supports "local"' '
 	x="notlocal" &&
 	echo "local" >expected1 &&
-- 
2.23.0.rc1.440.g8f3b7ca639

