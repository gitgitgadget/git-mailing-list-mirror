Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F21C1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 16:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbdDFQe4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 12:34:56 -0400
Received: from siwi.pair.com ([209.68.5.199]:19706 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753698AbdDFQew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 12:34:52 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 689118460D;
        Thu,  6 Apr 2017 12:34:51 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 2/3] p0004-read-tree: perf test to time read-tree
Date:   Thu,  6 Apr 2017 16:34:41 +0000
Message-Id: <20170406163442.36463-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170406163442.36463-1-git@jeffhostetler.com>
References: <20170406163442.36463-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p0004-read-tree.sh | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100755 t/perf/p0004-read-tree.sh

diff --git a/t/perf/p0004-read-tree.sh b/t/perf/p0004-read-tree.sh
new file mode 100755
index 0000000..d56020d
--- /dev/null
+++ b/t/perf/p0004-read-tree.sh
@@ -0,0 +1,117 @@
+#!/bin/sh
+
+test_description="Tests performance of read-tree"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+## usage: dir depth width files
+make_paths () {
+	for f in $(seq $4)
+	do
+		echo $1/file$f
+	done;
+	if test $2 -gt 0;
+	then
+		for w in $(seq $3)
+		do
+			make_paths $1/dir$w $(($2 - 1)) $3 $4
+		done
+	fi
+	return 0
+}
+
+fill_index () {
+	make_paths $1 $2 $3 $4 |
+	sed "s/^/100644 $EMPTY_BLOB	/" |
+	git update-index --index-info
+	return 0
+}
+
+br_base=xxx_base_xxx
+br_work1=xxx_work1_xxx
+br_work2=xxx_work2_xxx
+br_work3=xxx_work3_xxx
+
+new_dir=xxx_dir_xxx
+
+## (5, 10, 9) will create 999,999 files.
+## (4, 10, 9) will create  99,999 files.
+depth=5
+width=10
+files=9
+
+export br_base
+export br_work1
+export br_work2
+export br_work3
+
+export new_dir
+
+export depth
+export width
+export files
+
+## The number of files in the xxx_base_xxx branch.
+nr_base=$(git ls-files | wc -l)
+export nr_base
+
+## Inflate the index with thousands of empty files and commit it.
+## Turn on sparse-checkout so that we don't have to populate them
+## later when we start switching branches.  Use reset --hard to
+## quickly checkout the new HEAD with minimum actual files.
+test_expect_success 'inflate the index' '
+	git reset --hard &&
+	git branch $br_base &&
+	git branch $br_work1 &&
+	git checkout $br_work1 &&
+	fill_index $new_dir $depth $width $files &&
+	git commit -m $br_work1 &&
+	echo $new_dir/file1 >.git/info/sparse-checkout &&
+	git config --local core.sparsecheckout 1 &&
+	git reset --hard
+'
+
+## The number of files in the xxx_work1_xxx branch.
+nr_work1=$(git ls-files | wc -l)
+export nr_work1
+
+test_perf "read-tree work1 ($nr_work1)" '
+	git read-tree -m $br_base $br_work1 -n
+'
+
+## Alternate between base and work branches several
+## times to measure a large change.
+test_perf "switch base work1 ($nr_base $nr_work1)" '
+	git checkout $br_base &&
+	git checkout $br_work1
+'
+
+## Create work2 by modifying 1 file in work1.
+## Create work3 as an alias of work2.
+test_expect_success 'setup work2' '
+	git branch $br_work2 &&
+	git checkout $br_work2 &&
+	echo x >$new_dir/file1 &&
+	git add $new_dir/file1 &&
+	git commit -m $br_work2 &&
+	git branch $br_work3
+'
+
+## Alternate between work1 and work2 several times
+## to measure a very small change.
+test_perf "switch work1 work2 ($nr_work1)" '
+	git checkout $br_work1 &&
+	git checkout $br_work2
+'
+
+## Alternate between branches work2 and work3 which
+## are aliases of the same commit.
+test_perf "switch commit aliases ($nr_work1)" '
+	git checkout $br_work3 &&
+	git checkout $br_work2
+'
+
+test_done
-- 
2.9.3

