Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B271F404
	for <e@80x24.org>; Sat,  8 Sep 2018 05:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeIHK07 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 06:26:59 -0400
Received: from p3plsmtpa09-01.prod.phx3.secureserver.net ([173.201.193.230]:42844
        "EHLO p3plsmtpa09-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbeIHK07 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 06:26:59 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id yW0nf8jL488dPyW0rf36EA; Fri, 07 Sep 2018 22:42:30 -0700
From:   Max Kirillov <max@max630.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        =?UTF-8?q?Jelmer=20Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH v3] http-backend: allow empty CONTENT_LENGTH
Date:   Sat,  8 Sep 2018 08:42:24 +0300
Message-Id: <20180908054224.21856-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-reply-to: <20180908001940.GB225427@aiede.svl.corp.google.com>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNTPKaS4+T4NXpei0wCWGqdEa+PVCSAs94c3HrVN6w2HvlB6AuFe0rVVIMpo1+WX8ZOy0z2lBu2JK8FE2VUhLmfCqGn5nIwARLR+aBWBRl6UTBD5ycrk
 FUCNBrAyn4abS4cZz4OK5yEc/YR3Qk+/vcl1x7yfKSM1XzgW+vpX+tDdgHIvRTilsxg4p+vnieFOOfz9TUMU4krMde7dcogIxDOPw0UDlNLHXyeGADmsVOKE
 x/au/kTEGC1qFGs4j/glMbCrWlA868xUQGTA86agKIo=
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

PS: did I write v2, it should be v3 of course!
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

