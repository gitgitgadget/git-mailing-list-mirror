Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFA4C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiEUNxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354406AbiEUNxk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 09:53:40 -0400
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [IPv6:2001:19f0:5:727:1e84:17da:7c52:5ab4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A53895486
        for <git@vger.kernel.org>; Sat, 21 May 2022 06:53:36 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (2600-6c67-5000-3d1b-eed1-af9b-623d-3011.res6.spectrum.com [IPv6:2600:6c67:5000:3d1b:eed1:af9b:623d:3011])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 0D9272E617B0;
        Sat, 21 May 2022 13:53:35 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id F316113003B0; Sat, 21 May 2022 07:53:32 -0600 (MDT)
From:   Kevin Locke <kevin@kevinlocke.name>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] setup: don't die if realpath(3) fails on getcwd(3)
Date:   Sat, 21 May 2022 07:53:02 -0600
Message-Id: <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
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

The code added by e6f8861bd4 ("setup: introduce
startup_info->original_cwd") to preserve the working directory attempts
to normalize the path using strbuf_realpath().  If that fails, as in the
case above, it is treated as a fatal error.

This commit treats strbuf_realpath() errors as non-fatal.  If an error
occurs, setup_original_cwd() will continue without applying removal
prevention for cwd, resulting in the pre-2.35.0 behavior.  The risk
should be minimal, since git will not operate on a repository with
inaccessible ancestors, this behavior is only known to occur when cwd is
a descendant of the repository, an ancestor of cwd is inaccessible, and
no ancestors of the repository are inaccessible.

Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
---

Changes since v1:
 * Set startup_info->original_cwd = NULL when strbuf_realpath() fails,
   rather than setting it to the un-normalized path.
 * Add a trace message when realpath fails to aid debugging.
 * Remove potential realpath failure cause from comment before it.
 * Improve format for reference to e6f8861bd4 in commit message.
 * Clarify when the pre-2.35.0 behavior may occur as a result of this
   commit in the commit message.
 * Remove 'Fixes:' tag from commit message.

 setup.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index a7b36f3ffb..22430a663c 100644
--- a/setup.c
+++ b/setup.c
@@ -458,11 +458,16 @@ static void setup_original_cwd(void)
 	 *     not startup_info->original_cwd.
 	 */
 
-	/* Normalize the directory */
-	strbuf_realpath(&tmp, tmp_original_cwd, 1);
-	free((char*)tmp_original_cwd);
-	tmp_original_cwd = NULL;
-	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
+	/* Try to normalize the directory. */
+	if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
+		free((char*)tmp_original_cwd);
+		tmp_original_cwd = NULL;
+		startup_info->original_cwd = strbuf_detach(&tmp, NULL);
+	} else {
+		trace_printf("realpath(cwd) failed: %s\n", strerror(errno));
+		tmp_original_cwd = NULL;
+		goto no_prevention_needed;
+	}
 
 	/*
 	 * Get our worktree; we only protect the current working directory
-- 
2.35.1

