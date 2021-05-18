Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF098C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D59961074
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhERG2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:28:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:57352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhERG2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:28:54 -0400
Received: (qmail 10556 invoked by uid 109); 18 May 2021 06:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 06:27:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5077 invoked by uid 111); 18 May 2021 06:27:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 02:27:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 02:27:36 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Humphreys <behumphreys@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
Subject: [PATCH 1/2] t5551: test http interaction with credential helpers
Message-ID: <YKNeWOCaa31qRVqk@coredump.intra.peff.net>
References: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We test authentication with http, and we independently test that
credential helpers work, but we don't have any tests that cover the
two features working together. Let's add two:

  1. Make sure that a successful request asks the helper to save the
     credential. This works as expected.

  2. Make sure that a failed request asks the helper to forget the
     credential. This is marked as expect_failure, as it was recently
     regressed by 1b0d9545bb (remote-curl: fall back to basic auth if
     Negotiate fails, 2021-03-22). The symptom here is that the second
     request should prompt the user, but doesn't.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 984dba22af..1de87e4ffe 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -517,4 +517,45 @@ test_expect_success 'server-side error detected' '
 	test_i18ngrep "server-side error" actual
 '
 
+test_expect_success 'http auth remembers successful credentials' '
+	rm -f .git-credentials &&
+	test_config credential.helper store &&
+
+	# the first request prompts the user...
+	set_askpass user@host pass@host &&
+	git ls-remote "$HTTPD_URL/auth/smart/repo.git" >/dev/null &&
+	expect_askpass both user@host &&
+
+	# ...and the second one uses the stored value rather than
+	# prompting the user.
+	set_askpass bogus-user bogus-pass &&
+	git ls-remote "$HTTPD_URL/auth/smart/repo.git" >/dev/null &&
+	expect_askpass none
+'
+
+test_expect_failure 'http auth forgets bogus credentials' '
+	# seed credential store with bogus values. In real life,
+	# this would probably come from a password which worked
+	# for a previous request.
+	rm -f .git-credentials &&
+	test_config credential.helper store &&
+	{
+		echo "url=$HTTPD_URL" &&
+		echo "username=bogus" &&
+		echo "password=bogus"
+	} | git credential approve &&
+
+	# we expect this to use the bogus values and fail, never even
+	# prompting the user...
+	set_askpass user@host pass@host &&
+	test_must_fail git ls-remote "$HTTPD_URL/auth/smart/repo.git" >/dev/null &&
+	expect_askpass none &&
+
+	# ...but now we should have forgotten the bad value, causing
+	# us to prompt the user again.
+	set_askpass user@host pass@host &&
+	git ls-remote "$HTTPD_URL/auth/smart/repo.git" >/dev/null &&
+	expect_askpass both user@host
+'
+
 test_done
-- 
2.32.0.rc0.421.g64c9147932

