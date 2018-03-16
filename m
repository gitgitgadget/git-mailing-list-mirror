Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66DF1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCPUAi (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:00:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:10320 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbeCPUAg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:00:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 707173F4091;
        Fri, 16 Mar 2018 15:41:16 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id ED4763F4090;
        Fri, 16 Mar 2018 15:41:15 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 2/2] json-writer: unit test
Date:   Fri, 16 Mar 2018 19:40:57 +0000
Message-Id: <20180316194057.77513-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180316194057.77513-1-git@jeffhostetler.com>
References: <20180316194057.77513-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                    |   1 +
 t/helper/test-json-writer.c | 146 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      |  10 +++
 3 files changed, 157 insertions(+)
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh

diff --git a/Makefile b/Makefile
index 9000369..57f58e6 100644
--- a/Makefile
+++ b/Makefile
@@ -662,6 +662,7 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
+TEST_PROGRAMS_NEED_X += test-json-writer
 TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
new file mode 100644
index 0000000..bb43efb
--- /dev/null
+++ b/t/helper/test-json-writer.c
@@ -0,0 +1,146 @@
+#include "cache.h"
+#include "json-writer.h"
+
+const char *expect_obj1 = "{\"a\":\"abc\",\"b\":42,\"c\":true}";
+const char *expect_obj2 = "{\"a\":-1,\"b\":2147483647,\"c\":0}";
+const char *expect_obj3 = "{\"a\":0,\"b\":4294967295,\"c\":18446744073709551615}";
+const char *expect_obj4 = "{\"t\":true,\"f\":false,\"n\":null}";
+const char *expect_obj5 = "{\"abc\\tdef\":\"abc\\\\def\"}";
+
+struct strbuf obj1 = STRBUF_INIT;
+struct strbuf obj2 = STRBUF_INIT;
+struct strbuf obj3 = STRBUF_INIT;
+struct strbuf obj4 = STRBUF_INIT;
+struct strbuf obj5 = STRBUF_INIT;
+
+void make_obj1(void)
+{
+	jw_object_begin(&obj1);
+	jw_object_append_string(&obj1, "a", "abc");
+	jw_object_append_int(&obj1, "b", 42);
+	jw_object_append_true(&obj1, "c");
+	jw_object_end(&obj1);
+}
+
+void make_obj2(void)
+{
+	jw_object_begin(&obj2);
+	jw_object_append_int(&obj2, "a", -1);
+	jw_object_append_int(&obj2, "b", 0x7fffffff);
+	jw_object_append_int(&obj2, "c", 0);
+	jw_object_end(&obj2);
+}
+
+void make_obj3(void)
+{
+	jw_object_begin(&obj3);
+	jw_object_append_uint64(&obj3, "a", 0);
+	jw_object_append_uint64(&obj3, "b", 0xffffffff);
+	jw_object_append_uint64(&obj3, "c", 0xffffffffffffffff);
+	jw_object_end(&obj3);
+}
+
+void make_obj4(void)
+{
+	jw_object_begin(&obj4);
+	jw_object_append_true(&obj4, "t");
+	jw_object_append_false(&obj4, "f");
+	jw_object_append_null(&obj4, "n");
+	jw_object_end(&obj4);
+}
+
+void make_obj5(void)
+{
+	jw_object_begin(&obj5);
+	jw_object_append_string(&obj5, "abc" "\x09" "def", "abc" "\\" "def");
+	jw_object_end(&obj5);
+}
+
+const char *expect_arr1 = "[\"abc\",42,true]";
+const char *expect_arr2 = "[-1,2147483647,0]";
+const char *expect_arr3 = "[0,4294967295,18446744073709551615]";
+const char *expect_arr4 = "[true,false,null]";
+
+struct strbuf arr1 = STRBUF_INIT;
+struct strbuf arr2 = STRBUF_INIT;
+struct strbuf arr3 = STRBUF_INIT;
+struct strbuf arr4 = STRBUF_INIT;
+
+void make_arr1(void)
+{
+	jw_array_begin(&arr1);
+	jw_array_append_string(&arr1, "abc");
+	jw_array_append_int(&arr1, 42);
+	jw_array_append_true(&arr1);
+	jw_array_end(&arr1);
+}
+
+void make_arr2(void)
+{
+	jw_array_begin(&arr2);
+	jw_array_append_int(&arr2, -1);
+	jw_array_append_int(&arr2, 0x7fffffff);
+	jw_array_append_int(&arr2, 0);
+	jw_array_end(&arr2);
+}
+
+void make_arr3(void)
+{
+	jw_array_begin(&arr3);
+	jw_array_append_uint64(&arr3, 0);
+	jw_array_append_uint64(&arr3, 0xffffffff);
+	jw_array_append_uint64(&arr3, 0xffffffffffffffff);
+	jw_array_end(&arr3);
+}
+
+void make_arr4(void)
+{
+	jw_array_begin(&arr4);
+	jw_array_append_true(&arr4);
+	jw_array_append_false(&arr4);
+	jw_array_append_null(&arr4);
+	jw_array_end(&arr4);
+}
+
+char *expect_nest1 =
+	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]}";
+
+struct strbuf nest1 = STRBUF_INIT;
+
+void make_nest1(void)
+{
+	jw_object_begin(&nest1);
+	jw_object_append_object(&nest1, "obj1", obj1.buf);
+	jw_object_append_array(&nest1, "arr1", arr1.buf);
+	jw_object_end(&nest1);
+}
+
+void cmp(const char *test, const struct strbuf *buf, const char *exp)
+{
+	if (!strcmp(buf->buf, exp))
+		return;
+
+	printf("error[%s]: observed '%s' expected '%s'\n",
+	       test, buf->buf, exp);
+	exit(1);
+}
+
+#define t(v) do { make_##v(); cmp(#v, &v, expect_##v); } while (0)
+
+int cmd_main(int argc, const char **argv)
+{
+	t(obj1);
+	t(obj2);
+	t(obj3);
+	t(obj4);
+	t(obj5);
+
+	t(arr1);
+	t(arr2);
+	t(arr3);
+	t(arr4);
+
+	t(nest1);
+
+	return 0;
+}
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
new file mode 100755
index 0000000..7b86087
--- /dev/null
+++ b/t/t0019-json-writer.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='test json-writer JSON generation'
+. ./test-lib.sh
+
+test_expect_success 'unit test of json-writer routines' '
+	test-json-writer
+'
+
+test_done
-- 
2.9.3

