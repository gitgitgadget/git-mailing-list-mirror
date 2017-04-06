Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572471FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 16:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932286AbdDFQey (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 12:34:54 -0400
Received: from siwi.pair.com ([209.68.5.199]:21681 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdDFQew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 12:34:52 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D536C8460C;
        Thu,  6 Apr 2017 12:34:50 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 1/3] read-cache: add strcmp_offset function
Date:   Thu,  6 Apr 2017 16:34:40 +0000
Message-Id: <20170406163442.36463-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170406163442.36463-1-git@jeffhostetler.com>
References: <20170406163442.36463-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add strcmp_offset() function to also return the offset of the
first change.

Add unit test and helper to verify.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                      |  1 +
 cache.h                       |  1 +
 read-cache.c                  | 20 ++++++++++++++
 t/helper/.gitignore           |  1 +
 t/helper/test-strcmp-offset.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 t/t0065-strcmp-offset.sh      | 11 ++++++++
 6 files changed, 98 insertions(+)
 create mode 100644 t/helper/test-strcmp-offset.c
 create mode 100755 t/t0065-strcmp-offset.sh

diff --git a/Makefile b/Makefile
index 9ec6065..4c4c246 100644
--- a/Makefile
+++ b/Makefile
@@ -631,6 +631,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
+TEST_PROGRAMS_NEED_X += test-strcmp-offset
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
diff --git a/cache.h b/cache.h
index 80b6372..fad194b 100644
--- a/cache.h
+++ b/cache.h
@@ -574,6 +574,7 @@ extern int write_locked_index(struct index_state *, struct lock_file *lock, unsi
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
+extern int strcmp_offset(const char *s1, const char *s2, int *first_change);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern void adjust_dirname_case(struct index_state *istate, char *name);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
diff --git a/read-cache.c b/read-cache.c
index 9054369..e8f1900 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -887,6 +887,26 @@ static int has_file_name(struct index_state *istate,
 	return retval;
 }
 
+
+/*
+ * Like strcmp(), but also return the offset of the first change.
+ * If strings are equal, return the length.
+ */
+int strcmp_offset(const char *s1, const char *s2, int *first_change)
+{
+	int k;
+
+	if (!first_change)
+		return strcmp(s1, s2);
+
+	for (k = 0; s1[k] == s2[k]; k++)
+		if (s1[k] == '\0')
+			break;
+
+	*first_change = k;
+	return ((unsigned char *)s1)[k] - ((unsigned char *)s2)[k];
+}
+
 /*
  * Do we have another file with a pathname that is a proper
  * subset of the name we're trying to add?
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d6e8b36..0a89531 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -25,6 +25,7 @@
 /test-sha1
 /test-sha1-array
 /test-sigchain
+/test-strcmp-offset
 /test-string-list
 /test-submodule-config
 /test-subprocess
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
new file mode 100644
index 0000000..887ba7e
--- /dev/null
+++ b/t/helper/test-strcmp-offset.c
@@ -0,0 +1,64 @@
+#include "cache.h"
+
+struct test_data {
+	const char *s1;
+	const char *s2;
+	int first_change; /* or strlen() when equal */
+};
+
+static struct test_data data[] = {
+	{ "abc", "abc", 3 },
+	{ "abc", "def", 0 },
+
+	{ "abc", "abz", 2 },
+
+	{ "abc", "abcdef", 3 },
+
+	{ "abc\xF0zzz", "abc\xFFzzz", 3 },
+
+	{ NULL, NULL, 0 }
+};
+
+int try_pair(const char *sa, const char *sb, int first_change)
+{
+	int failed = 0;
+	int offset, r_exp, r_tst;
+	int r_exp_sign, r_tst_sign;
+
+	/*
+	 * Because differnt CRTs behave differently, only rely on signs
+	 * of the result values.
+	 */
+	r_exp = strcmp(sa, sb);
+	r_exp_sign = ((r_exp < 0) ? -1 : ((r_exp == 0) ? 0 : 1));
+
+	r_tst = strcmp_offset(sa, sb, &offset);
+	r_tst_sign = ((r_tst < 0) ? -1 : ((r_tst == 0) ? 0 : 1));
+
+	if (r_tst_sign != r_exp_sign) {
+		error("FAIL: '%s' vs '%s', result expect %d, observed %d\n",
+			  sa, sb, r_exp_sign, r_tst_sign);
+		failed = 1;
+	}
+
+	if (offset != first_change) {
+		error("FAIL: '%s' vs '%s', offset expect %d, observed %d\n",
+			  sa, sb, first_change, offset);
+		failed = 1;
+	}
+
+	return failed;
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	int failed = 0;
+	int k;
+
+	for (k=0; data[k].s1; k++) {
+		failed += try_pair(data[k].s1, data[k].s2, data[k].first_change);
+		failed += try_pair(data[k].s2, data[k].s1, data[k].first_change);
+	}
+
+	return failed;
+}
diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
new file mode 100755
index 0000000..0176c8c
--- /dev/null
+++ b/t/t0065-strcmp-offset.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+test_description='Test strcmp_offset functionality'
+
+. ./test-lib.sh
+
+test_expect_success run_helper '
+	test-strcmp-offset
+'
+
+test_done
-- 
2.9.3

