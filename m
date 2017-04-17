Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395901FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbdDQVh4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 17:37:56 -0400
Received: from siwi.pair.com ([209.68.5.199]:58168 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754307AbdDQVht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 17:37:49 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A35F684694;
        Mon, 17 Apr 2017 17:37:48 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v11 5/5] read-cache: speed up has_dir_name (part 2)
Date:   Mon, 17 Apr 2017 21:37:34 +0000
Message-Id: <20170417213734.55373-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170417213734.55373-1-git@jeffhostetler.com>
References: <20170417213734.55373-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach has_dir_name() to see if the path of the new item
is greater than the last path in the index array before
attempting to search for it.

has_dir_name() is looking for file/directory collisions
in the index and has to consider each sub-directory
prefix in turn.  This can cause multiple binary searches
for each path.

During operations like checkout, merge_working_tree()
populates the new index in sorted order, so we expect
to be able to append in many cases.

This commit is part 2 of 2.  This commit handles the
additional possible short-cuts as we look at each
sub-directory prefix.

The net-net gains for add_index_entry_with_check() and
both had_dir_name() commits are best seen for very
large repos.

Here are results for a synthetic repo with 4.2M files.

$ GIT_PERF_REPO=~/work/gfw/t/perf/repos/gen-many-files-10.4.3.git/ ./run HEAD~3 HEAD ./p0006-read-tree-checkout.sh
Test                                                            HEAD~3               HEAD
0006.2: read-tree br_base br_ballast (4194305)                  29.96(19.26+10.50)   23.76(13.42+10.12) -20.7%
0006.3: switch between br_base br_ballast (4194305)             56.95(36.08+16.83)   45.54(25.94+15.68) -20.0%
0006.4: switch between br_ballast br_ballast_plus_1 (4194305)   90.94(51.50+31.52)   78.22(39.39+30.70) -14.0%
0006.5: switch between aliases (4194305)                        93.72(51.63+34.09)   77.94(39.00+30.88) -16.8%

Results for medium repos (like linux.git) are mixed and have
more variance (probably do to disk IO unrelated to this test.

$ GIT_PERF_REPO=/mnt/test/linux.git/ ./run HEAD~3 HEAD ./p0006-read-tree-checkout.sh
Test                                                          HEAD~3             HEAD
0006.2: read-tree br_base br_ballast (57994)                  0.25(0.21+0.03)    0.20(0.17+0.02) -20.0%
0006.3: switch between br_base br_ballast (57994)             10.67(6.06+2.92)   10.51(5.94+2.91) -1.5%
0006.4: switch between br_ballast br_ballast_plus_1 (57994)   0.59(0.47+0.16)    0.52(0.40+0.13) -11.9%
0006.5: switch between aliases (57994)                        0.59(0.44+0.17)    0.51(0.38+0.14) -13.6%

$ GIT_PERF_REPO=/mnt/test/linux.git/ ./run HEAD~3 HEAD ./p0006-read-tree-checkout.sh
Test                                                          HEAD~3             HEAD
0006.2: read-tree br_base br_ballast (57994)                  0.24(0.21+0.02)    0.21(0.18+0.02) -12.5%
0006.3: switch between br_base br_ballast (57994)             10.42(5.98+2.91)   10.66(5.86+3.09) +2.3%
0006.4: switch between br_ballast br_ballast_plus_1 (57994)   0.59(0.49+0.13)    0.53(0.37+0.16) -10.2%
0006.5: switch between aliases (57994)                        0.59(0.43+0.17)    0.50(0.37+0.14) -15.3%

Results for smaller repos (like git.git) are not significant.
$ ./run HEAD~3 HEAD ./p0006-read-tree-checkout.sh
Test                                                         HEAD~3            HEAD
0006.2: read-tree br_base br_ballast (3043)                  0.01(0.00+0.00)   0.01(0.00+0.00) +0.0%
0006.3: switch between br_base br_ballast (3043)             0.31(0.17+0.11)   0.29(0.19+0.08) -6.5%
0006.4: switch between br_ballast br_ballast_plus_1 (3043)   0.03(0.02+0.00)   0.03(0.02+0.00) +0.0%
0006.5: switch between aliases (3043)                        0.03(0.02+0.00)   0.03(0.02+0.00) +0.0%

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 9af0bd4..c252b6c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -965,7 +965,7 @@ static int has_dir_name(struct index_state *istate,
 	}
 
 	for (;;) {
-		int len;
+		size_t len;
 
 		for (;;) {
 			if (*--slash == '/')
@@ -975,6 +975,67 @@ static int has_dir_name(struct index_state *istate,
 		}
 		len = slash - name;
 
+		if (cmp_last > 0) {
+			/*
+			 * (len + 1) is a directory boundary (including
+			 * the trailing slash).  And since the loop is
+			 * decrementing "slash", the first iteration is
+			 * the longest directory prefix; subsequent
+			 * iterations consider parent directories.
+			 */
+
+			if (len + 1 <= len_eq_last) {
+				/*
+				 * The directory prefix (including the trailing
+				 * slash) also appears as a prefix in the last
+				 * entry, so the remainder cannot collide (because
+				 * strcmp said the whole path was greater).
+				 *
+				 * EQ: last: xxx/A
+				 *     this: xxx/B
+				 *
+				 * LT: last: xxx/file_A
+				 *     this: xxx/file_B
+				 */
+				return retval;
+			}
+
+			if (len > len_eq_last) {
+				/*
+				 * This part of the directory prefix (excluding
+				 * the trailing slash) is longer than the known
+				 * equal portions, so this sub-directory cannot
+				 * collide with a file.
+				 *
+				 * GT: last: xxxA
+				 *     this: xxxB/file
+				 */
+				return retval;
+			}
+
+			if (istate->cache_nr > 0 &&
+				ce_namelen(istate->cache[istate->cache_nr - 1]) > len) {
+				/*
+				 * The directory prefix lines up with part of
+				 * a longer file or directory name, but sorts
+				 * after it, so this sub-directory cannot
+				 * collide with a file.
+				 *
+				 * last: xxx/yy-file (because '-' sorts before '/')
+				 * this: xxx/yy/abc
+				 */
+				return retval;
+			}
+
+			/*
+			 * This is a possible collision. Fall through and
+			 * let the regular search code handle it.
+			 *
+			 * last: xxx
+			 * this: xxx/file
+			 */
+		}
+
 		pos = index_name_stage_pos(istate, name, len, stage);
 		if (pos >= 0) {
 			/*
-- 
2.9.3

