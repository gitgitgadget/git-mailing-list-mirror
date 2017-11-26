Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B083C20954
	for <e@80x24.org>; Sun, 26 Nov 2017 01:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbdKZBzD (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 20:55:03 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:35083
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751907AbdKZBzB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 20:55:01 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Nov 2017 20:54:57 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id Im2ce86W4hwvHIm2newPFV; Sat, 25 Nov 2017 18:47:43 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v4 2/2] t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
Date:   Sun, 26 Nov 2017 03:47:19 +0200
Message-Id: <20171126014719.23728-3-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-Reply-To: <20171126014719.23728-2-max@max630.net>
References: <20171126014719.23728-1-max@max630.net>
 <20171126014719.23728-2-max@max630.net>
X-CMAE-Envelope: MS4wfHT5uLkbmJHIRn9X9qIjvB8/MfkHBmdgUoShI8kM5IpwtyOLOJPHduyAvO92dEAPMmZI0YDMxX4Xo5BbNIwSg6OEF6/05sdrSQRSBEKJ01kNu3rAjvZy
 fYXAoG0qR2YkzvrA+NOohpWbdSs4+lnWgkQL1W20c2GHIZsKe9QOtP5PGC139gi7cWpY8Ehb8tRB/IzMH4f6c9FVzc4UmqiEAj6Fk1eoK8ULH+QluRCwQcUC
 IOx+8zw2fcWD3AdDz73a3tacy6xc5jco5aZ0QFCgO2OlPDgs/dh2G24Gkne/H1wwqTAWRCTvBU2fwzTi3HEvAOTaTL4RD0ldA5W1VyiI5Cz6L3c2IIxJN2x0
 nnYvW4e1NaZyqoeGJXi4deTNdxNdwiqoyo0aDwE0L62ip1j+3Uk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for cases:

* CONTENT_LENGTH is set, script's stdin has more data.
  (Failure would make it read GIT_HTTP_MAX_REQUEST_BUFFER bytes from /dev/zero
  and fail. It does not seem to cause any performance issues with the default
  value of GIT_HTTP_MAX_REQUEST_BUFFER.)
* CONTENT_LENGTH is specified to a value which does not fix into ssize_t.

Signed-off-by: Max Kirillov <max@max630.net>
---
 Makefile                         |  1 +
 t/helper/test-print-values.c     | 10 ++++++++++
 t/t5560-http-backend-noserver.sh | 30 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 t/helper/test-print-values.c

diff --git a/Makefile b/Makefile
index 461c845d33..616408b32c 100644
--- a/Makefile
+++ b/Makefile
@@ -653,6 +653,7 @@ TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-print-values
 TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
 TEST_PROGRAMS_NEED_X += test-ref-store
diff --git a/t/helper/test-print-values.c b/t/helper/test-print-values.c
new file mode 100644
index 0000000000..8f7e5af319
--- /dev/null
+++ b/t/helper/test-print-values.c
@@ -0,0 +1,10 @@
+#include <stdio.h>
+#include <string.h>
+
+int cmd_main(int argc, const char **argv)
+{
+	if (argc == 2 && strcmp(argv[1], "(size_t)(-20)") == 0)
+		printf("%zu", (ssize_t)(-20));
+
+	return 0;
+}
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 9fafcf1945..f452090216 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -71,4 +71,34 @@ test_expect_success 'http-backend blocks bad PATH_INFO' '
 	expect_aliased 1 //domain/data.txt
 '
 
+# overrides existing definition for further cases
+run_backend() {
+	CONTENT_LENGTH="${#2}" && export CONTENT_LENGTH &&
+	( echo "$2" && cat /dev/zero ) |
+	QUERY_STRING="${1#*[?]}" \
+	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%[?]*}" \
+	git http-backend >act.out 2>act.err
+}
+
+test_expect_success 'CONTENT_LENGTH set and infinite input' '
+	config http.uploadpack true &&
+	GET info/refs?service=git-upload-pack "200 OK"	&&
+	! grep "fatal:.*" act.err &&
+	POST git-upload-pack 0000 "200 OK" &&
+	! grep "fatal:.*" act.err
+'
+
+test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
+	NOT_FIT_IN_SSIZE=`"$GIT_BUILD_DIR/t/helper/test-print-values" "(size_t)(-20)"` &&
+	env \
+		CONTENT_TYPE=application/x-git-upload-pack-request \
+		QUERY_STRING=/repo.git/git-upload-pack \
+		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
+		GIT_HTTP_EXPORT_ALL=TRUE \
+		REQUEST_METHOD=POST \
+		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
+		git http-backend </dev/zero >/dev/null 2>err &&
+	grep -q "fatal:.*CONTENT_LENGTH" err
+'
+
 test_done
-- 
2.11.0.1122.gc3fec58.dirty

