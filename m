Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6EB41FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 13:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbdDFNpV (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 09:45:21 -0400
Received: from siwi.pair.com ([209.68.5.199]:43469 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757069AbdDFNpT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 09:45:19 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 08AC284650;
        Thu,  6 Apr 2017 09:45:17 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 2/2] p0005-status: time status on very large repo
Date:   Thu,  6 Apr 2017 13:45:08 +0000
Message-Id: <20170406134508.31711-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170406134508.31711-1-git@jeffhostetler.com>
References: <20170406134508.31711-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p0005-status.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100755 t/perf/p0005-status.sh

diff --git a/t/perf/p0005-status.sh b/t/perf/p0005-status.sh
new file mode 100755
index 0000000..704cebc
--- /dev/null
+++ b/t/perf/p0005-status.sh
@@ -0,0 +1,61 @@
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
+br_work1=xxx_work1_xxx
+dir_new=xxx_dir_xxx
+
+## (5, 10, 9) will create 999,999 files.
+## (4, 10, 9) will create  99,999 files.
+depth=5
+width=10
+files=9
+
+## Inflate the index with thousands of empty files and commit it.
+## Use reset to actually populate the worktree.
+test_expect_success 'inflate the index' '
+	git reset --hard &&
+	git branch $br_work1 &&
+	git checkout $br_work1 &&
+	fill_index $dir_new $depth $width $files &&
+	git commit -m $br_work1 &&
+	git reset --hard
+'
+
+## The number of files in the branch.
+nr_work1=$(git ls-files | wc -l)
+
+test_perf "read-tree status work1 ($nr_work1)" '
+	git read-tree HEAD &&
+	git status
+'
+
+test_done
-- 
2.9.3

