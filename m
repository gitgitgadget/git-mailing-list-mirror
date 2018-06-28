Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6AE91F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967287AbeF1WGG (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:06:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:58956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966851AbeF1WGG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:06:06 -0400
Received: (qmail 32068 invoked by uid 109); 28 Jun 2018 22:06:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 22:06:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26036 invoked by uid 111); 28 Jun 2018 22:06:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 18:06:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 18:06:04 -0400
Date:   Thu, 28 Jun 2018 18:06:04 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: [PATCH 4/4] fsck: silence stderr when parsing .gitmodules
Message-ID: <20180628220603.GD5524@sigill.intra.peff.net>
References: <20180628220332.GA5128@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628220332.GA5128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If there's a parsing error we'll already report it via the
usual fsck report() function (or not, if the user has asked
to skip this object or warning type). The error message from
the config parser just adds confusion. Let's suppress it.

Note that we didn't test this case at all, so I've added
coverage in t7415. We may end up toning down or removing
this fsck check in the future. So take this test as checking
what happens now with a focus on stderr, and not any
ironclad guarantee that we must detect and report parse
failures in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c                     |  4 +++-
 t/t7415-submodule-names.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index aa7a52cc80..87b0e228bd 100644
--- a/fsck.c
+++ b/fsck.c
@@ -992,6 +992,7 @@ static int fsck_blob(struct blob *blob, const char *buf,
 		     unsigned long size, struct fsck_options *options)
 {
 	struct fsck_gitmodules_data data;
+	struct config_options config_opts = { 0 };
 
 	if (!oidset_contains(&gitmodules_found, &blob->object.oid))
 		return 0;
@@ -1011,8 +1012,9 @@ static int fsck_blob(struct blob *blob, const char *buf,
 	data.obj = &blob->object;
 	data.options = options;
 	data.ret = 0;
+	config_opts.error_action = CONFIG_ERROR_SILENT;
 	if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
-				".gitmodules", buf, size, &data, NULL))
+				".gitmodules", buf, size, &data, &config_opts))
 		data.ret |= report(options, &blob->object,
 				   FSCK_MSG_GITMODULES_PARSE,
 				   "could not parse gitmodules blob");
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index b68c5f5e85..ba8af785a5 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -176,4 +176,19 @@ test_expect_success 'fsck detects non-blob .gitmodules' '
 	)
 '
 
+test_expect_success 'fsck detects corrupt .gitmodules' '
+	git init corrupt &&
+	(
+		cd corrupt &&
+
+		echo "[broken" >.gitmodules &&
+		git add .gitmodules &&
+		git commit -m "broken gitmodules" &&
+
+		test_must_fail git fsck 2>output &&
+		grep gitmodulesParse output &&
+		test_i18ngrep ! "bad config" output
+	)
+'
+
 test_done
-- 
2.18.0.604.g8c4f59c959
