Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0DB1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966560AbeF1WMr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:12:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:58972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752637AbeF1WMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:12:46 -0400
Received: (qmail 32344 invoked by uid 109); 28 Jun 2018 22:12:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 22:12:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26115 invoked by uid 111); 28 Jun 2018 22:13:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 18:13:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 18:12:44 -0400
Date:   Thu, 28 Jun 2018 18:12:44 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] fsck: silence stderr when parsing .gitmodules
Message-ID: <20180628221244.GA11462@sigill.intra.peff.net>
References: <20180628220332.GA5128@sigill.intra.peff.net>
 <20180628220603.GD5524@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628220603.GD5524@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 06:06:03PM -0400, Jeff King wrote:

> Note that we didn't test this case at all, so I've added
> coverage in t7415. We may end up toning down or removing
> this fsck check in the future. So take this test as checking
> what happens now with a focus on stderr, and not any
> ironclad guarantee that we must detect and report parse
> failures in the future.

And such a patch _could_ look something like this. Though we could also
perhaps leave it in place and tone it down to "ignore" by default.

There's another case that triggers gitmodulesParse, too, which is a blob
so gigantic that we try not to hold it in memory. Technically that could
also happen due to somebody using .gitmodules for something unrelated.
But that seems even more far-fetched. And it _is_ dangerous to leave,
because I think existing vulnerable clients will try to load a 500MB
.gitmodules file in memory and parse it.

---
diff --git a/fsck.c b/fsck.c
index 87b0e228bd..296e8a8a7c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1013,11 +1013,9 @@ static int fsck_blob(struct blob *blob, const char *buf,
 	data.options = options;
 	data.ret = 0;
 	config_opts.error_action = CONFIG_ERROR_SILENT;
-	if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
-				".gitmodules", buf, size, &data, &config_opts))
-		data.ret |= report(options, &blob->object,
-				   FSCK_MSG_GITMODULES_PARSE,
-				   "could not parse gitmodules blob");
+	/* ignore errors */
+	git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
+			    ".gitmodules", buf, size, &data, &config_opts);
 
 	return data.ret;
 }
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index ba8af785a5..9a7dae88a5 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -176,7 +176,7 @@ test_expect_success 'fsck detects non-blob .gitmodules' '
 	)
 '
 
-test_expect_success 'fsck detects corrupt .gitmodules' '
+test_expect_success 'fsck does not complain about corrupt .gitmodules' '
 	git init corrupt &&
 	(
 		cd corrupt &&
@@ -185,9 +185,8 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
 		git add .gitmodules &&
 		git commit -m "broken gitmodules" &&
 
-		test_must_fail git fsck 2>output &&
-		grep gitmodulesParse output &&
-		test_i18ngrep ! "bad config" output
+		git fsck 2>output &&
+		! test -s output
 	)
 '
 
