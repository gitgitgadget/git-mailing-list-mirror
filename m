Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA3C352A4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC8820848
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgBMCZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:25:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:42136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729369AbgBMCZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:25:57 -0500
Received: (qmail 9907 invoked by uid 109); 13 Feb 2020 02:24:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:24:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8810 invoked by uid 111); 13 Feb 2020 02:34:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:34:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:25:56 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/13] pack-objects: support filters with bitmaps
Message-ID: <20200213022556.GM1126038@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just as rev-list recently learned to combine filters and bitmaps, let's
do the same for pack-objects. The infrastructure is all there; we just
need to pass along our filter options, and the pack-bitmap code will
decide to use bitmaps or not.

This unsurprisingly makes things faster for partial clones of large
repositories (here we're cloning linux.git):

  Test                              HEAD^               HEAD
  ------------------------------------------------------------------------------
  5310.9: simulated partial clone   38.94(37.28+5.87)   11.06(11.27+4.07) -71.6%

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c       |  3 +--
 t/perf/p5310-pack-bitmaps.sh |  4 ++++
 t/t5310-pack-bitmaps.sh      | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 60c943e42b..b09f85bd30 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3040,7 +3040,7 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git = prepare_bitmap_walk(revs, NULL)))
+	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
@@ -3418,7 +3418,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (filter_options.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
-		use_bitmap_index = 0;
 	}
 
 	/*
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index bbe1eb26a9..5ab2104ee8 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -49,6 +49,10 @@ test_perf 'rev-list count with blob:limit=1k' '
 		--filter=blob:limit=1k >/dev/null
 '
 
+test_perf 'simulated partial clone' '
+	git pack-objects --stdout --all --filter=blob:none </dev/null >/dev/null
+'
+
 test_expect_success 'create partial bitmap state' '
 	# pick a commit to represent the repo tip in the past
 	cutoff=$(git rev-list HEAD~100 -1) &&
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7ba7d294a5..ac9e6acf27 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -105,6 +105,20 @@ test_expect_success 'clone from bitmapped repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'partial clone from bitmapped repository' '
+	test_config uploadpack.allowfilter true &&
+	git clone --no-local --bare --filter=blob:none . partial-clone.git &&
+	(
+		cd partial-clone.git &&
+		pack=$(echo objects/pack/*.pack) &&
+		git verify-pack -v "$pack" >have &&
+		awk "/blob/ { print \$1 }" <have >blobs &&
+		# we expect this single blob because of the direct ref
+		git rev-parse refs/tags/tagged-blob >expect &&
+		test_cmp expect blobs
+	)
+'
+
 test_expect_success 'setup further non-bitmapped commits' '
 	test_commit_bulk --id=further 10
 '
-- 
2.25.0.785.g49bcbe7794
