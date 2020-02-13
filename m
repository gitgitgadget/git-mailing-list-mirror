Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD515C352A4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AAB206DB
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgBMCRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:17:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:42068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729333AbgBMCRb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:17:31 -0500
Received: (qmail 9809 invoked by uid 109); 13 Feb 2020 02:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8592 invoked by uid 111); 13 Feb 2020 02:26:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:26:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:17:30 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/13] rev-list: fallback to non-bitmap traversal when
 filtering
Message-ID: <20200213021730.GC1126038@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--use-bitmap-index" option is usually aspirational: if we have
bitmaps and the request can be fulfilled more quickly using them we'll
do so, but otherwise fall back to a non-bitmap traversal.

The exception is object filtering, which explicitly dies if the two
options are combined. Let's convert this to the usual fallback behavior.
This is a minor convenience for now (since the caller can easily know
that --filter and --use-bitmap-index don't combine), but will become
much more useful as we start to support _some_ filters with bitmaps, but
not others.

The test infrastructure here is bigger than necessary for checking this
one small feature. But it will serve as the basis for more filtering
bitmap tests in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c                 |  4 ++--
 t/t6113-rev-list-bitmap-filters.sh | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100755 t/t6113-rev-list-bitmap-filters.sh

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index e28d62ec64..bce406bd1e 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -521,8 +521,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.show_notes)
 		die(_("rev-list does not support display of notes"));
 
-	if (filter_options.choice && use_bitmap_index)
-		die(_("cannot combine --use-bitmap-index with object filtering"));
+	if (filter_options.choice)
+		use_bitmap_index = 0;
 
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
new file mode 100755
index 0000000000..977f8d0930
--- /dev/null
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='rev-list combining bitmaps and filters'
+. ./test-lib.sh
+
+test_expect_success 'set up bitmapped repo' '
+	# one commit will have bitmaps, the other will not
+	test_commit one &&
+	git repack -adb &&
+	test_commit two
+'
+
+test_expect_success 'filters fallback to non-bitmap traversal' '
+	# use a path-based filter, since they are inherently incompatible with
+	# bitmaps (i.e., this test will never get confused by later code to
+	# combine the features)
+	filter=$(echo "!one" | git hash-object -w --stdin) &&
+	git rev-list --objects --filter=sparse:oid=$filter HEAD >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=sparse:oid=$filter HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.25.0.785.g49bcbe7794

