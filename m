Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBAF20A04
	for <e@80x24.org>; Fri, 26 May 2017 19:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762283AbdEZTIQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:08:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58605 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761225AbdEZTHi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:07:38 -0400
Received: (qmail 21648 invoked by uid 109); 26 May 2017 19:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 19:07:33 +0000
Received: (qmail 32144 invoked by uid 111); 26 May 2017 19:08:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 15:08:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 15:07:31 -0400
Date:   Fri, 26 May 2017 15:07:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/6] check_filename(): refactor ":/" handling
Message-ID: <20170526190731.dlllzhqqnpsyvqva@sigill.intra.peff.net>
References: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We handle arguments with the ":/" pathspec magic specially,
making sure the name exists at the top-level.  We'll want to
handle more pathspec magic in future patches, so let's do a
little rearranging to make that easier.

Instead of relying on an if/else cascade to avoid the
prefix_filename() call, we'll just set prefix to NULL.
Likewise, we'll get rid of the "name" variable entirely, and
just push the "arg" pointer forward to skip past the magic.
That means by the time we get to the prefix-handling, we're
set up appropriately whether we saw ":/" or not.

Note that this does impact the final error message we
produce when stat() fails, as it shows "arg" (which we'll
have modified to skip magic and include the prefix). This is
a good thing; the original message would say something like
"failed to stat ':/foo'", which is confusing (we tried to
stat "foo").

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index 0309c2782..000ffa810 100644
--- a/setup.c
+++ b/setup.c
@@ -134,19 +134,20 @@ int path_inside_repo(const char *prefix, const char *path)
 
 int check_filename(const char *prefix, const char *arg)
 {
-	const char *name;
 	char *to_free = NULL;
 	struct stat st;
 
 	if (starts_with(arg, ":/")) {
 		if (arg[2] == '\0') /* ":/" is root dir, always exists */
 			return 1;
-		name = arg + 2;
-	} else if (prefix)
-		name = to_free = prefix_filename(prefix, arg);
-	else
-		name = arg;
-	if (!lstat(name, &st)) {
+		arg += 2;
+		prefix = NULL;
+	}
+
+	if (prefix)
+		arg = to_free = prefix_filename(prefix, arg);
+
+	if (!lstat(arg, &st)) {
 		free(to_free);
 		return 1; /* file exists */
 	}
-- 
2.13.0.496.ge44ba89db

