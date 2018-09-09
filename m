Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD891F404
	for <e@80x24.org>; Sun,  9 Sep 2018 04:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeIII6e (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 04:58:34 -0400
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:49922
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbeIII6d (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Sep 2018 04:58:33 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id yr3Bfw5CC0Gwuyr3FfbJ14; Sat, 08 Sep 2018 21:10:23 -0700
From:   Max Kirillov <max@max630.net>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Jelmer=20Vernoo=C4=B3?= <jelmer@jelmer.uk>
Subject: [PATCH v4] http-backend: allow empty CONTENT_LENGTH
Date:   Sun,  9 Sep 2018 07:10:16 +0300
Message-Id: <20180909041016.23980-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-reply-to: <20180907033607.24604-1-max@max630.net>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOxVxK0Hc4FOgLU6+A1l8XPfj6oLCXQ8hMMlNZu9yf3TkBqePsoPVJXvuXfV4iyKnQESEoKGJInJaZg/J7LnIrj7HeUBqSyVMuZ78vWJ2Txv+z2DuuyL
 ypxzTasOqaW8J9dhWcvwW7S5j+xdORnhDVigH0hgDZR84bzMEHNKHnKHTaKhfpBnkAMYUFwhggrbzstsJKupACZgVYgttwo2AiMQzzYytwW/ssnt1U6txLk9
 HNIKAKq3kxu0SoLBllY554gh5R3o8LTtgGvIxpR3vDk=
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

Fix the case of empty CONTENT_LENGTH to be treated as zero-length body
is expected, as specified by RFC3875. It does not actually matter what
does it mean because body is never read anyway, it just should not cause
parse error. Add a test for the case.

Reported-By: Jelmer Vernooĳ <jelmer@jelmer.uk>
Authored-by: Jeff King <peff@peff.net>
Signed-off-by: Max Kirillov <max@max630.net>
---
The fix suggested by Jeff. I supposed there should be "signed-off"
The tests pass as well
 http-backend.c                         | 24 ++++++++++++++++++++++--
 t/t5562-http-backend-content-length.sh | 11 +++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index e88d29f62b..949821b46f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -353,8 +353,28 @@ static ssize_t get_content_length(void)
 	ssize_t val = -1;
 	const char *str = getenv("CONTENT_LENGTH");
 
-	if (str && !git_parse_ssize_t(str, &val))
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

