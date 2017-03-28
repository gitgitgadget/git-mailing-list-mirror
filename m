Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E971FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755870AbdC1Trb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:47:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:53170 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755801AbdC1Tra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:47:30 -0400
Received: (qmail 11819 invoked by uid 109); 28 Mar 2017 19:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:47:05 +0000
Received: (qmail 8494 invoked by uid 111); 28 Mar 2017 19:47:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:47:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:47:03 -0400
Date:   Tue, 28 Mar 2017 15:47:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 17/18] gc: replace local buffer with git_path
Message-ID: <20170328194703.jsvwdykdshzzas5y@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We probe the "17/" loose object directory for auto-gc, and
use a local buffer to format the path. We can just use
git_path() for this. It handles paths of any length
(reducing our error handling). And because we feed the
result straight to a system call, we can just use the static
variant.

Note that git_path also knows the string "objects/" is
special, and will replace it with git_object_directory()
when necessary.

Another alternative would be to use sha1_file_name() for the
pretend object "170000...", but that ends up being more
hassle for no gain, as we have to truncate the final path
component.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/gc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c2c61a57b..2daede782 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -135,8 +135,6 @@ static int too_many_loose_objects(void)
 	 * distributed, we can check only one and get a reasonable
 	 * estimate.
 	 */
-	char path[PATH_MAX];
-	const char *objdir = get_object_directory();
 	DIR *dir;
 	struct dirent *ent;
 	int auto_threshold;
@@ -146,11 +144,7 @@ static int too_many_loose_objects(void)
 	if (gc_auto_threshold <= 0)
 		return 0;
 
-	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
-		warning(_("insanely long object directory %.*s"), 50, objdir);
-		return 0;
-	}
-	dir = opendir(path);
+	dir = opendir(git_path("objects/17"));
 	if (!dir)
 		return 0;
 
-- 
2.12.2.845.g55fcf8b10

