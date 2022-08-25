Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB9C28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 10:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiHYKvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbiHYKvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 06:51:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78842AC251
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 03:51:41 -0700 (PDT)
Received: (qmail 14190 invoked by uid 109); 25 Aug 2022 10:51:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Aug 2022 10:51:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28560 invoked by uid 111); 25 Aug 2022 10:51:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Aug 2022 06:51:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Aug 2022 06:51:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] remote: run "remote rm" argv through parse_options()
Message-ID: <YwdUPIv097AWRfTI@coredump.intra.peff.net>
References: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git remote rm" command's option parsing is fairly primitive: it
insists on a single argument, which it treats as the remote name, and
displays a usage message otherwise.

This is OK, and maybe even convenient, as you could run:

  git remote rm --foo

to drop a remote named "--foo". But it's also weirdly unlike most of the
rest of Git, which would complain that there is no option "--foo". The
right way to spell it by our conventions is:

  git remote rm -- --foo

but this doesn't currently work.

So let's bring the command in line with the rest of Git (including its
sibling subcommands!) by feeding argv to parse_options(). We already
have an empty options array for the usage helper.

Note that we have to adjust the argc index down by one, as
parse_options() eats the program name from the start of the array.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 96f562f00a..9aff864fd6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -862,12 +862,14 @@ static int rm(int argc, const char **argv, const char *prefix)
 	cb_data.skipped = &skipped;
 	cb_data.keep = &known_remotes;
 
-	if (argc != 2)
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_remote_rm_usage, 0);
+	if (argc != 1)
 		usage_with_options(builtin_remote_rm_usage, options);
 
-	remote = remote_get(argv[1]);
+	remote = remote_get(argv[0]);
 	if (!remote_is_configured(remote, 1)) {
-		error(_("No such remote: '%s'"), argv[1]);
+		error(_("No such remote: '%s'"), argv[0]);
 		exit(2);
 	}
 
-- 
2.37.2.1034.gd926c9c740
