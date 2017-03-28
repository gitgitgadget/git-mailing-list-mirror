Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC1220966
	for <e@80x24.org>; Tue, 28 Mar 2017 19:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755670AbdC1TIE (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:08:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:62734 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755657AbdC1TIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:08:01 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DDA378463A;
        Tue, 28 Mar 2017 15:07:54 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 2/2] test-core-checksum-index: core.checksumindex test helper
Date:   Tue, 28 Mar 2017 19:07:32 +0000
Message-Id: <20170328190732.59486-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170328190732.59486-1-git@jeffhostetler.com>
References: <20170328190732.59486-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Created test helper to measure read_index() with and without
core.checksumindex set and report performance.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                            |  1 +
 t/helper/.gitignore                 |  1 +
 t/helper/test-core-checksum-index.c | 77 +++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 t/helper/test-core-checksum-index.c

diff --git a/Makefile b/Makefile
index 9ec6065..6049427 100644
--- a/Makefile
+++ b/Makefile
@@ -607,6 +607,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
+TEST_PROGRAMS_NEED_X += test-core-checksum-index
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d6e8b36..f651a6b 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,6 +1,7 @@
 /test-chmtime
 /test-ctype
 /test-config
+/test-core-checksum-index
 /test-date
 /test-delta
 /test-dump-cache-tree
diff --git a/t/helper/test-core-checksum-index.c b/t/helper/test-core-checksum-index.c
new file mode 100644
index 0000000..0452dc2
--- /dev/null
+++ b/t/helper/test-core-checksum-index.c
@@ -0,0 +1,77 @@
+#include "cache.h"
+#include "parse-options.h"
+
+uint64_t time_runs(int do_checksum, int count)
+{
+	uint64_t t0, t1;
+	uint64_t sum = 0;
+	uint64_t avg;
+	int i;
+
+	git_config_set_gently("core.checksumindex",
+		(do_checksum ? "true" : "false"));
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
+			   do_checksum,
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
+			   do_checksum);
+		fflush(stdout);
+	}
+
+	return avg;
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	int original_do_checksum;
+	int count = 1;
+	const char *usage[] = {
+		"test-core-checksum-index",
+		NULL
+	};
+	struct option options[] = {
+		OPT_INTEGER('c', "count", &count, "number of passes"),
+		OPT_END(),
+	};
+	const char *prefix;
+	uint64_t avg_0, avg_1;
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
+	git_config_get_bool("core.checksumindex", &original_do_checksum);
+
+	avg_1 = time_runs(1, count);
+	avg_0 = time_runs(0, count);
+
+	git_config_set_gently("core.checksumindex",
+		((original_do_checksum) ? "true" : "false"));
+
+	if (avg_0 >= avg_1)
+		die("skipping index checksum verification did not help");
+	return 0;
+}
-- 
2.9.3

