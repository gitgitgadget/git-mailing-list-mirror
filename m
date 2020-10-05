Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D723C4727F
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448032078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgJEMQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:16:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgJEMQr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:16:47 -0400
Received: (qmail 32267 invoked by uid 109); 5 Oct 2020 12:16:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 12:16:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19057 invoked by uid 111); 5 Oct 2020 12:16:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 08:16:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 08:16:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 7/8] verify_path(): disallow symlinks in .gitattributes
 and .gitignore
Message-ID: <20201005121645.GG2907394@coredump.intra.peff.net>
References: <20201005121609.GA2907272@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005121609.GA2907272@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 10ecfa7649 (verify_path: disallow symlinks in .gitmodules,
2018-05-04) we made it impossible to load a .gitmodules file that's a
symlink into the index. The security reasons for doing so are described
there. We also discussed forbidding symlinks of other .git files as part
of that fix, but the tradeoff was less compelling:

  1. Unlike .gitmodules, the other files don't have content-level fsck
     checks. So an attacker using symlinks to evade those checks isn't a
     problem.

  2. Unlike .gitmodules, Git will never write .gitignore or
     .gitattributes itself, making it much less likely to use them to
     write outside the repo. They could be used for out-of-repo reads,
     however.

  3. The .gitmodules change was part of a critical bug-fix that was
     not publicly disclosed until it was released. Changing the other
     files was not needed for the minimal fix.

However, it's still a reasonable idea to forbid symlinks for these
files:

  - As noted, they can still be used to read out-of-repo files (which is
    fairly restricted, but in some circumstances you can probe file
    content by speculatively creating files and seeing if they get
    ignored)

  - They don't currently behave well in all cases. We sometimes read
    these files from the index, where we _don't_ follow symlinks (we'd
    just treat the symlink target as the .gitignore or .gitattributes
    content, which is actively wrong).

This patch forbids symlinked versions of these files from entering the
index. We already have helpers for obscured forms of the names from
e7cb0b4455 (is_ntfs_dotgit: match other .git files, 2018-05-11) and
0fc333ba20 (is_hfs_dotgit: match other .git files, 2018-05-02), which
were done as part of the series touching .gitmodules.

No tests yet, as we'll add them in a subsequent patch once we have fsck
support, too.

Signed-off-by: Jeff King <peff@peff.net>
---
 read-cache.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index ecf6f68994..63aec6c35d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -947,7 +947,9 @@ static int verify_dotfile(const char *rest, unsigned mode)
 			return 0;
 		if (S_ISLNK(mode)) {
 			rest += 3;
-			if (skip_iprefix(rest, "modules", &rest) &&
+			if ((skip_iprefix(rest, "modules", &rest) ||
+			     skip_iprefix(rest, "ignore", &rest) ||
+			     skip_iprefix(rest, "attributes", &rest)) &&
 			    (*rest == '\0' || is_dir_sep(*rest)))
 				return 0;
 		}
@@ -980,7 +982,9 @@ int verify_path(const char *path, unsigned mode)
 				if (is_hfs_dotgit(path))
 					return 0;
 				if (S_ISLNK(mode)) {
-					if (is_hfs_dotgitmodules(path))
+					if (is_hfs_dotgitmodules(path) ||
+					    is_hfs_dotgitignore(path) ||
+					    is_hfs_dotgitattributes(path))
 						return 0;
 				}
 			}
@@ -992,7 +996,9 @@ int verify_path(const char *path, unsigned mode)
 				if (is_ntfs_dotgit(path))
 					return 0;
 				if (S_ISLNK(mode)) {
-					if (is_ntfs_dotgitmodules(path))
+					if (is_ntfs_dotgitmodules(path) ||
+					    is_ntfs_dotgitignore(path) ||
+					    is_ntfs_dotgitattributes(path))
 						return 0;
 				}
 			}
-- 
2.28.0.1295.gf70bcb366f

