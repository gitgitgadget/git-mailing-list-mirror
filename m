Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33BED20970
	for <e@80x24.org>; Fri, 14 Apr 2017 19:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755474AbdDNTMs (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 15:12:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:30404 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754779AbdDNTMq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 15:12:46 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0BC6F845C9;
        Fri, 14 Apr 2017 15:12:39 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v10 1/3] read-cache: add strcmp_offset function
Date:   Fri, 14 Apr 2017 19:12:28 +0000
Message-Id: <20170414191230.52825-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170414191230.52825-1-git@jeffhostetler.com>
References: <20170414191230.52825-1-git@jeffhostetler.com>
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
 read-cache.c                  | 20 ++++++++++++++++++++
 t/helper/.gitignore           |  1 +
 t/helper/test-strcmp-offset.c | 22 ++++++++++++++++++++++
 t/t0065-strcmp-offset.sh      | 21 +++++++++++++++++++++
 6 files changed, 66 insertions(+)
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
index 80b6372..3c55047 100644
--- a/cache.h
+++ b/cache.h
@@ -574,6 +574,7 @@ extern int write_locked_index(struct index_state *, struct lock_file *lock, unsi
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
+extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern void adjust_dirname_case(struct index_state *istate, char *name);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
diff --git a/read-cache.c b/read-cache.c
index 9054369..97f13a1 100644
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
+int strcmp_offset(const char *s1, const char *s2, size_t *first_change)
+{
+	size_t k;
+
+	if (!first_change)
+		return strcmp(s1, s2);
+
+	for (k = 0; s1[k] == s2[k]; k++)
+		if (s1[k] == '\0')
+			break;
+
+	*first_change = k;
+	return (unsigned char)s1[k] - (unsigned char)s2[k];
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
index 0000000..4a45a54
--- /dev/null
+++ b/t/helper/test-strcmp-offset.c
@@ -0,0 +1,22 @@
+#include "cache.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	int result;
+	size_t offset;
+
+	if (!argv[1] || !argv[2])
+		die("usage: %s <string1> <string2>", argv[0]);
+
+	result = strcmp_offset(argv[1], argv[2], &offset);
+
+	/*
+	 * Because differnt CRTs behave differently, only rely on signs
+	 * of the result values.
+	 */
+	result = (result < 0 ? -1 :
+			  result > 0 ? 1 :
+			  0);
+	printf("%d %"PRIuMAX"\n", result, (uintmax_t)offset);
+	return 0;
+}
diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
new file mode 100755
index 0000000..7d6d214
--- /dev/null
+++ b/t/t0065-strcmp-offset.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='Test strcmp_offset functionality'
+
+. ./test-lib.sh
+
+while read s1 s2 expect
+do
+	test_expect_success "strcmp_offset($s1, $s2)" '
+		echo "$expect" >expect &&
+		test-strcmp-offset "$s1" "$s2" >actual &&
+		test_cmp expect actual
+	'
+done <<-EOF
+abc abc 0 3
+abc def -1 0
+abc abz -1 2
+abc abcdef -1 3
+EOF
+
+test_done
-- 
2.9.3

