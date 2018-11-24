Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EAE31F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 09:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeKXUZa (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 15:25:30 -0500
Received: from p3plsmtpa07-10.prod.phx3.secureserver.net ([173.201.192.239]:52975
        "EHLO p3plsmtpa07-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbeKXUZa (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Nov 2018 15:25:30 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id QUNNg2ktVGkjoQUNTgVTvQ; Sat, 24 Nov 2018 02:37:29 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: [PATCH v3] t5562: do not reuse output files
Date:   Sat, 24 Nov 2018 11:37:19 +0200
Message-Id: <20181124093719.10705-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
In-Reply-To: <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPxANyrkZwu5o9dpgdrOz99HQ5qrKMJDIcO8H9JgwqUDmhgEpBoI1HKRbSY99ZjGdeNXi72rvgbltGq28chy94jcJ3CsTxEZlACPBrnTkAlArMUTbxgA
 OrKScag1q7X930tXjVeXEm4sQZB6tmBJdwoWoOGXI2ReSF7mTPxuiaaY/U4h2E+wmQmeKmrBPw3cxzhjFxQDSwP4urcPQtihy7M/3jSK26PAbWCYgp7Q6cGl
 jR0yg9u1bB+7jmjWhQFg9NXO9hlkvYRw/qwcZkufJ7Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some expected failures of git-http-backend leaves running its children
(receive-pack or upload-pack) which still hold opened descriptors
to act.err and with some probability they live long enough to write
there their failure messages after next test has already truncated
the files. This causes occasional failures of the test script.

Avoid the issue by using separated output and error file for each test,
apprending the test number to their name.

Reported-by: Carlo Arenas <carenas@gmail.com>
Helped-by: Carlo Arenas <carenas@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
Use another output and error files for each test
 t/t5562-http-backend-content-length.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 90d890d02f..9ebbd77bbb 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -8,12 +8,12 @@ test_lazy_prereq GZIP 'gzip --version'
 verify_http_result() {
 	# some fatal errors still produce status 200
 	# so check if there is the error message
-	if grep 'fatal:' act.err
+	if grep 'fatal:' act.err.$test_count
 	then
 		return 1
 	fi
 
-	if ! grep "Status" act.out >act
+	if ! grep "Status" act.out.$test_count >act
 	then
 		printf "Status: 200 OK\r\n" >act
 	fi
@@ -33,7 +33,7 @@ test_http_env() {
 		REQUEST_METHOD=POST \
 		"$PERL_PATH" \
 		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl \
-		    "$request_body" git http-backend >act.out 2>act.err
+		    "$request_body" git http-backend >act.out.$test_count 2>act.err.$test_count
 }
 
 ssize_b100dots() {
@@ -161,7 +161,7 @@ test_expect_success 'empty CONTENT_LENGTH' '
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=GET \
 		CONTENT_LENGTH="" \
-		git http-backend <empty_body >act.out 2>act.err &&
+		git http-backend <empty_body >act.out.$test_count 2>act.err.$test_count &&
 	verify_http_result "200 OK"
 '
 
-- 
2.19.0.1202.g68e1e8f04e

