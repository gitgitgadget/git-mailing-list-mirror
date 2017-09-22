Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB2A202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbdIVUbi (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:31:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:11519 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbdIVUbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:31:37 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 06AE28470C;
        Fri, 22 Sep 2017 16:31:36 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 804A28470A;
        Fri, 22 Sep 2017 16:31:35 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 11/13] t6112: rev-list object filtering test
Date:   Fri, 22 Sep 2017 20:30:15 +0000
Message-Id: <20170922203017.53986-12-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922203017.53986-6-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t6112-rev-list-filters-objects.sh | 237 ++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100755 t/t6112-rev-list-filters-objects.sh

diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
new file mode 100755
index 0000000..66ff022
--- /dev/null
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -0,0 +1,237 @@
+#!/bin/sh
+
+test_description='git rev-list with object filtering'
+
+. ./test-lib.sh
+
+# test the omit-all filter
+
+test_expect_success 'setup' '
+	echo "{print \$1}" >print_1.awk &&
+	echo "{print \$2}" >print_2.awk &&
+
+	for n in 1 2 3 4 5
+	do
+		echo $n > file.$n
+		git add file.$n
+		git commit -m "$n"
+	done
+'
+
+# Verify the omitted ("~OID") lines match the predicted list of OIDs.
+test_expect_success 'omit-all-blobs omitted 5 blobs' '
+	git ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git rev-list HEAD --quiet --objects --filter-print-omitted --filter-omit-all-blobs \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+# Verify the complete OID list matches the unfiltered OIDs plus the omitted OIDs.
+test_expect_success 'omit-all-blobs nothing else changed' '
+	git rev-list HEAD --objects \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git rev-list HEAD --objects --filter-print-omitted --filter-omit-all-blobs \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+# test the size-based filtering.
+
+test_expect_success 'setup_large' '
+	for n in 1000 10000
+	do
+		printf "%"$n"s" X > large.$n
+		git add large.$n
+		git commit -m "$n"
+	done
+'
+
+test_expect_success 'omit-large-blobs omit 2 blobs' '
+	git ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git rev-list HEAD --quiet --objects --filter-print-omitted --filter-omit-large-blobs=500 \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'omit-large-blobs nothing else changed' '
+	git rev-list HEAD --objects \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git rev-list HEAD --objects --filter-print-omitted --filter-omit-large-blobs=500 \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+# boundary test around the size parameter.
+# filter is strictly less than the value, so size 500 and 1000 should have the
+# same results, but 1001 should filter more.
+
+test_expect_success 'omit-large-blobs omit 2 blobs' '
+	git ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git rev-list HEAD --quiet --objects --filter-print-omitted --filter-omit-large-blobs=1000 \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'omit-large-blobs omit 1 blob' '
+	git ls-files -s large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git rev-list HEAD --quiet --objects --filter-print-omitted --filter-omit-large-blobs=1001 \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'omit-large-blobs omit 1 blob (1k)' '
+	git ls-files -s large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git rev-list HEAD --quiet --objects --filter-print-omitted --filter-omit-large-blobs=1k \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'omit-large-blobs omit no blob (1m)' '
+	cat </dev/null >expected &&
+	git rev-list HEAD --quiet --objects --filter-print-omitted --filter-omit-large-blobs=1m \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+# Test sparse-pattern filtering (using explicit local patterns).
+# We use the same disk format as sparse-checkout to specify the
+# filtering, but do not require sparse-checkout to be enabled.
+
+test_expect_success 'setup using sparse file' '
+	mkdir dir1 &&
+	for n in sparse1 sparse2
+	do
+		echo $n > $n
+		git add $n
+		echo dir1/$n > dir1/$n
+		git add dir1/$n
+	done &&
+	git commit -m "sparse" &&
+	echo dir1/ >pattern1 &&
+	echo sparse1 >pattern2
+'
+
+# pattern1 should only include the 2 dir1/* files.
+# and omit the 5 file.*, 2 large.*, and 2 top-level sparse* files.
+test_expect_success 'sparse using path pattern1' '
+	git rev-list HEAD --objects --filter-print-omitted --filter-use-path=pattern1 >out &&
+
+	grep "^~" out >blobs.omitted &&
+	test $(cat blobs.omitted | wc -l) = 9 &&
+
+	grep "dir1/sparse" out >blobs.included &&
+	test $(cat blobs.included | wc -l) = 2
+'
+
+# pattern2 should include the sparse1 and dir1/sparse1.
+# and omit the 5 file.*, 2 large.*, and the 2 sparse2 files.
+test_expect_success 'sparse using path pattern2' '
+	git rev-list HEAD --objects --filter-print-omitted --filter-use-path=pattern2 >out &&
+
+	grep "^~" out >blobs.omitted &&
+	test $(cat blobs.omitted | wc -l) = 9 &&
+
+	grep "sparse1" out >blobs.included &&
+	test $(cat blobs.included | wc -l) = 2
+'
+
+# Test sparse-pattern filtering (using a blob in the repo).
+# This could be used to later let pack-objects do filtering.
+
+# pattern1 should only include the 2 dir1/* files.
+# and omit the 5 file.*, 2 large.*, 2 top-level sparse*, and 1 pattern file.
+test_expect_success 'sparse using OID for pattern1' '
+	git add pattern1 &&
+	git commit -m "pattern1" &&
+
+	git rev-list HEAD --objects >normal.output &&
+	grep "pattern1" <normal.output | awk "{print \$1;}" >pattern1.oid &&
+
+	git rev-list HEAD --objects --filter-print-omitted --filter-use-blob=`cat pattern1.oid` >out &&
+
+	grep "^~" out >blobs.omitted &&
+	test $(cat blobs.omitted | wc -l) = 10 &&
+
+	grep "dir1/sparse" out >blobs.included &&
+	test $(cat blobs.included | wc -l) = 2
+'
+
+# repeat previous test but use blob-ish expression rather than OID.
+test_expect_success 'sparse using blob-ish to get OID for pattern spec' '
+	git rev-list HEAD --objects --filter-print-omitted --filter-use-blob=HEAD:pattern1 >out &&
+
+	grep "^~" out >blobs.omitted &&
+	test $(cat blobs.omitted | wc -l) = 10 &&
+
+	grep "dir1/sparse" out >blobs.included &&
+	test $(cat blobs.included | wc -l) = 2
+'
+
+# pattern2 should include the sparse1 and dir1/sparse1.
+# and omit the 5 file.*, 2 large.*, 2 top-level sparse*, and 2 pattern files.
+test_expect_success 'sparse using OID for pattern2' '
+	git add pattern2 &&
+	git commit -m "pattern2" &&
+
+	git rev-list HEAD --objects >normal.output &&
+	grep "pattern2" <normal.output | awk "{print \$1;}" >pattern2.oid &&
+
+	git rev-list HEAD --objects --filter-print-omitted --filter-use-blob=`cat pattern2.oid` >out &&
+
+	grep "^~" out >blobs.omitted &&
+	test $(cat blobs.omitted | wc -l) = 11 &&
+
+	grep "sparse1" out >blobs.included &&
+	test $(cat blobs.included | wc -l) = 2
+'
+
+# repeat previous test but use blob-ish expression rather than OID.
+test_expect_success 'sparse using blob-ish rather than OID for pattern2' '
+	git rev-list HEAD --objects --filter-print-omitted --filter-use-blob=HEAD:pattern2 >out &&
+
+	grep "^~" out >blobs.omitted &&
+	test $(cat blobs.omitted | wc -l) = 11 &&
+
+	grep "sparse1" out >blobs.included &&
+	test $(cat blobs.included | wc -l) = 2
+'
+
+# delete some loose objects and test rev-list printing them as missing.
+test_expect_success 'print missing objects' '
+	git ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	for id in `cat expected | sed "s|..|&/|"`
+	do
+		rm .git/objects/$id
+	done &&
+	git rev-list --quiet HEAD --filter-print-missing --objects \
+		| awk -f print_1.awk \
+		| sed "s/?//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_done
-- 
2.9.3

