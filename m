Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3050C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B580222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbgBNSW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:43714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2394912AbgBNSW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:26 -0500
Received: (qmail 22976 invoked by uid 109); 14 Feb 2020 18:22:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23669 invoked by uid 111); 14 Feb 2020 18:31:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:25 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/15] t5310: factor out bitmap traversal comparison
Message-ID: <20200214182225.GH150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check the results of "rev-list --use-bitmap-index" by comparing it to
the same traversal without the bitmap option. However, this is a little
tricky to do because of some output differences (see the included
comment for details). Let's pull this out into a helper function, since
we'll be adding some similar tests.

While we're at it, let's also try to confirm that the bitmap output did
indeed use bitmaps. Since the code internally falls back to the
non-bitmap path in some cases, the tests are at risk of becoming trivial
noops.

This is a bit fragile, as not all outputs will differ (e.g., looking at
only the commits from a fully-bitmapped pack will end up exactly the
same as the normal traversal order, since it also matches the pack
order). So we'll provide an escape hatch by which tests can disable this
check (which should only be used after manually confirming that bitmaps
kicked in).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5310-pack-bitmaps.sh | 10 +++-------
 t/test-lib-functions.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7ba7d294a5..b8645ae070 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -81,13 +81,9 @@ rev_list_tests() {
 	'
 
 	test_expect_success "enumerate --objects ($state)" '
-		git rev-list --objects --use-bitmap-index HEAD >tmp &&
-		cut -d" " -f1 <tmp >tmp2 &&
-		sort <tmp2 >actual &&
-		git rev-list --objects HEAD >tmp &&
-		cut -d" " -f1 <tmp >tmp2 &&
-		sort <tmp2 >expect &&
-		test_cmp expect actual
+		git rev-list --objects --use-bitmap-index HEAD >actual &&
+		git rev-list --objects HEAD >expect &&
+		test_bitmap_traversal expect actual
 	'
 
 	test_expect_success "bitmap --objects handles non-commit objects ($state)" '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 284c52d076..352c213d52 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1516,3 +1516,30 @@ test_set_port () {
 	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
 	eval $var=$port
 }
+
+# Compare a file containing rev-list bitmap traversal output to its non-bitmap
+# counterpart. You can't just use test_cmp for this, because the two produce
+# subtly different output:
+#
+#   - regular output is in traversal order, whereas bitmap is split by type,
+#     with non-packed objects at the end
+#
+#   - regular output has a space and the pathname appended to non-commit
+#     objects; bitmap output omits this
+#
+# This function normalizes and compares the two. The second file should
+# always be the bitmap output.
+test_bitmap_traversal () {
+	if test "$1" = "--no-confirm-bitmaps"
+	then
+		shift
+	elif cmp "$1" "$2"
+	then
+		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
+		return 1
+	fi &&
+	cut -d' ' -f1 "$1" | sort >"$1.normalized" &&
+	sort "$2" >"$2.normalized" &&
+	test_cmp "$1.normalized" "$2.normalized" &&
+	rm -f "$1.normalized" "$2.normalized"
+}
-- 
2.25.0.796.gcc29325708

