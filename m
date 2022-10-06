Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A4BC4332F
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 13:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJFNKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiJFNKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 09:10:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41D5581
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 06:10:16 -0700 (PDT)
Received: (qmail 11989 invoked by uid 109); 6 Oct 2022 13:10:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Oct 2022 13:10:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26198 invoked by uid 111); 6 Oct 2022 13:10:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Oct 2022 09:10:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Oct 2022 09:10:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] test-submodule: inline resolve_relative_url() function
Message-ID: <Yz7Tt4ezU/GS3tHu@coredump.intra.peff.net>
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The resolve_relative_url() function takes argc and argv parameters; it
then reads up to 3 elements of argv without looking at argc at all. At
first glance, this seems like a bug. But it has only one caller,
cmd__submodule_resolve_relative_url(), which does confirm that argc is
3.

The main reason this is a separate function is that it was moved from
library code in 96a28a9bc6 (submodule--helper: move
"resolve-relative-url-test" to a test-tool, 2022-09-01).

We can make this code simpler and more obviously safe by just inlining
the function in its caller. As a bonus, this silences a
-Wunused-parameter warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-submodule.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index e0e0c53d38..b7d117cd55 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -85,10 +85,17 @@ static int cmd__submodule_is_active(int argc, const char **argv)
 	return !is_submodule_active(the_repository, argv[0]);
 }
 
-static int resolve_relative_url(int argc, const char **argv)
+static int cmd__submodule_resolve_relative_url(int argc, const char **argv)
 {
 	char *remoteurl, *res;
 	const char *up_path, *url;
+	struct option options[] = {
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, "test-tools", options,
+			     submodule_resolve_relative_url_usage, 0);
+	if (argc != 3)
+		usage_with_options(submodule_resolve_relative_url_usage, options);
 
 	up_path = argv[0];
 	remoteurl = xstrdup(argv[1]);
@@ -104,19 +111,6 @@ static int resolve_relative_url(int argc, const char **argv)
 	return 0;
 }
 
-static int cmd__submodule_resolve_relative_url(int argc, const char **argv)
-{
-	struct option options[] = {
-		OPT_END()
-	};
-	argc = parse_options(argc, argv, "test-tools", options,
-			     submodule_resolve_relative_url_usage, 0);
-	if (argc != 3)
-		usage_with_options(submodule_resolve_relative_url_usage, options);
-
-	return resolve_relative_url(argc, argv);
-}
-
 static struct test_cmd cmds[] = {
 	{ "check-name", cmd__submodule_check_name },
 	{ "is-active", cmd__submodule_is_active },
-- 
2.38.0.661.g581b1c9920

