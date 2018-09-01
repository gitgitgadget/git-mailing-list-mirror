Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707C71F404
	for <e@80x24.org>; Sat,  1 Sep 2018 07:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIAL7T (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 07:59:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:36118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725964AbeIAL7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 07:59:18 -0400
Received: (qmail 24353 invoked by uid 109); 1 Sep 2018 07:48:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Sep 2018 07:48:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11580 invoked by uid 111); 1 Sep 2018 07:48:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Sep 2018 03:48:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2018 03:48:13 -0400
Date:   Sat, 1 Sep 2018 03:48:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] t5310: test delta reuse with bitmaps
Message-ID: <20180901074813.GB25461@sigill.intra.peff.net>
References: <20180901074145.GA24023@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180901074145.GA24023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 6a1e32d532 (pack-objects: reuse on-disk deltas for
thin "have" objects, 2018-08-21) taught pack-objects a new
optimization trick. Since this wasn't meant to change
user-visible behavior, but only produce smaller packs more
quickly, testing focused on t/perf/p5311.

However, since people don't run perf tests very often, we
should make sure that the feature is exercised in the
regular test suite. This patch does so.

Signed-off-by: Jeff King <peff@peff.net>
---
Side note: If we do squash patch 1 into the eariler series, that will
invalidate the commit id mentioned in the commit message here.

 t/t5310-pack-bitmaps.sh | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 557bd0d0c0..af38776054 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -342,4 +342,97 @@ test_expect_success 'truncated bitmap fails gracefully' '
 	test_i18ngrep corrupt stderr
 '
 
+# have_delta <obj> <expected_base>
+#
+# Note that because this relies on cat-file, it might find _any_ copy of an
+# object in the repository. The caller is responsible for making sure
+# there's only one (e.g., via "repack -ad", or having just fetched a copy).
+have_delta () {
+	echo $2 >expect &&
+	echo $1 | git cat-file --batch-check="%(deltabase)" >actual &&
+	test_cmp expect actual
+}
+
+# Create a state of history with these properties:
+#
+#  - refs that allow a client to fetch some new history, while sharing some old
+#    history with the server; we use branches delta-reuse-old and
+#    delta-reuse-new here
+#
+#  - the new history contains an object that is stored on the server as a delta
+#    against a base that is in the old history
+#
+#  - the base object is not immediately reachable from the tip of the old
+#    history; finding it would involve digging down through history we know the
+#    other side has
+#
+# This should result in a state where fetching from old->new would not
+# traditionally reuse the on-disk delta (because we'd have to dig to realize
+# that the client has it), but we will do so if bitmaps can tell us cheaply
+# that the other side has it.
+test_expect_success 'set up thin delta-reuse parent' '
+	# This first commit contains the buried base object.
+	test-tool genrandom delta 16384 >file &&
+	git add file &&
+	git commit -m "delta base" &&
+	base=$(git rev-parse --verify HEAD:file) &&
+
+	# These intermediate commits bury the base back in history.
+	# This becomes the "old" state.
+	for i in 1 2 3 4 5
+	do
+		echo $i >file &&
+		git commit -am "intermediate $i" || return 1
+	done &&
+	git branch delta-reuse-old &&
+
+	# And now our new history has a delta against the buried base. Note
+	# that this must be smaller than the original file, since pack-objects
+	# prefers to create deltas from smaller objects to larger.
+	test-tool genrandom delta 16300 >file &&
+	git commit -am "delta result" &&
+	delta=$(git rev-parse --verify HEAD:file) &&
+	git branch delta-reuse-new &&
+
+	# Repack with bitmaps and double check that we have the expected delta
+	# relationship.
+	git repack -adb &&
+	have_delta $delta $base
+'
+
+# Now we can sanity-check the non-bitmap behavior (that the server is not able
+# to reuse the delta). This isn't strictly something we care about, so this
+# test could be scrapped in the future. But it makes sure that the next test is
+# actually triggering the feature we want.
+#
+# Note that our tools for working with on-the-wire "thin" packs are limited. So
+# we actually perform the fetch, retain the resulting pack, and inspect the
+# result.
+test_expect_success 'fetch without bitmaps ignores delta against old base' '
+	test_config pack.usebitmaps false &&
+	test_when_finished "rm -rf client.git" &&
+	git init --bare client.git &&
+	(
+		cd client.git &&
+		git config transfer.unpackLimit 1 &&
+		git fetch .. delta-reuse-old:delta-reuse-old &&
+		git fetch .. delta-reuse-new:delta-reuse-new &&
+		have_delta $delta $ZERO_OID
+	)
+'
+
+# And do the same for the bitmap case, where we do expect to find the delta.
+test_expect_success 'fetch with bitmaps can reuse old base' '
+	test_config pack.usebitmaps true &&
+	test_when_finished "rm -rf client.git" &&
+	git init --bare client.git &&
+	(
+		cd client.git &&
+		git config transfer.unpackLimit 1 &&
+		git fetch .. delta-reuse-old:delta-reuse-old &&
+		git fetch .. delta-reuse-new:delta-reuse-new &&
+		have_delta $delta $base
+	)
+'
+
 test_done
-- 
2.19.0.rc1.549.g6ce4dc0f08

