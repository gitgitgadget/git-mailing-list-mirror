Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833BB1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 21:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdC0VJ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 17:09:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:50041 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752238AbdC0VJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 17:09:53 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2BC0784618;
        Mon, 27 Mar 2017 17:09:52 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 2/2] skip_verify_index: helper test
Date:   Mon, 27 Mar 2017 21:09:39 +0000
Message-Id: <1490648979-49580-3-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
References: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Created test to measure read_index() with and without
skip_verify_index set and report performance differences.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                          |  1 +
 t/helper/.gitignore               |  1 +
 t/helper/test-skip-verify-index.c | 73 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 t/helper/test-skip-verify-index.c

diff --git a/Makefile b/Makefile
index 9ec6065..e4932b6 100644
--- a/Makefile
+++ b/Makefile
@@ -631,6 +631,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
+TEST_PROGRAMS_NEED_X += test-skip-verify-index
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d6e8b36..4d2ed3c 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -25,6 +25,7 @@
 /test-sha1
 /test-sha1-array
 /test-sigchain
+/test-skip-verify-index
 /test-string-list
 /test-submodule-config
 /test-subprocess
diff --git a/t/helper/test-skip-verify-index.c b/t/helper/test-skip-verify-index.c
new file mode 100644
index 0000000..ec2db27
--- /dev/null
+++ b/t/helper/test-skip-verify-index.c
@@ -0,0 +1,73 @@
+#include "cache.h"
+#include "parse-options.h"
+
+uint64_t time_runs(int count)
+{
+	uint64_t t0, t1;
+	uint64_t sum = 0;
+	uint64_t avg;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		t0 = getnanotime();
+		read_cache();
+		t1 = getnanotime();
+
+		sum += (t1 - t0);
+
+		printf("%f %d [cache_nr %d]\n",
+			   ((double)(t1 - t0))/1000000000,
+			   skip_verify_index,
+			   the_index.cache_nr);
+		fflush(stdout);
+
+		discard_cache();
+	}
+
+	avg = sum / count;
+	if (count > 1) {
+		printf("%f %d avg\n",
+			   (double)avg/1000000000,
+			   skip_verify_index);
+		fflush(stdout);
+	}
+
+	return avg;
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	int count = 1;
+	const char *usage[] = {
+		"test-core-verify-index",
+		NULL
+	};
+	struct option options[] = {
+		OPT_INTEGER('c', "count", &count, "number of passes"),
+		OPT_END(),
+	};
+	const char *prefix;
+	uint64_t avg_no_skip, avg_skip;
+
+	prefix = setup_git_directory();
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (count < 1)
+		die("count must greater than zero");
+
+	/* throw away call to get the index in the disk cache */
+	read_cache();
+	discard_cache();
+
+	/* disable index SHA verification */
+	skip_verify_index = 0;
+	avg_no_skip = time_runs(count);
+
+	/* enable index SHA verification */
+	skip_verify_index = 1;
+	avg_skip = time_runs(count);
+
+	if (avg_skip > avg_no_skip)
+		die("skipping index SHA verification did not help");
+	return 0;
+}
-- 
2.7.4

