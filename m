Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D711FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdJXSyJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:42908 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbdJXSyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:54:06 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9269D845A4;
        Tue, 24 Oct 2017 14:54:05 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F129084597;
        Tue, 24 Oct 2017 14:54:04 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 11/13] t6112: rev-list object filtering test
Date:   Tue, 24 Oct 2017 18:53:30 +0000
Message-Id: <20171024185332.57261-12-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t6112-rev-list-filters-objects.sh | 223 ++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)
 create mode 100755 t/t6112-rev-list-filters-objects.sh

diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
new file mode 100755
index 0000000..26fa12f
--- /dev/null
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -0,0 +1,223 @@
+#!/bin/sh
+
+test_description='git rev-list with object filtering for partial clone'
+
+. ./test-lib.sh
+
+# Test the blob:none filter.
+
+test_expect_success 'setup r1' '
+	echo "{print \$1}" >print_1.awk &&
+	echo "{print \$2}" >print_2.awk &&
+
+	git init r1 &&
+	for n in 1 2 3 4 5
+	do
+		echo "This is file: $n" > r1/file.$n
+		git -C r1 add file.$n
+		git -C r1 commit -m "$n"
+	done
+'
+
+test_expect_success 'verify blob:none omits all 5 blobs' '
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify emitted+omitted == all' '
+	git -C r1 rev-list HEAD --objects \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git -C r1 rev-list HEAD --objects --filter-print-omitted --filter=blob:none \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+
+# Test blob:limit=<n>[kmg] filter.
+# We boundary test around the size parameter.  The filter is strictly less than
+# the value, so size 500 and 1000 should have the same results, but 1001 should
+# filter more.
+
+test_expect_success 'setup r2' '
+	git init r2 &&
+	for n in 1000 10000
+	do
+		printf "%"$n"s" X > r2/large.$n
+		git -C r2 add large.$n
+		git -C r2 commit -m "$n"
+	done
+'
+
+test_expect_success 'verify blob:limit=500 omits all blobs' '
+	git -C r2 ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=500 \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify emitted+omitted == all' '
+	git -C r2 rev-list HEAD --objects \
+		| awk -f print_1.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --objects --filter-print-omitted --filter=blob:limit=500 \
+		| awk -f print_1.awk \
+		| sed "s/~//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1000' '
+	git -C r2 ls-files -s large.1000 large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1000 \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1001' '
+	git -C r2 ls-files -s large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1001 \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1k' '
+	git -C r2 ls-files -s large.10000 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1k \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify blob:limit=1m' '
+	cat </dev/null >expected &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1m \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+# Test sparse:path=<path> filter.
+# Use a local file containing a sparse-checkout specification to filter
+# out blobs not required for the corresponding sparse-checkout.  We do not
+# require sparse-checkout to actually be enabled.
+
+test_expect_success 'setup r3' '
+	git init r3 &&
+	mkdir r3/dir1 &&
+	for n in sparse1 sparse2
+	do
+		echo "This is file: $n" > r3/$n
+		git -C r3 add $n
+		echo "This is file: dir1/$n" > r3/dir1/$n
+		git -C r3 add dir1/$n
+	done &&
+	git -C r3 commit -m "sparse" &&
+	echo dir1/ >pattern1 &&
+	echo sparse1 >pattern2
+'
+
+test_expect_success 'verify sparse:path=pattern1 omits top-level files' '
+	git -C r3 ls-files -s sparse1 sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern1 \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify sparse:path=pattern2 omits both sparse2 files' '
+	git -C r3 ls-files -s sparse2 dir1/sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern2 \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+# Test sparse:oid=<oid-ish> filter.
+# Like sparse:path, but we get the sparse-checkout specification from
+# a blob rather than a file on disk.
+
+test_expect_success 'setup r3 part 2' '
+	echo dir1/ >r3/pattern &&
+	git -C r3 add pattern &&
+	git -C r3 commit -m "pattern"
+'
+
+test_expect_success 'verify sparse:oid=OID omits top-level files' '
+	git -C r3 ls-files -s pattern sparse1 sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	oid=$(git -C r3 ls-files -s pattern | awk -f print_2.awk) &&
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=$oid \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
+	git -C r3 ls-files -s pattern sparse1 sparse2 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=master:pattern \
+		| awk -f print_1.awk \
+		| sed "s/~//" >observed &&
+	test_cmp observed expected
+'
+
+# Delete some loose objects and use rev-list, but WITHOUT any filtering.
+# This models previously omitted objects that we did not receive.
+
+test_expect_success 'rev-list W/ print-missing' '
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk -f print_2.awk \
+		| sort >expected &&
+	for id in `cat expected | sed "s|..|&/|"`
+	do
+		rm r1/.git/objects/$id
+	done &&
+	git -C r1 rev-list --quiet HEAD --filter-print-missing --objects \
+		| awk -f print_1.awk \
+		| sed "s/?//" \
+		| sort >observed &&
+	test_cmp observed expected
+'
+
+test_expect_success 'rev-list W/O print-missing fails' '
+	test_must_fail git -C r1 rev-list --quiet --objects HEAD
+'
+
+test_expect_success 'rev-list W/ extension.partialcloneremote set succeeds' '
+	git -C r1 config --local core.repositoryformatversion 1 &&
+	git -C r1 config --local extensions.partialcloneremote "origin" &&
+	git -C r1 rev-list --quiet --objects HEAD
+'
+
+test_expect_success 'rev-list W/ extension.partialclonefilter set succeeds' '
+	git -C r1 config --local core.repositoryformatversion 1 &&
+	git -C r1 config --local extensions.partialclonefilter "something" &&
+	git -C r1 rev-list --quiet --objects HEAD
+'
+
+test_done
-- 
2.9.3

