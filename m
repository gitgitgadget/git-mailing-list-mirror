Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B6D1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 19:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfGWT1G (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 15:27:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:49548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725372AbfGWT1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 15:27:06 -0400
Received: (qmail 9830 invoked by uid 109); 23 Jul 2019 19:27:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jul 2019 19:27:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12371 invoked by uid 111); 23 Jul 2019 19:28:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jul 2019 15:28:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jul 2019 15:27:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?5YiY54Kc?= <lw17qhdz@gmail.com>
Subject: [PATCH] xdiff: clamp function context indices in post-image
Message-ID: <20190723192704.GA4065@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After finding a function line for --function-context in the pre-image,
xdl_emit_diff() calculates the equivalent line in the post-image.  It
assumes that the lines between changes are the same on both sides.  If
the option --ignore-blank-lines was also given then this is not
necessarily true.

Clamp the calculation results for start and end of the function context
to prevent out-of-bounds array accesses.

Note that this _just_ fixes the case where our mismatch sends us off the
beginning of the file. There are likely other cases where our assumption
causes us to go to the wrong line within the file. Nobody has developed
a test case yet, and the ultimate fix is likely more complicated than
this patch. But this at least prevents a segfault in the meantime.

Credit for finding the bug goes to "Liu Wei of Tencent Security Xuanwu
Lab".

Reported-by: 刘炜 <lw17qhdz@gmail.com>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4015-diff-whitespace.sh | 22 ++++++++++++++++++++++
 xdiff/xemit.c              |  4 ++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index ab4670d236..6b087df3dc 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2008,4 +2008,26 @@ test_expect_success 'compare mixed whitespace delta across moved blocks' '
 	test_cmp expected actual
 '
 
+# Note that the "6" in the expected hunk header below is funny, since we only
+# show 5 lines (the missing one was blank and thus ignored). This is how
+# --ignore-blank-lines behaves even without --function-context, and this test
+# is just checking the interaction of the two features. Don't take it as an
+# endorsement of that output.
+test_expect_success 'combine --ignore-blank-lines with --function-context' '
+	test_write_lines 1 "" 2 3 4 5 >a &&
+	test_write_lines 1    2 3 4   >b &&
+	test_must_fail git diff --no-index \
+		--ignore-blank-lines --function-context a b >actual.raw &&
+	sed -n "/@@/,\$p" <actual.raw >actual &&
+	cat <<-\EOF >expect &&
+	@@ -1,6 +1,4 @@
+	 1
+	 2
+	 3
+	 4
+	-5
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 7778dc2b19..30713ae9a9 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -210,7 +210,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			if (fs1 < 0)
 				fs1 = 0;
 			if (fs1 < s1) {
-				s2 -= s1 - fs1;
+				s2 = XDL_MAX(s2 - (s1 - fs1), 0);
 				s1 = fs1;
 			}
 		}
@@ -232,7 +232,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			if (fe1 < 0)
 				fe1 = xe->xdf1.nrec;
 			if (fe1 > e1) {
-				e2 += fe1 - e1;
+				e2 = XDL_MIN(e2 + (fe1 - e1), xe->xdf2.nrec);
 				e1 = fe1;
 			}
 
-- 
2.22.0.993.gcc1030c86b
