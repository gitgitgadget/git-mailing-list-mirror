Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3B71F404
	for <e@80x24.org>; Fri,  7 Sep 2018 03:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeIGIPF (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 04:15:05 -0400
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:55437
        "EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbeIGIPF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Sep 2018 04:15:05 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id y7Z3fzf4BiaxKy7Z9fPfHP; Thu, 06 Sep 2018 20:36:17 -0700
From:   Max Kirillov <max@max630.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        =?UTF-8?q?Jelmer=20Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH v2] http-backend: allow empty CONTENT_LENGTH
Date:   Fri,  7 Sep 2018 06:36:07 +0300
Message-Id: <20180907033607.24604-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
MIME-Version: 1.0
In-reply-to: <20180906193516.28909-1-max@max630.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfB9jULTHvYUMBdE4R2HcarNgQBSD74jpJcnVVIuz5viCcSa/yDfspmmMiRV0YzbxjKrJYl7ipqESbq2rseDAgoRfib4lqXf0fNzWlWNvaydmPFt5iZmg
 6+PPJZbKoWCFQvHz5vZa8PSIJdEASmFlCyahRHQVD3DN2HP6Mxe2MhrRfCnjYM5gKNSWzXUFiF8jeWtOKel+1UbXPUH1WPxW1iVTJ6NjEl38p7q6yh1T2gRS
 DhLTLMnkefkTO0uhCuIAPEU/4FpXWQn/885QXzOaFFY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to RFC3875, empty environment variable is equivalent to unset,
and for CONTENT_LENGTH it should mean zero body to read.

However, unset CONTENT_LENGTH is also used for chunked encoding to indicate
reading until EOF. At least, the test "large fetch-pack requests can be split
across POSTs" from t5551 starts faliing, if unset or empty CONTENT_LENGTH is
treated as zero length body. So keep the existing behavior as much as possible.

Add a test for the case.

Reported-By: Jelmer Vernooĳ <jelmer@jelmer.uk>
Signed-off-by: Max Kirillov <max@max630.net>
---
Added the "reported-by" and explained inline the reason to keep existing behavior
 http-backend.c                         |  2 +-
 t/t5562-http-backend-content-length.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/http-backend.c b/http-backend.c
index e88d29f62b..a1230d7ead 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -353,7 +353,7 @@ static ssize_t get_content_length(void)
 	ssize_t val = -1;
 	const char *str = getenv("CONTENT_LENGTH");
 
-	if (str && !git_parse_ssize_t(str, &val))
+	if (str && *str && !git_parse_ssize_t(str, &val))
 		die("failed to parse CONTENT_LENGTH: %s", str);
 	return val;
 }
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 057dcb85d6..ca34c2f054 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -152,4 +152,15 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 	grep "fatal:.*CONTENT_LENGTH" err
 '
 
+test_expect_success 'empty CONTENT_LENGTH' '
+	env \
+		QUERY_STRING=/repo.git/HEAD \
+		PATH_TRANSLATED="$PWD"/.git/HEAD \
+		GIT_HTTP_EXPORT_ALL=TRUE \
+		REQUEST_METHOD=GET \
+		CONTENT_LENGTH="" \
+		git http-backend <empty_body >act.out 2>act.err &&
+	verify_http_result "200 OK"
+'
+
 test_done
-- 
2.17.0.1185.g782057d875

