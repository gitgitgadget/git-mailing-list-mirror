Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E051F404
	for <e@80x24.org>; Mon, 10 Sep 2018 20:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeIKBuK (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 21:50:10 -0400
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:58425
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbeIKBuK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Sep 2018 21:50:10 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id zTCEf4aLL0GwuzTCJfcmLH; Mon, 10 Sep 2018 13:54:16 -0700
From:   Max Kirillov <max@max630.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?q?Jelmer=20Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Max Kirillov <max@max630.net>
Subject: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero
Date:   Mon, 10 Sep 2018 23:53:59 +0300
Message-Id: <20180910205359.32332-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-reply-to: <20180910052558.GB55941@aiede.svl.corp.google.com>
X-CMAE-Envelope: MS4wfDzyHMNe2FFkY8AYWU/kpAFcQBtjpZTFYOYtyAKjFEuncLzn+Dk976OZjkYVr2FOvsVK5hYYBK7u3SxxtRQnnEvu7hIk/+MvX6K3iqSBNnwTlRdoYela
 NjUoXC48+ywv7IjS2RnWVi6WjfGWr5LYyaCtvoVCTx37jXKr2DoTn403ARtEiIfNr7Zf2P4ffydI4zawbkQl05IN6FVsmNHIazE+AdO8D3Jey2lRibtZLxHJ
 k2coNGeiKAnRpHjQvNcZcvYtsjyVkrFg4EqSXEirHgk5iXl+weGQV42C9TGSxDXYxJjSkXa+e1dtEe1jf1bqnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>
Subject: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero

There is no known case where empty body it used by a server as
instruction to read until EOF, so there is no need to violate the RFC.
Make get_content_length() return 0 in this case.

Currently there is no practical difference, as the GET request
where it can be empty is handled without actual reading the body
(in get_info_refs() function), but it is better to stick to the correct
behavior.

Signed-off-by: Max Kirillov <max@max630.net>
---
The incremental. Hopefully I described the reason right. Needs "signed-off-by"
 http-backend.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 458642ef72..ea36a52118 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -353,8 +353,28 @@ static ssize_t get_content_length(void)
 	ssize_t val = -1;
 	const char *str = getenv("CONTENT_LENGTH");
 
-	if (str && *str && !git_parse_ssize_t(str, &val))
-		die("failed to parse CONTENT_LENGTH: %s", str);
+	if (!str) {
+		/*
+		 * RFC3875 says this must mean "no body", but in practice we
+		 * receive chunked encodings with no CONTENT_LENGTH. Tell the
+		 * caller to read until EOF.
+		 */
+		val = -1;
+	} else if (!*str) {
+		/*
+		 * An empty length should be treated as "no body" according to
+		 * RFC3875, and this seems to hold in practice.
+		 */
+		val = 0;
+	} else {
+		/*
+		 * We have a non-empty CONTENT_LENGTH; trust what's in it as long
+		 * as it can be parsed.
+		 */
+		if (!git_parse_ssize_t(str, &val))
+			die("failed to parse CONTENT_LENGTH: '%s'", str);
+	}
+
 	return val;
 }
 
-- 
2.17.0.1185.g782057d875

