Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2454C1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 05:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbeIHK10 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 06:27:26 -0400
Received: from p3plsmtpa12-07.prod.phx3.secureserver.net ([68.178.252.236]:53723
        "EHLO p3plsmtpa12-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbeIHK10 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 06:27:26 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Sep 2018 06:27:26 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id yVu9fkom2j39lyVuEfoGf4; Fri, 07 Sep 2018 22:35:39 -0700
From:   Max Kirillov <max@max630.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        =?UTF-8?q?Jelmer=20Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH v2] http-backend: allow empty CONTENT_LENGTH
Date:   Sat,  8 Sep 2018 08:35:21 +0300
Message-Id: <20180908053521.21218-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-reply-to: <20180908001940.GB225427@aiede.svl.corp.google.com>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJe4evNAMkow1ErPdRpNz/Z3QqO/KdSdxrY3ULjb4Gs8Ts+wD9bpbOqLksraNGWO1B8qc14r8/NNoVlEssxmji55dFKSHKEzsP3g8E3azSrUDpBUsWA+
 s6l9jF6bDWBWzcpRv6zyrAh3iN/ULpBEROMeW4odAWyiDZQtCN9VeMJTdXyq6zGWsBxfVQ5BVprG8Li5lt6vFU6d2FZGlka+8Vz3FeloI0MtCXPAO3wuIt5A
 76756Pv1U4VLQakgZvIArtH4sEy9uQ27CSl6quFitUo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 817f7dc223, CONTENT_LENGTH variable was never considered,
http-backend was just reading request body from standard input until EOF
when it, or a command started by it, needed it.

Then it was discovered that some HTTP do not close standard input, instead
expecting CGI scripts to obey CONTENT_LENGTH. In 817f7dc223, behavior
was changed to consider the CONTENT_LENGTH variable when it is set. Case
of unset CONTENT_LENGTH was kept to mean "read until EOF" which is not
compliant to the RFC3875 (which treats it as empty body), but
practically is used when client uses chunked encoding to submit big
request.

Case of empty CONTENT_LENGTH has slept through this conditions.
Apparently, it is used for GET requests, and RFC3875 does specify that
it also means empty body. Current implementation, however, fails to
parse it and aborts the request.

Fix the case of empty CONTENT_LENGTH to also be treated as "read until EOF".
It does not actually matter what does it mean because body is never read
anyway, it just should not cause parse error. Add a test for the case.

Reported-By: Jelmer Vernooĳ <jelmer@jelmer.uk>
Signed-off-by: Max Kirillov <max@max630.net>
---
Provided more thorough message, also fix test (it did not test actually the error before)

There will be more versions later, at least the one which suggested by Jeff
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
index 057dcb85d6..b28c3c4765 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -152,4 +152,15 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 	grep "fatal:.*CONTENT_LENGTH" err
 '
 
+test_expect_success 'empty CONTENT_LENGTH' '
+	env \
+		QUERY_STRING="/repo.git/info/refs?service=git-receive-pack" \
+		PATH_TRANSLATED="$PWD"/.git/info/refs \
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

