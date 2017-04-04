Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838F520964
	for <e@80x24.org>; Tue,  4 Apr 2017 21:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbdDDVJF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 17:09:05 -0400
Received: from siwi.pair.com ([209.68.5.199]:59181 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754051AbdDDVJB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 17:09:01 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5F61B84608;
        Tue,  4 Apr 2017 17:09:00 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 1/4] p0004-read-tree: perf test to time read-tree
Date:   Tue,  4 Apr 2017 21:08:44 +0000
Message-Id: <20170404210847.50860-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170404210847.50860-1-git@jeffhostetler.com>
References: <20170404210847.50860-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p0004-read-tree.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 t/perf/p0004-read-tree.sh

diff --git a/t/perf/p0004-read-tree.sh b/t/perf/p0004-read-tree.sh
new file mode 100755
index 0000000..ffbbf8e
--- /dev/null
+++ b/t/perf/p0004-read-tree.sh
@@ -0,0 +1,84 @@
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
+br_work=xxx_work_xxx
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
+export br_work
+export new_dir
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
+## later when we start switching branches.
+test_expect_success 'inflate the index' '
+	git reset --hard &&
+	git branch $br_base &&
+	git branch $br_work &&
+	git checkout $br_work &&
+	fill_index $new_dir $depth $width $files &&
+	git commit -m $br_work &&
+	echo $new_dir/file1 >.git/info/sparse-checkout &&
+	git config --local core.sparsecheckout 1 &&
+	git reset --hard
+'
+
+## The number of files in the xxx_work_xxx branch.
+nr_work=$(git ls-files | wc -l)
+export nr_work
+
+test_perf "read-tree ($nr_work)" '
+	git read-tree -m $br_base $br_work -n
+'
+
+test_perf "switch branches ($nr_base $nr_work)" '
+	git checkout $br_base &&
+	git checkout $br_work
+'
+
+
+test_done
-- 
2.9.3

