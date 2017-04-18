Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28ACD201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 19:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757558AbdDRToj (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 15:44:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:10103 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755504AbdDRTog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 15:44:36 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5060284598;
        Tue, 18 Apr 2017 15:44:30 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1] diffcore-rename: speed up register_rename_src
Date:   Tue, 18 Apr 2017 19:44:21 +0000
Message-Id: <20170418194421.22453-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170418194421.22453-1-git@jeffhostetler.com>
References: <20170418194421.22453-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach register_rename_src() to see if new file pair
can simply be appended to the rename_src[] array before
performing the binary search to find the proper insertion
point.

This is a performance optimization.  This routine is called
during run_diff_files in status and the caller is iterating
over the sorted index, so we should expect to be able to
append in the normal case.  The existing insert logic is
preserved so we don't have to assume that, but simply take
advantage of it if possible.

Using t/perf/p0005-status.h (from a parallel patch series),
we get the following improvement on a 4.2M file repo:

Test                                            HEAD~1               HEAD
0005.2: read-tree status br_ballast (4194305)   59.14(31.85+18.79)   55.48(28.52+20.71) -6.2%

On a 1M file repo:
Test                                            HEAD~1            HEAD
0005.2: read-tree status br_ballast (1000001)   8.20(4.82+3.35)   7.91(4.57+3.27) -3.5%

On a smaller repo, like linux.git (58K files), results are masked
by normal I/O variance.

Test                                          HEAD~1            HEAD
0005.2: read-tree status br_ballast (57994)   0.43(0.30+0.13)   0.42(0.31+0.12) -2.3%
0005.2: read-tree status br_ballast (57994)   0.42(0.32+0.09)   0.43(0.34+0.10) +2.4%
0005.2: read-tree status br_ballast (57994)   0.44(0.33+0.10)   0.42(0.26+0.16) -4.5%

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 diffcore-rename.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c8..543a409 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -81,6 +81,18 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 
 	first = 0;
 	last = rename_src_nr;
+
+	if (last > 0) {
+		struct diff_rename_src *src = &(rename_src[last-1]);
+		int cmp = strcmp(one->path, src->p->one->path);
+		if (!cmp)
+			return src;
+		if (cmp > 0) {
+			first = last;
+			goto append_it;
+		}
+	}
+
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct diff_rename_src *src = &(rename_src[next]);
@@ -94,6 +106,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 		first = next+1;
 	}
 
+append_it:
 	/* insert to make it at "first" */
 	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
 	rename_src_nr++;
-- 
2.9.3

