Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58D71F403
	for <e@80x24.org>; Tue,  5 Jun 2018 16:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeFEQeT (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 12:34:19 -0400
Received: from siwi.pair.com ([209.68.5.199]:18174 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbeFEQeR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 12:34:17 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 856713F4879;
        Tue,  5 Jun 2018 12:34:17 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1C59C3F4873;
        Tue,  5 Jun 2018 12:34:17 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 2/2] json-writer: t0019: add Python unit test
Date:   Tue,  5 Jun 2018 16:33:58 +0000
Message-Id: <20180605163358.119080-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180605163358.119080-1-git@jeffhostetler.com>
References: <20180605163358.119080-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Test json-writer output using Python.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t0019-json-writer.sh  | 38 ++++++++++++++++++++++++++++++++++++++
 t/t0019/parse_json_1.py | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 t/t0019/parse_json_1.py

diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
index c9c2e23..951cd89 100755
--- a/t/t0019-json-writer.sh
+++ b/t/t0019-json-writer.sh
@@ -233,4 +233,42 @@ test_expect_success 'inline array with no members' '
 	test_cmp expect actual
 '
 
+# As a sanity check, ask Python to parse our generated JSON.  Let Python
+# recursively dump the resulting dictionary in sorted order.  Confirm that
+# that matches our expectations.
+test_expect_success PYTHON 'parse JSON using Python' '
+	cat >expect <<-\EOF &&
+	a abc
+	b 42
+	sub1 dict
+	sub1.c 3.14
+	sub1.d True
+	sub1.sub2 list
+	sub1.sub2[0] False
+	sub1.sub2[1] dict
+	sub1.sub2[1].g 0
+	sub1.sub2[1].h 1
+	sub1.sub2[2] None
+	EOF
+	test-json-writer >output.json \
+		@object \
+			@object-string a abc \
+			@object-int b 42 \
+			@object-object "sub1" \
+				@object-double c 2 3.140 \
+				@object-true d \
+				@object-array "sub2" \
+					@array-false \
+					@array-object \
+						@object-int g 0 \
+						@object-int h 1 \
+					@end \
+					@array-null \
+				@end \
+			@end \
+		@end &&
+	python "$TEST_DIRECTORY"/t0019/parse_json_1.py <output.json >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t0019/parse_json_1.py b/t/t0019/parse_json_1.py
new file mode 100644
index 0000000..9d928a3
--- /dev/null
+++ b/t/t0019/parse_json_1.py
@@ -0,0 +1,35 @@
+import os
+import sys
+import json
+
+def dump_item(label_input, v):
+    if type(v) is dict:
+        print("%s dict" % (label_input))
+        dump_dict(label_input, v)
+    elif type(v) is list:
+        print("%s list" % (label_input))
+        dump_list(label_input, v)
+    else:
+        print("%s %s" % (label_input, v))
+
+def dump_list(label_input, list_input):
+    ix = 0
+    for v in list_input:
+        label = ("%s[%d]" % (label_input, ix))
+        dump_item(label, v)
+        ix += 1
+    return
+              
+def dump_dict(label_input, dict_input):
+    for k in sorted(dict_input.iterkeys()):
+        v = dict_input[k]
+        if (len(label_input) > 0):
+            label = ("%s.%s" % (label_input, k))
+        else:
+            label = k
+        dump_item(label, v)
+    return
+
+for line in sys.stdin:
+    data = json.loads(line)
+    dump_dict("", data)
-- 
2.9.3

