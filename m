Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D8BC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59A82333D
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbhAGJo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:44:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:48532 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbhAGJo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:44:58 -0500
Received: (qmail 16094 invoked by uid 109); 7 Jan 2021 09:44:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jan 2021 09:44:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26466 invoked by uid 111); 7 Jan 2021 09:44:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jan 2021 04:44:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jan 2021 04:44:17 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Harold Kim <h.kim@flatt.tech>
Subject: [PATCH 2/2] fsck: reject .gitmodules git:// urls with newlines
Message-ID: <X/bX8XDYH2rni9uV@coredump.intra.peff.net>
References: <X/bXV9dGFK2bxBV0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/bXV9dGFK2bxBV0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit taught the clone/fetch client side to reject a
git:// URL with a newline in it. Let's also catch these when fscking a
.gitmodules file, which will give an earlier warning.

Note that it would be simpler to just complain about newline in _any_
URL, but an earlier tightening for http/ftp made sure we kept allowing
newlines for unknown protocols (and this is covered in the tests). So
we'll stick to that precedent.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c                        |  2 +-
 t/t7416-submodule-dash-url.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index f82e2fe9e3..5e282b3b6b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1082,7 +1082,7 @@ static int check_submodule_url(const char *url)
 	if (looks_like_command_line_option(url))
 		return -1;
 
-	if (submodule_url_is_relative(url)) {
+	if (submodule_url_is_relative(url) || starts_with(url, "git://")) {
 		char *decoded;
 		const char *next;
 		int has_nl;
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index eec96e0ba9..d21dc8b009 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -201,4 +201,19 @@ test_expect_success 'fsck rejects embedded newline in relative url' '
 	grep gitmodulesUrl err
 '
 
+test_expect_success 'fsck rejects embedded newline in git url' '
+	git checkout --orphan git-newline &&
+	cat >.gitmodules <<-\EOF &&
+	[submodule "foo"]
+	url = "git://example.com:1234/repo%0a.git"
+	EOF
+	git add .gitmodules &&
+	git commit -m "git url with newline" &&
+	test_when_finished "rm -rf dst" &&
+	git init --bare dst &&
+	git -C dst config transfer.fsckObjects true &&
+	test_must_fail git push dst HEAD 2>err &&
+	grep gitmodulesUrl err
+'
+
 test_done
-- 
2.30.0.572.g094076f6a2
