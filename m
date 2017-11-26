Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E81D20954
	for <e@80x24.org>; Sun, 26 Nov 2017 01:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbdKZBzG (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 20:55:06 -0500
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:33024
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751907AbdKZBzE (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 20:55:04 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id Im9jetQwL0TufIm9teDkyx; Sat, 25 Nov 2017 18:55:04 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v5 2/2] t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
Date:   Sun, 26 Nov 2017 03:54:48 +0200
Message-Id: <20171126015448.24111-3-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
In-Reply-To: <20171126015448.24111-1-max@max630.net>
References: <20171126015448.24111-1-max@max630.net>
X-CMAE-Envelope: MS4wfDvQNxcYf3JmeRL046pSwiZQKzno7lplc40HusDj5xFoAt904g4cR0kRVP2VKT0WWJLRcz4uTDbtf0TB8iffTjn8vVZw6yAP4KLc85AG/p6iJmz7ktMJ
 Q3WSVu0Ef+9Fna1RRKFJ0/srkmzvUjaU9nqTUrxTzuj8yN8fMXK/RBY78XYRqhM6AdJ47LZcF6MOLduGmzZqeshi/AAuDozd/oH44FYFCRlq8S/1Wnm761DT
 VOeVClReeoCPQGRmXEMXjaFHPdmgmCIsfCPklTxkp8uD0QwgQ8MPt+HbK5VK3N8vk9dtU4pFHivyfrEIAzLKsVPQW7mwU8lTvFkgbVcdQ9C6cZf9E9AAKGus
 v6IQWbtBH02+jm8MJGb3Y3quGlLzKzHSV2EcDG12WYJN9+6r7CQ=
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

