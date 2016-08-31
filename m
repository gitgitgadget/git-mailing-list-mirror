Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5021FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 05:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755809AbcHaFDP (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 01:03:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:35725 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751202AbcHaFDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 01:03:14 -0400
Received: (qmail 4920 invoked by uid 109); 31 Aug 2016 05:03:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 05:03:14 +0000
Received: (qmail 2999 invoked by uid 111); 31 Aug 2016 05:03:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 01:03:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2016 01:03:10 -0400
Date:   Wed, 31 Aug 2016 01:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, gitster@pobox.com
Subject: [PATCH 2/3] diff-highlight: add multi-byte tests
Message-ID: <20160831050309.3k43nn737ztcajiz@sigill.intra.peff.net>
References: <20160831050229.cabhfzqcpcpvkugl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160831050229.cabhfzqcpcpvkugl@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have a test suite for diff highlight, we can
show off the improvements from 8d00662 (diff-highlight: do
not split multibyte characters, 2015-04-03).

While we're at it, we can also add another case that
_doesn't_ work: combining code points are treated as their
own unit, which means that we may stick colors between them
and the character they are modifying (with the result that
the color is not shown in an xterm, though it's possible
that other terminals err the other way, and show the color
but not the accent).  There's no fix here, but let's
document it as a failure.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 36 +++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index e42232d..7d034aa 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -207,7 +207,41 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
 	EOF
 '
 
-# TODO add multi-byte test
+# These two code points share the same leading byte in UTF-8 representation;
+# a naive byte-wise diff would highlight only the second byte.
+#
+#   - U+00f3 ("o" with acute)
+o_accent=$(printf '\303\263')
+#   - U+00f8 ("o" with stroke)
+o_stroke=$(printf '\303\270')
+
+test_expect_success 'diff-highlight treats multibyte utf-8 as a unit' '
+	echo "unic${o_accent}de" >a &&
+	echo "unic${o_stroke}de" >b &&
+	dh_test a b <<-EOF
+		@@ -1 +1 @@
+		-unic${CW}${o_accent}${CR}de
+		+unic${CW}${o_stroke}${CR}de
+	EOF
+'
+
+# Unlike the UTF-8 above, these are combining code points which are meant
+# to modify the character preceding them:
+#
+#   - U+0301 (combining acute accent)
+combine_accent=$(printf '\314\201')
+#   - U+0302 (combining circumflex)
+combine_circum=$(printf '\314\202')
+
+test_expect_failure 'diff-highlight treats combining code points as a unit' '
+	echo "unico${combine_accent}de" >a &&
+	echo "unico${combine_circum}de" >b &&
+	dh_test a b <<-EOF
+		@@ -1 +1 @@
+		-unic${CW}o${combine_accent}${CR}de
+		+unic${CW}o${combine_circum}${CR}de
+	EOF
+'
 
 test_expect_success 'diff-highlight works with the --graph option' '
 	dh_test_setup_history &&
-- 
2.10.0.rc2.125.gcfb3d08

