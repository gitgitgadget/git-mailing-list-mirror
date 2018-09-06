Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1F51F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeIGATp (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 20:19:45 -0400
Received: from p3plsmtpa08-05.prod.phx3.secureserver.net ([173.201.193.106]:47358
        "EHLO p3plsmtpa08-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbeIGATp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Sep 2018 20:19:45 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2018 20:19:45 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id y03mf2bccpRXAy03rfhLO6; Thu, 06 Sep 2018 12:35:28 -0700
From:   Max Kirillov <max@max630.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        =?UTF-8?q?Jelmer=20Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH] http-backend: allow empty CONTENT_LENGTH
Date:   Thu,  6 Sep 2018 22:35:16 +0300
Message-Id: <20180906193516.28909-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-reply-to: <20180906061038.GA94045@aiede.svl.corp.google.com>
X-CMAE-Envelope: MS4wfJ4EViEJO4B7fddsM0N8Svy+ke5BdrIT8STG7IpUb6bkTvFPZWdwoEX5xUGXdwiCAskG6Rd+OPDvsrFQzYjrOXbI+1z+fZuj6SSd1VDnP2oIrPr5OmLd
 qRa+J95N2mWb3j6OQtm9XqcXZacor+CA6EL6UpARHFpDIeRcID7F0pd87gSUJFx7fnURmmfP/AsfE38WEK8DvO7H+w+/ehpNrz7TsNQ4NDJJCf9HO2suYGCy
 g7vDbmzK7Hm55P1xLUUhcSdiiNyLkj5kVy4EYWdm5fo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to RFC3875, empty environment variable is equivalent to unset,
and for CONTENT_LENGTH it should mean zero body to read.

However, as discussed in [1], unset CONTENT_LENGTH is also used for
chunked encoding to indicate reading until EOF, so keep this behavior also
for empty CONTENT_LENGTH.

Add a test for the case.

[1] https://public-inbox.org/git/20160329201349.GB9527@sigill.intra.peff.net/

Signed-off-by: Max Kirillov <max@max630.net>
---
Hi.

This should fix it. I'm not sure should it treat it as 0 or "-1"
At least the tests mentioned by Jeff fails if I try to treat missing CONTENT_LENGTH as "-1"
So keep the existing behavior as much as possible
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

