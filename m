Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01845C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 23:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbiESXr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbiESXrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 19:47:14 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 16:47:13 PDT
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [IPv6:2001:19f0:5:727:1e84:17da:7c52:5ab4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B239B94
        for <git@vger.kernel.org>; Thu, 19 May 2022 16:47:13 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (unknown [69.145.56.143])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id C01AB2E536DF;
        Thu, 19 May 2022 23:39:37 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id 849C5130035B; Thu, 19 May 2022 17:39:25 -0600 (MDT)
From:   Kevin Locke <kevin@kevinlocke.name>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] setup: don't die if realpath(3) fails on getcwd(3)
Date:   Thu, 19 May 2022 17:39:13 -0600
Message-Id: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to Git 2.35.0, git could be run from an inaccessible working
directory so long as the git repository specified by options and/or
environment variables was accessible.  For example:

    git init repo
    mkdir -p a/b
    cd a/b
    chmod u-x ..
    git -C "${PWD%/a/b}/repo" status

If this example seems a bit contrived, consider running with the
repository owner as a substitute UID (e.g. with runuser(1) or sudo(8))
without ensuring the working directory is accessible by that user.

The code added by e6f8861bd4 to preserve the working directory attempts
to normalize the path using strbuf_realpath().  If that fails, as in the
case above, it is treated as a fatal error.  To avoid this, we can
continue after the error.  At worst, git will fail to detect that the
working directory is inside the worktree, resulting in the pre-2.35.0
behavior of not preserving the working directory.

Fixes: e6f8861bd4 ("setup: introduce startup_info->original_cwd")
Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
---
 setup.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index a7b36f3ffb..fb68caaae0 100644
--- a/setup.c
+++ b/setup.c
@@ -458,11 +458,13 @@ static void setup_original_cwd(void)
 	 *     not startup_info->original_cwd.
 	 */
 
-	/* Normalize the directory */
-	strbuf_realpath(&tmp, tmp_original_cwd, 1);
-	free((char*)tmp_original_cwd);
+	/* Try to normalize the directory.  Fails if ancestor not readable. */
+	if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
+		free((char*)tmp_original_cwd);
+		startup_info->original_cwd = strbuf_detach(&tmp, NULL);
+	} else
+		startup_info->original_cwd = tmp_original_cwd;
 	tmp_original_cwd = NULL;
-	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
 
 	/*
 	 * Get our worktree; we only protect the current working directory
-- 
2.35.1

