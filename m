Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826B51F428
	for <e@80x24.org>; Tue,  2 Jan 2018 21:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeABVKR (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 16:10:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:51040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750787AbeABVKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 16:10:16 -0500
Received: (qmail 11214 invoked by uid 109); 2 Jan 2018 21:10:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jan 2018 21:10:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19456 invoked by uid 111); 2 Jan 2018 21:10:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 02 Jan 2018 16:10:46 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2018 16:10:14 -0500
Date:   Tue, 2 Jan 2018 16:10:14 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 3/4] clone: factor out dir_exists() helper
Message-ID: <20180102211014.GC22556@sigill.intra.peff.net>
References: <20180102210753.GA10430@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180102210753.GA10430@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two parts of git-clone's setup logic check whether a
directory exists, and they both call stat directly with the
same scratch "struct stat" buffer. Let's pull that into a
helper, which has a few advantages:

  - it makes the purpose of the stat calls more obvious

  - it makes it clear that we don't care about the
    information in "buf" remaining valid

  - if we later decide to make the check more robust (e.g.,
    complaining about non-directories), we can do it in one
    place

Note that we could just use file_exists() for this, which
has identical code. But we specifically care about
directories, so this future-proofs us against that function
later getting more picky about seeing actual files.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2da71db107..04b0d7283f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -863,10 +863,15 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
+static int dir_exists(const char *path)
+{
+	struct stat sb;
+	return !stat(path, &sb);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
-	struct stat buf;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
 	int dest_exists;
@@ -938,7 +943,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		dir = guess_dir_name(repo_name, is_bundle, option_bare);
 	strip_trailing_slashes(dir);
 
-	dest_exists = !stat(dir, &buf);
+	dest_exists = dir_exists(dir);
 	if (dest_exists && !is_empty_dir(dir))
 		die(_("destination path '%s' already exists and is not "
 			"an empty directory."), dir);
@@ -949,7 +954,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		work_tree = NULL;
 	else {
 		work_tree = getenv("GIT_WORK_TREE");
-		if (work_tree && !stat(work_tree, &buf))
+		if (work_tree && dir_exists(work_tree))
 			die(_("working tree '%s' already exists."), work_tree);
 	}
 
-- 
2.16.0.rc0.384.gc477e89267

